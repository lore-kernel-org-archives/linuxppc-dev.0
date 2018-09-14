Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BZC153drzF3VG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 22:12:13 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8EC5MdW006087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:12:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mgb9y3tkm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:12:10 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Fri, 14 Sep 2018 13:12:06 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>,
 "David S. Miller" <davem@davemloft.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greentime Hu <green.hu@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Jonas Bonn <jonas@southpole.se>, Jonathan Corbet <corbet@lwn.net>,
 Ley Foon Tan <lftan@altera.com>, Mark Salter <msalter@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Matt Turner <mattst88@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@sifive.com>,
 Paul Burton <paul.burton@mips.com>, Richard Kuo <rkuo@codeaurora.org>,
 Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>,
 Russell King <linux@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, nios2-dev@lists.rocketboards.org,
 openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
 uclinux-h8-devel@lists.sourceforge.jp,
 Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 10/30] memblock: replace __alloc_bootmem_node_nopanic with
 memblock_alloc_try_nid_nopanic
Date: Fri, 14 Sep 2018 15:10:25 +0300
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <1536927045-23536-11-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The __alloc_bootmem_node_nopanic() attempts to allocate memory for a
specified node. If the allocation fails it then retries to allocate memory
from any node. Upon success, the allocated memory is set to 0.

The memblock_alloc_try_nid_nopanic() does exactly the same thing and can be
used instead.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/x86/kernel/setup_percpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index ea554f8..67d48e26 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -112,8 +112,10 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
 			 cpu, size, __pa(ptr));
 	} else {
-		ptr = __alloc_bootmem_node_nopanic(NODE_DATA(node),
-						   size, align, goal);
+		ptr = memblock_alloc_try_nid_nopanic(size, align, goal,
+						     BOOTMEM_ALLOC_ACCESSIBLE,
+						     node);
+
 		pr_debug("per cpu data for cpu%d %lu bytes on node%d at %016lx\n",
 			 cpu, size, node, __pa(ptr));
 	}
-- 
2.7.4
