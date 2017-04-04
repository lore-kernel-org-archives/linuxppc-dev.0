Return-Path: <dja@axtens.net>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxsMW20kBzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 11:48:55 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 79so33586136pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 18:48:55 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, benh@kernel.crashing.org,
 paulus@samba.org, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 01/11] powerpc/powernv: Data structure and macros
 definitions
In-Reply-To: <1491231308-15282-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-2-git-send-email-maddy@linux.vnet.ibm.com>
Date: Tue, 04 Apr 2017 11:48:50 +1000
Message-ID: <87h925kkn1.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> +#define IMC_MAX_CHIPS			32
> +#define IMC_MAX_PMUS			32
> +#define IMC_MAX_PMU_NAME_LEN		256
I've noticed this is used as both the maximum length for event names and
event value strings. Would another name suit better?

> +
> +#define IMC_NEST_MAX_PAGES		16
> +
> +#define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
> +#define IMC_DTB_NEST_COMPAT		"ibm,imc-counters-nest"
> +
> +/*
> + * Structure to hold per chip specific memory address
> + * information for nest pmus. Nest Counter data are exported
> + * in per-chip reserved memory region by the PORE Engine.
> + */
> +struct perchip_nest_info {
> +	u32 chip_id;
> +	u64 pbase;
> +	u64 vbase[IMC_NEST_MAX_PAGES];
> +	u64 size;
> +};
> +
> +/*
> + * Place holder for nest pmu events and values.
> + */
> +struct imc_events {
> +	char *ev_name;
> +	char *ev_value;
> +};
> +
> +/*
> + * Device tree parser code detects IMC pmu support and
> + * registers new IMC pmus. This structure will
> + * hold the pmu functions and attrs for each imc pmu and
> + * will be referenced at the time of pmu registration.
> + */
> +struct imc_pmu {
> +	struct pmu pmu;
> +	int domain;
> +	const struct attribute_group *attr_groups[4];
> +};
> +
> +/*
> + * Domains for IMC PMUs
> + */
> +#define IMC_DOMAIN_NEST		1
> +#define IMC_DOMAIN_UNKNOWN	-1
> +
> +#endif /* PPC_POWERNV_IMC_PMU_DEF_H */
> -- 
> 2.7.4
