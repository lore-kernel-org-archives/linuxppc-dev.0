Message-ID: <3BD71137.57160101@chinook.com>
Date: Wed, 24 Oct 2001 15:06:31 -0400
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: =?iso-8859-1?Q?K=E1ri=20Dav=ED=F0sson?= <kd@flaga.is>
Cc: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: microcodepatch
References: <EADB10BAC266A14A85ECBF8686A73E3145934F@kolkrabbi.flaga.is>
Content-Type: multipart/mixed;
 boundary="------------DEDC222C0C6390087213A4D0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------DEDC222C0C6390087213A4D0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The I2C driver doesn't work properly with the microcode patch - it
initializes tbptr and rbptr to 0, not r_tbase and r_rbase, and it uses
the INIT_TRX command (which the patched code doesn't support) instead of
separate INIT_RX and INIT_TX.

You might want to try the attached minor patch, which works for us.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421
--------------DEDC222C0C6390087213A4D0
Content-Type: text/plain; charset=us-ascii;
 name="i2c-ucode.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-ucode.diff"

Index: i2c-algo-8xx.c
===================================================================
RCS file: /src/cvs/hardhat/devkit/lsp/motorola-mbx860/linux-2.4.2_hhl20/drivers/i2c/i2c-algo-8xx.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- i2c-algo-8xx.c	2001/07/24 17:23:38	1.1.1.1
+++ i2c-algo-8xx.c	2001/10/01 19:08:20	1.2
@@ -99,8 +99,12 @@
 		volatile cpm8xx_t *cp = cpm_adap->cp;

 		cp->cp_cpcr =
-			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_RX) | CPM_CR_FLG;
 		while (cp->cp_cpcr & CPM_CR_FLG);
+
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TX) | CPM_CR_FLG;
+		while (cp->cp_cpcr & CPM_CR_FLG);
 	}

 	/* Select an arbitrary address.  Just make sure it is unique.
@@ -151,12 +155,12 @@

 	iip->iic_rstate = 0;
 	iip->iic_rdp = 0;
-	iip->iic_rbptr = 0;
+	iip->iic_rbptr = r_rbase;
 	iip->iic_rbc = 0;
 	iip->iic_rxtmp = 0;
 	iip->iic_tstate = 0;
 	iip->iic_tdp = 0;
-	iip->iic_tbptr = 0;
+	iip->iic_tbptr = r_tbase;
 	iip->iic_tbc = 0;
 	iip->iic_txtmp = 0;
 }

--------------DEDC222C0C6390087213A4D0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
