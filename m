Return-Path: <srs0=xpzz=3n=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vz1Xp4LwpzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 09:00:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vz1Xp3qJCz8sX0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 09:00:58 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vz1Xn0KSNz9sDF
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2017 09:00:56 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v35N0VXv021475
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Apr 2017 18:00:37 -0500
Message-ID: <1491433230.4166.96.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 04/10] powerpc/xive: Native exploitation of the XIVE
 interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Thu, 06 Apr 2017 09:00:30 +1000
In-Reply-To: <201704060615.jhUAdOZN%fengguang.wu@intel.com>
References: <201704060615.jhUAdOZN%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-06 at 06:46 +0800, kbuild test robot wrote:
> Hi Benjamin,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.11-rc5 next-20170405]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system]

Ooops, I was 1 patch off in my git send-email, forgetting the
opal-api.h updates. I'm sending the pre-req patch separately.

Cheers,
Ben.

> url:    https://github.com/0day-ci/linux/commits/Benjamin-
> Herrenschmidt/powerpc-Add-more-PPC-bit-conversion-macros/20170406-
> 041935
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> .git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master
> /sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_populate_irq_data':
> > > arch/powerpc/sysdev/xive/native.c:55:7: error: implicit
> > > declaration of function 'opal_xive_get_irq_info' [-
> > > Werror=implicit-function-declaration]
> 
>      rc = opal_xive_get_irq_info(hw_irq, &flags, &eoi_page,
> &trig_page,
>           ^~~~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:64:19: error:
> > > 'OPAL_XIVE_IRQ_STORE_EOI' undeclared (first use in this function)
> 
>      if (opal_flags & OPAL_XIVE_IRQ_STORE_EOI)
>                       ^~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c:64:19: note: each undeclared
> identifier is reported only once for each function it appears in
> > > arch/powerpc/sysdev/xive/native.c:66:19: error:
> > > 'OPAL_XIVE_IRQ_LSI' undeclared (first use in this function)
> 
>      if (opal_flags & OPAL_XIVE_IRQ_LSI)
>                       ^~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:68:19: error:
> > > 'OPAL_XIVE_IRQ_SHIFT_BUG' undeclared (first use in this function)
> 
>      if (opal_flags & OPAL_XIVE_IRQ_SHIFT_BUG)
>                       ^~~~~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:70:19: error:
> > > 'OPAL_XIVE_IRQ_MASK_VIA_FW' undeclared (first use in this
> > > function)
> 
>      if (opal_flags & OPAL_XIVE_IRQ_MASK_VIA_FW)
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:72:19: error:
> > > 'OPAL_XIVE_IRQ_EOI_VIA_FW' undeclared (first use in this
> > > function)
> 
>      if (opal_flags & OPAL_XIVE_IRQ_EOI_VIA_FW)
>                       ^~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_configure_irq':
> > > arch/powerpc/sysdev/xive/native.c:105:8: error: implicit
> > > declaration of function 'opal_xive_set_irq_config' [-
> > > Werror=implicit-function-declaration]
> 
>       rc = opal_xive_set_irq_config(hw_irq, target, prio, sw_irq);
>            ^~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_configure_queue':
> > > arch/powerpc/sysdev/xive/native.c:135:7: error: implicit
> > > declaration of function 'opal_xive_get_queue_info' [-
> > > Werror=implicit-function-declaration]
> 
>      rc = opal_xive_get_queue_info(vp_id, prio, NULL, NULL,
>           ^~~~~~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:148:10: error:
> > > 'OPAL_XIVE_EQ_ALWAYS_NOTIFY' undeclared (first use in this
> > > function)
> 
>      flags = OPAL_XIVE_EQ_ALWAYS_NOTIFY | OPAL_XIVE_EQ_ENABLED;
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:148:39: error:
> > > 'OPAL_XIVE_EQ_ENABLED' undeclared (first use in this function)
> 
>      flags = OPAL_XIVE_EQ_ALWAYS_NOTIFY | OPAL_XIVE_EQ_ENABLED;
>                                           ^~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:153:12: error:
> > > 'OPAL_XIVE_EQ_ESCALATE' undeclared (first use in this function)
> 
>       flags |= OPAL_XIVE_EQ_ESCALATE;
>                ^~~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:158:8: error: implicit
> > > declaration of function 'opal_xive_set_queue_info' [-
> > > Werror=implicit-function-declaration]
> 
>       rc = opal_xive_set_queue_info(vp_id, prio, qpage_phys, order,
> flags);
>            ^~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_get_ipi':
> > > arch/powerpc/sysdev/xive/native.c:254:9: error: implicit
> > > declaration of function 'opal_xive_allocate_irq' [-
> > > Werror=implicit-function-declaration]
> 
>       irq = opal_xive_allocate_irq(chip_id);
>             ^~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_alloc_irq':
> > > arch/powerpc/sysdev/xive/native.c:275:31: error:
> > > 'OPAL_XIVE_ANY_CHIP' undeclared (first use in this function)
> 
>       rc = opal_xive_allocate_irq(OPAL_XIVE_ANY_CHIP);
>                                   ^~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_free_irq':
> > > arch/powerpc/sysdev/xive/native.c:288:12: error: implicit
> > > declaration of function 'opal_xive_free_irq' [-Werror=implicit-
> > > function-declaration]
> 
>       s64 rc = opal_xive_free_irq(irq);
>                ^~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_shutdown':
> > > arch/powerpc/sysdev/xive/native.c:317:2: error: implicit
> > > declaration of function 'opal_xive_reset' [-Werror=implicit-
> > > function-declaration]
> 
>      opal_xive_reset(OPAL_XIVE_MODE_EMU);
>      ^~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:317:18: error:
> > > 'OPAL_XIVE_MODE_EMU' undeclared (first use in this function)
> 
>      opal_xive_reset(OPAL_XIVE_MODE_EMU);
>                      ^~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_setup_cpu':
> > > arch/powerpc/sysdev/xive/native.c:392:8: error: implicit
> > > declaration of function 'opal_xive_set_vp_info' [-
> > > Werror=implicit-function-declaration]
> 
>       rc = opal_xive_set_vp_info(vp, OPAL_XIVE_VP_ENABLED, 0);
>            ^~~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:392:34: error:
> > > 'OPAL_XIVE_VP_ENABLED' undeclared (first use in this function)
> 
>       rc = opal_xive_set_vp_info(vp, OPAL_XIVE_VP_ENABLED, 0);
>                                      ^~~~~~~~~~~~~~~~~~~~
> > > arch/powerpc/sysdev/xive/native.c:403:7: error: implicit
> > > declaration of function 'opal_xive_get_vp_info' [-
> > > Werror=implicit-function-declaration]
> 
>      rc = opal_xive_get_vp_info(vp, NULL, &vp_cam_be, NULL, NULL);
>           ^~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/sysdev/xive/native.c: In function
> 'xive_native_sync_source':
> --
>    arch/powerpc/xmon/xmon.c: In function 'dump_one_xive':
> > > arch/powerpc/xmon/xmon.c:2352:2: error: implicit declaration of
> > > function 'opal_xive_dump' [-Werror=implicit-function-declaration]
> 
>      opal_xive_dump(XIVE_DUMP_TM_HYP, hwid);
>      ^~~~~~~~~~~~~~
> > > arch/powerpc/xmon/xmon.c:2352:17: error: 'XIVE_DUMP_TM_HYP'
> > > undeclared (first use in this function)
> 
>      opal_xive_dump(XIVE_DUMP_TM_HYP, hwid);
>                     ^~~~~~~~~~~~~~~~
>    arch/powerpc/xmon/xmon.c:2352:17: note: each undeclared identifier
> is reported only once for each function it appears in
> > > arch/powerpc/xmon/xmon.c:2353:17: error: 'XIVE_DUMP_TM_POOL'
> > > undeclared (first use in this function)
> 
>      opal_xive_dump(XIVE_DUMP_TM_POOL, hwid);
>                     ^~~~~~~~~~~~~~~~~
> > > arch/powerpc/xmon/xmon.c:2354:17: error: 'XIVE_DUMP_TM_OS'
> > > undeclared (first use in this function)
> 
>      opal_xive_dump(XIVE_DUMP_TM_OS, hwid);
>                     ^~~~~~~~~~~~~~~
> > > arch/powerpc/xmon/xmon.c:2355:17: error: 'XIVE_DUMP_TM_USER'
> > > undeclared (first use in this function)
> 
>      opal_xive_dump(XIVE_DUMP_TM_USER, hwid);
>                     ^~~~~~~~~~~~~~~~~
> > > arch/powerpc/xmon/xmon.c:2356:17: error: 'XIVE_DUMP_VP'
> > > undeclared (first use in this function)
> 
>      opal_xive_dump(XIVE_DUMP_VP, hwid);
>                     ^~~~~~~~~~~~
> > > arch/powerpc/xmon/xmon.c:2357:17: error: 'XIVE_DUMP_EMU_STATE'
> > > undeclared (first use in this function)
> 
>      opal_xive_dump(XIVE_DUMP_EMU_STATE, hwid);
>                     ^~~~~~~~~~~~~~~~~~~
>    arch/powerpc/xmon/xmon.c: In function 'dump_one_xive_irq':
> > > arch/powerpc/xmon/xmon.c:2393:7: error: implicit declaration of
> > > function 'opal_xive_get_irq_config' [-Werror=implicit-function-
> > > declaration]
> 
>      rc = opal_xive_get_irq_config(num, &vp, &prio, &lirq);
>           ^~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +/opal_xive_get_irq_info +55 arch/powerpc/sysdev/xive/native.c
> 
>     49		__be32 esb_shift, src_chip;
>     50		u64 opal_flags;
>     51		s64 rc;
>     52	
>     53		memset(data, 0, sizeof(*data));
>     54	
>   > 55		rc = opal_xive_get_irq_info(hw_irq, &flags,
> &eoi_page, &trig_page,
>     56					    &esb_shift,
> &src_chip);
>     57		if (rc) {
>     58			pr_err("XIVE:
> opal_xive_get_irq_info(0x%x) returned %lld\n",
>     59			       hw_irq, rc);
>     60			return -EINVAL;
>     61		}
>     62	
>     63		opal_flags = be64_to_cpu(flags);
>   > 64		if (opal_flags & OPAL_XIVE_IRQ_STORE_EOI)
>     65			data->flags |= XIVE_IRQ_FLAG_STORE_EOI;
>   > 66		if (opal_flags & OPAL_XIVE_IRQ_LSI)
>     67			data->flags |= XIVE_IRQ_FLAG_LSI;
>   > 68		if (opal_flags & OPAL_XIVE_IRQ_SHIFT_BUG)
>     69			data->flags |= XIVE_IRQ_FLAG_SHIFT_BUG;
>   > 70		if (opal_flags & OPAL_XIVE_IRQ_MASK_VIA_FW)
>     71			data->flags |= XIVE_IRQ_FLAG_MASK_FW;
>   > 72		if (opal_flags & OPAL_XIVE_IRQ_EOI_VIA_FW)
>     73			data->flags |= XIVE_IRQ_FLAG_EOI_FW;
>     74		data->eoi_page = be64_to_cpu(eoi_page);
>     75		data->trig_page = be64_to_cpu(trig_page);
>     76		data->esb_shift = be32_to_cpu(esb_shift);
>     77		data->src_chip = be32_to_cpu(src_chip);
>     78	
>     79		data->eoi_mmio = ioremap(data->eoi_page, 1u <<
> data->esb_shift);
>     80		if (!data->eoi_mmio) {
>     81			pr_err("XIVE: Failed to map EOI page
> for irq 0x%x\n", hw_irq);
>     82			return -ENOMEM;
>     83		}
>     84	
>     85		if (!data->trig_page)
>     86			return 0;
>     87		if (data->trig_page == data->eoi_page) {
>     88			data->trig_mmio = data->eoi_mmio;
>     89			return 0;
>     90		}
>     91	
>     92		data->trig_mmio = ioremap(data->trig_page, 1u
> << data->esb_shift);
>     93		if (!data->trig_mmio) {
>     94			pr_err("XIVE: Failed to map trigger
> page for irq 0x%x\n", hw_irq);
>     95			return -ENOMEM;
>     96		}
>     97		return 0;
>     98	}
>     99	
>    100	int xive_native_configure_irq(u32 hw_irq, u32 target,
> u8 prio, u32 sw_irq)
>    101	{
>    102		s64 rc;
>    103	
>    104		for (;;) {
>  > 105			rc = opal_xive_set_irq_config(hw_irq,
> target, prio, sw_irq);
>    106			if (rc != OPAL_BUSY)
>    107				break;
>    108			msleep(1);
>    109		}
>    110		return rc == 0 ? 0 : -ENXIO;
>    111	}
>    112	
>    113	/* This can be called multiple time to change a queue
> configuration */
>    114	int xive_native_configure_queue(u32 vp_id, struct
> xive_q *q, u8 prio,
>    115					__be32 *qpage, u32
> order, bool can_escalate)
>    116	{
>    117		s64 rc = 0;
>    118		__be64 qeoi_page_be;
>    119		__be32 esc_irq_be;
>    120		u64 flags, qpage_phys;
>    121	
>    122		/* If there's an actual queue page, clean it */
>    123		if (order) {
>    124			if (WARN_ON(!qpage))
>    125				return -EINVAL;
>    126			qpage_phys = __pa(qpage);
>    127		} else
>    128			qpage_phys = 0;
>    129	
>    130		/* Initialize the rest of the fields */
>    131		q->msk = order ? ((1u << (order - 2)) - 1) : 0;
>    132		q->idx = 0;
>    133		q->toggle = 0;
>    134	
>  > 135		rc = opal_xive_get_queue_info(vp_id, prio,
> NULL, NULL,
>    136					      &qeoi_page_be,
>    137					      &esc_irq_be,
>    138					      NULL);
>    139		if (rc) {
>    140			pr_err("XIVE: Error %lld getting queue
> info prio %d\n",
>    141			       rc, prio);
>    142			rc = -EIO;
>    143			goto fail;
>    144		}
>    145		q->eoi_phys = be64_to_cpu(qeoi_page_be);
>    146	
>    147		/* Default flags */
>  > 148		flags = OPAL_XIVE_EQ_ALWAYS_NOTIFY |
> OPAL_XIVE_EQ_ENABLED;
>    149	
>    150		/* Escalation needed ? */
>    151		if (can_escalate) {
>    152			q->esc_irq = be32_to_cpu(esc_irq_be);
>  > 153			flags |= OPAL_XIVE_EQ_ESCALATE;
>    154		}
>    155	
>    156		/* Configure and enable the queue in HW */
>    157		for (;;) {
>  > 158			rc = opal_xive_set_queue_info(vp_id,
> prio, qpage_phys, order, flags);
>    159			if (rc != OPAL_BUSY)
>    160				break;
>    161			msleep(1);
>    162		}
>    163		if (rc) {
>    164			pr_err("XIVE: Error %lld setting queue
> for prio %d\n",
>    165			       rc, prio);
>    166			rc = -EIO;
>    167		} else {
>    168			/*
>    169			 * KVM code requires all of the above
> to be visible before
>    170			 * q->qpage is set due to how it
> manages IPI EOIs
>    171			 */
>    172			wmb();
>    173			q->qpage = qpage;
>    174		}
>    175	 fail:
>    176		return rc;
>    177	}
>    178	
>    179	static void __xive_native_disable_queue(u32 vp_id,
> struct xive_q *q, u8 prio)
>    180	{
>    181		s64 rc;
>    182	
>    183		/* Disable the queue in HW */
>    184		for (;;) {
>    185			rc = opal_xive_set_queue_info(vp_id,
> prio, 0, 0, 0);
>    186				break;
>    187			msleep(1);
>    188		}
>    189		if (rc)
>    190			pr_err("XIVE: Error %lld disabling
> queue for prio %d\n",
>    191			       rc, prio);
>    192	}
>    193	
>    194	void xive_native_disable_queue(u32 vp_id, struct xive_q
> *q, u8 prio)
>    195	{
>    196		__xive_native_disable_queue(vp_id, q, prio);
>    197	}
>    198	
>    199	static int xive_native_setup_queue(unsigned int cpu,
> struct xive_cpu *xc, u8 prio)
>    200	{
>    201		struct xive_q *q = &xc->queue[prio];
>    202		unsigned int alloc_order;
>    203		struct page *pages;
>    204		__be32 *qpage;
>    205	
>    206		alloc_order = (xive_queue_shift > PAGE_SHIFT) ?
>    207			(xive_queue_shift - PAGE_SHIFT) : 0;
>    208		pages = alloc_pages_node(cpu_to_node(cpu),
> GFP_KERNEL, alloc_order);
>    209		if (!pages)
>    210			return -ENOMEM;
>    211		qpage = (__be32 *)page_address(pages);
>    212		memset(qpage, 0, 1 << xive_queue_shift);
>    213		return
> xive_native_configure_queue(get_hard_smp_processor_id(cpu),
>    214						   q, prio,
> qpage, xive_queue_shift, false);
>    215	}
>    216	
>    217	static void xive_native_cleanup_queue(unsigned int cpu,
> struct xive_cpu *xc, u8 prio)
>    218	{
>    219		struct xive_q *q = &xc->queue[prio];
>    220		unsigned int alloc_order;
>    221	
>    222		/*
>    223		 * We use the variant with no iounmap as this
> is called on exec
>    224		 * from an IPI and iounmap isn't safe
>    225		 */
>    226		__xive_native_disable_queue(get_hard_smp_proces
> sor_id(cpu), q, prio);
>    227		alloc_order = (xive_queue_shift > PAGE_SHIFT) ?
>    228			(xive_queue_shift - PAGE_SHIFT) : 0;
>    229		free_pages((unsigned long)q->qpage,
> alloc_order);
>    230		q->qpage = NULL;
>    231	}
>    232	
>    233	static bool xive_native_match(struct device_node *node)
>    234	{
>    235		return of_device_is_compatible(node, "ibm,opal-
> xive-vc");
>    236	}
>    237	
>    238	#ifdef CONFIG_SMP
>    239	static int xive_native_get_ipi(unsigned int cpu, struct
> xive_cpu *xc)
>    240	{
>    241		struct device_node *np;
>    242		unsigned int chip_id;
>    243		s64 irq;
>    244	
>    245		/* Find the chip ID */
>    246		np = of_get_cpu_node(cpu, NULL);
>    247		if (np) {
>    248			if (of_property_read_u32(np, "ibm,chip-
> id", &chip_id) < 0)
>    249				chip_id = 0;
>    250		}
>    251	
>    252		/* Allocate an IPI and populate info about it
> */
>    253		for (;;) {
>  > 254			irq = opal_xive_allocate_irq(chip_id);
>    255			if (irq == OPAL_BUSY) {
>    256				msleep(1);
>    257				continue;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
