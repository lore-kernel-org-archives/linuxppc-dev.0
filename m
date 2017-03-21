Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnKtT6PB2zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 15:42:41 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L4XhMr007026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 00:42:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ajfemspu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 00:42:29 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 00:42:28 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 skiboot@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Skiboot] [PATCH][OPAL] cpufeatures: add base and POWER8,
 POWER9 /cpus/features dt
In-Reply-To: <20170307111326.28129-2-npiggin@gmail.com>
References: <20170307111326.28129-1-npiggin@gmail.com>
 <20170307111326.28129-2-npiggin@gmail.com>
Date: Tue, 21 Mar 2017 15:42:22 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a88fw89d.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> With this patch and the Linux one, I can boot (in mambo) a POWER8 or
> POWER9 without looking up any cpu tables, and mainly looking at PVR
> for MCE and PMU.

That's pretty neat. I now await the day where somebody produces a chip
with uneven feature sets between cores.

> Machine and ISA speicfic features that are not abstracted by firmware
> and not captured here will have to be handled on a case by case basis,
> using PVR if necessary. Major ones that remain are PMU and machine
> check.

At least for machine check we could probably get something "good enough"
without too much effort.

For PMU, I wonder if we could get something that's suitably common with
the IMC work being done so that we could "just work" on new PMUs (albeit
calling into OPAL for enable/disable)

> Open question is where and how to develop and document these features?
> Not the dt representation created by skiboot, but the exact nature of
> each feature. What exact behaviour does a particular feature imply,
> etc.

Part of me seems to think this could be something for the Architecture,
and then we just have a 1-to-1 mapping of the arch bits and we're all
one big happy family....

Benh/Paulus can probably laugh at me suitably hard for suggesting such a
thing being possible though :)

I see the kernel patch has docs for the DT bindings, I'd like to also
keep a copy in the skiboot tree, if only to further my impossible quest
to somewhat document the OPAL ABI.

> diff --git a/core/device.c b/core/device.c
> index 30b31f46..1900ba71 100644
> --- a/core/device.c
> +++ b/core/device.c
> @@ -548,6 +548,13 @@ u32 dt_property_get_cell(const struct dt_property *prop, u32 index)
>  	return fdt32_to_cpu(((const u32 *)prop->prop)[index]);
>  }
>  
> +void dt_property_set_cell(struct dt_property *prop, u32 index, u32 val)
> +{
> +	assert(prop->len >= (index+1)*sizeof(u32));
> +	/* Always aligned, so this works. */
> +	((u32 *)prop->prop)[index] = cpu_to_fdt32(val);
> +}
> +
>  /* First child of this node. */
>  struct dt_node *dt_first(const struct dt_node *root)
>  {
> diff --git a/core/init.c b/core/init.c
> index 58f96f47..938920eb 100644
> --- a/core/init.c
> +++ b/core/init.c
> @@ -703,6 +703,8 @@ static void per_thread_sanity_checks(void)
>  /* Called from head.S, thus no prototype. */
>  void main_cpu_entry(const void *fdt);
>  
> +extern void mambo_add_cpu_features(struct dt_node *root);
> +
>  void __noreturn __nomcount main_cpu_entry(const void *fdt)
>  {
>  	/*
> @@ -774,6 +776,7 @@ void __noreturn __nomcount main_cpu_entry(const void *fdt)
>  			abort();
>  	} else {
>  		dt_expand(fdt);
> +		mambo_add_cpu_features(dt_root);
>  	}

(without checking closely, just going from memory), this would also the
the case on P8 OpenPOWER hardware, as we get the device tree from
Hostboot there too.

>  	/* Now that we have a full devicetree, verify that we aren't on fire. */
> diff --git a/hdata/cpu-common.c b/hdata/cpu-common.c
> index aa2752c1..1da1b1cb 100644
> --- a/hdata/cpu-common.c
> +++ b/hdata/cpu-common.c

> +	{ "vector-crypto",
> +	CPU_ALL,
> +	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
> +	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
> +	-1, -1, 38,
> +	"vector", },

Did we want to break this down at all? Specifically maybe just the AES
instructions?

AFAIK it's been the only set where there was some amount of discussion
about somebody possibly not wanting to include.

-- 
Stewart Smith
OPAL Architect, IBM.
