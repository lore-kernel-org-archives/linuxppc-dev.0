Return-Path: <linuxppc-dev+bounces-26211-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3068C61DF0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 04:58:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYGwH2w90z2y2f;
	Mon, 31 Aug 2026 14:58:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788152303;
	cv=none; b=T+SPWjh//ijVxhfQAqK+5EaZhsHErww+BptKsnmAdQneIlouXqBCVLOxMNFl2TkhAcfZo6QmdXbQ+JeNYdfOwzKm/BMQnLn93/cfFIsc77Vk1nxdyALjsLLzAeiwZ4tycAqXh84DQWgBW1xnIYjZp/aZU234Ve24UAkvmrlylxeml+wBSQjYsUKV/yye6IUj1nPiMBEk+zPUHpdSKu9+tz3bxWDZR93DOpyx+uzaRGpLyi3aUJcmqGeGq63iErPl18myialpVBjUNoLvfeWVJyexutxLslfAiSLph2PuYNafmByKiDK1U/3n2j3c6wmTh08UKf/C4yduXMDp5Lqf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788152303; c=relaxed/relaxed;
	bh=en4AmD5hCeuCuRbL6FUrsGO5StL0i22HAbZmjfcxvuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOoyhBXrkcQUBeb1LeaYuirNfx/AmRyXyyQukLyLGZ+tcM3z5l4wHO+QkaWNicwTK97n3UxEn3/dQAN26p8QmWB+Tuhj6HdR2ICZUUUyqc2dzYcWQ9cS1NAA2wUK4OBVT+vXdA4YHso+EcYhzQiRAwheHQIZqD0VE06vHefTc1QGD6pOUjZ2v8s2Tp0uKFTsURmeQnO6MjBvLY3S5dqwKsIV/4td0WlQt3lvEN4DKi5KncKZ+dAnjlnx2M/TdMSllW3G7oFf8zoryJZRzp8gGs/5kCr4Ad9hq9KydwaE8OeBqQUKyt9qgd52FY4tqVmNopwICSbp3ntl5hLvUmR42w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xu2oJUL3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xu2oJUL3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYGwG1Gzxz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 14:58:21 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so4330352a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788152299; x=1788757099; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=en4AmD5hCeuCuRbL6FUrsGO5StL0i22HAbZmjfcxvuw=;
        b=Xu2oJUL35A3CeSZoUQC+sDPqUnIfcWp/ILsIufnAUmpMyk7fLee6IWqpVnrVPKNuWH
         /0dilWimfLGPzK+B4gZWNwjk2AVFblxhOdw0y/TqsWtemwEgQXTw8TQD1XwJGEklmN83
         gClEyBSTv04NI+h+xCxCfiCj1Obgf8NRCaUkXzJzVpnuatdJ0M4jendMa7Sn/Y7RLTEH
         G8cHnZ+EFnOGZmaNgqYOA3nzrpSwXyScjgc79kp8fI6WtMrnyeV8iAJj3NKbiO43nb+Q
         5MAkmllaSCR4dEdimDTrNucsz8pDDk+1XuokYc8twjpGXMUdvTpUHoaa4WU2cgLT1YFN
         h4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788152299; x=1788757099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=en4AmD5hCeuCuRbL6FUrsGO5StL0i22HAbZmjfcxvuw=;
        b=DZjWdhWZlTqWTqVsAuIKWOLu5UZ/9OeWn9ckYd5HSYDQmE9ep1bSQehCLJsZw8Ka1b
         LWuDKKP7orMi0M7rMf8PRexNles3mqJRMByEbt0otQHBu8dX4YmwZa6HxxLBt8xmM6F+
         9RSZgqG5+vtQFR4OzVEJaWJT19cwIFryn9+DBPkthKKF1GB3XknDKrTwrYfOd0YnsrK6
         Rb32R2VXSBTvvEq0XQYQx/hnTFuZA86/hzR27+NRJEbl6LrHd2H/jd0hps9upgxHKR4d
         4JCt+cGsX0dixSVo4+h4ru1m/0ee1tSFzAXfrZe3tL3g9Abi+qBBoB9Q0h2BbF+4z1I2
         ex1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzhjNqN5PTRF9twwQdZ/hNcOzYogCrIIFqk0WyHqYStx/Fx0DFLmdyLibgpA7XTDcPX4LUENPYnqiW/aqw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ksTVY7dBkBYedob6Ad9fzqWQ80KBommgRtXQmzdDskQvE+KCoT
	e1kpAW+7higKm+6n/Kimyfa0gJ2Ny8ekfydgmjoXcOipSzJ24lWVCqh5
