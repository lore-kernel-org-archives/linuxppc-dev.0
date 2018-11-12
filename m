Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17509C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 11:50:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2A8223D8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 11:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2A8223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tpwC23WKzF3Xc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 22:50:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42tpsC4jJgzDqf6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 22:47:26 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9271E80D;
 Mon, 12 Nov 2018 03:47:24 -0800 (PST)
Received: from [10.163.1.201] (unknown [10.163.1.201])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0D023F5A0;
 Mon, 12 Nov 2018 03:47:19 -0800 (PST)
Subject: Re: [RFC] mm: Replace all open encodings for NUMA_NO_NODE
To: Hans Verkuil <hverkuil@xs4all.nl>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <1541990515-11670-1-git-send-email-anshuman.khandual@arm.com>
 <de754de5-cdf9-87d2-7ab2-a3630c034121@xs4all.nl>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d947edec-8c5a-78d7-4069-687ac4ad7cb8@arm.com>
Date: Mon, 12 Nov 2018 17:17:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <de754de5-cdf9-87d2-7ab2-a3630c034121@xs4all.nl>
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
Cc: linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org,
 intel-wired-lan@lists.osuosl.org, linux-alpha@vger.kernel.org,
 dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com, linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/12/2018 02:13 PM, Hans Verkuil wrote:
> On 11/12/2018 03:41 AM, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is encoded
>> as -1. Even though implicitly understood it is always better to have macros
>> in there. Replace these open encodings for an invalid node number with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
>> 'invalid node' from various places redirecting them to a common definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Build tested this with multiple cross compiler options like alpha, sparc,
>> arm64, x86, powerpc64le etc with their default config which might not have
>> compiled tested all driver related changes. I will appreciate folks giving
>> this a test in their respective build environment.
>>
>> All these places for replacement were found by running the following grep
>> patterns on the entire kernel code. Please let me know if this might have
>> missed some instances. This might also have replaced some false positives.
>> I will appreciate suggestions, inputs and review.
> The 'node' in the drivers/media and the drivers/video sources has nothing to
> do with numa. It's an index for a framebuffer instead (i.e. the X in /dev/fbX).

Thanks for the input. Will drop the changes there.
