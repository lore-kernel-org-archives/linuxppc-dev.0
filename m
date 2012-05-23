Return-Path: <rientjes@google.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01FCBB6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 14:18:06 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so11665896pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 21:18:04 -0700 (PDT)
Date: Tue, 22 May 2012 21:17:56 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch] sched, numa: Allocate node_queue on any node for offline nodes
In-Reply-To: <20120522130354.fdb335eb294f4206b4b2fed5@canb.auug.org.au>
Message-ID: <alpine.DEB.2.00.1205222116160.32649@chino.kir.corp.google.com>
References: <20120522114051.0c9db9a7c2d660bc9e0e1be2@canb.auug.org.au>
 <alpine.DEB.2.00.1205211846120.20916@chino.kir.corp.google.com>
 <20120522130354.fdb335eb294f4206b4b2fed5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

struct node_queue must be allocated with NUMA_NO_NODE for nodes that are 
not (yet) online, otherwise the page allocator has a bad zonelist and 
results in an early crash.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/sched/numa.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/sched/numa.c b/kernel/sched/numa.c
--- a/kernel/sched/numa.c
+++ b/kernel/sched/numa.c
@@ -885,7 +885,8 @@ static __init int numa_init(void)
 
 	for_each_node(node) {
 		struct node_queue *nq = kmalloc_node(sizeof(*nq),
-				GFP_KERNEL | __GFP_ZERO, node);
+				GFP_KERNEL | __GFP_ZERO,
+				node_online(node) ? node : NUMA_NO_NODE);
 		BUG_ON(!nq);
 
 		spin_lock_init(&nq->lock);
