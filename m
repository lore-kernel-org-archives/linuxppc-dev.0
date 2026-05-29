Return-Path: <linuxppc-dev+bounces-21689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E386CD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:01:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRbR211rmz2xnZ;
	Fri, 29 May 2026 18:01:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780041694;
	cv=none; b=N397AC26JWBv9EwAJeNE9A6nwt7QgMlRLe5IL3haKIXoRkpVTzsI4+kPQJkJJQepdaFaAjfQj+D+NeREqmv4zy3gTmdmbgeAoGQMteTuNnC+vS8YgcJlzTgEZ3jx+5R9UKhN1EwqEx4f0P4abTaXzw+k6ohgHqhCsm99HtO2iT28Nf3FWAHUug2ykiA2xOZWlGceVc0OWW/2zV9QrzUhPHrjoNdjWt1QWGFYurjtRde8PF7mfmaqlCIj4bro0gEn4hvQzXWanv9uuqMZTD31GfkxHeaa1UqHmdfpa2agJ5GyupxBOJcdpwALZ9YCpl+jvzcpehi2n8gtf5uh4DHCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780041694; c=relaxed/relaxed;
	bh=ygDftnBE/K56Zx7J3uMTfndW2nsumAQLsJKudZkzTic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJ97x4TuxVORj62t/nxv11dbPxAkBzIKc+1Q5Hs5Y8FvhXLght7YS5+GBgnEptEvJpdIN7ksb+C/MCEgWsEsR6N0nsmC96egCN29kI6uMtQKPACv8V6SQ7kJpsjyQ/hg3ZxWw0XNbmrs8Est7vpiHFsKIt13MZ+dup4jb3YHjothyXLXp88TR1bGQ4y1mc4l4b1BM4jsjONq1ilcoyhc+UdRmsX6qUaOEhXc6dQ+FaEwQwQKRaxYQ9qkegMB2446JiciyxXYWOIKUZ9/CaswZA3HxJTEqZvrNvdaEo4cL1baKBy0rxMcGzwzFdzhEEUZUvHyXbjvll3g0zmO1lOxnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHW0l67n; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHW0l67n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRbR015n1z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:01:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D5E6960564;
	Fri, 29 May 2026 08:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6B01F00893;
	Fri, 29 May 2026 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780041689;
	bh=ygDftnBE/K56Zx7J3uMTfndW2nsumAQLsJKudZkzTic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZHW0l67nfx1v80Zi0i5JwHMEybDSKRaf5FOfNCTA4sPnc1l5ABEFwj1kCzDaNVQvG
	 /WZ/evAYFOlQZUVrh9bybecZ1RAciFlGpIJfzdQf6al2BjaofJBSpJ4Uier4isrUvM
	 ggoM0BWZe3j/s8+OMKInmVswyAxDelvPPGsJPqmAqCjoOGy6aQt6IFcZ37tH4DaDJU
	 YZlZ/rGAgSpoeKmr2e/F/uwWDbilcNPAB11Z1BUmXfmoonz5P3QLfZ3swxjmE2U++i
	 D0iPTeFIGcuAyGBDHi2us9aNlPWAi4smrrUT5/1nom1iV7JJkKgGfaWHF9TMQqyaVD
	 OacxBvgW2y37A==
