Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B9EF1A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 17:10:47 +1000 (EST)
Received: from torres.puc.rediris.es (torres.puc.rediris.es
 [IPv6:2001:720:418:ca00::9])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 31532140217
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 17:10:47 +1000 (EST)
Date: Thu, 4 Sep 2014 08:45:16 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Jerome Glisse <j.glisse@gmail.com>
Subject: Re: TTM placement & caching issue/questions
Message-ID: <20140904064516.GA14765@visitor2.iram.es>
References: <1409789547.30640.136.camel@pasglop>
 <20140904015548.GB4835@gmail.com> <20140904020742.GC4835@gmail.com>
 <1409797523.25089.8.camel@pasglop>
 <20140904023117.GD4835@gmail.com> <20140904023656.GF4835@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140904023656.GF4835@gmail.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
 dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 03, 2014 at 10:36:57PM -0400, Jerome Glisse wrote:
> On Wed, Sep 03, 2014 at 10:31:18PM -0400, Jerome Glisse wrote:
> > On Thu, Sep 04, 2014 at 12:25:23PM +1000, Benjamin Herrenschmidt wrote:
> > > On Wed, 2014-09-03 at 22:07 -0400, Jerome Glisse wrote:
> > > 
> > > > So in the meantime the attached patch should work, it just silently ignore
> > > > the caching attribute request on non x86 instead of pretending that things
> > > > are setup as expected and then latter the radeon ou nouveau hw unsetting
> > > > the snoop bit.
> > > > 
> > > > It's not tested but i think it should work.
> > > 
> > > I'm still getting placements with !CACHED going from bo_memcpy in
> > > ttm_io_prot() though ... I'm looking at filtering the placement
> > > attributes instead.
> > > 
> > > Ben.
> > 
> > Ok so this one should do the trick.
> 
> Ok final version ... famous last word.
[snipped older version]
> >From 236038e18dc303bb9aa877922e01963d3fb0b7af Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
> Date: Wed, 3 Sep 2014 22:04:34 -0400
> Subject: [PATCH] drm/ttm: force cached mapping on non x86 platform.
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> People interested in providing uncached or write combined mapping
> on there architecture need to do the ground work inside there arch

s/there/their/g

> specific code to allow to break the linear kernel mapping so that
> page mapping attributes can be updated, in the meantime force cached
> mapping for non x86 architecture.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> ---
>  drivers/gpu/drm/radeon/radeon_ttm.c |  2 +-
>  drivers/gpu/drm/ttm/ttm_bo.c        |  2 +-
>  drivers/gpu/drm/ttm/ttm_tt.c        | 32 +++++++++++++++++++++-----------
>  include/drm/ttm/ttm_bo_driver.h     |  2 +-
>  4 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 72afe82..4dd5060 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -304,7 +304,7 @@ static int radeon_move_vram_ram(struct ttm_buffer_object *bo,
>  		return r;
>  	}
>  
> -	r = ttm_tt_set_placement_caching(bo->ttm, tmp_mem.placement);
> +	r = ttm_tt_set_placement_caching(bo->ttm, &tmp_mem.placement);
>  	if (unlikely(r)) {
>  		goto out_cleanup;
>  	}
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3da89d5..4dc21c3 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -305,7 +305,7 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>  				goto out_err;
>  		}
>  
> -		ret = ttm_tt_set_placement_caching(bo->ttm, mem->placement);
> +		ret = ttm_tt_set_placement_caching(bo->ttm, &mem->placement);
>  		if (ret)
>  			goto out_err;
>  
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index bf080ab..a0df803 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -89,14 +89,6 @@ static inline int ttm_tt_set_page_caching(struct page *p,
>  
>  	return ret;
>  }
> -#else /* CONFIG_X86 */
> -static inline int ttm_tt_set_page_caching(struct page *p,
> -					  enum ttm_caching_state c_old,
> -					  enum ttm_caching_state c_new)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_X86 */
>  
>  /*
>   * Change caching policy for the linear kernel map
> @@ -149,19 +141,37 @@ out_err:
>  	return ret;
>  }
>  
> -int ttm_tt_set_placement_caching(struct ttm_tt *ttm, uint32_t placement)
> +int ttm_tt_set_placement_caching(struct ttm_tt *ttm, uint32_t *placement)
>  {
>  	enum ttm_caching_state state;
>  
> -	if (placement & TTM_PL_FLAG_WC)
> +	if (*placement & TTM_PL_FLAG_WC)
>  		state = tt_wc;
> -	else if (placement & TTM_PL_FLAG_UNCACHED)
> +	else if (*placement & TTM_PL_FLAG_UNCACHED)
>  		state = tt_uncached;
>  	else
>  		state = tt_cached;
>  
>  	return ttm_tt_set_caching(ttm, state);
>  }
> +#else /* CONFIG_X86 */
> +int ttm_tt_set_placement_caching(struct ttm_tt *ttm, uint32_t *placement)
> +{
> +	if (*placement & (TTM_PL_TT | TTM_PL_FLAG_SYSTEM)) {
> +		ttm->caching_state = tt_cached;
> +		*placement &= ~TTM_PL_MASK_CACHING;
> +		*placement |= TTM_PL_FLAG_CACHED;
> +	} else {
> +		if (*placement & TTM_PL_FLAG_WC)
> +			ttm->caching_state = tt_wc;
> +		else if (placement & TTM_PL_FLAG_UNCACHED)
> +			ttm->caching_state = tt_uncached;
> +		else
> +			ttm->caching_state = tt_cached;
> +	}
> +	return 0;
> +}
> +#endif /* CONFIG_X86 */
>  EXPORT_SYMBOL(ttm_tt_set_placement_caching);
>  
>  void ttm_tt_destroy(struct ttm_tt *ttm)
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index 1d9f0f1..cbc5ad2 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -669,7 +669,7 @@ extern int ttm_tt_swapin(struct ttm_tt *ttm);
>   * hit RAM. This function may be very costly as it involves global TLB
>   * and cache flushes and potential page splitting / combining.
>   */
> -extern int ttm_tt_set_placement_caching(struct ttm_tt *ttm, uint32_t placement);
> +extern int ttm_tt_set_placement_caching(struct ttm_tt *ttm, uint32_t *placement);
>  extern int ttm_tt_swapout(struct ttm_tt *ttm,
>  			  struct file *persistent_swap_storage);
>  
> -- 
> 1.9.3
> 

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
