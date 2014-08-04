Return-Path: <dietmar.eggemann@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 2DCE71A014D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 21:31:07 +1000 (EST)
Message-ID: <53DF6EFC.30705@arm.com>
Date: Mon, 04 Aug 2014 12:31:08 +0100
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: scheduler crash on Power
References: <20140730072242.GA21516@us.ibm.com> <53DA2F15.1070605@arm.com>	
 <20140801212447.GA25435@us.ibm.com> <1407122432.2286.0.camel@concordia>
In-Reply-To: <1407122432.2286.0.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: "bruno@wolff.to" <bruno@wolff.to>, Michael Ellerman <michaele@au1.ibm.com>,
 "jwboyer@redhat.com" <jwboyer@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infrdead.org" <peterz@infrdead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/08/14 04:20, Michael Ellerman wrote:
> On Fri, 2014-08-01 at 14:24 -0700, Sukadev Bhattiprolu wrote:
>> Dietmar Eggemann [dietmar.eggemann@arm.com] wrote:
>> | > ltcbrazos2-lp07 login: [  181.915974] ------------[ cut here ]------=
------
>> | > [  181.915991] WARNING: at ../kernel/sched/core.c:5881
>> |=20
>> | This warning indicates the problem. One of the struct sched_domains do=
es
>> | not have it's groups member set.
>> |=20
>> | And its happening during a rebuild of the sched domain hierarchy, not
>> | during the initial build.
>> |=20
>> | You could run your system with the following patch-let (on top of
>> | https://lkml.org/lkml/2014/7/17/288)  w/ and w/o the perf related
>> | patches (w/ CONFIG_SCHED_DEBUG enabled).
>> |=20
>> | @@ -5882,6 +5882,9 @@ static void init_sched_groups_capacity(int cpu,
>> | struct sched_domain *sd)
>> |  {
>> |         struct sched_group *sg =3D sd->groups;
>> |=20
>> | +#ifdef CONFIG_SCHED_DEBUG
>> | +       printk("sd name: %s span: %pc\n", sd->name, sd->span);
>> | +#endif
>> |         WARN_ON(!sg);
>> |=20
>> |         do {
>> |=20
>> | This will show if the rebuild of the sched domain hierarchy happens on
>> | both systems and hopefully indicate for which sched_domain the
>> | sd->groups is not set.
>>
>> Thanks for the patch. It appears that the NUMA sched domain does not
>> have the sd->groups set - snippet of the error (with your patch and
>> Peter's patch)
>>
>> [  181.914494] build_sched_groups: got group c000000006da0000 with cpus:=
=20
>> [  181.914498] build_sched_groups: got group c0000000dd830000 with cpus:=
=20
>> [  181.915234] sd name: SMT span: 8-15
>> [  181.915239] sd name: DIE span: 0-7
>> [  181.915242] sd name: NUMA span: 0-15
>> [  181.915250] ------------[ cut here ]------------
>> [  181.915253] WARNING: at ../kernel/sched/core.c:5891
>>
>> Patched code:
>>
>> =095884 static void init_sched_groups_capacity(int cpu, struct sched_dom=
ain *sd)
>> =095885 {
>> =095886         struct sched_group *sg =3D sd->groups;
>> =095887=20
>> =095888 #ifdef CONFIG_SCHED_DEBUG
>> =095889         printk("sd name: %s span: %pc\n", sd->name, sd->span);
>> =095890 #endif
>> =095891         WARN_ON(!sg);
>>
>> Complete log below.
>>
>> I was able to bisect it down to this patch in the 24x7 patchset
>>
>> =09https://lkml.org/lkml/2014/5/27/804
>>
>> I replaced the kfree(page) calls in the patch with
>> kmem_cache_free(hv_page_cache, page).
>>
>> The problem sems to disappear if the call to create_events_from_catalog(=
)
>> in hv_24x7_init() is skipped. I am continuing to debug the 24x7 patch.
>=20
> Is that patch just clobbering memory it doesn't own and corrupting the
> scheduler data structures?

Quite likely. When the system comes up initially, it has SMT and DIE
sched domain level:

...
[    0.033832] build_sched_groups: got group c0000000e7d50000 with cpus:
[    0.033835] build_sched_groups: got group c0000000e7d80000 with cpus:
[    0.033844] sd name: SMT span: 8-15
[    0.033847] sd name: DIE span: 0-15  <-- !!!
[    0.033850] sd name: SMT span: 8-15
[    0.033853] sd name: DIE span: 0-15
...

and the cpu mask of DIE spans all CPUs '0-15'.

Then during the rebuild of the sched domain hierarchy, this looks very
different:

...
[  181.914494] build_sched_groups: got group c000000006da0000 with cpus:
[  181.914498] build_sched_groups: got group c0000000dd830000 with cpus:
[  181.915234] sd name: SMT span: 8-15
[  181.915239] sd name: DIE span: 0-7   <-- !!!
[  181.915242] sd name: NUMA span: 0-15
...

The cpu mask of the DIE level is all the sudden '0-7', which is clearly
wrong.

So I suspect that sched_domain_mask_f mask function for the DIE level
'cpu_cpu_mask()' returns a wrong value during this rebuild.

Could be checked with this little patch-let:

@@ -6467,6 +6467,12 @@ struct sched_domain *build_sched_domain(struct
sched_domain_topology_level *tl,
        if (!sd)
                return child;

+       printk("%s: cpu: %d level: %s cpu_map: %pc tl->mask: %pc\n",
+                       __func__,
+                       cpu, tl->name,
+                       cpu_map,
+                       tl->mask(cpu));
+
        cpumask_and(sched_domain_span(sd), cpu_map, tl->mask(cpu));
        if (child) {
                sd->level =3D child->level + 1;


Should give you something similar like:

...
build_sched_domain: cpu: 0 level: GMC cpu_map: 0-4 tl->mask: 0
build_sched_domain: cpu: 0 level: MC cpu_map: 0-4 tl->mask: 0-1
build_sched_domain: cpu: 0 level: DIE cpu_map: 0-4 tl->mask: 0-4
build_sched_domain: cpu: 1 level: GMC cpu_map: 0-4 tl->mask: 1
build_sched_domain: cpu: 1 level: MC cpu_map: 0-4 tl->mask: 0-1
build_sched_domain: cpu: 1 level: DIE cpu_map: 0-4 tl->mask: 0-4
...

>=20
> cheers
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
