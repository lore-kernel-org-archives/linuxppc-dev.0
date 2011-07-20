Return-Path: <anton@samba.org>
Date: Wed, 20 Jul 2011 20:14:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
Message-ID: <20110720201436.19e9689a@kryten>
In-Reply-To: <1311070894.13765.180.camel@twins>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins> <20110714103418.7ef25b68@kryten>
	<20110714143521.5fe4fab6@kryten> <1310649379.2586.273.camel@twins>
	<20110715104547.29c3c509@kryten> <1311024956.2309.22.camel@laptop>
	<20110719144451.79bc69ab@kryten> <1311070894.13765.180.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Peter,

> That looks very strange indeed.. up to node 23 there is the normal
> symmetric matrix with all the trace elements on 10 (as we would expect
> for local access), and some 4x4 sub-matrix stacked around the trace
> with 20, suggesting a single hop distance, and the rest on 40 being
> out-there.

I retested with the latest version of numactl, and get correct results.

I worked out why the patches don't boot, we weren't allocating any
space for the cpumask and ran off the end of the allocation.

Should we also use cpumask_copy instead of open coding it? I added that
too.

Anton

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2011-07-20 01:54:08.191668781 -0500
+++ linux-2.6/kernel/sched.c	2011-07-20 04:45:36.203750525 -0500
@@ -7020,8 +7020,8 @@
 		if (cpumask_test_cpu(i, covered))
 			continue;
 
-		sg = kzalloc_node(sizeof(struct sched_group), GFP_KERNEL,
-				cpu_to_node(i));
+		sg = kzalloc_node(sizeof(struct sched_group) + cpumask_size(),
+				  GFP_KERNEL, cpu_to_node(i));
 
 		if (!sg)
 			goto fail;
@@ -7031,7 +7031,7 @@
 		child = *per_cpu_ptr(sdd->sd, i);
 		if (child->child) {
 			child = child->child;
-			*sg_span = *sched_domain_span(child);
+			cpumask_copy(sg_span, sched_domain_span(child));
 		} else
 			cpumask_set_cpu(i, sg_span);
 
