Return-Path: <anton@samba.org>
Date: Tue, 20 Sep 2011 10:19:38 +1000
From: Anton Blanchard <anton@samba.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/5] ppc64 scheduler fixes
Message-ID: <20110920101938.121098ed@kryten>
In-Reply-To: <1311597702.24752.1.camel@twins>
References: <20110725023311.175792493@samba.org>
	<1311597702.24752.1.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mingo@elte.hu, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Peter,

> On Mon, 2011-07-25 at 12:33 +1000, Anton Blanchard wrote:
> > Here are a set of ppc64 scheduler fixes that help with some
> > multi node performance issues.
> 
> They look fine to me. I'll probably ping you when I'll rip out all
> that SD_NODES_PER_DOMAIN crap for good, but until then I'm fine with
> you fiddling it for ppc64.
> 
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Are you OK if Ben takes this, or would you prefer to send it via the
scheduler tree?

Anton
--

[2/5] sched: Allow SD_NODES_PER_DOMAIN to be overridden

We want to override the default value of SD_NODES_PER_DOMAIN on ppc64,
so move it into linux/topology.h.

Signed-off-by: Anton Blanchard <anton@samba.org>

---

Index: linux-2.6-work/include/linux/topology.h
===================================================================
--- linux-2.6-work.orig/include/linux/topology.h	2011-07-25 11:20:02.588717796 +1000
+++ linux-2.6-work/include/linux/topology.h	2011-07-25 11:26:50.616468376 +1000
@@ -201,6 +201,10 @@ int arch_update_cpu_topology(void);
 	.balance_interval	= 64,					\
 }
 
+#ifndef SD_NODES_PER_DOMAIN
+#define SD_NODES_PER_DOMAIN 16
+#endif
+
 #ifdef CONFIG_SCHED_BOOK
 #ifndef SD_BOOK_INIT
 #error Please define an appropriate SD_BOOK_INIT in include/asm/topology.h!!!
Index: linux-2.6-work/kernel/sched.c
===================================================================
--- linux-2.6-work.orig/kernel/sched.c	2011-07-25 11:20:09.538850173 +1000
+++ linux-2.6-work/kernel/sched.c	2011-07-25 11:26:50.626468565 +1000
@@ -6938,8 +6938,6 @@ static int __init isolated_cpu_setup(cha
 
 __setup("isolcpus=", isolated_cpu_setup);
 
-#define SD_NODES_PER_DOMAIN 16
-
 #ifdef CONFIG_NUMA
 
 /**
