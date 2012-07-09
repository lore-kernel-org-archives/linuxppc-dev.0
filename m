Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9065A2C0211
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 14:20:52 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 9 Jul 2012 09:50:48 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q694KiXp3015106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 09:50:45 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q699oIoa007564
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 15:20:18 +0530
Message-ID: <4FFA5C1B.10702@linux.vnet.ibm.com>
Date: Mon, 09 Jul 2012 09:50:43 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/4] powerpc/perf: Create mmcra_sihv/mmcra_sipv helpers
References: <20120626210013.2fbb9044@kryten>
In-Reply-To: <20120626210013.2fbb9044@kryten>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sukadev@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 26 June 2012 04:30 PM, Anton Blanchard wrote:

> 
> We want to access the MMCRA_SIHV and MMCRA_SIPR bits elsewhere so 
> create mmcra_sihv and mmcra_sipr which hide the differences between
> the old and new layout of the bits.
> 


Hey Anton,

Going further in this direction, we can actually create wrapper functions
to capture SIHV and SIPR values whether they are based out of MMCRA register or
not. It would help us decide PERF_RECORD_MISC_USER | PERF_RECORD_MISC_HYPERVISOR
| PERF_RECORD_MISC_KERNEL hiding the register and related bit details.

> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-build/arch/powerpc/perf/core-book3s.c
> ===================================================================
> --- linux-build.orig/arch/powerpc/perf/core-book3s.c	2012-06-26 10:26:40.695707845 +1000
> +++ linux-build/arch/powerpc/perf/core-book3s.c	2012-06-26 10:28:53.325958826 +1000
> @@ -116,6 +116,26 @@ static inline void perf_get_data_addr(st
>  		*addrp = mfspr(SPRN_SDAR);
>  }
> 
> +static bool mmcra_sihv(unsigned long mmcra)
> +{
> +	unsigned long sihv = MMCRA_SIHV;
> +
> +	if (ppmu->flags & PPMU_ALT_SIPR)
> +		sihv = POWER6_MMCRA_SIHV;
> +
> +	return !!(mmcra & sihv);
> +}
> +
> +static bool mmcra_sipr(unsigned long mmcra)
> +{
> +	unsigned long sipr = MMCRA_SIPR;
> +
> +	if (ppmu->flags & PPMU_ALT_SIPR)
> +		sipr = POWER6_MMCRA_SIPR;
> +
> +	return !!(mmcra & sipr);
> +}
