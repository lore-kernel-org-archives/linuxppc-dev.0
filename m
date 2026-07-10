Return-Path: <linuxppc-dev+bounces-23988-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E11C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 04:14:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxJPj4g02z2yQH;
	Fri, 10 Jul 2026 14:14:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783656873;
	cv=none; b=YuAp6MyeOZMOVDgc1se7Q0QUgdU8jZZern8Jh91advjEF5/WzIae0tEm5P/uEGRwaT+3liv6ve0nc14wVGJEHD0tqxlmZ3mB3JIKPIbzezY80jP8YwwDDenn1tmWwQkNmqXqtCXnSb76Di1RabK3CM4oBN990R8QlYu6OcYVAHG9S3c4QTdBGZMEe6q8u7IxA0ItbHE3RCRyHDaWsx1CWESmoCklyKHrUG2sUJO1K5vraXpxwnqUyQe0tSzPbwW/b3AcEfqrsSwdGaV95wdaesJHOuGv9HidnJ9BIstqzsyzRznnnll29HwjTNy0aXjCqxEiDd3bnw8DPiwn7zGo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783656873; c=relaxed/relaxed;
	bh=6jxpcS6PTHQj1X2CNIJSbdLIe+j/geIEwLwqXX7rn1c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=P9kHthCzLq6YHsXmREg8BznmXK2o8scwgu7iq/o5UQVbVk/+Brr+8w7vRGZaA0z4DjmH0NX3owfuhPSlRO2uW2bSZotB4O/Ky5f/ev1ZScMYOsHiTeNq377juiMexkCDv8NbZiBo+us6k+MvkGyZo2yacS2z6Dwp67LpVoVaevfckD1bWPdVh6FiBUtfr7fQWAKLuUK6ZjlHyzia2lBySI8aOMbFUkRGXPMXW1nadId37SUDFpwY1ZNFoNMUDRSrpgxLNgV3w/9kfXFpQQLjD4mFBqDzU+N3lO3n1vJWBNo6QAnbGXFc80tXkMhHAmF0Czvc/F2ZWfrhEeP/M73uAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jsaBzWGk; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jsaBzWGk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxJPh5QChz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 14:14:32 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-38511175ad3so512724a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783656870; x=1784261670; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6jxpcS6PTHQj1X2CNIJSbdLIe+j/geIEwLwqXX7rn1c=;
        b=jsaBzWGkF6GGo9hSQ2c/9ZkaJlTkRG/ttqJfZRqSkkEV4lbt14RkBXU2ZBnz7xnL7n
         AestWWBAgq+OUEqFPnx/QytmJDrfmf7cDmpmd4qrs0loGW+WZIzHix59zmRd80eJ7VMe
         UWUFCztjk+p8XIMbaJx5zyBLWTdEMAbDP+qwNHRU9iQOVs6uyRdbhlE1FelTcHt2piQV
         tvphFHplqxo81VTgNVcCNw4g1V5kSG6Kut0VaTlRskwNjx0kOp4UUPbN3RwunsfewxwP
         ukA+C0fmUB1A/kjf2AjC3loA/23jQINI8NMPEVGMpstwM8DqR6d5ktF+XQp/K8gzGIrI
         U2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783656870; x=1784261670;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6jxpcS6PTHQj1X2CNIJSbdLIe+j/geIEwLwqXX7rn1c=;
        b=QPCtSySOJoyHikupUrn7wnSe5R3ElKYpLBVHoosLkhEpnhAvbbpiwqGuQGTA0N3pK9
         OciiEh10LM53oWlvA7aom+gFpQKCLUL9HNYb6dr+A0zXzknRF0wbC60E9hf6rXjSbdqL
         Rh0Xb75/fAS1k9K6OsEEE3gn2JMs9vGgOB4ny4ra6J5m0vLm34kE/afUW/l/0akh7o5M
         mTw7cPAI66kd/tlOemUppBz5aBEgtW8icNRhi3GjOJJg7Ll+rSEPgdpPL5iATUOpuR3+
         roqLhNFYMxFZJUvO8wXj7YQ1I0tY6Ck9X9IHxTb0qQyoQHsTYlsF7JLo3q5C19KdFCLL
         WFow==
X-Forwarded-Encrypted: i=1; AHgh+RqZLvcW3iws90khMTm6QpKCFuz/Pas5rFKsDyc/1dxfu0hEcbQsp41JdsLhagmOTrK4CuyidGPee11vDH0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YynR/9VsCSbMmLH0nGvmqOiBDGfmSn9+7+eZRb+H5/zs/h1Prtd
	dCQWcZHmyLIWmUgYWK7kkxknIyoiJtGv/yltgBdQ+kWI9LWHapTX+nPg
