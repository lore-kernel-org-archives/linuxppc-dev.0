Return-Path: <linuxppc-dev+bounces-18821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB9B10A1E65
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:54:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhLHb5hsPz2yd7;
	Thu, 26 Mar 2026 21:54:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522443;
	cv=none; b=TqLlAg7NfSvMTT6G+q5ENHnhXCSGVoubvj5wcEmRMSi8HPdW//73LgkHAhFf1/tQgqwg+8HkYIa+yAE4UQcBYhhgwbch1qJMyqoHyLmrIMNmaia24vQZ3utXZpec3WkJkxLH2z1ew39roUREOR6OTEF8b2336NA++NE6igWFxPaWIkwTujh+BAiZsn++bVPh/5NTXV+IQJZH6STuZu7KSYWoywi4h8/qnVHQC2zAbZAYqWQZdGaMz3usph9qVJDG7kJlC1DeCAXZ1bYltK3FT5jS8GK8CW+dLjkkfYvoYrs1YB+t1yCW6yciS41ZHXhLOeKQbeSM09msvswhFRqt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522443; c=relaxed/relaxed;
	bh=DV/gCCOMldyoDdt4HqPHllB/Qo2XxEjw7eaoKAE9NtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKmgs7piFfBuV1u/pGT3/k20R8Bn9wkknyddtlEry3mja+A8P9nK0og45YJneAWg4NC1fcPo0c0+Ir5UO3k7vZbUuvkhZMvYxK1H8NPYToXDAwU1RVlg7IWt4HXu/guDsAPdc+Tten56iHer/mBIek30hUXCpDCv79hEBzAbji3ScLgeIJ+X690ZJtRr6xP4+eEoIrFPehdoyetpTJgZdqBtAANPx43cIP9TKOdg95ZHqSw5ePxRQBDtmSMdz9zNcTLfPYNswl7+PuAT/8o7m+LIpYZcLZEpnFT7NK/KeWeG0WaHnCGJKIH30QPvIlBOBFse1Vez/zyKvU7xXmtcJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b4O8r4Jq; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b4O8r4Jq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhLHY70wmz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 21:54:00 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC4611AED;
	Thu, 26 Mar 2026 03:53:20 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BEE03FB90;
	Thu, 26 Mar 2026 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774522406; bh=TbxaIif3p8WQ6+e44Bzl22FNO5C/zwaxFLGv4rhnrAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4O8r4Jq2CFcar+ykaYubGzY5y5qXmjwpctKmzjtCbYrCy7ZWRYDuVV6rw/K5YRYE
	 cFU8FIDuxcRiwzgg6ypdQsF6ZJHHAtZPQCtyFE9nn5+FJpKL3uUn2slYkKqObCNZpl
	 vTALvEOciub+LB3zvVDl3q8MoMa8BSfaYZ27RjFc=
Date: Thu, 26 Mar 2026 10:53:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
	peterz@infradead.org, pawan.kumar.gupta@linux.intel.com,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, elver@google.com, paulmck@kernel.org,
	lirongqing@baidu.com, rppt@kernel.org, ardb@kernel.org,
	leitao@debian.org, osandov@fb.com, cfsworks@gmail.com,
	tangyouling@kylinos.cn, sourabhjain@linux.ibm.com,
	ritesh.list@gmail.com, eajames@linux.ibm.com,
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
	samuel.holland@sifive.com, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
	jbohac@suse.cz, fuqiang.wang@easystack.cn, guoren@kernel.org,
	chenjiahao16@huawei.com, hbathini@linux.ibm.com,
	james.morse@arm.com, takahiro.akashi@linaro.org,
	lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v10 4/8] crash: Exclude crash kernel memory in crash core
Message-ID: <acUQHCETMXaEtdK5@arm.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
 <20260325025904.2811960-5-ruanjinjie@huawei.com>
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
In-Reply-To: <20260325025904.2811960-5-ruanjinjie@huawei.com>

On Wed, Mar 25, 2026 at 10:59:00AM +0800, Jinjie Ruan wrote:
> The crash memory alloc, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> handling them in the crash core would eliminate a lot of duplication, so
> do them in the common code.
> 
> To achieve the above goal, three architecture-specific functions are
> introduced:
> 
> - arch_get_system_nr_ranges(). Pre-counts the max number of memory ranges.
> 
> - arch_crash_populate_cmem(). Collects the memory ranges and fills them
>   into cmem.
> 
> - arch_crash_exclude_ranges(). Architecture's additional crash memory
>   ranges exclusion, defaulting to empty.
> 
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

