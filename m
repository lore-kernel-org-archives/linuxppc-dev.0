Return-Path: <linuxppc-dev+bounces-24001-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F16C44506
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:12:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxSLG2wqLz2yRF;
	Fri, 10 Jul 2026 20:12:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783678326;
	cv=none; b=n6fgFfSQkcV3vigdWuUZHUoQ2MsMjrCJoOXrQAZIyVKjhJpVbWftGthaAvr98siLK4vt+wapSz4VLC5IiJMwiOl8n0Z2x8VWsqenIoe+zNKe9MbZyq9aqJA7GKjv515Afz4os6ooUWgQTsnuCmC/eQ0LlXg0k1+bOm1Ci61ZdxQagNddU+3Fi39yJD3IYDhtmxGGd/3h3r7p/d3R4/t6ZMcnIOnVJW7vI78N2wixbpbKsOTqSMSVa8SaJy/DegXLvFXdCVq1NKnvEjD7CeCVUOWzV9ezEmztODXrBICsQ4aH08gzhhjTGCeJxMYlN0HIjD9ho9O4a/fgRcpBFebuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783678326; c=relaxed/relaxed;
	bh=o6xV8+arhXOVNUwWe6koYvBL1FEn/j8lb2bT0WNrclI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=kMMCSU2b9O1SEavyCI8580MoE96gSZ0dXFUPODPKRh1YybMUKLmAOll68RmE6EjUTckpj9AXGXgX1Skr8mOHXWN9E5yptaaM3pYgVjOJx6RrMiyI4fgWMML36/GQH9jfORTvbQ61B+SBR32hy+gkIpYdDQirfhMsZ9jkCT2d3DdeuXlfRx1zNCEonO3H8ItP57u4UXIXUeX0a0K1FCfEFgkelqZWs3Rg+4712Uo2gyVtFM5NQOcQSJlpRiOK2VMFK/x3nNhr/J6t1qSjh8wHhvq4Gwy1ZOJCB6ZO8qeUyVEUiBHoB4GFJtBrRb9nx9LhZWZXVWKipnrD9GVeqReR9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lxN3IENt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lxN3IENt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxSLD6rbLz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 20:12:04 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-848593533cbso522616b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783678321; x=1784283121; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o6xV8+arhXOVNUwWe6koYvBL1FEn/j8lb2bT0WNrclI=;
        b=lxN3IENtr8vL1TiSUVj5OhpOC7JcBbdOFPH4MyZXVKRFAXVePdk7XoFFdue3KlUIzn
         3WkD92GzcB0JyneJxzBd0A+/JxRwDgEjnIpv/d6XYr/CXhohWN5SgtHGI75cj/kJgiql
         uwd+MLwkGIU8ho3MA5OV6/emY4Z3wYMxDbD1eZ933bKnYN4CMa4urxuNx27ieeilo+rs
         Av+s7JqpSTwV7KX8OJeSDZqkrz8L408ORj1RmpgRKPvbKCRqs/1BcP2gfM7RxoPT+Arf
         1QiJe+ieY+ABBUVx2sVOE1uWMxS+BqvtF1SbF0cPj4p45sPI8a1q+Hkc8DsvOY5dV8/k
         +hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678321; x=1784283121;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6xV8+arhXOVNUwWe6koYvBL1FEn/j8lb2bT0WNrclI=;
        b=Yvs3ND81aR3vmnw2wBkO8wac9OfJKJdW8n5K0mkVsT1bsZLxGL0O7D27PDUkrvo/ta
         7HxO2gze/0ULI2c6upwVGXOrEpqCu69k70qcR8HtjnciZqs92I6V3qN9s2lQjxs95UHG
         6GJxhD9A/bFgQE7G0EIfzTOc9PhJrNo4pvlVvTUXEcUYi6XfleYU8XI/FZQ7iy0YGfEs
         hi1kc79CqYiHNHq9HMpTpLSv1Aszr6/cVXA6TX1LPHq6Vx4zHyDh59TNHXB8RaJ0GjLq
         CfwJp7mks22sNZgkKv7+kwfA/sF2vz3nPi9H/vLsz90hNV5dopi4FxbB2SlgTonG54db
         qtrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjyQsaNgTW1Aa+xPNz855j2JWJxp1+NjqkP5RzXl0iueOSMS1+J8ll9QsjkEkDE9rhykBghCt3uZzqR3E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3das4/eN+83IhFJANPxiBBUwo3tM+iCpCQR+z3YFCq5dxY7rp
	tLzuvxOOw9M3UmbLbbgh1/Xpi83MjJk9KnD+IQOWjCR6QLwr/g4CLDPy
