Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id E74712BDC5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 20:49:41 +1000 (EST)
Received: from [10.1.1.107] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-dev@ozlabs.org; 21 Sep 2004 06:49:40 -0400
Date: Tue, 21 Sep 2004 06:43:24 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0409210635390.9149@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [PATCH] innocuous changes to facilitate SMC1 relocation
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


   a fairly innocent patch that shouldn't break anything, just adds 
support for eventual SMC1 relocation patch -- can someone please, 
please, pretty please apply this?

   the changes:

   1) add definition of smp variable to micropatch.c for eventual use
   2) increase RPBASE to avoid obvious memory clash
   3) change verify_patch() to restore commproc->cp_rccr to what it
 	was before it was cleared
   4) extend struct definition of smc_uart_t in commproc.h to define
 	the SMC1 relocation pointer
   5) change definition of reserved space in struct scc_uart to char[]
 	from meaningless, chaotic selection of uint/ushort

   the only reservation i have is the change to verify_patch() to 
restore the value of cp_rccr to what it was before it was cleared. 
and before anyone says, "i don't know, it's worked fine until now," a 
quick grep shows that absolutely no one else in the entire source tree 
even calls this routine, so there's really no way to know if it's ever 
worked in the first place.



--- linuxppc-2.5/arch/ppc/8xx_io/micropatch.c	2004-09-21 06:20:02.375914800 -0400
+++ linuxppc-2.5-new/arch/ppc/8xx_io/micropatch.c	2004-09-21 06:28:37.208648328 -0400
@@ -638,6 +638,7 @@
  	volatile cpm8xx_t	*commproc;
  	volatile iic_t		*iip;
  	volatile spi_t		*spp;
+	volatile smc_uart_t	*smp;
  	int	i;

  	commproc = (cpm8xx_t *)&immr->im_cpm;
@@ -683,7 +684,7 @@
  #if defined(USE_SMC_PATCH) || defined(USE_IIC_PATCH)

  	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
-#define RPBASE 0x0400
+#define RPBASE 0x0500
  	iip->iic_rpbase = RPBASE;

  	/* Put SPI above the IIC, also 32-byte aligned.
@@ -747,10 +748,12 @@
  	volatile uint		*dp;
  	volatile cpm8xx_t	*commproc;
  	int i;
+	ushort save_rccr;

  	commproc = (cpm8xx_t *)&immr->im_cpm;

  	printk("cp_rccr %x\n", commproc->cp_rccr);
+	save_rccr = commproc->cp_rccr ;
  	commproc->cp_rccr = 0;

  	dp = (uint *)(commproc->cp_dpmem);
@@ -771,7 +774,7 @@
  			break; 		}

-	commproc->cp_rccr = 0x0009;
+	commproc->cp_rccr = save_rccr;
  #endif /* PATCH_DEFINED */
  }

--- linuxppc-2.5/include/asm-ppc/commproc.h	2004-09-16 13:08:12.000000000 -0400
+++ linuxppc-2.5-new/include/asm-ppc/commproc.h	2004-09-16 13:40:52.000000000 -0400
@@ -145,6 +145,8 @@
  	ushort	smc_brkec;	/* rcv'd break condition counter */
  	ushort	smc_brkcr;	/* xmt break count register */
  	ushort	smc_rmask;	/* Temporary bit mask */
+	char	res1[8];	/* Reserved */
+	ushort	smc_rpbase;	/* Relocation pointer */
  } smc_uart_t;

  /* Function code bits.
@@ -475,8 +477,7 @@
  */
  typedef struct scc_uart {
  	sccp_t	scc_genscc;
-	uint	scc_res1;	/* Reserved */
-	uint	scc_res2;	/* Reserved */
+	char	res1[8];	/* Reserved */
  	ushort	scc_maxidl;	/* Maximum idle chars */
  	ushort	scc_idlc;	/* temp idle counter */
  	ushort	scc_brkcr;	/* Break count register */
@@ -560,9 +561,9 @@
  	ushort	iic_tbptr;	/* Internal */
  	ushort	iic_tbc;	/* Internal */
  	uint	iic_txtmp;	/* Internal */
-	uint	iic_res;	/* reserved */
+	char	res1[4];	/* Reserved */
    	ushort	iic_rpbase;	/* Relocation pointer */
-	ushort	iic_res2;	/* reserved */
+	char	res2[2];	/* Reserved */
  } iic_t;

  #define BD_IIC_START		((ushort)0x0400)
