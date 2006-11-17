Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 077DB67BBC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 21:33:36 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kAHAXXLP018217
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:33:33 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kAHAXXqK018644
	for linuxppc-dev@ozlabs.org; Fri, 17 Nov 2006 19:33:33 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kAHAXW8B001712
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:33:32 +0900 (JST)
Date: Fri, 17 Nov 2006 19:33:31 +0900 (JST)
Message-Id: <200611171033.kAHAXV97013086@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/16] add hypervisor support for SPU
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd-san,

> On Wednesday 15 November 2006 10:28, Ishizaki Kou wrote:
> 
> > +static int __init find_spu_unit_number(struct device_node *spe)
> > +{
> > +       const unsigned int *reg;
> > +       reg = get_property(spe, "reg", NULL);
> > +       return reg ? *reg : 0;
> > +}
> > +
> 
> The unit number shold not be in the 'reg' property any more. With
> the device tree layout we want to migrate to for better OFW compatibility,
> 'reg' should contain the addresses of local store, problem state and priv2
> mappings, in that order.
> 
> Having the function is fine, but your interface needs to be a different
> property.

We don't think that standard binding for SPE exists. Do you have any
proposal? If you have, please send us your binding.

On our device tree, property "reg" has unit number. Addresses are in
property "priv2", "problem" and "local-store". Because of LPAR
environment, property "priv1" does not exist.


> > @@ -805,7 +816,11 @@
> >         if (ret)
> >                 goto out_unmap;
> >         spin_lock_init(&spu->register_lock);
> > -       spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
> > +#ifdef CONFIG_SPU_NEED_SHADOW_INT_MASK
> > +       spin_lock_init(&spu->int_mask_lock);
> > +#endif
> > +       if (!(firmware_has_feature(FW_FEATURE_LPAR)))
> > +               spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
> >         spu_mfc_sr1_set(spu, 0x33);
> > ...
> >         u32 node;
> > +       u32 unit_number;
> >         u64 flags;
> >         u64 dar;
> >         u64 dsisr;
> > +#ifdef CONFIG_SPU_NEED_SHADOW_INT_MASK
> > +       spinlock_t int_mask_lock;
> > +       u64 shadow_int_mask_RW[3];
> > +#endif
> >         size_t ls_size;
> >         unsigned int slb_replace;
> >         struct mm_struct *mm;
> 
> Not sure what others think about this, but I'd prefer not to have the
> #ifdef here at all. This part is not a fast path, so we can spend the
> few extra bytes and cycles on keeping it in the kernel always.
> 
> The place where it is used should still have a run-time check for whether
> it's running on BEAT.

When Geoff-san's "abstract spu management routines" patch is accepted,
we have to rewrite this code to meet with that patch.
These data and initializer will be moved to platform-dependent files.

Thank you,
Kou Ishizaki
Toshiba
