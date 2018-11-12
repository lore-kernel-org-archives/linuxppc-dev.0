Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA7C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:16:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF06214F1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF06214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tcsJ4wdlzF3BG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 15:16:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42tcpk5lG9zF0Qj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 15:14:38 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D853FA78;
 Sun, 11 Nov 2018 20:14:36 -0800 (PST)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A2453F5BD;
 Sun, 11 Nov 2018 20:14:32 -0800 (PST)
Subject: Re: [RFC] mm: Replace all open encodings for NUMA_NO_NODE
To: Joseph Qi <jiangqi903@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <1541990515-11670-1-git-send-email-anshuman.khandual@arm.com>
 <1e9393c5-ff43-8ec7-dd6c-a662f09ef7c1@gmail.com>
 <b92e3275-7a04-a148-bb5b-38658c270583@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <926057f3-f31d-9fe0-e2a8-d76bc3d97049@arm.com>
Date: Mon, 12 Nov 2018 09:44:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b92e3275-7a04-a148-bb5b-38658c270583@arm.com>
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
 linux-alpha@vger.kernel.org, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/12/2018 09:40 AM, Anshuman Khandual wrote:
> 
> 
> On 11/12/2018 09:27 AM, Joseph Qi wrote:
>> For ocfs2 part, node means host in the cluster, not NUMA node.
>>
> 
> Does not -1 indicate an invalid node which can never be present ?
> 

My bad, got it wrong. Seems like this is nothing to do with NUMA node
at all. Will drop the changes from ocfs2.
