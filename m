Return-Path: <SRS0=+bYb=OD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9465DC43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 11:16:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE632086B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 11:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE632086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4329bT4K7rzDqWt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 22:16:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 4329XZ4NVxzDqW0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2018 22:13:33 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94F6A3898;
 Sat, 24 Nov 2018 03:13:30 -0800 (PST)
Received: from [10.163.1.117] (unknown [10.163.1.117])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55D4F3F5AF;
 Sat, 24 Nov 2018 03:13:19 -0800 (PST)
Subject: Re: [PATCH] mm: Replace all open encodings for NUMA_NO_NODE
To: Andrew Morton <akpm@linux-foundation.org>
References: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
 <20181123154415.42898a42e28a31488749738a@linux-foundation.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8e16e9d1-8f64-d2ca-7d06-985ce601f75b@arm.com>
Date: Sat, 24 Nov 2018 16:43:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181123154415.42898a42e28a31488749738a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: hverkuil@xs4all.nl, linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, intel-wired-lan@lists.osuosl.org,
 linux-alpha@vger.kernel.org, dmaengine@vger.kernel.org,
 sparclinux@vger.kernel.org, jiangqi903@gmail.com,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/24/2018 05:14 AM, Andrew Morton wrote:
> On Fri, 23 Nov 2018 15:24:16 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> At present there are multiple places where invalid node number is encoded
>> as -1. Even though implicitly understood it is always better to have macros
>> in there. Replace these open encodings for an invalid node number with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
>> 'invalid node' from various places redirecting them to a common definition.
>>
>> ...
>>
>> Build tested this with multiple cross compiler options like alpha, sparc,
>> arm64, x86, powerpc, powerpc64le etc with their default config which might
>> not have compiled tested all driver related changes. I will appreciate
>> folks giving this a test in their respective build environment.
>>
>> All these places for replacement were found by running the following grep
>> patterns on the entire kernel code. Please let me know if this might have
>> missed some instances. This might also have replaced some false positives.
>> I will appreciate suggestions, inputs and review.
>>
>> 1. git grep "nid == -1"
>> 2. git grep "node == -1"
>> 3. git grep "nid = -1"
>> 4. git grep "node = -1"
> 
> The build testing is good, but I worry that some of the affected files
> don't clearly have numa.h in their include paths, for the NUMA_NO_NODE
> definition.
> 
> The first thing I looked it is arch/powerpc/include/asm/pci-bridge.h. 
> Maybe it somehow manages to include numa.h via some nested include, but
> if so, is that reliable across all config combinations and as code
> evolves?
> 
> So I think that the patch should have added an explicit include of
> numa.h, especially in cases where the affected file previously had no
> references to any of the things which numa.h defines.

Fair enough. Will include numa.h in those particular files.
