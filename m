Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E21C1A0243
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 01:48:57 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ED914140D72
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:48:56 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 00:48:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A6A0B2CE8056
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:48:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98Emfdc40042638
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:48:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98EmISf005369
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:48:21 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 palves@redhat.com, oleg@redhat.com, dhowells@redhat.com,
 davej@redhat.com, davem@davemloft.net, mikey@neuling.org,
 benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com,
 mpe@ellerman.id.au, sam.bobroff@au1.ibm.com, kirjanov@gmail.com,
 shuahkh@osg.samsung.com, Ulrich.Weigand@de.ibm.com,
 emachado@linux.vnet.ibm.com
Subject: [PATCH V9 01/28] elf: Add powerpc specific core note sections
Date: Thu,  8 Oct 2015 20:17:22 +0530
Message-Id: <1444315669-23487-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1444315669-23487-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444315669-23487-1-git-send-email-khandual@linux.vnet.ibm.com>
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
