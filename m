Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 18:09:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2A120817
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lw9f4pae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2A120817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Zg03FmJzDqb1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 05:09:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lw9f4pae";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.dk
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=axboe@kernel.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lw9f4pae"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433ZYp0wMyzDqM6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 05:04:29 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id z7so12185981iti.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 10:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PqTq+H8+rhmPLG6tqGEachvR9RLFaxATqoCV/phnZGQ=;
 b=Lw9f4paennw2Q7ERYGYf13QL1FEe8xX+NxItWg7dT86uTIxE6CA6xqC2DagjtU3aqu
 JtoCrXTbTEym46o184VZvjfSsi0wU0CNg3iX3/UYitIcAo2af000amHmxeLr5hE0rxkT
 qnJ/CBQfVqFuzNNBlde+2rvGFo64GKbOGA9W0HyceNRKniIaXvsKe9u1X4ESusWJantf
 M4qMcRJ95em052Z4P8pghjv/XJgQ0afoEqPrfgwKzIIUXnoidlUf9mgZCKFEzoZPlgOc
 oJ2orvxxl6Qn33jVhfR4FlRRXQUW7fn3pvtRUOInThi1VSI3eBD+7/ublnTh3Ka3fOc2
 2S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PqTq+H8+rhmPLG6tqGEachvR9RLFaxATqoCV/phnZGQ=;
 b=CsUAkTO8/sOA1u5HUPGBu4xQZFM316QmAwsqaaKI+s0encVlqW2UqFuvoVrA+lu6+z
 Er8/LcT7bwfS9H/9VJhEH955KUXiRs7Z8DnrMahwjjGyU17VbZrY08LgCw/ET7dqzNbg
 o3t6SDAXWUamIJNf4KUfE+JzxQ4taKrmedniPk6G5xUeQ/UJ1pn6KKGGdHdUykr8ymS7
 tfNyn25pUVs7yEQXwLujvV7lRY9W4C4PQjob1qET09hVz4HV/Vr1n4CbzoteuEVwVyp9
 dRP7SHLoU4zLAib1Z9KvTwXuWoA62ToIeBqty6998Bw2d8dPfpOXGz+NOffd4wVjJYOW
 xQEQ==
X-Gm-Message-State: AA+aEWaEj7lLUYmQMVLQX/zSf+bNEoqIs2fEJhJH+scf32SmbgZ/g7sh
 L8qJUNUXgXEEOl/beLJfn5xFLg==
X-Google-Smtp-Source: AFSGD/VMh/JR2/LSxaV6pJqJ8CN1srsI4trGfHLzd6kdp2ASaAmV/OX8sKXihw4FfTLaqvPSOOMEcg==
X-Received: by 2002:a02:8cce:: with SMTP id n14mr26118375jal.125.1543255467182; 
 Mon, 26 Nov 2018 10:04:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
 by smtp.gmail.com with ESMTPSA id r133-v6sm566263itb.17.2018.11.26.10.04.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Nov 2018 10:04:26 -0800 (PST)
Subject: Re: [Intel-wired-lan] [PATCH V2] mm: Replace all open encodings for
 NUMA_NO_NODE
To: jeffrey.t.kirsher@intel.com, Anshuman Khandual
 <anshuman.khandual@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
 <c1b8de1a8e9d4d215b56498e2d5b83a02083483a.camel@intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4d0840f2-bd96-e671-8120-56ef33a37816@kernel.dk>
Date: Mon, 26 Nov 2018 11:04:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c1b8de1a8e9d4d215b56498e2d5b83a02083483a.camel@intel.com>
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
Cc: linux-block@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 hverkuil@xs4all.nl, dmaengine@vger.kernel.org, vkoul@kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, jiangqi903@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/26/18 10:56 AM, Jeff Kirsher wrote:
> On Mon, 2018-11-26 at 17:56 +0530, Anshuman Khandual wrote:
>> At present there are multiple places where invalid node number is
>> encoded
>> as -1. Even though implicitly understood it is always better to have
>> macros
>> in there. Replace these open encodings for an invalid node number
>> with the
>> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions
>> like
>> 'invalid node' from various places redirecting them to a common
>> definition.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> For the 'ixgbe' driver changes.
> 
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Lost the original, but for mtip32xx:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

