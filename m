Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cXDX3W0lzF0jD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 00:59:24 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6RExFRa068285
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:59:22 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kg3qudcn1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:59:22 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 27 Jul 2018 10:59:20 -0400
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 05/10] powerpc/traps: Print VMA for unhandled signals
Date: Fri, 27 Jul 2018 11:58:06 -0300
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180727145811.12334-6-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds VMA address in the message printed for unhandled signals,
similarly to what other architectures, like x86, print.

Before this patch, a page fault looked like:

    pandafault[61470]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00007fff8d185100 code 2

After this patch, a page fault looks like:

    pandafault[6303]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00007fff93c55100 code 2 in pandafault[10000000+10000]

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/traps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 047d980ac776..e6c43ef9fb50 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -315,9 +315,13 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 		return;
 
 	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \
-		" nip "REG_FMT" lr "REG_FMT" code %x\n",
+		" nip "REG_FMT" lr "REG_FMT" code %x",
 		current->comm, current->pid, signr, addr,
 		regs->nip, regs->link, code);
+
+	print_vma_addr(KERN_CONT " in ", regs->nip);
+
+	pr_cont("\n");
 }
 
 void _exception_pkey(int signr, struct pt_regs *regs, int code,
-- 
2.17.1
