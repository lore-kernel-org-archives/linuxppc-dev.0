Return-Path: <linuxppc-dev+bounces-29434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723ECCC6B19
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 20:44:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j45tS2vtDz30hC;
	Wed, 14 Oct 2026 07:44:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791924288;
	cv=none; b=bSdSDv6vi0m1On+4AWdgzY/iOqwM6gHtNT/7AUzx3N+dYmtkKWkaPjQw+QgnBYuOfVaBrUf61CLFSQmUn+0PXIZckahImawmj5YOCs20OPBkhPAn8DrXazb6JO9KH0D69JV65xbB5l3OSEq4iRD8zJ5BYXceFxZqMXhGScK97KUvOM+Qa2268yhIt7BpnC2NLrTfKQ+dip9vgEsc3oK3m8/5a60PEV0FtEgHvaHR7Pwzw6oU6DWjo+WZeZh3wpgj0X0/W3+acF1vOFO46nerUux4evSZNMWtwDh3EaAlTWViemEs6nTPYlTOb+GXUAk9FU95BcK4daCYavtaPd5RZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791924288; c=relaxed/relaxed;
	bh=m3wbzeKnN192GR421OBCIel3qP9yeoQm43Qr6LemHA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IN4OV3641HWOFXORQPBjxxw66Z5PGS2Itx+jOpMtAjQkDezbfJBfm5zS9mcfoUA8z5wPy8Z/phl9iRFnP5iiDuH2qnMfHwnDmXM7eK85YAr/VsbH+iSyb8sGbfk9/eOi30H4kVVfc8j4p+XV1/b/dAkk/AQJEuvMMYlUBAQ+BlhrNch3hTJV7q9+zbI6wBbIxOjnrSog9qJ0Bx7R7Wh1QSwD9p6V79kSgaEBJZT3MUH+yX63DNS4gGsHv225+OBMbVD+00ICZM4C01fszn49oV23UnYW9T1S+AG3iW7p+eV2XRpP+7M0hUjfxXmRtUT3yjHzRPzffcvUs2Zke97Swg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Um5mcRt5; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=tim.c.chen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Um5mcRt5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=tim.c.chen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j45tP5Nxnz2xwN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 07:44:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791924286; x=1823460286;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hKPtDA6WNH3/iKEwQ7cGCkaW1k5mutPIIOA3W63nodI=;
  b=Um5mcRt537bvksqDmJ+KUH5l76aXiNxZKK1+Xi5ZlLbYI1PwIshTa7wf
   K17Fz+OK1By7taDkU3sXFoaUxycKu3h0VHLEvjZekpASeXln1Td27O74H
   S3W3f5GX0HmeHmlS8wmADhWwlBbbEMWDzY2u0M9vFPPELU6MLfUqgl2VS
   gPo3OJHzIe0YabTWhO7xe/87gp+I6xS3kcXA9TUu+6Lc1XSU0xLp/EHs/
   PK3+1iPWWWeNo0CHh6eGqdeIRmJqk5ME8s9POdWjG4A6/irdOUNa4WQH2
   EHXlRV89UkY+eoooeV1fEJFlspz6G0cHj3ptIshlj0tJYXzSIQ6+nZUrH
   g==;
