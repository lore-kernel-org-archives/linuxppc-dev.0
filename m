Return-Path: <linuxppc-dev+bounces-19611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEC0F44869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:46:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsdP95YMsz2yZ6;
	Fri, 10 Apr 2026 23:46:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775828765;
	cv=none; b=eAvJ8TjfZqxoLScYSLUlI6PjcKvMLvI/i0XeMgMg9cDplx/iEx93+Iegjb2sd1LHoYi/2I4Ov8qndG6Vmjh2PWvjqzIft3lLjkusOoBv98zgotDQGWSHjGB74LgjbEXf3ylha/UJ3lG13qV8m4uotF9qqUa0L80xjztrNhCM5pgkCSPfE7YVm+vRa9qxvqo50eD4bjCNTVFkdC54FdtetSZ4DkWuQbNtuSUorqXVUMQYSJPJWMQai3xv7ltb6U3mtib0wRwS2TTRzLU2CW0quzB3E2+lPGmNys/wB9xWznI1OslOk6elGp1toxYp2pqD1FoQAiKT4mqkcdLkz+om8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775828765; c=relaxed/relaxed;
	bh=UO23niezElZIPksvH1GF8l70Cs5yLVefVLzmUuVpdSQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=czgEp9AskSCff7pCFfKDD8MckCKMe79pUduYfS7HrutVU6VYlCbb9eAbBJRCwaSBVJPMhBAq/QQQcEGBh+El0Q9p/BVSIsWI648HLsPQ79ggIb+bLsKLw3jl/KAKndYWx3VR3thA6RrGZstVCLW4+JEIpXwCOYlwUAZuEkOtPIJ0lDG8gsnn0YmpkwfdBQJRrA+gkCwa3kg9Kqqzl+gzBjiTzcAJiUL3eqDd4uKvFA646BintHTN+f62IFdJyS4s5Wsd0fIb3bVYfLwdt9C9wFe8Dw0cJJawzwBolbr0NHq+M29hsLYD1PP8FrfDPyYQG61Nzc2JgAIeBUgZDdCxhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FEXiIzJv; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FEXiIzJv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsdP651hjz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 23:46:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775828763; x=1807364763;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XhwVNk7AmxnQFYYbofWW0xn2GGcCMLifpnTZm0hI0iw=;
  b=FEXiIzJv8+UcMwTX/PPQY4mi9B3tvPyDq0w36qvSMB3Rhq5KcV2w3D/t
   X+/6YobVSdu+0GzRXM9ROQud1eABwZnSSQmRXUeXUvr82pu4QfwaLz9Zi
   ZmPnrlUYrX1OEqVv4axRIp2RYyLSZeJGJoCLIGD7jw6ePFRHuP0ipa/rQ
   qgBfOi+HYLNDl9fg3+Ep5+RKcqC99CHZvA1mh2+HhYk2Want+uaP8Wcx7
   K+d2S8LPKEsmwmg0cbEtqbeDS91t8LAIXQQi3S2X9uRtu76aLt6wruRpU
   rHAk/e0WWUsLrtUeMMoG8HbZmzo+h3rHVMuU1M+s0xbORptwnp3Ziy1m+
   w==;
X-CSE-ConnectionGUID: 1LhXBVDZRyWtR51G0QtJpQ==
X-CSE-MsgGUID: bHaMKqnvQwm/ENdnUO/U3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88229179"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="88229179"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 06:45:56 -0700
X-CSE-ConnectionGUID: 5EGNTPxSQP+GmiqHTb7hcA==
X-CSE-MsgGUID: poU0WXXBR3aVBOf3UOJDiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="225932507"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 06:45:46 -0700
Message-ID: <9db9515b-08e8-47bd-aced-206ac183195a@linux.intel.com>
Date: Fri, 10 Apr 2026 21:45:43 +0800
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
Cc: baolu.lu@linux.intel.com, x86@kernel.org, iommu@lists.linux.dev,
 Arnd Bergmann <arnd@arndb.de>, Michael Grzeschik
 <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
 Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: Re: [patch 09/38] iommu/vt-d: Use sched_clock() instead of
 get_cycles()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.187521447@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260410120318.187521447@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/2026 8:19 PM, Thomas Gleixner wrote:
> Calculating the timeout from get_cycles() is a historical leftover without
> any functional requirement.
> 
> Use ktime_get() instead.

The subject line says "Use sched_clock() ...", but the implementation
actually uses ktime_get(). Is it a typo or anything I misunderstood?

Other parts look good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

> 
> Signed-off-by: Thomas Gleixner<tglx@kernel.org>
> Cc:x86@kernel.org
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc:iommu@lists.linux.dev
> ---
>   arch/x86/include/asm/iommu.h |    3 ---
>   drivers/iommu/intel/dmar.c   |    4 ++--
>   drivers/iommu/intel/iommu.h  |    8 ++++++--
>   3 files changed, 8 insertions(+), 7 deletions(-)

Thanks,
baolu

