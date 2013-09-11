Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id CD7F12C03F7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 02:44:59 +1000 (EST)
Date: Wed, 11 Sep 2013 18:44:56 +0200
Message-Id: <201309111644.r8BGiuDZ016325@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Activating CONFIG_PIN_TLB is supposed to pin the IMMR and the first three
8Mbytes pages. But the setting of the MD_CTR was missing so as the index is
decremented every DTLB update, the pinning of the third 8Mbytes page was
overwriting the DTLB entry for IMMR.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S linux-3.11/arch/powerpc/kernel/head_8xx.S
--- linux-3.11.org/arch/powerpc/kernel/head_8xx.S	2013-09-02 22:46:10.000000000 +0200
+++ linux-3.11/arch/powerpc/kernel/head_8xx.S	2013-09-09 11:28:54.000000000 +0200
@@ -862,6 +862,9 @@
 	addis	r11, r11, 0x0080	/* Add 8M */
 	mtspr	SPRN_MD_RPN, r11
 
+	addi	r10, r10, 0x0100
+	mtspr	SPRN_MD_CTR, r10
+
 	addis	r8, r8, 0x0080		/* Add 8M */
 	mtspr	SPRN_MD_EPN, r8
 	mtspr	SPRN_MD_TWC, r9