Message-ID: <9fb06d4c-0b89-4ec9-ac11-4578a8aa5fd2@kernel.org>
Date: Fri, 29 May 2026 10:01:24 +0200
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: use sysfs_emit{_at} in sysfs show functions
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260524130002.793476-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260524130002.793476-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/05/2026 à 15:00, Thorsten Blum a écrit :
> Replace sprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show
> functions, which are preferred for formatting sysfs output because they
> provide safer bounds checking.
> 
> While the current code only emits strings that fit easily within
> PAGE_SIZE, use sysfs_emit() and sysfs_emit_at() to follow secure coding
> best practices.
> 
> This is a mechanical cleanup with a few simple edge cases:
> 
> - In domains_show(), drop the redundant n < 0 check since neither
>    sprintf() nor sysfs_emit() return negative values.
> 
> - In powercap_show() and psr_show(), also drop the dead ret < 0 checks.
> 
> - In ps3_fw_version_show(), normalize the output by adding a terminating
>    newline as suggested by checkpatch.
> 
> - In vio's modalias_show(), replace the deprecated strcpy() [1] followed
>    by strlen() with sysfs_emit().
> 
> Leave validate_show() and the variable-length hv-gpci helpers unchanged
> since they already have explicit bounds handling, and converting those
> would be more than a mechanical conversion.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/kernel/cacheinfo.c               | 13 +++++----
>   arch/powerpc/kernel/eeh_sysfs.c               |  8 ++---
>   arch/powerpc/kernel/fadump.c                  | 10 +++----
>   arch/powerpc/kernel/iommu.c                   |  3 +-
>   arch/powerpc/kernel/security.c                | 13 +++++----
>   arch/powerpc/kernel/sysfs.c                   | 23 ++++++++-------
>   arch/powerpc/perf/core-book3s.c               |  3 +-
>   arch/powerpc/perf/hv-24x7.c                   | 18 +++++-------
>   arch/powerpc/perf/hv-gpci.c                   |  5 ++--
>   arch/powerpc/perf/kvm-hv-pmu.c                |  3 +-
>   arch/powerpc/perf/vpa-pmu.c                   |  3 +-
>   .../powerpc/platforms/83xx/mcu_mpc8349emitx.c |  3 +-
>   arch/powerpc/platforms/cell/spu_base.c        |  5 ++--
>   arch/powerpc/platforms/powernv/idle.c         |  3 +-
>   arch/powerpc/platforms/powernv/opal-dump.c    | 11 +++----
>   arch/powerpc/platforms/powernv/opal-elog.c    |  9 +++---
>   arch/powerpc/platforms/powernv/opal-flash.c   |  4 +--
>   .../powerpc/platforms/powernv/opal-powercap.c | 12 +++-----
>   arch/powerpc/platforms/powernv/opal-psr.c     | 12 +++-----
>   arch/powerpc/platforms/powernv/subcore.c      |  3 +-
>   arch/powerpc/platforms/ps3/setup.c            |  3 +-
>   arch/powerpc/platforms/pseries/cmm.c          |  5 ++--
>   arch/powerpc/platforms/pseries/dlpar.c        |  3 +-
>   arch/powerpc/platforms/pseries/ibmebus.c      |  5 ++--
>   arch/powerpc/platforms/pseries/papr_scm.c     |  5 ++--
>   arch/powerpc/platforms/pseries/power.c        |  3 +-
>   .../platforms/pseries/pseries_energy.c        |  3 +-
>   arch/powerpc/platforms/pseries/suspend.c      |  3 +-
>   arch/powerpc/platforms/pseries/vas-sysfs.c    |  3 +-
>   arch/powerpc/platforms/pseries/vio.c          | 29 +++++++++----------
>   arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c   |  3 +-
>   31 files changed, 118 insertions(+), 111 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
> index 90d51d9b3ed2..04e5ea38bdc0 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -18,6 +18,7 @@
>   #include <linux/of.h>
>   #include <linux/percpu.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <asm/cputhreads.h>
>   #include <asm/smp.h>
>   
> @@ -596,7 +597,7 @@ static ssize_t size_show(struct kobject *k, struct kobj_attribute *attr, char *b
>   	if (cache_size_kb(cache, &size_kb))
>   		return -ENODEV;
>   
> -	return sprintf(buf, "%uK\n", size_kb);
> +	return sysfs_emit(buf, "%uK\n", size_kb);
>   }
>   
>   static struct kobj_attribute cache_size_attr =
> @@ -613,7 +614,7 @@ static ssize_t line_size_show(struct kobject *k, struct kobj_attribute *attr, ch
>   	if (cache_get_line_size(cache, &line_size))
>   		return -ENODEV;
>   
> -	return sprintf(buf, "%u\n", line_size);
> +	return sysfs_emit(buf, "%u\n", line_size);
>   }
>   
>   static struct kobj_attribute cache_line_size_attr =
> @@ -629,7 +630,7 @@ static ssize_t nr_sets_show(struct kobject *k, struct kobj_attribute *attr, char
>   	if (cache_nr_sets(cache, &nr_sets))
>   		return -ENODEV;
>   
> -	return sprintf(buf, "%u\n", nr_sets);
> +	return sysfs_emit(buf, "%u\n", nr_sets);
>   }
>   
>   static struct kobj_attribute cache_nr_sets_attr =
> @@ -645,7 +646,7 @@ static ssize_t associativity_show(struct kobject *k, struct kobj_attribute *attr
>   	if (cache_associativity(cache, &associativity))
>   		return -ENODEV;
>   
> -	return sprintf(buf, "%u\n", associativity);
> +	return sysfs_emit(buf, "%u\n", associativity);
>   }
>   
>   static struct kobj_attribute cache_assoc_attr =
> @@ -657,7 +658,7 @@ static ssize_t type_show(struct kobject *k, struct kobj_attribute *attr, char *b
>   
>   	cache = index_kobj_to_cache(k);
>   
> -	return sprintf(buf, "%s\n", cache_type_string(cache));
> +	return sysfs_emit(buf, "%s\n", cache_type_string(cache));
>   }
>   
>   static struct kobj_attribute cache_type_attr =
> @@ -671,7 +672,7 @@ static ssize_t level_show(struct kobject *k, struct kobj_attribute *attr, char *
>   	index = kobj_to_cache_index_dir(k);
>   	cache = index->cache;
>   
> -	return sprintf(buf, "%d\n", cache->level);
> +	return sysfs_emit(buf, "%d\n", cache->level);
>   }
>   
>   static struct kobj_attribute cache_level_attr =
> diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
> index 706e1eb95efe..b9785f105f75 100644
> --- a/arch/powerpc/kernel/eeh_sysfs.c
> +++ b/arch/powerpc/kernel/eeh_sysfs.c
> @@ -9,6 +9,7 @@
>   #include <linux/of.h>
>   #include <linux/pci.h>
>   #include <linux/stat.h>
> +#include <linux/sysfs.h>
>   #include <asm/ppc-pci.h>
>   #include <asm/pci-bridge.h>
>   
> @@ -31,7 +32,7 @@ static ssize_t eeh_show_##_name(struct device *dev,      \
>   	if (!edev)                                            \
>   		return 0;                                     \
>   	                                                      \
> -	return sprintf(buf, _format "\n", edev->_memb);       \
> +	return sysfs_emit(buf, _format "\n", edev->_memb);    \
>   }                                                        \
>   static DEVICE_ATTR(_name, 0444, eeh_show_##_name, NULL);
>   
> @@ -49,8 +50,7 @@ static ssize_t eeh_pe_state_show(struct device *dev,
>   		return -ENODEV;
>   
>   	state = eeh_ops->get_state(edev->pe, NULL);
> -	return sprintf(buf, "0x%08x 0x%08x\n",
> -		       state, edev->pe->state);
> +	return sysfs_emit(buf, "0x%08x 0x%08x\n", state, edev->pe->state);
>   }
>   
>   static ssize_t eeh_pe_state_store(struct device *dev,
> @@ -87,7 +87,7 @@ static ssize_t eeh_notify_resume_show(struct device *dev,
>   	if (!edev || !edev->pe)
>   		return -ENODEV;
>   
> -	return sprintf(buf, "%d\n", pdn->last_allow_rc);
> +	return sysfs_emit(buf, "%d\n", pdn->last_allow_rc);
>   }
>   
>   static ssize_t eeh_notify_resume_store(struct device *dev,
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 501d43bf18f3..a313b1653124 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1422,7 +1422,7 @@ static ssize_t enabled_show(struct kobject *kobj,
>   			    struct kobj_attribute *attr,
>   			    char *buf)
>   {
> -	return sprintf(buf, "%d\n", fw_dump.fadump_enabled);
> +	return sysfs_emit(buf, "%d\n", fw_dump.fadump_enabled);
>   }
>   
>   /*
> @@ -1434,28 +1434,28 @@ static ssize_t hotplug_ready_show(struct kobject *kobj,
>   				      struct kobj_attribute *attr,
>   				      char *buf)
>   {
> -	return sprintf(buf, "%d\n", 1);
> +	return sysfs_emit(buf, "%d\n", 1);
>   }
>   
>   static ssize_t mem_reserved_show(struct kobject *kobj,
>   				 struct kobj_attribute *attr,
>   				 char *buf)
>   {
> -	return sprintf(buf, "%ld\n", fw_dump.reserve_dump_area_size);
> +	return sysfs_emit(buf, "%ld\n", fw_dump.reserve_dump_area_size);
>   }
>   
>   static ssize_t registered_show(struct kobject *kobj,
>   			       struct kobj_attribute *attr,
>   			       char *buf)
>   {
> -	return sprintf(buf, "%d\n", fw_dump.dump_registered);
> +	return sysfs_emit(buf, "%d\n", fw_dump.dump_registered);
>   }
>   
>   static ssize_t bootargs_append_show(struct kobject *kobj,
>   				   struct kobj_attribute *attr,
>   				   char *buf)
>   {
> -	return sprintf(buf, "%s\n", (char *)__va(fw_dump.param_area));
> +	return sysfs_emit(buf, "%s\n", (char *)__va(fw_dump.param_area));
>   }
>   
>   static ssize_t bootargs_append_store(struct kobject *kobj,
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index d122e8447831..ee1b5cb557c9 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -13,6 +13,7 @@
>   #include <linux/init.h>
>   #include <linux/types.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/mm.h>
>   #include <linux/spinlock.h>
>   #include <linux/string.h>
> @@ -141,7 +142,7 @@ late_initcall(fail_iommu_debugfs);
>   static ssize_t fail_iommu_show(struct device *dev,
>   			       struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%d\n", dev->archdata.fail_iommu);
> +	return sysfs_emit(buf, "%d\n", dev->archdata.fail_iommu);
>   }
>   
>   static ssize_t fail_iommu_store(struct device *dev,
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> index fbb7ebd8aa08..600596cb4ffb 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -11,6 +11,7 @@
>   #include <linux/nospec.h>
>   #include <linux/prctl.h>
>   #include <linux/seq_buf.h>
> +#include <linux/sysfs.h>
>   #include <linux/debugfs.h>
>   
>   #include <asm/asm-prototypes.h>
> @@ -163,13 +164,13 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
>   	}
>   
>   	if (thread_priv)
> -		return sprintf(buf, "Vulnerable: L1D private per thread\n");
> +		return sysfs_emit(buf, "Vulnerable: L1D private per thread\n");
>   
>   	if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
>   	    !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR))
> -		return sprintf(buf, "Not affected\n");
> +		return sysfs_emit(buf, "Not affected\n");
>   
> -	return sprintf(buf, "Vulnerable\n");
> +	return sysfs_emit(buf, "Vulnerable\n");
>   }
>   
>   ssize_t cpu_show_l1tf(struct device *dev, struct device_attribute *attr, char *buf)
> @@ -352,14 +353,14 @@ ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *
>   		default:
>   			type = "unknown";
>   		}
> -		return sprintf(buf, "Mitigation: Kernel entry/exit barrier (%s)\n", type);
> +		return sysfs_emit(buf, "Mitigation: Kernel entry/exit barrier (%s)\n", type);
>   	}
>   
>   	if (!security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV) &&
>   	    !security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR))
> -		return sprintf(buf, "Not affected\n");
> +		return sysfs_emit(buf, "Not affected\n");
>   
> -	return sprintf(buf, "Vulnerable\n");
> +	return sysfs_emit(buf, "Vulnerable\n");
>   }
>   
>   static int ssb_prctl_get(struct task_struct *task)
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 6b3dd6decdf9..329c1690b5ed 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -5,6 +5,7 @@
>   #include <linux/percpu.h>
>   #include <linux/init.h>
>   #include <linux/sched.h>
> +#include <linux/sysfs.h>
>   #include <linux/export.h>
>   #include <linux/nodemask.h>
>   #include <linux/cpumask.h>
> @@ -63,7 +64,7 @@ static ssize_t show_smt_snooze_delay(struct device *dev,
>   {
>   	pr_warn_once("%s (%d) read from unsupported smt_snooze_delay\n",
>   		     current->comm, current->pid);
> -	return sprintf(buf, "100\n");
> +	return sysfs_emit(buf, "100\n");
>   }
>   
>   static DEVICE_ATTR(smt_snooze_delay, 0644, show_smt_snooze_delay,
> @@ -100,7 +101,7 @@ static ssize_t show_##NAME(struct device *dev, \
>   	struct cpu *cpu = container_of(dev, struct cpu, dev); \
>   	unsigned long val; \
>   	smp_call_function_single(cpu->dev.id, read_##NAME, &val, 1);	\
> -	return sprintf(buf, "%lx\n", val); \
> +	return sysfs_emit(buf, "%lx\n", val); \
>   } \
>   static ssize_t __used \
>   	store_##NAME(struct device *dev, struct device_attribute *attr, \
> @@ -183,7 +184,7 @@ static void add_write_permission_dev_attr(struct device_attribute *attr)
>   static ssize_t show_dscr_default(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%lx\n", dscr_default);
> +	return sysfs_emit(buf, "%lx\n", dscr_default);
>   }
>   
>   /**
> @@ -272,7 +273,7 @@ static ssize_t show_pw20_state(struct device *dev,
>   
>   	value &= PWRMGTCR0_PW20_WAIT;
>   
> -	return sprintf(buf, "%u\n", value ? 1 : 0);
> +	return sysfs_emit(buf, "%u\n", value ? 1 : 0);
>   }
>   
>   static void do_store_pw20_state(void *val)
> @@ -337,7 +338,7 @@ static ssize_t show_pw20_wait_time(struct device *dev,
>   		time = pw20_wt;
>   	}
>   
> -	return sprintf(buf, "%llu\n", time > 0 ? time : 0);
> +	return sysfs_emit(buf, "%llu\n", time > 0 ? time : 0);
>   }
>   
>   static void set_pw20_wait_entry_bit(void *val)
> @@ -394,7 +395,7 @@ static ssize_t show_altivec_idle(struct device *dev,
>   
>   	value &= PWRMGTCR0_AV_IDLE_PD_EN;
>   
> -	return sprintf(buf, "%u\n", value ? 1 : 0);
> +	return sysfs_emit(buf, "%u\n", value ? 1 : 0);
>   }
>   
>   static void do_store_altivec_idle(void *val)
> @@ -459,7 +460,7 @@ static ssize_t show_altivec_idle_wait_time(struct device *dev,
>   		time = altivec_idle_wt;
>   	}
>   
> -	return sprintf(buf, "%llu\n", time > 0 ? time : 0);
> +	return sysfs_emit(buf, "%llu\n", time > 0 ? time : 0);
>   }
>   
>   static void set_altivec_idle_wait_entry_bit(void *val)
> @@ -746,7 +747,7 @@ static struct device_attribute pa6t_attrs[] = {
>   #ifdef CONFIG_PPC_SVM
>   static ssize_t show_svm(struct device *dev, struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%u\n", is_secure_guest());
> +	return sysfs_emit(buf, "%u\n", is_secure_guest());
>   }
>   static DEVICE_ATTR(svm, 0444, show_svm, NULL);
>   
> @@ -780,7 +781,7 @@ static ssize_t idle_purr_show(struct device *dev,
>   	u64 val;
>   
>   	smp_call_function_single(cpu->dev.id, read_idle_purr, &val, 1);
> -	return sprintf(buf, "%llx\n", val);
> +	return sysfs_emit(buf, "%llx\n", val);
>   }
>   static DEVICE_ATTR(idle_purr, 0400, idle_purr_show, NULL);
>   
> @@ -810,7 +811,7 @@ static ssize_t idle_spurr_show(struct device *dev,
>   	u64 val;
>   
>   	smp_call_function_single(cpu->dev.id, read_idle_spurr, &val, 1);
> -	return sprintf(buf, "%llx\n", val);
> +	return sysfs_emit(buf, "%llx\n", val);
>   }
>   static DEVICE_ATTR(idle_spurr, 0400, idle_spurr_show, NULL);
>   
> @@ -1143,7 +1144,7 @@ static ssize_t show_physical_id(struct device *dev,
>   {
>   	struct cpu *cpu = container_of(dev, struct cpu, dev);
>   
> -	return sprintf(buf, "%d\n", get_hard_smp_processor_id(cpu->dev.id));
> +	return sysfs_emit(buf, "%d\n", get_hard_smp_processor_id(cpu->dev.id));
>   }
>   static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
>   
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 2e6adf5b95c4..bb65f0abc462 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -10,6 +10,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/percpu.h>
>   #include <linux/hardirq.h>
> +#include <linux/sysfs.h>
>   #include <linux/uaccess.h>
>   #include <asm/reg.h>
>   #include <asm/pmc.h>
> @@ -2204,7 +2205,7 @@ ssize_t power_events_sysfs_show(struct device *dev,
>   
>   	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
>   
> -	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> +	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
>   }
>   
>   static struct pmu power_pmu = {
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 243c0a1c8cda..abb4cfb11fcc 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -12,6 +12,7 @@
>   #include <linux/rbtree.h>
>   #include <linux/module.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/vmalloc.h>
>   
>   #include <asm/cputhreads.h>
> @@ -434,19 +435,19 @@ static ssize_t cpumask_show(struct device *dev,
>   static ssize_t sockets_show(struct device *dev,
>   			    struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%d\n", phys_sockets);
> +	return sysfs_emit(buf, "%d\n", phys_sockets);
>   }
>   
>   static ssize_t chipspersocket_show(struct device *dev,
>   				   struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%d\n", phys_chipspersocket);
> +	return sysfs_emit(buf, "%d\n", phys_chipspersocket);
>   }
>   
>   static ssize_t coresperchip_show(struct device *dev,
>   				 struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%d\n", phys_coresperchip);
> +	return sysfs_emit(buf, "%d\n", phys_coresperchip);
>   }
>   
>   static struct attribute *device_str_attr_create_(char *name, char *str)
> @@ -1061,7 +1062,7 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
>   static ssize_t domains_show(struct device *dev, struct device_attribute *attr,
>   			    char *page)
>   {
> -	int d, n, count = 0;
> +	int d, count = 0;
>   	const char *str;
>   
>   	for (d = 0; d < HV_PERF_DOMAIN_MAX; d++) {
> @@ -1069,12 +1070,7 @@ static ssize_t domains_show(struct device *dev, struct device_attribute *attr,
>   		if (!str)
>   			continue;
>   
> -		n = sprintf(page, "%d: %s\n", d, str);
> -		if (n < 0)
> -			break;
> -
> -		count += n;
> -		page += n;
> +		count += sysfs_emit_at(page, count, "%d: %s\n", d, str);
>   	}
>   	return count;
>   }
> @@ -1095,7 +1091,7 @@ static ssize_t _name##_show(struct device *dev,			\
>   		ret = -EIO;					\
>   		goto e_free;					\
>   	}							\
> -	ret = sprintf(buf, _fmt, _expr);			\
> +	ret = sysfs_emit(buf, _fmt, _expr);			\
>   e_free:								\
>   	kmem_cache_free(hv_page_cache, page);			\
>   	return ret;						\
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index c7a1fe5918c5..1135f9739ead 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -11,6 +11,7 @@
>   
>   #include <linux/init.h>
>   #include <linux/perf_event.h>
> +#include <linux/sysfs.h>
>   #include <asm/firmware.h>
>   #include <asm/hvcall.h>
>   #include <asm/io.h>
> @@ -85,7 +86,7 @@ static ssize_t _name##_show(struct device *dev,			\
>   	if (hret)						\
>   		return -EIO;					\
>   								\
> -	return sprintf(page, _format, caps._name);		\
> +	return sysfs_emit(page, _format, caps._name);		\
>   }								\
>   static struct device_attribute hv_caps_attr_##_name = __ATTR_RO(_name)
>   
> @@ -93,7 +94,7 @@ static ssize_t kernel_version_show(struct device *dev,
>   				   struct device_attribute *attr,
>   				   char *page)
>   {
> -	return sprintf(page, "0x%x\n", COUNTER_INFO_VERSION_CURRENT);
> +	return sysfs_emit(page, "0x%x\n", COUNTER_INFO_VERSION_CURRENT);
>   }
>   
>   static ssize_t cpumask_show(struct device *dev,
> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
> index ae264c9080ef..aa72b96b5a8c 100644
> --- a/arch/powerpc/perf/kvm-hv-pmu.c
> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
> @@ -16,6 +16,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/spinlock_types.h>
>   #include <linux/spinlock.h>
> +#include <linux/sysfs.h>
>   
>   #include <asm/types.h>
>   #include <asm/kvm_ppc.h>
> @@ -48,7 +49,7 @@ static ssize_t kvmppc_events_sysfs_show(struct device *dev,
>   	struct perf_pmu_events_attr *pmu_attr;
>   
>   	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> -	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> +	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
>   }
>   
>   /* Holds the hostwide stats */
> diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
> index 840733468959..bff4cfab7b94 100644
> --- a/arch/powerpc/perf/vpa-pmu.c
> +++ b/arch/powerpc/perf/vpa-pmu.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/perf_event.h>
> +#include <linux/sysfs.h>
>   #include <asm/kvm_ppc.h>
>   #include <asm/kvm_book3s_64.h>
>   
> @@ -26,7 +27,7 @@ static ssize_t vpa_pmu_events_sysfs_show(struct device *dev,
>   
>   	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
>   
> -	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> +	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
>   }
>   
>   #define VPA_PMU_EVENT_ATTR(_name, _id)				\
> diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> index 9b693594a5f7..c3fbec1f1d24 100644
> --- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> +++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> @@ -15,6 +15,7 @@
>   #include <linux/i2c.h>
>   #include <linux/gpio/driver.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/kthread.h>
>   #include <linux/property.h>
>   #include <linux/reboot.h>
> @@ -77,7 +78,7 @@ static ssize_t show_status(struct device *d,
>   		return -ENODEV;
>   	mcu->reg_ctrl = ret;
>   
> -	return sprintf(buf, "%02x\n", ret);
> +	return sysfs_emit(buf, "%02x\n", ret);
>   }
>   static DEVICE_ATTR(status, 0444, show_status, NULL);
>   
> diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
> index 0ec7b3bdda56..8452153d4650 100644
> --- a/arch/powerpc/platforms/cell/spu_base.c
> +++ b/arch/powerpc/platforms/cell/spu_base.c
> @@ -20,6 +20,7 @@
>   #include <linux/mutex.h>
>   #include <linux/linux_logo.h>
>   #include <linux/syscore_ops.h>
> +#include <linux/sysfs.h>
>   #include <asm/spu.h>
>   #include <asm/spu_priv1.h>
>   #include <asm/spu_csa.h>
> @@ -638,8 +639,8 @@ static ssize_t spu_stat_show(struct device *dev,
>   {
>   	struct spu *spu = container_of(dev, struct spu, dev);
>   
> -	return sprintf(buf, "%s %llu %llu %llu %llu "
> -		      "%llu %llu %llu %llu %llu %llu %llu %llu\n",
> +	return sysfs_emit(buf,
> +		"%s %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu\n",
>   		spu_state_names[spu->stats.util_state],
>   		spu_acct_time(spu, SPU_UTIL_USER),
>   		spu_acct_time(spu, SPU_UTIL_SYSTEM),
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 6cd461f82968..33103a98cfd5 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -8,6 +8,7 @@
>   #include <linux/types.h>
>   #include <linux/mm.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/of.h>
>   #include <linux/device.h>
>   #include <linux/cpu.h>
> @@ -171,7 +172,7 @@ static u8 fastsleep_workaround_applyonce;
>   static ssize_t show_fastsleep_workaround_applyonce(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%u\n", fastsleep_workaround_applyonce);
> +	return sysfs_emit(buf, "%u\n", fastsleep_workaround_applyonce);
>   }
>   
>   static ssize_t store_fastsleep_workaround_applyonce(struct device *dev,
> diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
> index 2e4bffa74163..0586821d7af4 100644
> --- a/arch/powerpc/platforms/powernv/opal-dump.c
> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
> @@ -8,6 +8,7 @@
>   #include <linux/kobject.h>
>   #include <linux/mm.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/vmalloc.h>
>   #include <linux/pagemap.h>
>   #include <linux/delay.h>
> @@ -40,7 +41,7 @@ static ssize_t dump_id_show(struct dump_obj *dump_obj,
>   			    struct dump_attribute *attr,
>   			    char *buf)
>   {
> -	return sprintf(buf, "0x%x\n", dump_obj->id);
> +	return sysfs_emit(buf, "0x%x\n", dump_obj->id);
>   }
>   
>   static const char* dump_type_to_string(uint32_t type)
> @@ -58,15 +59,15 @@ static ssize_t dump_type_show(struct dump_obj *dump_obj,
>   			      char *buf)
>   {
>   
> -	return sprintf(buf, "0x%x %s\n", dump_obj->type,
> -		       dump_type_to_string(dump_obj->type));
> +	return sysfs_emit(buf, "0x%x %s\n", dump_obj->type,
> +			  dump_type_to_string(dump_obj->type));
>   }
>   
>   static ssize_t dump_ack_show(struct dump_obj *dump_obj,
>   			     struct dump_attribute *attr,
>   			     char *buf)
>   {
> -	return sprintf(buf, "ack - acknowledge dump\n");
> +	return sysfs_emit(buf, "ack - acknowledge dump\n");
>   }
>   
>   /*
> @@ -114,7 +115,7 @@ static ssize_t init_dump_show(struct dump_obj *dump_obj,
>   			      struct dump_attribute *attr,
>   			      char *buf)
>   {
> -	return sprintf(buf, "1 - initiate Service Processor(FSP) dump\n");
> +	return sysfs_emit(buf, "1 - initiate Service Processor(FSP) dump\n");
>   }
>   
>   static int64_t dump_fips_init(uint8_t type)
> diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
> index 2b8331922ab9..6cacd3fd3cd5 100644
> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> @@ -40,7 +40,7 @@ static ssize_t elog_id_show(struct elog_obj *elog_obj,
>   			    struct elog_attribute *attr,
>   			    char *buf)
>   {
> -	return sprintf(buf, "0x%llx\n", elog_obj->id);
> +	return sysfs_emit(buf, "0x%llx\n", elog_obj->id);
>   }
>   
>   static const char *elog_type_to_string(uint64_t type)
> @@ -55,16 +55,15 @@ static ssize_t elog_type_show(struct elog_obj *elog_obj,
>   			      struct elog_attribute *attr,
>   			      char *buf)
>   {
> -	return sprintf(buf, "0x%llx %s\n",
> -		       elog_obj->type,
> -		       elog_type_to_string(elog_obj->type));
> +	return sysfs_emit(buf, "0x%llx %s\n", elog_obj->type,
> +			  elog_type_to_string(elog_obj->type));
>   }
>   
>   static ssize_t elog_ack_show(struct elog_obj *elog_obj,
>   			     struct elog_attribute *attr,
>   			     char *buf)
>   {
> -	return sprintf(buf, "ack - acknowledge log message\n");
> +	return sysfs_emit(buf, "ack - acknowledge log message\n");
>   }
>   
>   static ssize_t elog_ack_store(struct elog_obj *elog_obj,
> diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
> index a3f7a2928767..5ca5f6329a2d 100644
> --- a/arch/powerpc/platforms/powernv/opal-flash.c
> +++ b/arch/powerpc/platforms/powernv/opal-flash.c
> @@ -238,7 +238,7 @@ static ssize_t manage_show(struct kobject *kobj,
>   	struct manage_flash_t *const args_buf = &manage_flash_data;
>   	int rc;
>   
> -	rc = sprintf(buf, "%d\n", args_buf->status);
> +	rc = sysfs_emit(buf, "%d\n", args_buf->status);
>   	/* Set status to default*/
>   	args_buf->status = FLASH_NO_OP;
>   	return rc;
> @@ -321,7 +321,7 @@ static ssize_t update_show(struct kobject *kobj,
>   			   struct kobj_attribute *attr, char *buf)
>   {
>   	struct update_flash_t *const args_buf = &update_flash_data;
> -	return sprintf(buf, "%d\n", args_buf->status);
> +	return sysfs_emit(buf, "%d\n", args_buf->status);
>   }
>   
>   /*
> diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
> index 9bb73cb42a65..bf18b333281e 100644
> --- a/arch/powerpc/platforms/powernv/opal-powercap.c
> +++ b/arch/powerpc/platforms/powernv/opal-powercap.c
> @@ -10,6 +10,7 @@
>   #include <linux/of.h>
>   #include <linux/kobject.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   
>   #include <asm/opal.h>
>   
> @@ -56,16 +57,11 @@ static ssize_t powercap_show(struct kobject *kobj, struct kobj_attribute *attr,
>   			goto out;
>   		}
>   		ret = opal_error_code(opal_get_async_rc(msg));
> -		if (!ret) {
> -			ret = sprintf(buf, "%u\n", be32_to_cpu(pcap));
> -			if (ret < 0)
> -				ret = -EIO;
> -		}
> +		if (!ret)
> +			ret = sysfs_emit(buf, "%u\n", be32_to_cpu(pcap));
>   		break;
>   	case OPAL_SUCCESS:
> -		ret = sprintf(buf, "%u\n", be32_to_cpu(pcap));
> -		if (ret < 0)
> -			ret = -EIO;
> +		ret = sysfs_emit(buf, "%u\n", be32_to_cpu(pcap));
>   		break;
>   	default:
>   		ret = opal_error_code(ret);
> diff --git a/arch/powerpc/platforms/powernv/opal-psr.c b/arch/powerpc/platforms/powernv/opal-psr.c
> index 24d0a894d965..19228181cb6f 100644
> --- a/arch/powerpc/platforms/powernv/opal-psr.c
> +++ b/arch/powerpc/platforms/powernv/opal-psr.c
> @@ -10,6 +10,7 @@
>   #include <linux/of.h>
>   #include <linux/kobject.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   
>   #include <asm/opal.h>
>   
> @@ -50,16 +51,11 @@ static ssize_t psr_show(struct kobject *kobj, struct kobj_attribute *attr,
>   			goto out;
>   		}
>   		ret = opal_error_code(opal_get_async_rc(msg));
> -		if (!ret) {
> -			ret = sprintf(buf, "%u\n", be32_to_cpu(psr));
> -			if (ret < 0)
> -				ret = -EIO;
> -		}
> +		if (!ret)
> +			ret = sysfs_emit(buf, "%u\n", be32_to_cpu(psr));
>   		break;
>   	case OPAL_SUCCESS:
> -		ret = sprintf(buf, "%u\n", be32_to_cpu(psr));
> -		if (ret < 0)
> -			ret = -EIO;
> +		ret = sysfs_emit(buf, "%u\n", be32_to_cpu(psr));
>   		break;
>   	default:
>   		ret = opal_error_code(ret);
> diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
> index 393e747541fb..f7668ef1ac1f 100644
> --- a/arch/powerpc/platforms/powernv/subcore.c
> +++ b/arch/powerpc/platforms/powernv/subcore.c
> @@ -12,6 +12,7 @@
>   #include <linux/gfp.h>
>   #include <linux/smp.h>
>   #include <linux/stop_machine.h>
> +#include <linux/sysfs.h>
>   
>   #include <asm/cputhreads.h>
>   #include <asm/cpuidle.h>
> @@ -409,7 +410,7 @@ static ssize_t __used store_subcores_per_core(struct device *dev,
>   static ssize_t show_subcores_per_core(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%x\n", subcores_per_core);
> +	return sysfs_emit(buf, "%x\n", subcores_per_core);
>   }
>   
>   static DEVICE_ATTR(subcores_per_core, 0644,
> diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
> index 150c09b58ae8..ca2608a70f4d 100644
> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -10,6 +10,7 @@
>   #include <linux/delay.h>
>   #include <linux/fs.h>
>   #include <linux/root_dev.h>
> +#include <linux/sysfs.h>
>   #include <linux/console.h>
>   #include <linux/export.h>
>   #include <linux/memblock.h>
> @@ -183,7 +184,7 @@ static int ps3_set_dabr(unsigned long dabr, unsigned long dabrx)
>   static ssize_t ps3_fw_version_show(struct kobject *kobj,
>   	struct kobj_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%s", ps3_firmware_version_str);
> +	return sysfs_emit(buf, "%s\n", ps3_firmware_version_str);
>   }
>   
>   static int __init ps3_setup_sysfs(void)
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 8d83df12430f..38e22125b96f 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -18,6 +18,7 @@
>   #include <linux/sched.h>
>   #include <linux/stringify.h>
>   #include <linux/swap.h>
> +#include <linux/sysfs.h>
>   #include <linux/device.h>
>   #include <linux/balloon.h>
>   #include <asm/firmware.h>
> @@ -333,7 +334,7 @@ static int cmm_thread(void *dummy)
>   				   struct device_attribute *attr,	\
>   				   char *buf)			\
>   	{							\
> -		return sprintf(buf, format, ##args);		\
> +		return sysfs_emit(buf, format, ##args);		\
>   	}							\
>   	static DEVICE_ATTR(name, 0444, show_##name, NULL)
>   
> @@ -343,7 +344,7 @@ CMM_SHOW(loaned_target_kb, "%lu\n", PAGES2KB(loaned_pages_target));
>   static ssize_t show_oom_pages(struct device *dev,
>   			      struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%lu\n", PAGES2KB(oom_freed_pages));
> +	return sysfs_emit(buf, "%lu\n", PAGES2KB(oom_freed_pages));
>   }
>   
>   static ssize_t store_oom_pages(struct device *dev,
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index a7c451c2507d..f4d33b8dffd8 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -14,6 +14,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/cpu.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/of.h>
>   
>   #include "of_helpers.h"
> @@ -798,7 +799,7 @@ static ssize_t dlpar_store(const struct class *class, const struct class_attribu
>   static ssize_t dlpar_show(const struct class *class, const struct class_attribute *attr,
>   			  char *buf)
>   {
> -	return sprintf(buf, "%s\n", "memory,cpu,dt");
> +	return sysfs_emit(buf, "%s\n", "memory,cpu,dt");
>   }
>   
>   static CLASS_ATTR_RW(dlpar);
> diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
> index cad2deb7e70d..2d0f991da2c8 100644
> --- a/arch/powerpc/platforms/pseries/ibmebus.c
> +++ b/arch/powerpc/platforms/pseries/ibmebus.c
> @@ -46,6 +46,7 @@
>   #include <linux/of.h>
>   #include <linux/slab.h>
>   #include <linux/stat.h>
> +#include <linux/sysfs.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <asm/ibmebus.h>
> @@ -399,7 +400,7 @@ static ssize_t devspec_show(struct device *dev,
>   	struct platform_device *ofdev;
>   
>   	ofdev = to_platform_device(dev);
> -	return sprintf(buf, "%pOF\n", ofdev->dev.of_node);
> +	return sysfs_emit(buf, "%pOF\n", ofdev->dev.of_node);
>   }
>   static DEVICE_ATTR_RO(devspec);
>   
> @@ -409,7 +410,7 @@ static ssize_t name_show(struct device *dev,
>   	struct platform_device *ofdev;
>   
>   	ofdev = to_platform_device(dev);
> -	return sprintf(buf, "%pOFn\n", ofdev->dev.of_node);
> +	return sysfs_emit(buf, "%pOFn\n", ofdev->dev.of_node);
>   }
>   static DEVICE_ATTR_RO(name);
>   
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 63eca4ebb5e5..75da96c08cdd 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -8,6 +8,7 @@
>   #include <linux/ioport.h>
>   #include <linux/seq_file.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/ndctl.h>
>   #include <linux/sched.h>
>   #include <linux/libnvdimm.h>
> @@ -1062,8 +1063,8 @@ static ssize_t health_bitmap_inject_show(struct device *dev,
>   	struct nvdimm *dimm = to_nvdimm(dev);
>   	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
>   
> -	return sprintf(buf, "%#llx\n",
> -		       READ_ONCE(p->health_bitmap_inject_mask));
> +	return sysfs_emit(buf, "%#llx\n",
> +			  READ_ONCE(p->health_bitmap_inject_mask));
>   }
>   
>   static DEVICE_ATTR_ADMIN_RO(health_bitmap_inject);
> diff --git a/arch/powerpc/platforms/pseries/power.c b/arch/powerpc/platforms/pseries/power.c
> index 3676cb297767..7b9dfe829f25 100644
> --- a/arch/powerpc/platforms/pseries/power.c
> +++ b/arch/powerpc/platforms/pseries/power.c
> @@ -11,6 +11,7 @@
>   
>   #include <linux/kobject.h>
>   #include <linux/string.h>
> +#include <linux/sysfs.h>
>   #include <linux/errno.h>
>   #include <linux/init.h>
>   #include <asm/machdep.h>
> @@ -22,7 +23,7 @@ unsigned long rtas_poweron_auto; /* default and normal state is 0 */
>   static ssize_t auto_poweron_show(struct kobject *kobj,
>   				 struct kobj_attribute *attr, char *buf)
>   {
> -        return sprintf(buf, "%lu\n", rtas_poweron_auto);
> +	return sysfs_emit(buf, "%lu\n", rtas_poweron_auto);
>   }
>   
>   static ssize_t auto_poweron_store(struct kobject *kobj,
> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
> index 2c661b798235..fdaf85ecd39b 100644
> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> @@ -12,6 +12,7 @@
>   #include <linux/errno.h>
>   #include <linux/init.h>
>   #include <linux/seq_file.h>
> +#include <linux/sysfs.h>
>   #include <linux/device.h>
>   #include <linux/cpu.h>
>   #include <linux/of.h>
> @@ -242,7 +243,7 @@ static ssize_t get_best_energy_data(struct device *dev,
>   	if (rc != H_SUCCESS)
>   		return -EINVAL;
>   
> -	return sprintf(page, "%lu\n", retbuf[1] >> 32);
> +	return sysfs_emit(page, "%lu\n", retbuf[1] >> 32);
>   }
>   
>   /* Wrapper functions */
> diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
> index c51db63d3e88..a9928d75624a 100644
> --- a/arch/powerpc/platforms/pseries/suspend.c
> +++ b/arch/powerpc/platforms/pseries/suspend.c
> @@ -7,6 +7,7 @@
>   #include <linux/delay.h>
>   #include <linux/suspend.h>
>   #include <linux/stat.h>
> +#include <linux/sysfs.h>
>   #include <asm/firmware.h>
>   #include <asm/hvcall.h>
>   #include <asm/machdep.h>
> @@ -121,7 +122,7 @@ static ssize_t show_hibernate(struct device *dev,
>   			      struct device_attribute *attr,
>   			      char *buf)
>   {
> -	return sprintf(buf, "%d\n", KERN_DT_UPDATE);
> +	return sysfs_emit(buf, "%d\n", KERN_DT_UPDATE);
>   }
>   
>   static DEVICE_ATTR(hibernate, 0644, show_hibernate, store_hibernate);
> diff --git a/arch/powerpc/platforms/pseries/vas-sysfs.c b/arch/powerpc/platforms/pseries/vas-sysfs.c
> index 4f6fbbb672ae..00c6ffd3ef39 100644
> --- a/arch/powerpc/platforms/pseries/vas-sysfs.c
> +++ b/arch/powerpc/platforms/pseries/vas-sysfs.c
> @@ -10,6 +10,7 @@
>   #include <linux/miscdevice.h>
>   #include <linux/kobject.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/mm.h>
>   
>   #include "vas.h"
> @@ -58,7 +59,7 @@ static ssize_t update_total_credits_store(struct vas_cop_feat_caps *caps,
>   #define sysfs_caps_entry_read(_name)					\
>   static ssize_t _name##_show(struct vas_cop_feat_caps *caps, char *buf) 	\
>   {									\
> -	return sprintf(buf, "%d\n", atomic_read(&caps->_name));	\
> +	return sysfs_emit(buf, "%d\n", atomic_read(&caps->_name));	\
>   }
>   
>   struct vas_sysfs_entry {
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> index 08e2add48adb..572bdf42335e 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -14,6 +14,7 @@
>   #include <linux/types.h>
>   #include <linux/delay.h>
>   #include <linux/stat.h>
> +#include <linux/sysfs.h>
>   #include <linux/device.h>
>   #include <linux/init.h>
>   #include <linux/slab.h>
> @@ -942,14 +943,14 @@ static ssize_t cmo_##name##_show(struct device *dev,                    \
>                                           struct device_attribute *attr,  \
>                                            char *buf)                     \
>   {                                                                       \
> -	return sprintf(buf, "%lu\n", to_vio_dev(dev)->cmo.name);        \
> +	return sysfs_emit(buf, "%lu\n", to_vio_dev(dev)->cmo.name);     \
>   }
>   
>   static ssize_t cmo_allocs_failed_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
>   	struct vio_dev *viodev = to_vio_dev(dev);
> -	return sprintf(buf, "%d\n", atomic_read(&viodev->cmo.allocs_failed));
> +	return sysfs_emit(buf, "%d\n", atomic_read(&viodev->cmo.allocs_failed));
>   }
>   
>   static ssize_t cmo_allocs_failed_store(struct device *dev,
> @@ -998,7 +999,7 @@ static DEVICE_ATTR_RW(cmo_allocs_failed);
>   #define viobus_cmo_rd_attr(name)                                        \
>   static ssize_t cmo_bus_##name##_show(const struct bus_type *bt, char *buf)    \
>   {                                                                       \
> -	return sprintf(buf, "%lu\n", vio_cmo.name);                     \
> +	return sysfs_emit(buf, "%lu\n", vio_cmo.name);                  \
>   }                                                                       \
>   static struct bus_attribute bus_attr_cmo_bus_##name =			\
>   	__ATTR(cmo_##name, S_IRUGO, cmo_bus_##name##_show, NULL)
> @@ -1007,7 +1008,7 @@ static struct bus_attribute bus_attr_cmo_bus_##name =			\
>   static ssize_t                                                          \
>   cmo_##name##_##var##_show(const struct bus_type *bt, char *buf)         \
>   {                                                                       \
> -	return sprintf(buf, "%lu\n", vio_cmo.name.var);                 \
> +	return sysfs_emit(buf, "%lu\n", vio_cmo.name.var);              \
>   }                                                                       \
>   static BUS_ATTR_RO(cmo_##name##_##var)
>   
> @@ -1022,7 +1023,7 @@ viobus_cmo_pool_rd_attr(excess, free);
>   
>   static ssize_t cmo_high_show(const struct bus_type *bt, char *buf)
>   {
> -	return sprintf(buf, "%lu\n", vio_cmo.high);
> +	return sysfs_emit(buf, "%lu\n", vio_cmo.high);
>   }
>   
>   static ssize_t cmo_high_store(const struct bus_type *bt, const char *buf,
> @@ -1535,7 +1536,7 @@ machine_device_initcall(pseries, vio_device_init);
>   static ssize_t name_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
> -	return sprintf(buf, "%s\n", to_vio_dev(dev)->name);
> +	return sysfs_emit(buf, "%s\n", to_vio_dev(dev)->name);
>   }
>   static DEVICE_ATTR_RO(name);
>   
> @@ -1544,7 +1545,7 @@ static ssize_t devspec_show(struct device *dev,
>   {
>   	struct device_node *of_node = dev->of_node;
>   
> -	return sprintf(buf, "%pOF\n", of_node);
> +	return sysfs_emit(buf, "%pOF\n", of_node);
>   }
>   static DEVICE_ATTR_RO(devspec);
>   
> @@ -1556,17 +1557,13 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>   	const char *cp;
>   
>   	dn = dev->of_node;
> -	if (!dn) {
> -		strcpy(buf, "\n");
> -		return strlen(buf);
> -	}
> +	if (!dn)
> +		return sysfs_emit(buf, "\n");
>   	cp = of_get_property(dn, "compatible", NULL);
> -	if (!cp) {
> -		strcpy(buf, "\n");
> -		return strlen(buf);
> -	}
> +	if (!cp)
> +		return sysfs_emit(buf, "\n");
>   
> -	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
> +	return sysfs_emit(buf, "vio:T%sS%s\n", vio_dev->type, cp);
>   }
>   static DEVICE_ATTR_RO(modalias);
>   
> diff --git a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
> index f9e64f54dc14..f63b89adf9f3 100644
> --- a/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
> +++ b/arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/kernel.h>
>   #include <linux/slab.h>
> +#include <linux/sysfs.h>
>   #include <linux/errno.h>
>   #include <linux/module.h>
>   #include <linux/interrupt.h>
> @@ -61,7 +62,7 @@ static ssize_t fsl_timer_wakeup_show(struct device *dev,
>   	}
>   	mutex_unlock(&sysfs_lock);
>   
> -	return sprintf(buf, "%lld\n", interval);
> +	return sysfs_emit(buf, "%lld\n", interval);
>   }
>   
>   static ssize_t fsl_timer_wakeup_store(struct device *dev,


