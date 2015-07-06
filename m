Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57F191A0D7D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 20:26:11 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A03C3140DC0
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2015 20:26:10 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 15:56:07 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E0B453940068
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2015 15:56:02 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t66APrdT25690156
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2015 15:55:55 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t66APpPQ027748
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2015 15:55:51 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH 1/2] powerpc/signal: Fix confusing header documentation in
 sigcontext.h
Date: Mon,  6 Jul 2015 15:55:33 +0530
Message-Id: <1436178334-15496-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As 'vmx_reserve' array element had been expanded to contain 101 double
words, the comment block above that needs to be updated. Also changed
the array size declaration to reflect the logic mentioned in the comment
block above. This change helps in explaining how the HW registers are
represented in the array.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/sigcontext.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/sigcontext.h b/arch/powerpc/include/uapi/asm/sigcontext.h
index 9c1f24f..b0c5c46 100644
--- a/arch/powerpc/include/uapi/asm/sigcontext.h
+++ b/arch/powerpc/include/uapi/asm/sigcontext.h
@@ -28,7 +28,7 @@ struct sigcontext {
 /*
  * To maintain compatibility with current implementations the sigcontext is
  * extended by appending a pointer (v_regs) to a quadword type (elf_vrreg_t)
- * followed by an unstructured (vmx_reserve) field of 69 doublewords.  This
+ * followed by an unstructured (vmx_reserve) field of 101 doublewords. This
  * allows the array of vector registers to be quadword aligned independent of
  * the alignment of the containing sigcontext or ucontext. It is the
  * responsibility of the code setting the sigcontext to set this pointer to
@@ -80,7 +80,7 @@ struct sigcontext {
  * registers and vscr/vrsave.
  */
 	elf_vrreg_t	__user *v_regs;
-	long		vmx_reserve[ELF_NVRREG+ELF_NVRREG+32+1];
+	long		vmx_reserve[ELF_NVRREG+ELF_NVRREG+1+32];
 #endif
 };
 
-- 
2.1.0
