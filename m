Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DF2C1A0739
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 18:09:14 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6B79614017F
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 18:09:14 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 17:09:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 21B322BB0054
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 18:09:12 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0E79Bp726607824
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 18:09:11 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0E79972005511
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 18:09:11 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V7 1/8] elf: Add new powerpc specifc core note sections
Date: Wed, 14 Jan 2015 12:38:43 +0530
Message-Id: <1421219330-19984-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1421219330-19984-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1421219330-19984-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 kirjanov@gmail.com, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds four new ELF core note sections for powerpc
transactional memory and one new ELF core note section for
powerpc general miscellaneous debug registers. These addition
of new ELF core note sections extends the existing ELF ABI
without affecting it in any manner.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 include/uapi/linux/elf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 71e1d0e..0fd9983 100644
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
1.9.3