X-Gm-Gg: AYBFou0dJPC5hgMkAwEaFNe4Dm8r0iZlEk2cpiixz+4JvnXMv0/1GVVuo1TIK/CABSZ
	hHLkrRbQCF7nJtBMnkWVutzzIMKdcbTSo4kGFSU3ydQqcO5TVx/nYtdo6/RBd31efhZBk1v7o64
	J1hW7Dyej2AfeJPi23n7O9mcEy6x6ZqkhMM1YtXUu1e3QRoIyEOSsgeWh/FPMB8eL9lc4xs1xup
	6mkQZ8PVMSyN63470hH7onPtSAJ5nW4xWIviATC+1t9PN85KrZhsRmhdOSGNPSz2PEnYhGrTIYt
	ljhY3a4BCdX4Ctb4r+Jr0VblEQhm1tE8/6/TZl9F9Ue1cpk9F+XswDiIEts4XdrkhpLiJxfDTU0
	yhezyWYVrGilycYwGy3eoYWnDftTpjFQnc/pOABWTJDpUrEAcqRon+39Nut2XJeb3oTgTiS2vRf
	GO9E8575NN7Tbzk/zSK8YnlnZ//1bqFLaYOtsSwEzROF1rn/2ZcL7ewfcMQ7LZCRg/DH6QDPUPn
	yiipiGAWkEzF5I+mnMOGFRKtQhwiX5ckg==
X-Received: by 2002:a17:90b:2e4b:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-396d0d7b9bdmr35544502a91.6.1788152298604;
        Sun, 30 Aug 2026 21:58:18 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.43.112.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8094dasm27903206eec.13.2026.08.30.21.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:58:18 -0700 (PDT)
Date: Mon, 31 Aug 2026 10:28:12 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/configs: Add debug configs for debugging
Message-ID: <apUJnx1jpdfHLaVa@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260827121309.94434-1-gautam@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827121309.94434-1-gautam@linux.ibm.com>