X-Gm-Gg: AfdE7cl5Dz1hOlNf6HfXHTHdl+5W5tyD/+PTQ/79nj73xMVdbDu8OnsNNVkuoIHVRsM
	EZee20R0TE1BwSUyXMmKo314SYAHi69QxOwGfBqwCEGFd1z3oXeJahzqc8h25QdWNop8NmQ2FIb
	T4OTSRLO1ftA7rBeejayY1qT+eXCncN9MQaW+e2qJRZ6OCNWcASfUFH80Ipr8cQ75H7X30ax/Yj
	1SaDNHyF53urUPDHrCRAvfnSpAoAw8NaGF1TzgxzWWVsXwAVljKFGLFxofKiVvcZafBoIkiE313
	+nPnWlyRdR96m4PTFQE2W1D4/sPucI+U6LTC5jPSPil2TN8wGEQShf4jEcdj9TP6iGqGdg2lDpl
	7XyfUg9yLprF4pCYyHmJoSNd1LT/X8gRNTBqYn62jUZxGD4ZWB2Cv+MwjfcFEVV+1ynBr079zSd
	fw41pywwVKwwM=
X-Received: by 2002:a05:6a20:729d:b0:3bf:a624:deb8 with SMTP id adf61e73a8af0-3c0bcebc735mr13769800637.21.1783678321446;
        Fri, 10 Jul 2026 03:12:01 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm42738891c88.12.2026.07.10.03.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:12:00 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com, chleroy@kernel.org, Srikar Dronamraju <srikar@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] powerpc/numa: Support coregroup on PowerNV
In-Reply-To: <20260605055242.1757485-8-srikar@linux.ibm.com>
Date: Fri, 10 Jul 2026 11:18:12 +0530
Message-ID: <v7anv1ib.ritesh.list@gmail.com>
References: <20260605055242.1757485-5-srikar@linux.ibm.com> <20260605055242.1757485-8-srikar@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Srikar Dronamraju <srikar@linux.ibm.com> writes:

> Coregroup support on powerpc has so far been limited to PowerVM LPARs.
> However, PowerNV can also support coregroups when firmware exposes the
> required coregroup information through the associativity hierarchy.
>
> Detect coregroup support by checking whether primary_domain_index is the
> penultimate domain in the CPU node's ibm,associativity property. On
> PowerNV, a non-penultimate primary_domain_index indicates that firmware
> provides an additional level for coregroup information.
>
> This keeps the logic compatible with PowerVM systems, where
> primary_domain_index is likewise not the penultimate associativity
> domain.
>
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
> Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
> - Handle comments from Christophe Leroy; make code more flat
>
>  arch/powerpc/mm/numa.c | 56 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 9aa71eb7e96b..e97b624203ea 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -889,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
>  	return 0;
>  }
>  
> +/*
> + * If hierarchy extends beyond primary_domain_index + 1, then next
> + * level corresponds to coregroup.
> + */
> +static int detect_and_enable_coregroup(const __be32 *associativity, int index)

Do we care about it's return value? We are not reading that in the
patch.
this function is mainly only needed in __init, can we mark it so.

> +{
> +	if (!associativity || index == -1)
> +		goto out;
> +
> +	index = of_read_number(associativity, 1);
> +
> +	if (index > primary_domain_index + 1) {
> +		coregroup_enabled = 1;
> +		return index;
> +	}
> +out:
> +	coregroup_enabled = 0;
> +	return -1;
> +}

For PowerVM, we now have two places which will enable coregroup_enabled
during mem_topology_setup(). Is there some way we can unify that?

