Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id AA7FF2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 03:38:58 +1000 (EST)
Date: Tue, 5 Oct 2004 13:32:11 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0410051330310.5314@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] first in a series to enhance microcode patches
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


   resend of previous patch -- sorry, forgot the developer's cert of 
origin.  please be patient, i'm slowly getting the hang of this.

   purpose of patch:

   1) adds a relocation pointer to smc_uart_t
   2) redeclares reserved chunks in structures to be in terms of a
      standard char array, rather than the hideous combination of uint,
      ushort, and so on.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>



--- linuxppc-2.5/include/asm-ppc/commproc.h	2004-09-16 13:08:12.000000000 
-0400
+++ linuxppc-2.5-new/include/asm-ppc/commproc.h	2004-09-16 13:40:52.000000000 
-0400
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