X-Gm-Gg: AfdE7cni0htZtlyrczN+hx7BDIaUt/1ijjGRlqgjLEApFWNl4bQ71fCqljYnG/Hrlyh
	onXInzr1RA8TJRh5Bw1tIRor2773+3fb/H9zN5USN0RQnzZkkw4sqaLrzVY8MkFpyfHj0e8w8NR
	JLDwZVSAjsUgS9mfF3jLpj7lq2tzBuUJyLQENE4k5X9vSdmrOo+elOBHQPYxfccbj8uRtMzzt0I
	DehSjMC6Uk8DMSxNpk/WDUlkx+NE/KYgraE+SxkOGLMpYg6nka5r8Ey/IFZ4HjK0smO/eaXA05u
	Lf3hHE5GQgGBrE/mejvdxMBMOWAo9Jz1tlwXQ3IohwIl8Rjts8hrxZKAdCbunWqGTedZ5wvfTqW
	iqKwERFzVwpIXKBSCZDprzTGqYEfVe0WQgBVBnMzSQavGs2I7MV7q+kVANaRXSwUE34CcjS7Wdj
	T3F2OVxnYKyI8=
X-Received: by 2002:a17:90b:2701:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38da8bea6c9mr198654a91.19.1783656869990;
        Thu, 09 Jul 2026 21:14:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311838c9235sm29776466eec.21.2026.07.09.21.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:14:29 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com, chleroy@kernel.org, Srikar Dronamraju <srikar@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] powerpc/numa: Allow cpu_to_coregroup_id without PPC_SPLPAR
In-Reply-To: <20260605055242.1757485-7-srikar@linux.ibm.com>
Date: Fri, 10 Jul 2026 09:34:55 +0530
Message-ID: <wlv3v6ag.ritesh.list@gmail.com>
References: <20260605055242.1757485-5-srikar@linux.ibm.com> <20260605055242.1757485-7-srikar@linux.ibm.com>
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

> Make cpu_to_coregroup_id() available outside PPC_SPLPAR so it can be
> used by platforms that do not rely on the SPLPAR-specific VPHN path.
>
> Keep the existing fallback behavior by returning the core ID when
> coregroup information is unavailable.
>

Looks like this mainly brings the cpu_to_coregroup_id() outside of
CONFIG_PPC_SPLPAR gate. 

> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
> Changelog from v1:
> - Handle comments from Christophe Leroy; Remove extern key word in
>   declaration
>
>  arch/powerpc/include/asm/topology.h | 15 +++++++--------
>  arch/powerpc/mm/numa.c              | 22 ++++++++++++++++------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 66ed5fe1b718..385715f1ad56 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -71,6 +71,7 @@ extern void map_cpu_to_node(int cpu, int node);
>  extern void unmap_cpu_from_node(unsigned long cpu);
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
> +int cpu_to_coregroup_id(int cpu);
>  #else
>  
>  static inline int early_cpu_to_node(int cpu) { return 0; }
> @@ -107,14 +108,6 @@ static inline void map_cpu_to_node(int cpu, int node) {}
>  static inline void unmap_cpu_from_node(unsigned long cpu) {}
>  #endif /* CONFIG_HOTPLUG_CPU */
>  #endif /* CONFIG_SMP */
> -
> -#endif /* CONFIG_NUMA */
> -
> -#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> -void find_and_update_cpu_nid(int cpu);
> -extern int cpu_to_coregroup_id(int cpu);
> -#else
> -static inline void find_and_update_cpu_nid(int cpu) {}
>  static inline int cpu_to_coregroup_id(int cpu)
>  {
>  #ifdef CONFIG_SMP
> @@ -124,6 +117,12 @@ static inline int cpu_to_coregroup_id(int cpu)
>  #endif
>  }
>  
> +#endif /* CONFIG_NUMA */
> +
> +#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> +void find_and_update_cpu_nid(int cpu);
> +#else
> +static inline void find_and_update_cpu_nid(int cpu) {}
>  #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
>  
>  #include <asm-generic/topology.h>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index c44a80d8fc11..9aa71eb7e96b 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1428,6 +1428,21 @@ void find_and_update_cpu_nid(int cpu)
>  	pr_debug("%s:%d cpu %d nid %d\n", __func__, __LINE__, cpu, new_nid);
>  }
>  
> +static int topology_update_init(void)
> +{
> +	topology_inited = 1;
> +	return 0;
> +}
> +device_initcall(topology_update_init);
> +
> +#else
> +static long vphn_get_associativity(unsigned long cpu,
> +					__be32 *associativity)
> +{
> +	return -1;
> +}
> +#endif /* CONFIG_PPC_SPLPAR */
> +
>  int cpu_to_coregroup_id(int cpu)
>  {
>  	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
> @@ -1453,10 +1468,5 @@ int cpu_to_coregroup_id(int cpu)
>  	return cpu_to_core_id(cpu);
>  }
>  
> -static int topology_update_init(void)
> -{
> -	topology_inited = 1;
> -	return 0;
> +	return coregroup_id;
>  }

These above two lines seems to be out of any function scope. So applying
only patch-1 & patch-2 will give a compile error. This needs fixing.

-ritesh

> -device_initcall(topology_update_init);
> -#endif /* CONFIG_PPC_SPLPAR */
> -- 
> 2.43.0