This also means we enable coregroup in case of PowerVM with SPLPAR when
per-cpu VPHN associativity index > primary_domain_index+1. But this
isn't reflected in your commit msg. The commit msg only says this
affects PowerNV.

setup_arch
  mem_topology_setup
    parse_numa_properties
      detect_and_enable_coregroup() {...
       // coregroup_enabled = 0/1
        	index = of_read_number(associativity, 1);

	        if (index > primary_domain_index + 1) {
            		coregroup_enabled = 1;
                    		return index;
            }

      }
    <...>
    find_possible_nodes() {...
        	prop_length /= sizeof(int);
	        if (prop_length > primary_domain_index + 2)
		       coregroup_enabled = 1;
    }

> +
>  static int __init parse_numa_properties(void)
>  {
>  	struct device_node *memory, *pci;
> -	int default_nid = 0;
> -	unsigned long i;
> +	int default_nid = 0, index = 0;
>  	const __be32 *associativity;
> +	unsigned long i;
>  
>  	if (numa_enabled == 0) {
>  		pr_warn("disabled by user\n");
> @@ -927,7 +947,6 @@ static int __init parse_numa_properties(void)
>  	 */
>  	for_each_present_cpu(i) {
>  		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
> -		struct device_node *cpu;
>  		int nid = NUMA_NO_NODE;
>  
>  		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
> @@ -935,7 +954,9 @@ static int __init parse_numa_properties(void)
>  		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
>  			nid = associativity_to_nid(vphn_assoc);
>  			initialize_form1_numa_distance(vphn_assoc);
> +			index = detect_and_enable_coregroup(vphn_assoc, index);
>  		} else {
> +			struct device_node *cpu;
>  
>  			/*
>  			 * Don't fall back to default_nid yet -- we will plug
> @@ -948,6 +969,7 @@ static int __init parse_numa_properties(void)
>  			associativity = of_get_associativity(cpu);
>  			if (associativity) {
>  				nid = associativity_to_nid(associativity);
> +				index = detect_and_enable_coregroup(associativity, index);
>  				initialize_form1_numa_distance(associativity);
>  			}
>  			of_node_put(cpu);
> @@ -1445,7 +1467,9 @@ static long vphn_get_associativity(unsigned long cpu,
>  
>  int cpu_to_coregroup_id(int cpu)
>  {
> -	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
> +	int coregroup_id = cpu_to_core_id(cpu);
> +	struct device_node *cpunode = NULL;
> +	const __be32 *associativity;
>  	int index;
>  
>  	if (cpu < 0 || cpu > nr_cpu_ids)
> @@ -1454,19 +1478,31 @@ int cpu_to_coregroup_id(int cpu)
>  	if (!coregroup_enabled)
>  		goto out;
>  
> -	if (!firmware_has_feature(FW_FEATURE_VPHN))
> -		goto out;
> +	if (firmware_has_feature(FW_FEATURE_VPHN)) {
> +		__be32 tmp[VPHN_ASSOC_BUFSIZE] = {0};
>  
> -	if (vphn_get_associativity(cpu, associativity))
> +		if (vphn_get_associativity(cpu, tmp))
> +			goto out;
> +
> +		associativity = tmp;
> +
> +	} else {
> +		cpunode = of_get_cpu_node(cpu, NULL);
> +		if (!cpunode)
> +			goto out;
> +
> +		associativity = of_get_associativity(cpunode);
> +	}
> +	if (!associativity)
>  		goto out;
>  
>  	index = of_read_number(associativity, 1);
>  	if (index > primary_domain_index + 1)
> -		return of_read_number(&associativity[index - 1], 1);
> +		coregroup_id = of_read_number(&associativity[index - 1], 1);
>  
>  out:
> -	return cpu_to_core_id(cpu);
> -}

Looks like leftover removed from previous patch. This change should be
fixed in patch-2 itself.

> +	if (cpunode)
> +		of_node_put(cpunode);
>  
>  	return coregroup_id;
>  }
> -- 
> 2.43.0

-ritesh

