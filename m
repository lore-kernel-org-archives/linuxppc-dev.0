Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 7C5D767A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Mar 2005 01:07:16 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j2OEB0aR005929
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 16:11:00 +0200 (EET)
Received: from ifaistos.intranet.gr (ifaistos.intranet.GR [146.124.20.203])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j2OEAxNJ005920
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 16:10:59 +0200 (EET)
Received: from [146.124.120.118] (voipkopsias.intranet.GR [146.124.120.118])
	by ifaistos.intranet.gr (8.11.7p1+Sun/8.11.7) with ESMTP id
	j2OE2C913884 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 16:02:12 +0200 (EET)
Message-ID: <4242C768.407@intracom.gr>
Date: Thu, 24 Mar 2005 15:58:00 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------070503030309000507090302"
Subject: [PATCH] 8xx typo fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070503030309000507090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

The following patch fixes a typo which was introduced in the great
SPRN_ renaming.

The patch is against the latest linus bk tree (2.6.12-rc1).

Please apply.

Regards

Pantelis

P.S. I want 4 hours of my life back.

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

--------------070503030309000507090302
Content-Type: text/x-patch;
 name="8xx-insn-tlbmiss-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8xx-insn-tlbmiss-fix.patch"

--- linux-2.5/arch/ppc/kernel/head_8xx.S	2005-03-15 14:22:24.000000000 +0200
+++ linux-2.5-intracom/arch/ppc/kernel/head_8xx.S	2005-03-24 15:43:22.000000000 +0200
@@ -307,7 +307,7 @@
 	stw	r11, 4(r0)
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	DO_8xx_CPU6(0x3780, r3)
-	mtspr	SPRN_MD_EPN, r1	/* Have to use MD_EPN for walk, MI_EPN can't */
+	mtspr	SPRN_MD_EPN, r10	/* Have to use MD_EPN for walk, MI_EPN can't */
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
 
 	/* If we are faulting a kernel address, we have to use the

--------------070503030309000507090302--
