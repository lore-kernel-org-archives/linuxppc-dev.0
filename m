Return-Path: <TakashiA.Yamamoto@jp.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id BB050DDFA4
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 00:21:38 +1100 (EST)
Received: from mail34.sony.co.jp (localhost [127.0.0.1])
	by mail34.sony.co.jp (R8/Sony) with ESMTP id m09DLZif016375
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 22:21:35 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail34.sony.co.jp (R8/Sony) with SMTP id m09DLZBN016368
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 22:21:35 +0900 (JST)
From: "TakashiYamamoto" <TakashiA.Yamamoto@jp.sony.com>
To: "'Geoff Levand'" <geoffrey.levand@am.sony.com>, <paulus@samba.org>
References: <477EF59C.2070809@am.sony.com> <47846B48.5000003@am.sony.com>
In-Reply-To: <47846B48.5000003@am.sony.com>
Subject: RE: [patch 4/4 v2] PS3: Add logical performance monitor driver support
Date: Wed, 9 Jan 2008 22:20:59 +0900
Message-ID: <002001c852c2$7ae35130$70a9f390$@Yamamoto@jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I found a bug in our patch.

> +/**
> + * ps3_lpm_open - Open the logical performance monitor device.
> + * @tb_type: Specifies the type of trace buffer lv1 sould use for this lpm
> + *  instance, specified by one of enum ps3_lpm_tb_type.
> + * @tb_cache: Optional user supplied buffer to use as the trace buffer cache.
> + *  If NULL, the driver will allocate and manage an internal buffer.
> + *  Unused when when @tb_type is PS3_LPM_TB_TYPE_NONE.
> + * @tb_cache_size: The size in bytes of the user supplied @tb_cache buffer.
> + *  Unused when @tb_cache is NULL or @tb_type is PS3_LPM_TB_TYPE_NONE.
> + */
> +
> +int ps3_lpm_open(enum ps3_lpm_tb_type tb_type, void *tb_cache,
> +	u64 tb_cache_size)
> +{
> +	int result;
> +	u64 tb_size;
> +
> +	BUG_ON(!lpm_priv);
> +	BUG_ON(tb_type != PS3_LPM_TB_TYPE_NONE
> +		&& tb_type != PS3_LPM_TB_TYPE_INTERNAL);
> +
> +	if (tb_type == PS3_LPM_TB_TYPE_NONE && tb_cache)
> +		dev_dbg(sbd_core(), "%s:%u: bad in vals\n", __func__, __LINE__);
> +
> +	if (!atomic_add_unless(&lpm_priv->open, 1, 1)) {
> +		dev_dbg(sbd_core(), "%s:%u: busy\n", __func__, __LINE__);
> +		return -EBUSY;
> +	}
> +
> +	if (tb_type == PS3_LPM_TB_TYPE_NONE) {
> +		lpm_priv->tb_cache_internal = NULL;
> +		lpm_priv->tb_cache_size = 0;
> +		lpm_priv->tb_cache = NULL;
> +	} else if (tb_cache) {
> +		if (tb_cache != (void *)_ALIGN_UP((unsigned long)tb_cache, 128)
> +			|| tb_cache_size != _ALIGN_UP(tb_cache_size, 128)) {
> +			dev_err(sbd_core(), "%s:%u: unaligned tb_cache\n",
> +				__func__, __LINE__);
> +			result = -EINVAL;
> +			goto fail_align;
> +		}
> +		lpm_priv->tb_cache_internal = NULL;
> +		lpm_priv->tb_cache_size = tb_cache_size;
> +		lpm_priv->tb_cache = tb_cache;
> +	} else {
> +		/* tb_cache needs 128 byte alignment. */
> +		lpm_priv->tb_cache_size = PS3_LPM_DEFAULT_TB_CACHE_SIZE;
> +		lpm_priv->tb_cache_internal = kzalloc(tb_cache_size + 127,

The first parameter of kzalloc() is wrong.

		lpm_priv->tb_cache_internal = kzalloc(lpm_priv->tb_cache_size + 127,
                                                      ^^^^^^^^^^

> +			GFP_KERNEL);
> +		if (!lpm_priv->tb_cache_internal) {
> +			dev_err(sbd_core(), "%s:%u: alloc internal tb_cache "
> +				"failed\n", __func__, __LINE__);
> +			result = -ENOMEM;
> +			goto fail_malloc;
> +		}
> +		lpm_priv->tb_cache = (void *)_ALIGN_UP(
> +			(unsigned long)lpm_priv->tb_cache_internal, 128);
> +	}
> +
> +	result = lv1_construct_lpm(0, tb_type, 0, 0,
> +				ps3_mm_phys_to_lpar(__pa(lpm_priv->tb_cache)),
> +				lpm_priv->tb_cache_size, &lpm_priv->lpm_id,
> +				&lpm_priv->outlet_id, &tb_size);
> +
> +	if (result) {
> +		dev_err(sbd_core(), "%s:%u: lv1_construct_lpm failed: %s\n",
> +			__func__, __LINE__, ps3_result(result));
> +		result = -EINVAL;
> +		goto fail_construct;
> +	}
> +
> +	lpm_priv->shadow.pm_control = PS3_LPM_SHADOW_REG_INIT;
> +	lpm_priv->shadow.pm_start_stop = PS3_LPM_SHADOW_REG_INIT;
> +	lpm_priv->shadow.pm_interval = PS3_LPM_SHADOW_REG_INIT;
> +	lpm_priv->shadow.group_control = PS3_LPM_SHADOW_REG_INIT;
> +	lpm_priv->shadow.debug_bus_control = PS3_LPM_SHADOW_REG_INIT;
> +
> +	dev_dbg(sbd_core(), "%s:%u: lpm_id 0x%lx, outlet_id 0x%lx, "
> +		"tb_size 0x%lx\n", __func__, __LINE__, lpm_priv->lpm_id,
> +		lpm_priv->outlet_id, tb_size);
> +
> +	return 0;
> +
> +fail_construct:
> +	kfree(lpm_priv->tb_cache_internal);
> +	lpm_priv->tb_cache_internal = NULL;
> +fail_malloc:
> +fail_align:
> +	atomic_dec(&lpm_priv->open);
> +	return result;
> +}
> +EXPORT_SYMBOL_GPL(ps3_lpm_open);

Thanks.
Takashi Yamamoto.
