Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B523B1A0962
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 14:33:10 +1000 (EST)
Date: Fri, 26 Sep 2014 14:33:09 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 10/15] powerpc/mm: Add hooks for cxl
Message-ID: <20140926143309.33c0eeac@kryten>
In-Reply-To: <1411028820-29933-11-git-send-email-mikey@neuling.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-11-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This add a hook into tlbie() so that we use global invalidations when
> there are cxl contexts active.
> 
> Normally cxl snoops broadcast tlbie.  cxl can have TLB entries
> invalidated via MMIO, but we aren't doing that yet.  So for now we
> are just disabling local tlbies when cxl contexts are active.  In
> future we can make tlbie() local mode smarter so that it invalidates
> cxl contexts explicitly when it needs to.
> 
> This also adds a hooks for when SLBs are invalidated to ensure any
> corresponding SLBs in cxl are also invalidated at the same time.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

> +	use_local = local && mmu_has_feature(MMU_FTR_TLBIEL) && !cxl_ctx_in_use();

Seems reasonable until we can get the MMIO based optimisation in.

Will all CAPI cached translations be invalidated before we finish using
a CAPI context? And conversely, could CAPI cache any translations when a
context isn't active? I'm mostly concerned that we can't have a
situation where badly behaving userspace could result in a stale
translation.

>  	spu_flush_all_slbs(mm);
>  #endif
> +	cxl_slbia(mm);

>  			spu_flush_all_slbs(mm);
>  #endif
> +			cxl_slbia(mm);

>  	spu_flush_all_slbs(mm);
>  #endif
> +	cxl_slbia(mm);

>  	spu_flush_all_slbs(mm);
>  #endif
> +	cxl_slbia(mm);

Should we combine the SPU vs CXL callouts into something common -
perhaps copro_flush_all_slbs()?

Anton