On Thu, Aug 27, 2026 at 05:43:08PM +0530, Gautam Menghani wrote:
> Kernel has multiple config options to run extra validation checks that
> can help catch bugs. Define new configs for major subsystems to
> make it easy to enable the debug config options for a given area.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Split the enablement of configs into pseries and powernv configs.
> 
>  arch/powerpc/Makefile                    | 32 ++++++++++++++++++++++++
>  arch/powerpc/configs/common_debug.config | 11 ++++++++
>  arch/powerpc/configs/locks_debug.config  | 13 ++++++++++
>  arch/powerpc/configs/lockup_debug.config |  4 +++
>  arch/powerpc/configs/mm_debug.config     | 24 ++++++++++++++++++
>  5 files changed, 84 insertions(+)
>  create mode 100644 arch/powerpc/configs/common_debug.config
>  create mode 100644 arch/powerpc/configs/locks_debug.config
>  create mode 100644 arch/powerpc/configs/lockup_debug.config
>  create mode 100644 arch/powerpc/configs/mm_debug.config
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 9385db478c59..818aacace875 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -352,6 +352,38 @@ ppc64_randconfig:
>  	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/64-bit.config \
>  		-f $(srctree)/Makefile randconfig
> 
> +generated_configs += pseries_debug_defconfig
> +pseries_debug_defconfig:
> +	$(call merge_into_defconfig,ppc64_defconfig,le guest kvm_guest common_debug)
> +
> +generated_configs += pseries_locks_debug_defconfig
> +pseries_locks_debug_defconfig:
> +	$(call merge_into_defconfig,ppc64_defconfig,le guest kvm_guest locks_debug)
> +
> +generated_configs += pseries_mm_debug_defconfig
> +pseries_mm_debug_defconfig:
> +	$(call merge_into_defconfig,ppc64_defconfig,le guest kvm_guest mm_debug)
> +
> +generated_configs += pseries_lockup_debug_defconfig
> +pseries_lockup_debug_defconfig:
> +	$(call merge_into_defconfig,ppc64_defconfig,le guest kvm_guest lockup_debug)
> +
> +generated_configs += powernv_debug_defconfig
> +powernv_debug_defconfig:
> +	$(call merge_into_defconfig,powernv_defconfig,le guest kvm_guest common_debug)
> +
> +generated_configs += powernv_locks_debug_defconfig
> +powernv_locks_debug_defconfig:
> +	$(call merge_into_defconfig,powernv_defconfig,le guest kvm_guest locks_debug)
> +
> +generated_configs += powernv_mm_debug_defconfig
> +powernv_mm_debug_defconfig:
> +	$(call merge_into_defconfig,powernv_defconfig,le guest kvm_guest mm_debug)
> +
> +generated_configs += powernv_lockup_debug_defconfig
> +powernv_lockup_debug_defconfig:
> +	$(call merge_into_defconfig,powernv_defconfig,le guest kvm_guest lockup_debug)
> +
>  PHONY += $(generated_configs)
> 
>  define archhelp
> diff --git a/arch/powerpc/configs/common_debug.config b/arch/powerpc/configs/common_debug.config
> new file mode 100644
> index 000000000000..a341c8b41468
> --- /dev/null
> +++ b/arch/powerpc/configs/common_debug.config
> @@ -0,0 +1,11 @@
> +# For use in CI testing
> +CONFIG_EXPERT=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_PROVE_RCU=y
> +CONFIG_KASAN=y
> +CONFIG_UBSAN=y
> +CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_DEBUG_VM=y
> +CONFIG_DEBUG_OBJECTS=y
> +CONFIG_DEBUG_KMEMLEAK=y
> +CONFIG_DEBUG_STACKOVERFLOW=y
> diff --git a/arch/powerpc/configs/locks_debug.config b/arch/powerpc/configs/locks_debug.config
> new file mode 100644
> index 000000000000..b2cb23de75db
> --- /dev/null
> +++ b/arch/powerpc/configs/locks_debug.config
> @@ -0,0 +1,13 @@
> +CONFIG_EXPERT=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_DEBUG_LOCK_ALLOC=y
> +CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> +CONFIG_DEBUG_MUTEXES=y
> +CONFIG_DEBUG_SPINLOCK=y
> +CONFIG_DEBUG_RT_MUTEXES=y
> +CONFIG_DEBUG_RWSEMS=y
> +CONFIG_PROVE_RAW_LOCK_NESTING=y
> +CONFIG_RCU_EXPERT=y
> +CONFIG_PROVE_RCU=y
> +CONFIG_RCU_TRACE=y
> diff --git a/arch/powerpc/configs/lockup_debug.config b/arch/powerpc/configs/lockup_debug.config
> new file mode 100644
> index 000000000000..ad0a79abf60f
> --- /dev/null
> +++ b/arch/powerpc/configs/lockup_debug.config
> @@ -0,0 +1,4 @@
> +CONFIG_EXPERT=y
> +CONFIG_WQ_WATCHDOG=y
> +CONFIG_DETECT_HUNG_TASK=y
> +CONFIG_PANIC_ON_OOPS=y
> diff --git a/arch/powerpc/configs/mm_debug.config b/arch/powerpc/configs/mm_debug.config
> new file mode 100644
> index 000000000000..0e88eb983536
> --- /dev/null
> +++ b/arch/powerpc/configs/mm_debug.config
> @@ -0,0 +1,24 @@
> +CONFIG_EXPERT=y
> +CONFIG_DEBUG_PAGEALLOC=y
> +CONFIG_DEBUG_SLAB=y
> +CONFIG_KASAN=y
> +CONFIG_KFENCE=y
> +CONFIG_KMSAN=y
> +CONFIG_DEBUG_KMEMLEAK=y
> +CONFIG_DEBUG_VM=y
> +CONFIG_DEBUG_VIRTUAL=y
> +CONFIG_DEBUG_OBJECTS=y
> +CONFIG_DEBUG_OBJECTS_FREE=y
> +CONFIG_DEBUG_OBJECTS_TIMERS=y
> +CONFIG_DEBUG_OBJECTS_WORK=y
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> +CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> +CONFIG_SCHED_STACK_END_CHECK=y
> +CONFIG_DEBUG_VM_MAPLE_TREE=y
> +CONFIG_DEBUG_VM_RB=y
> +CONFIG_DEBUG_VM_PGFLAGS=y
> +CONFIG_DEBUG_MEMORY_INIT=y
> +CONFIG_DEBUG_PER_CPU_MAPS=y
> +CONFIG_DEBUG_KMAP_LOCAL=y
> +CONFIG_DEBUG_HIGHMEM=y
> +CONFIG_DEBUG_STACKOVERFLOW=y
> --
> 2.54.0
> 

Thanks Gautam for this. we'll be able to catch a lot of issues earlier
with this.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

