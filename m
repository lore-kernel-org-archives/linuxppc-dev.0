Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fzsK1qWMzF15Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 00:51:17 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6VE8v6m121555
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 10:51:15 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kjqybdvd8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 10:51:15 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Tue, 31 Jul 2018 08:51:14 -0600
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Joe Perches <joe@perches.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 8/9] powerpc/traps: Show instructions on exceptions
Date: Tue, 31 Jul 2018 11:50:19 -0300
In-Reply-To: <20180731145020.14009-1-muriloo@linux.ibm.com>
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180731145020.14009-9-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Call show_instructions() in arch/powerpc/kernel/traps.c to dump
instructions at faulty location, useful to debugging.

Before this patch, an unhandled signal message looked like:

  pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]

After this patch, it looks like:

  pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]
  Instruction dump:
  4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
  392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e71f12bca146..b27f3f71d745 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -70,6 +70,7 @@
 #include <asm/hmi.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/kprobes.h>
+#include <asm/stacktrace.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
@@ -356,6 +357,8 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	print_vma_addr(KERN_CONT " in ", regs->nip);
 
 	pr_cont("\n");
+
+	show_instructions(regs);
 }
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-- 
2.17.1
