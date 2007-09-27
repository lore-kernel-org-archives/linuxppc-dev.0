Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1114DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 18:31:12 +1000 (EST)
Subject: Re: [PATCH 4/7] Celleb: New HTAB Guest OS Interface on Beat
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20070927.165326.-1300536104.kouish@swc.toshiba.co.jp>
References: <20070927.165326.-1300536104.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 18:31:06 +1000
Message-Id: <1190881866.6158.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-09-27 at 16:53 +0900, Ishizaki Kou wrote:
> This is a patch kit to work with new Guest OS Interface
> to tweak HTAB on Beat. It detects old and new Guest OS Interfaces
> automatically.

You may also consider adding an API to Beat to invalidate ranges of
addresses. We could us that through the batch invalidate mechanism to
speed up significantly process tear down and forks typically.

> Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
> ---
> 
> Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
> ===================================================================
> --- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/setup.c
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
> @@ -119,7 +119,7 @@ static int __init celleb_probe(void)
>  		return 0;
>  
>  	powerpc_firmware_features |= FW_FEATURE_CELLEB_POSSIBLE;
> -	hpte_init_beat();
> +	hpte_init_beat_v3();
>  	return 1;
>  }
>  
> Index: linux-powerpc-git/include/asm-powerpc/mmu-hash64.h
> ===================================================================
> --- linux-powerpc-git.orig/include/asm-powerpc/mmu-hash64.h
> +++ linux-powerpc-git/include/asm-powerpc/mmu-hash64.h
> @@ -256,6 +256,7 @@ extern void hpte_init_native(void);
>  extern void hpte_init_lpar(void);
>  extern void hpte_init_iSeries(void);
>  extern void hpte_init_beat(void);
> +extern void hpte_init_beat_v3(void);
>  
>  extern void stabs_alloc(void);
>  extern void slb_initialize(void);
> Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat_syscall.h
> ===================================================================
> --- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/beat_syscall.h
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat_syscall.h
> @@ -157,4 +157,8 @@
>  #define HV_rtc_write __BEAT_ADD_VENDOR_ID(0x191, 1)
>  #define HV_eeprom_read __BEAT_ADD_VENDOR_ID(0x192, 1)
>  #define HV_eeprom_write __BEAT_ADD_VENDOR_ID(0x193, 1)
> +#define HV_insert_htab_entry3 __BEAT_ADD_VENDOR_ID(0x104, 1)
> +#define HV_invalidate_htab_entry3 __BEAT_ADD_VENDOR_ID(0x105, 1)
> +#define HV_update_htab_permission3 __BEAT_ADD_VENDOR_ID(0x106, 1)
> +#define HV_clear_htab3 __BEAT_ADD_VENDOR_ID(0x107, 1)
>  #endif
> Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat_wrapper.h
> ===================================================================
> --- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/beat_wrapper.h
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat_wrapper.h
> @@ -98,6 +98,37 @@ static inline s64 beat_write_htab_entry(
>  	return ret;
>  }
>  
> +static inline s64 beat_insert_htab_entry3(u64 htab_id, u64 group,
> +	u64 hpte_v, u64 hpte_r, u64 mask_v, u64 value_v, u64 *slot)
> +{
> +	u64 dummy[1];
> +	s64 ret;
> +
> +	ret = beat_hcall1(HV_insert_htab_entry3, dummy, htab_id, group,
> +		hpte_v, hpte_r, mask_v, value_v);
> +	*slot = dummy[0];
> +	return ret;
> +}
> +
> +static inline s64 beat_invalidate_htab_entry3(u64 htab_id, u64 group,
> +	u64 va, u64 pss)
> +{
> +	return beat_hcall_norets(HV_invalidate_htab_entry3,
> +		htab_id, group, va, pss);
> +}
> +
> +static inline s64 beat_update_htab_permission3(u64 htab_id, u64 group,
> +	u64 va, u64 pss, u64 ptel_mask, u64 ptel_value)
> +{
> +	return beat_hcall_norets(HV_update_htab_permission3,
> +		htab_id, group, va, pss, ptel_mask, ptel_value);
> +}
> +
> +static inline s64 beat_clear_htab3(u64 htab_id)
> +{
> +	return beat_hcall_norets(HV_clear_htab3, htab_id);
> +}
> +
>  static inline void beat_shutdown_logical_partition(u64 code)
>  {
>  	(void)beat_hcall_norets(HV_shutdown_logical_partition, code);
> @@ -217,4 +248,41 @@ static inline s64 beat_put_iopte(u64 ioa
>  		ioid, flags);
>  }
>  
> +static inline s64 beat_construct_event_receive_port(u64 *port)
> +{
> +	u64 dummy[1];
> +	s64 ret;
> +
> +	ret = beat_hcall1(HV_construct_event_receive_port, dummy);
> +	*port = dummy[0];
> +	return ret;
> +}
> +
> +static inline s64 beat_destruct_event_receive_port(u64 port)
> +{
> +	s64 ret;
> +
> +	ret = beat_hcall_norets(HV_destruct_event_receive_port, port);
> +	return ret;
> +}
> +
> +static inline s64 beat_create_repository_node(u64 path[4], u64 data[2])
> +{
> +	s64 ret;
> +
> +	ret = beat_hcall_norets(HV_create_repository_node2,
> +		path[0], path[1], path[2], path[3], data[0], data[1]);
> +	return ret;
> +}
> +
> +static inline s64 beat_get_repository_node_value(u64 lpid, u64 path[4],
> +	u64 data[2])
> +{
> +	s64 ret;
> +
> +	ret = beat_hcall2(HV_get_repository_node_value2, data,
> +		lpid, path[0], path[1], path[2], path[3]);
> +	return ret;
> +}
> +
>  #endif
> Index: linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c
> ===================================================================
> --- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/htab.c
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/htab.c
> @@ -306,3 +306,133 @@ void __init hpte_init_beat(void)
>  	ppc_md.hpte_remove	= beat_lpar_hpte_remove;
>  	ppc_md.hpte_clear_all	= beat_lpar_hptab_clear;
>  }
> +
> +static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
> +				  unsigned long va, unsigned long pa,
> +				  unsigned long rflags, unsigned long vflags,
> +				  int psize)
> +{
> +	unsigned long lpar_rc;
> +	unsigned long slot;
> +	unsigned long hpte_v, hpte_r;
> +
> +	/* same as iseries */
> +	if (vflags & HPTE_V_SECONDARY)
> +		return -1;
> +
> +	if (!(vflags & HPTE_V_BOLTED))
> +		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
> +			"rflags=%lx, vflags=%lx, psize=%d)\n",
> +		hpte_group, va, pa, rflags, vflags, psize);
> +
> +	hpte_v = hpte_encode_v(va, psize) | vflags | HPTE_V_VALID;
> +	hpte_r = hpte_encode_r(pa, psize) | rflags;
> +
> +	if (!(vflags & HPTE_V_BOLTED))
> +		DBG_LOW(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
> +
> +	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
> +		hpte_r &= ~_PAGE_COHERENT;
> +
> +	/* insert into not-volted entry */
> +	lpar_rc = beat_insert_htab_entry3(0, hpte_group, hpte_v, hpte_r,
> +		HPTE_V_BOLTED, 0, &slot);
> +	/*
> +	 * Since we try and ioremap PHBs we don't own, the pte insert
> +	 * will fail. However we must catch the failure in hash_page
> +	 * or we will loop forever, so return -2 in this case.
> +	 */
> +	if (unlikely(lpar_rc != 0)) {
> +		if (!(vflags & HPTE_V_BOLTED))
> +			DBG_LOW(" lpar err %lx\n", lpar_rc);
> +		return -2;
> +	}
> +	if (!(vflags & HPTE_V_BOLTED))
> +		DBG_LOW(" -> slot: %lx\n", slot);
> +
> +	/* We have to pass down the secondary bucket bit here as well */
> +	return (slot ^ hpte_group) & 15;
> +}
> +
> +/*
> + * NOTE: for updatepp ops we are fortunate that the linux "newpp" bits and
> + * the low 3 bits of flags happen to line up.  So no transform is needed.
> + * We can probably optimize here and assume the high bits of newpp are
> + * already zero.  For now I am paranoid.
> + */
> +static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
> +				    unsigned long newpp,
> +				    unsigned long va,
> +				    int psize, int local)
> +{
> +	unsigned long lpar_rc;
> +	unsigned long want_v;
> +	unsigned long pss;
> +
> +	want_v = hpte_encode_v(va, psize);
> +	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
> +
> +	DBG_LOW("    update: "
> +		"avpnv=%016lx, slot=%016lx, psize: %d, newpp %016lx ... ",
> +		want_v & HPTE_V_AVPN, slot, psize, newpp);
> +
> +	lpar_rc = beat_update_htab_permission3(0, slot, want_v, pss, 7, newpp);
> +
> +	if (lpar_rc == 0xfffffff7) {
> +		DBG_LOW("not found !\n");
> +		return -1;
> +	}
> +
> +	DBG_LOW("ok\n");
> +
> +	BUG_ON(lpar_rc != 0);
> +
> +	return 0;
> +}
> +
> +static void beat_lpar_hpte_invalidate_v3(unsigned long slot, unsigned long va,
> +					 int psize, int local)
> +{
> +	unsigned long want_v;
> +	unsigned long lpar_rc;
> +	unsigned long pss;
> +
> +	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
> +		slot, va, psize, local);
> +	want_v = hpte_encode_v(va, psize);
> +	pss = (psize == MMU_PAGE_4K) ? -1UL : mmu_psize_defs[psize].penc;
> +
> +	lpar_rc = beat_invalidate_htab_entry3(0, slot, want_v, pss);
> +
> +	/* E_busy can be valid output: page may be already replaced */
> +	BUG_ON(lpar_rc != 0 && lpar_rc != 0xfffffff7);
> +}
> +
> +static int64_t _beat_lpar_hptab_clear_v3(void)
> +{
> +	return beat_clear_htab3(0);
> +}
> +
> +static void beat_lpar_hptab_clear_v3(void)
> +{
> +	_beat_lpar_hptab_clear_v3();
> +}
> +
> +void __init hpte_init_beat_v3(void)
> +{
> +	if (_beat_lpar_hptab_clear_v3() == 0) {
> +		ppc_md.hpte_invalidate	= beat_lpar_hpte_invalidate_v3;
> +		ppc_md.hpte_updatepp	= beat_lpar_hpte_updatepp_v3;
> +		ppc_md.hpte_updateboltedpp = beat_lpar_hpte_updateboltedpp;
> +		ppc_md.hpte_insert	= beat_lpar_hpte_insert_v3;
> +		ppc_md.hpte_remove	= beat_lpar_hpte_remove;
> +		ppc_md.hpte_clear_all	= beat_lpar_hptab_clear_v3;
> +	} else {
> +		ppc_md.hpte_invalidate	= beat_lpar_hpte_invalidate;
> +		ppc_md.hpte_updatepp	= beat_lpar_hpte_updatepp;
> +		ppc_md.hpte_updateboltedpp = beat_lpar_hpte_updateboltedpp;
> +		ppc_md.hpte_insert	= beat_lpar_hpte_insert;
> +		ppc_md.hpte_remove	= beat_lpar_hpte_remove;
> +		ppc_md.hpte_clear_all	= beat_lpar_hptab_clear;
> +	}
> +}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