X-CSE-ConnectionGUID: llC3BmKYSfyk7L4AL6sV0A==
X-CSE-MsgGUID: ArVgcsTUTf+MwrZ5keTbYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="681167"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="681167"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:44:41 -0700
X-CSE-ConnectionGUID: KStLpYvNRqyhG2cKmcGMJg==
X-CSE-MsgGUID: vSXiOx4xT3euS2RFd67gdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1196521"
Received: from unknown (HELO [10.241.242.105]) ([10.241.242.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 13:44:40 -0700
Message-ID: <4d0f2f4631f2f836bb1aec140c2c8e3e11d7ba20.camel@linux.intel.com>
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, peterz@infradead.org
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	ritesh.list@gmail.com, kprateek.nayak@amd.com, yu.c.chen@intel.com, 
	vineethr@linux.ibm.com, vincent.guittot@linaro.org, srikar@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au
Date: Tue, 13 Oct 2026 13:44:40 -0700
In-Reply-To: <dfd8312d-a59c-4480-b054-d94d2e66110e@linux.ibm.com>
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
	 <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
	 <dfd8312d-a59c-4480-b054-d94d2e66110e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
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

On Tue, 2026-10-13 at 15:28 +0530, Shrikanth Hegde wrote:
>=20

[snip]

>=20
> One way to fix it is with a change like below.
> But more thoughts after the patch.
>=20
> ---
>   arch/powerpc/include/asm/topology.h |  7 +------
>   arch/powerpc/kernel/smp.c           | 23 +++++++++++++++++++++++
>   include/linux/sched.h               |  2 +-
>   kernel/sched/topology.c             |  7 +++++++
>   4 files changed, 32 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/a=
sm/topology.h
> index 44ec416fa489..f4555632e692 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -135,12 +135,7 @@ struct cpumask *cpu_coregroup_mask(int cpu);
>   const struct cpumask *cpu_die_mask(int cpu);
>   int cpu_die_id(int cpu);
>  =20
> -/*
> - * Points to where the LLC is. On power9 this will point at CACHE
> - * domain, On others it will point to SMT domain. In all cases
> - * cpu_l2_cache_mask points to where LLC is
> - */
> -#define arch_llc_mask(cpu)     cpu_l2_cache_mask(cpu)
> +const struct cpumask *arch_llc_mask(int cpu);

You will need to add
#define arch_llc_mask arch_llc_mask
here.

Otherwise kernel/sched/topology.c looks for a macro:

  # ifndef arch_llc_mask
  #define arch_llc_mask(cpu) cpu_coregroup_mask(cpu)
  # endif

With the #define gone, the generic code falls back to
cpu_coregroup_mask().

>  =20
>   #ifdef CONFIG_PPC64
>   #include <asm/smp.h>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 6a4ee7d3b8e5..139c54fc3e2d 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1864,6 +1864,28 @@ void __noreturn arch_cpu_idle_dead(void)
>  =20
>   #endif
>  =20
> +/*
> + * Points to where the LLC is. On power9 this will point at CACHE
> + * domain, On others it will point to SMT domain. In all cases
> + * cpu_l2_cache_mask points to where LLC is.
> + *
> + * If there is llc_override debug knob, return appropriate mask
> + */
> +const struct cpumask *arch_llc_mask(int cpu)
> +{
> +	switch (READ_ONCE(llc_override)) {
> +	case LLC_OVERRIDE_SMT:
> +		return cpu_smt_mask(cpu);
> +	case LLC_OVERRIDE_MC:
> +		return cpu_coregroup_mask(cpu);
> +	case LLC_OVERRIDE_PKG:
> +		return cpu_die_mask(cpu);
> +	case LLC_OVERRIDE_DISABLED:
> +	default:
> +		return cpu_l2_cache_mask(cpu);
> +	}
> +}
> +

The mask here has to match the span of the highest SD_SHARE_LLC
domain, and there seems to be some mismatches.                             =
     =20
                                                                           =
   =20
- PKG: On power pc, seems like cpu_die_mask() returns
  cpu_coregroup_map when coregroups are
  supported,=C2=A0

	if (has_coregroup_support())                                              =
                                                                           =
                         =20
		return per_cpu(cpu_coregroup_map, cpu);                                  =
                                                                           =
                  =20
	else                                                                      =
                                                                           =
                         =20
		return cpu_node_mask(cpu);            =20

  so this is the MC span while sd_llc sits at PKG. It
  should be cpu_node_mask(), the same as tl_pkg_mask().  =20

- SMT: patch 3 adds SD_SHARE_LLC only to MC/PKG, so for "smt" the
  flags are as before. I think it is possible for P9 to have
  shared_caches between two cores:

  /*
   * P9 has a slightly odd architecture where pairs of cores share an L2 ca=
che.
   * This topology makes it *much* cheaper to migrate tasks between adjacen=
t cores
   * since the migrated task remains cache hot. We want to take advantage o=
f this
   * at the scheduler level so an extra topology level is required.
   */

  the CACHE level also has SD_SHARE_LLC, and highest_flag_domain() picks it=
, so sd_llc spans
  cpu_l2_cache_map. shared_caches is only set when that map is wider
  than the core's threads, e.g. a P9 core pair sharing an L2:

    CPU:               0 1 2 3 | 4 5 6 7
    cpu_smt_mask():    core A  | core B
    sd_llc (CACHE):    0-7

  The ids follow cpu_smt_mask(), so 0-3 and 4-7 get different ids
  while sd_llc and sd_llc_size cover all eight, and
  cpus_share_cache(0, 4) is false, which is incorrect.

>   int arch_update_cpu_topology(void)
>   {
>   	if (READ_ONCE(llc_override_changed)) {
> @@ -1923,6 +1945,7 @@ static ssize_t llc_override_set(struct file *file, =
const char __user *ubuf,
>   		pr_info("sched LLC override set to %s. Rebuilding sched domains\n",
>   			llc_override_str[override]);
>  =20
> +		sched_reset_llc_id();

The reset here seems racy without taking cpus_read_lock, and taking
sched_domains_mutex for each CPU and you could have a cpu hot plug event
or cpu set rebuild in between. =20

That's why I would go with the boot parameter. The llc ids are assigned onc=
e,
with the right mask, so there is nothing to reset or rebuild, no
change to kernel/sched/, and everything stays in arch/powerpc. Since
this is an experiment knob, needing a reboot to change it is a small
cost, and every run starts from a clean state.

Tim

>   		rebuild_sched_domains();
>   	}
>  =20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7b91cae4a59c..4d7e2ee841a9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2505,5 +2505,5 @@ extern void migrate_enable(void);
>   #endif /* MODULE */
>  =20
>   DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
> -
> +void sched_reset_llc_id(void);
>   #endif
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index dd2b1d70ec9d..63c9bca4c5eb 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -3087,6 +3087,13 @@ void sched_domains_free_llc_id(int cpu)
>   	sched_domains_mutex_unlock();
>   }
>  =20
> +void sched_reset_llc_id(void)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		sched_domains_free_llc_id(cpu);
> +}
>   /*
>    * Build sched domains for a given set of CPUs and attach the sched dom=
ains
>    * to the individual CPUs

