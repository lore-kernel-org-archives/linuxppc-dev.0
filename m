Return-Path: <linuxppc-dev+bounces-143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA349C3DA4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2024 23:43:38 +0000 (UTC)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=127.0.0.1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wlz8T2b4Sz2ysb;
	Sat, 17 Aug 2024 09:43:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dietmar.eggemann@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlmmC0GX1z2xXV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2024 01:55:22 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F1613D5;
	Fri, 16 Aug 2024 08:55:17 -0700 (PDT)
Received: from [192.168.181.244] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 931F53F58B;
	Fri, 16 Aug 2024 08:54:46 -0700 (PDT)
Message-ID: <9c46d5f0-f4ff-461b-b483-840fab6dfecc@arm.com>
Date: Fri, 16 Aug 2024 17:54:39 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
 peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com,
 yangyicong@hisilicon.com, xuwei5@huawei.com, guohanjun@huawei.com
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-2-yangyicong@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240806085320.63514-2-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 10:53, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently if architectures want to support HOTPLUG_SMT they need to
> provide a topology_is_primary_thread() telling the framework which
> thread in the SMT cannot offline. However arm64 doesn't have a
> restriction on which thread in the SMT cannot offline, a simplest
> choice is that just make 1st thread as the "primary" thread. So
> just make this as the default implementation in the framework and
> let architectures like x86 that have special primary thread to
> override this function.

IMHO, ARM64 (/ARM), RISCV and PARISC (SMP) use GENERIC_ARCH_TOPOLOGY
(and drivers/base/arch_topology.c) so they could share
topology_is_primary_thread() also there?

[...]


