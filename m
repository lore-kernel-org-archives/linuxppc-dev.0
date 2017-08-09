Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS2Ps4ytdzDqty
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 17:06:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 10/10] powerpc/xive: fix the size of the cpumask used in
 xive_find_target_in_mask()
In-Reply-To: <1502182969-3180-1-git-send-email-clg@kaod.org>
References: <1502182969-3180-1-git-send-email-clg@kaod.org>
Date: Wed, 09 Aug 2017 17:06:57 +1000
Message-ID: <874lthnrse.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C=C3=A9dric Le Goater <clg@kaod.org> writes:
> When called from xive_irq_startup(), the size of the cpumask can be
> larger than nr_cpu_ids. Most of time, its value is NR_CPUS (2048).

Ugh, you're right.

  #define nr_cpumask_bits	((unsigned int)NR_CPUS)
  ...
  /**
   * cpumask_weight - Count of bits in *srcp
   * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
   */
  static inline unsigned int cpumask_weight(const struct cpumask *srcp)
  {
  	return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
  }


I don't know what the comment on srcp is trying to say. It's not true
that it only counts nr_cpu_ids worth of bits.

So it does seem if we're passed a mask with > nr_cpu_ids bits set then
cpumask_weight() will return > nr_cpu_ids, which is .. unhelpful.


BUT, I don't see other code handling cpumask_weight() returning >
nr_cpu_ids - at least I can't find any with some grepping.


So what is going wrong here that we're being passed a mask with more
than nr_cpu_ids bits set?

I think the affinity mask is copied to the desc in desc_smp_init(), and
the call chain will be:

  irq_create_mapping()
    -> irq_domain_alloc_descs()
       -> __irq_alloc_descs()
          -> alloc_descs()
             -> alloc_desc()
                -> desc_set_defaults()
                   -> desc_smp_init()

irq_create_mapping() is doing:

  virq =3D irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node), NU=
LL);

Where the affinity mask is the NULL at the end.

So presumably we're hitting the irq_default_affinity case here:

  static void desc_smp_init(struct irq_desc *desc, int node,
  			  const struct cpumask *affinity)
  {
  	if (!affinity)
  		affinity =3D irq_default_affinity;
  	cpumask_copy(desc->irq_common_data.affinity, affinity);


Which comes from:

  static void __init init_irq_default_affinity(void)
  {
  #ifdef CONFIG_CPUMASK_OFFSTACK
  	if (!irq_default_affinity)
  		zalloc_cpumask_var(&irq_default_affinity, GFP_NOWAIT);
  #endif
  	if (cpumask_empty(irq_default_affinity))
  		cpumask_setall(irq_default_affinity);
  }

And cpumask_setall() will indeed set NR_CPUs bits.


So that all seems sane, except that it does mean cpumask_weight() can
return > nr_cpu_ids which is awkward.

I guess this patch is a good fix, I'll expand the change log a bit.

cheers


> This can result in such WARNINGs in xive_find_target_in_mask():
>
>    [    0.094480] WARNING: CPU: 10 PID: 1 at ../arch/powerpc/sysdev/xive/=
common.c:476 xive_find_target_in_mask+0x110/0x2f0
>    [    0.094486] Modules linked in:
>    [    0.094491] CPU: 10 PID: 1 Comm: swapper/0 Not tainted 4.12.0+ #3
>    [    0.094496] task: c0000003fae4f200 task.stack: c0000003fe108000
>    [    0.094501] NIP: c00000000008a310 LR: c00000000008a2e4 CTR: 0000000=
00072ca34
>    [    0.094506] REGS: c0000003fe10b360 TRAP: 0700   Not tainted  (4.12.=
0+)
>    [    0.094510] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
>    [    0.094515]   CR: 88000222  XER: 20040008
>    [    0.094521] CFAR: c00000000008a2cc SOFTE: 0
>    [    0.094521] GPR00: c00000000008a274 c0000003fe10b5e0 c000000001428f=
00 0000000000000010
>    [    0.094521] GPR04: 0000000000000010 0000000000000010 00000000000000=
10 0000000000000099
>    [    0.094521] GPR08: 0000000000000010 0000000000000001 ffffffffffff00=
00 0000000000000000
>    [    0.094521] GPR12: 0000000000000000 c00000000fff2d00 c00000000000d4=
d8 0000000000000000
>    [    0.094521] GPR16: 0000000000000000 0000000000000000 00000000000000=
00 0000000000000000
>    [    0.094521] GPR20: 0000000000000000 0000000000000000 00000000000000=
00 c000000000b451e8
>    [    0.094521] GPR24: 00000000ffffffff c000000001462354 00000000000008=
00 00000000000007ff
>    [    0.094521] GPR28: c000000001462354 0000000000000010 c0000003f857e4=
18 0000000000000010
>    [    0.094580] NIP [c00000000008a310] xive_find_target_in_mask+0x110/0=
x2f0
>    [    0.094585] LR [c00000000008a2e4] xive_find_target_in_mask+0xe4/0x2=
f0
>    [    0.094589] Call Trace:
>    [    0.094593] [c0000003fe10b5e0] [c00000000008a274] xive_find_target_=
in_mask+0x74/0x2f0 (unreliable)
>    [    0.094601] [c0000003fe10b690] [c00000000008abf0] xive_pick_irq_tar=
get.isra.1+0x200/0x230
>    [    0.094608] [c0000003fe10b830] [c00000000008b250] xive_irq_startup+=
0x60/0x180
>    [    0.094614] [c0000003fe10b8b0] [c0000000001608f0] irq_startup+0x70/=
0xd0
>    [    0.094620] [c0000003fe10b8f0] [c00000000015df7c] __setup_irq+0x7bc=
/0x880
>    [    0.094626] [c0000003fe10ba90] [c00000000015e30c] request_threaded_=
irq+0x14c/0x2c0
>    [    0.094632] [c0000003fe10baf0] [c0000000000aeb00] request_event_sou=
rces_irqs+0x100/0x180
>    [    0.094639] [c0000003fe10bc10] [c000000000e7d2f8] __machine_initcal=
l_pseries_init_ras_IRQ+0x104/0x134
>    [    0.094646] [c0000003fe10bc40] [c00000000000cc88] do_one_initcall+0=
x68/0x1d0
>    [    0.094652] [c0000003fe10bd00] [c000000000e643c8] kernel_init_freea=
ble+0x290/0x374
>    [    0.094658] [c0000003fe10bdc0] [c00000000000d4f4] kernel_init+0x24/=
0x170
>    [    0.094664] [c0000003fe10be30] [c00000000000b268] ret_from_kernel_t=
hread+0x5c/0x74
>    [    0.094669] Instruction dump:
>    [    0.094673] 48586529 60000000 e8dc0002 393f0001 7f9b4800 7c7d07b4 7=
d3f07b4 409effcc
>    [    0.094682] 7f9d3000 7d26e850 79290fe0 69290001 <0b090000> 409c0194=
 3f620004 3b7b8ec8
>
> Fix this problem by using a minimum value.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/sysdev/xive/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index 536ee15f61fb..4dac7d560a42 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -463,7 +463,7 @@ static int xive_find_target_in_mask(const struct cpum=
ask *mask,
>  	int cpu, first, num, i;
>=20=20
>  	/* Pick up a starting point CPU in the mask based on  fuzz */
> -	num =3D cpumask_weight(mask);
> +	num =3D min_t(int, cpumask_weight(mask), nr_cpu_ids);
>  	first =3D fuzz % num;
>=20=20
>  	/* Locate it */
> --=20
> 2.7.5
