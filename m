Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17A161A05D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:38 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6D24C140B0E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:37 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D177A3940048
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:32 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8VVd61472932
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:31 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8PCH027655
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:30 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 01/28] elf: Add powerpc specific core note sections
Date: Tue, 19 May 2015 20:37:57 +0530
Message-Id: <1432048104-4695-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds twelve ELF core note sections for powerpc
architecture for various registers and register sets which
need to be accessed from ptrace interface and then gdb.
These additions include special purpose registers like TAR,
PPR, DSCR, TM running and checkpointed state for various
register sets, EBB related register set etc. Addition of
these new ELF core note sections extends the existing ELF
ABI on powerpc arch without affecting it in any manner.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 include/uapi/linux/elf.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 71e1d0e..58654c2 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -379,6 +379,18 @@ typedef struct elf64_shdr {
 #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
 #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
 #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
+#define NT_PPC_TAR	0x103		/* Target Address Register */
+#define NT_PPC_PPR	0x104		/* Program Priority Register */
+#define NT_PPC_DSCR	0x105		/* Data Stream Control Register */
+#define NT_PPC_EBB	0x106		/* Event Based Branch Registers */
+#define NT_PPC_TM_CGPR	0x107		/* TM checkpointed GPR Registers */
+#define NT_PPC_TM_CFPR	0x108		/* TM checkpointed FPR Registers */
+#define NT_PPC_TM_CVMX	0x109		/* TM checkpointed VMX Registers */
+#define NT_PPC_TM_CVSX	0x10a		/* TM checkpointed VSX Registers */
+#define NT_PPC_TM_SPR	0x10b		/* TM Special Purpose Registers */
+#define NT_PPC_TM_CTAR	0x10c		/* TM checkpointed Target Address Register */
+#define NT_PPC_TM_CPPR	0x10d		/* TM checkpointed Program Priority Register */
+#define NT_PPC_TM_CDSCR	0x10e		/* TM checkpointed Data Stream Control Register */
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
-- 
2.1.0
