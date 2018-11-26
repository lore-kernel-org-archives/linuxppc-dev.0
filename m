Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4210EC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 06:47:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4BC2082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 06:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4BC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433HXl30x9zDqNk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 17:47:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 433HTy4CYmzDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 17:45:09 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 251CB351D;
 Sun, 25 Nov 2018 22:45:07 -0800 (PST)
Received: from [192.168.0.102] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4AB53F5A0;
 Sun, 25 Nov 2018 22:45:02 -0800 (PST)
Subject: Re: [PATCH] mm: Replace all open encodings for NUMA_NO_NODE
To: Vinod Koul <vkoul@kernel.org>
References: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
 <20181124140554.GG3175@vkoul-mobl.Dlink>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5228bcdb-b140-a86a-6c9c-488f1a723353@arm.com>
Date: Mon, 26 Nov 2018 12:15:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181124140554.GG3175@vkoul-mobl.Dlink>
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
 sparclinux@vger.kernel.org, akpm@linux-foundation.org, jiangqi903@gmail.com,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/24/2018 07:35 PM, Vinod Koul wrote:
> On 23-11-18, 15:24, Anshuman Khandual wrote:
> 
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -386,7 +386,8 @@ EXPORT_SYMBOL(dma_issue_pending_all);
>>  static bool dma_chan_is_local(struct dma_chan *chan, int cpu)
>>  {
>>  	int node = dev_to_node(chan->device->dev);
>> -	return node == -1 || cpumask_test_cpu(cpu, cpumask_of_node(node));
>> +	return node == NUMA_NO_NODE ||
>> +		cpumask_test_cpu(cpu, cpumask_of_node(node));
>>  }
> 
> I do not see dev_to_node being updated first, that returns -1 so I would
> prefer to check for -1 unless it return NUMA_NO_NODE

Sure will update dev_to_node() to return NUMA_NO_NODE as well.
