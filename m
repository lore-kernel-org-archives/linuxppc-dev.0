Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1vCW2LjqzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 16:26:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eryu Guan <eguan@redhat.com>
Cc: tj@kernel.org, Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1
 regression] mount ext4 fs results in kernel crash on PPC64le host)
In-Reply-To: <20170630114756.GD23360@eguan.usersys.redhat.com>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
 <20170629034122.GI23360@eguan.usersys.redhat.com>
 <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
 <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
 <878tkb9ewo.fsf@concordia.ellerman.id.au>
 <20170629135919.GU23360@eguan.usersys.redhat.com>
 <8760fdrdq1.fsf@concordia.ellerman.id.au>
 <20170630114756.GD23360@eguan.usersys.redhat.com>
Date: Tue, 04 Jul 2017 16:26:11 +1000
Message-ID: <87tw2syayk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Eryu Guan <eguan@redhat.com> writes:
> On Fri, Jun 30, 2017 at 08:07:02PM +1000, Michael Ellerman wrote:
>> 
>> Can you try this patch and see if it changes anything? (with the debug
>> still applied).
>
> This patch fixes the crash for me. After appliying this patch (with all
> other debug patches still applied), kernel didn't print any warnings or
> calltraces or debug messages.

OK. It's not meant to fix it :)

I can't form any connection between your bisection result and that
patch, nothing is making any sense TBH.

What hardware are you on? And are you doing CPU hotplug or anything like that?

Can you back out the last patch I sent and try this?

cheers


diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c74bf39ef764..8ec3841f9689 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3338,6 +3338,8 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 
 	lockdep_assert_held(&wq_pool_mutex);
 
+	WARN_ON(cpumask_empty(attrs->cpumask));
+
 	/* do we already have a matching pool? */
 	hash_for_each_possible(unbound_pool_hash, pool, hash_node, hash) {
 		if (wqattrs_equal(pool->attrs, attrs)) {
@@ -3366,6 +3368,8 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 	copy_workqueue_attrs(pool->attrs, attrs);
 	pool->node = target_node;
 
+	WARN_ON(cpumask_empty(pool->attrs->cpumask));
+
 	/*
 	 * no_numa isn't a worker_pool attribute, always clear it.  See
 	 * 'struct workqueue_attrs' comments for detail.
@@ -5494,6 +5498,7 @@ static void __init wq_numa_init(void)
 
 	for_each_possible_cpu(cpu) {
 		node = cpu_to_node(cpu);
+		printk("%s: setting cpu %d on node %d present? %d\n", __func__, cpu, node, cpu_present(cpu));
 		if (WARN_ON(node == NUMA_NO_NODE)) {
 			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
 			/* happens iff arch is bonkers, let's just proceed */
@@ -5502,6 +5507,16 @@ static void __init wq_numa_init(void)
 		cpumask_set_cpu(cpu, tbl[node]);
 	}
 
+	for_each_possible_cpu(cpu) {
+		struct worker_pool *pool;
+
+		for_each_cpu_worker_pool(pool, cpu) {
+			if (cpumask_empty(pool->attrs->cpumask))
+				printk("%s: cpumask EMPTY! for pool %p on cpu %d\n", __func__, pool, cpu);
+			printk("%s: pool %p on cpu %d node = %d\n", __func__, pool, cpu, pool->node);
+		}
+	}
+
 	wq_numa_possible_cpumask = tbl;
 	wq_numa_enabled = true;
 }
