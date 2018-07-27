Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cXFB6yjVzF0x4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 00:59:58 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6RExGT2141902
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:59:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kg3mkdms0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 10:59:56 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 27 Jul 2018 10:59:55 -0400
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
Subject: [PATCH v2 10/10] powerpc/traps: Add line prefix in show_instructions()
Date: Fri, 27 Jul 2018 11:58:11 -0300
In-Reply-To: <20180727145811.12334-1-muriloo@linux.ibm.com>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180727145811.12334-11-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove "Instruction dump:" line by adding a prefix to display current->comm
and current->pid, along with the instructions dump.

The prefix can serve as a glue that links the instructions dump to its
originator, allowing messages to be interleaved in the logs.

Before this patch, a page fault looked like:

    pandafault[10524]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100 code 2 in pandafault[10000000+10000]
    Instruction dump:
    4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
    392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

After this patch, it looks like:

    pandafault[10850]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fff9f3e5100 code 2 in pandafault[10000000+10000]
    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/process.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 709bfb524b84..25b6dfc8dd81 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1265,16 +1265,19 @@ static int instructions_to_print = 16;
 void show_instructions(struct pt_regs *regs)
 {
 	int i;
+	const char *prefix = KERN_INFO "%s[%d]: code: ";
 	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
 			sizeof(int));
 
-	printk("Instruction dump:");
+	printk(prefix, current->comm, current->pid);
 
 	for (i = 0; i < instructions_to_print; i++) {
 		int instr;
 
-		if (!(i % 8))
+		if (!(i % 8) && (i > 0)) {
 			pr_cont("\n");
+			printk(prefix, current->comm, current->pid);
+		}
 
 #if !defined(CONFIG_BOOKE)
 		/* If executing with the IMMU off, adjust pc rather
-- 
2.17.1
