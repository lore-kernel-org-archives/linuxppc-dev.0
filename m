Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C6C511402DA
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 17:56:58 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 5 May 2014 13:26:56 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6878E1258059
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 13:25:48 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s457uxsF59965624
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 13:26:59 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s457uphB015807
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 13:26:52 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] elf: Add some new PowerPC specifc note sections
Date: Mon,  5 May 2014 13:24:27 +0530
Message-Id: <1399276469-13541-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, avagin@openvz.org, palves@redhat.com, oleg@redhat.com,
 michael@ellerman.id.au, roland@redhat.com,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds four new note sections for transactional memory
and one note section for some miscellaneous registers. This addition
of new elf note sections extends the existing elf ABI without affecting
it in any manner.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 include/uapi/linux/elf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index ef6103b..4040124 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -379,6 +379,11 @@ typedef struct elf64_shdr {
 #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
 #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
 #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
+#define NT_PPC_TM_SPR	0x103		/* PowerPC TM special registers */
+#define NT_PPC_TM_CGPR	0x104		/* PowerpC TM checkpointed GPR */
+#define NT_PPC_TM_CFPR	0x105		/* PowerPC TM checkpointed FPR */
+#define NT_PPC_TM_CVMX	0x106		/* PowerPC TM checkpointed VMX */
+#define NT_PPC_MISC	0x107		/* PowerPC miscellaneous registers */
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
-- 
1.7.11.7
