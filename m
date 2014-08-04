Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 240FA1A01B2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 13:20:35 +1000 (EST)
Message-ID: <1407122432.2286.0.camel@concordia>
Subject: Re: scheduler crash on Power
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Mon, 04 Aug 2014 13:20:32 +1000
In-Reply-To: <20140801212447.GA25435@us.ibm.com>
References: <20140730072242.GA21516@us.ibm.com> <53DA2F15.1070605@arm.com>
 <20140801212447.GA25435@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "bruno@wolff.to" <bruno@wolff.to>, Michael Ellerman <michaele@au1.ibm.com>,
 "jwboyer@redhat.com" <jwboyer@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infrdead.org" <peterz@infrdead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-01 at 14:24 -0700, Sukadev Bhattiprolu wrote:
> Dietmar Eggemann [dietmar.eggemann@arm.com] wrote:
> | > ltcbrazos2-lp07 login: [  181.915974] ------------[ cut here ]------------
> | > [  181.915991] WARNING: at ../kernel/sched/core.c:5881
> | 
> | This warning indicates the problem. One of the struct sched_domains does
> | not have it's groups member set.
> | 
> | And its happening during a rebuild of the sched domain hierarchy, not
> | during the initial build.
> | 
> | You could run your system with the following patch-let (on top of
> | https://lkml.org/lkml/2014/7/17/288)  w/ and w/o the perf related
> | patches (w/ CONFIG_SCHED_DEBUG enabled).
> | 
> | @@ -5882,6 +5882,9 @@ static void init_sched_groups_capacity(int cpu,
> | struct sched_domain *sd)
> |  {
> |         struct sched_group *sg = sd->groups;
> | 
> | +#ifdef CONFIG_SCHED_DEBUG
> | +       printk("sd name: %s span: %pc\n", sd->name, sd->span);
> | +#endif
> |         WARN_ON(!sg);
> | 
> |         do {
> | 
> | This will show if the rebuild of the sched domain hierarchy happens on
> | both systems and hopefully indicate for which sched_domain the
> | sd->groups is not set.
> 
> Thanks for the patch. It appears that the NUMA sched domain does not
> have the sd->groups set - snippet of the error (with your patch and
> Peter's patch)
> 
> [  181.914494] build_sched_groups: got group c000000006da0000 with cpus: 
> [  181.914498] build_sched_groups: got group c0000000dd830000 with cpus: 
> [  181.915234] sd name: SMT span: 8-15
> [  181.915239] sd name: DIE span: 0-7
> [  181.915242] sd name: NUMA span: 0-15
> [  181.915250] ------------[ cut here ]------------
> [  181.915253] WARNING: at ../kernel/sched/core.c:5891
> 
> Patched code:
> 
> 	5884 static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
> 	5885 {
> 	5886         struct sched_group *sg = sd->groups;
> 	5887 
> 	5888 #ifdef CONFIG_SCHED_DEBUG
> 	5889         printk("sd name: %s span: %pc\n", sd->name, sd->span);
> 	5890 #endif
> 	5891         WARN_ON(!sg);
> 
> Complete log below.
> 
> I was able to bisect it down to this patch in the 24x7 patchset
> 
> 	https://lkml.org/lkml/2014/5/27/804
> 
> I replaced the kfree(page) calls in the patch with
> kmem_cache_free(hv_page_cache, page).
> 
> The problem sems to disappear if the call to create_events_from_catalog()
> in hv_24x7_init() is skipped. I am continuing to debug the 24x7 patch.

Is that patch just clobbering memory it doesn't own and corrupting the
scheduler data structures?

cheers
