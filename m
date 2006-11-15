Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 6469467CD2
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 02:47:39 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/16] add hypervisor support for SPU
Date: Wed, 15 Nov 2006 16:47:14 +0100
References: <200611150928.kAF9SkJN021123@toshiba.co.jp>
In-Reply-To: <200611150928.kAF9SkJN021123@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611151647.15695.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 15 November 2006 10:28, Ishizaki Kou wrote:

> +static int __init find_spu_unit_number(struct device_node *spe)
> +{
> +=A0=A0=A0=A0=A0=A0=A0const unsigned int *reg;
> +=A0=A0=A0=A0=A0=A0=A0reg =3D get_property(spe, "reg", NULL);
> +=A0=A0=A0=A0=A0=A0=A0return reg ? *reg : 0;
> +}
> +

The unit number shold not be in the 'reg' property any more. With
the device tree layout we want to migrate to for better OFW compatibility,
'reg' should contain the addresses of local store, problem state and priv2
mappings, in that order.

Having the function is fine, but your interface needs to be a different
property.

> @@ -805,7 +816,11 @@
> =A0=A0=A0=A0=A0=A0=A0=A0if (ret)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out_unmap;
> =A0=A0=A0=A0=A0=A0=A0=A0spin_lock_init(&spu->register_lock);
> -=A0=A0=A0=A0=A0=A0=A0spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
> +#ifdef CONFIG_SPU_NEED_SHADOW_INT_MASK
> +=A0=A0=A0=A0=A0=A0=A0spin_lock_init(&spu->int_mask_lock);
> +#endif
> +=A0=A0=A0=A0=A0=A0=A0if (!(firmware_has_feature(FW_FEATURE_LPAR)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spu_mfc_sdr_set(spu, mfspr(=
SPRN_SDR1));
> =A0=A0=A0=A0=A0=A0=A0=A0spu_mfc_sr1_set(spu, 0x33);
> ...
> =A0=A0=A0=A0=A0=A0=A0=A0u32 node;
> +=A0=A0=A0=A0=A0=A0=A0u32 unit_number;
> =A0=A0=A0=A0=A0=A0=A0=A0u64 flags;
> =A0=A0=A0=A0=A0=A0=A0=A0u64 dar;
> =A0=A0=A0=A0=A0=A0=A0=A0u64 dsisr;
> +#ifdef=A0CONFIG_SPU_NEED_SHADOW_INT_MASK
> +=A0=A0=A0=A0=A0=A0=A0spinlock_t int_mask_lock;
> +=A0=A0=A0=A0=A0=A0=A0u64 shadow_int_mask_RW[3];
> +#endif
> =A0=A0=A0=A0=A0=A0=A0=A0size_t ls_size;
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned int slb_replace;
> =A0=A0=A0=A0=A0=A0=A0=A0struct mm_struct *mm;

Not sure what others think about this, but I'd prefer not to have the
#ifdef here at all. This part is not a fast path, so we can spend the
few extra bytes and cycles on keeping it in the kernel always.

The place where it is used should still have a run-time check for whether
it's running on BEAT.

	Arnd <><
