Return-Path: <SRS0=JiTK=V4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261A5C433FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 17:47:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C95A2067D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dw+SeYbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C95A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zLVX0RdzzDqnG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 03:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="dw+SeYbk"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zLSJ0Tf5zDqNw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2019 03:45:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pEAfotcFLsFotBYT9u4zeRqv3NeeQAlDety7JPTf8Pk=; b=dw+SeYbkgl15ByYdw4RBRwGpI5
 OQRbhMYNZQy3bzAx5TIQcL6nZ4sauiIJzRse8yongu5JqPY6aoJalrxRvlk01U/pCwDOw/2pmFJaD
 P1gRHYsrEp+s+iq8YUjI4MGLu//erIQdXrho9cOTBXZKeLz8JFQpS+d+T6SVCRqsaBTceMtiBPAL9
 K6qZqrz0yuqnuZ3oMdNwOb05wHSS4MloOj9+DKViGd5eR1DPhulBDXdM72Qf3YxGHWdhjFCH5PT3m
 ioWvgp3GDSoi8julWf1KoQx7EnwTzV5jyNDyqyWBQzDDbz0lPbNq/vbmvDf5oWMOc7VHyKca5WKls
 QitLDIVA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=[192.168.1.17])
 by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hssfH-000639-C3; Wed, 31 Jul 2019 17:45:28 +0000
Subject: Re: microblaze HAVE_MEMBLOCK_NODE_MAP dependency (was Re: [PATCH v2
 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA)
To: Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@kernel.org>
References: <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz> <20190731062420.GC21422@rapoport-lnx>
 <20190731080309.GZ9330@dhcp22.suse.cz> <20190731111422.GA14538@rapoport-lnx>
 <20190731114016.GI9330@dhcp22.suse.cz> <20190731122631.GB14538@rapoport-lnx>
 <20190731130037.GN9330@dhcp22.suse.cz> <20190731142129.GA24998@rapoport-lnx>
 <20190731144114.GY9330@dhcp22.suse.cz> <20190731171510.GB24998@rapoport-lnx>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57b08afb-d07e-a24f-4cfe-5a633227ed6b@infradead.org>
Date: Wed, 31 Jul 2019 10:45:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190731171510.GB24998@rapoport-lnx>
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Will Deacon <will@kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "willy@infradead.org" <willy@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Hoan Tran OS <hoan@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Open Source Submission <patches@amperecomputing.com>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 7/31/19 10:15 AM, Mike Rapoport wrote:
> On Wed, Jul 31, 2019 at 04:41:14PM +0200, Michal Hocko wrote:
>> On Wed 31-07-19 17:21:29, Mike Rapoport wrote:
>>> On Wed, Jul 31, 2019 at 03:00:37PM +0200, Michal Hocko wrote:
>>>>
>>>> I am sorry, but I still do not follow. Who is consuming that node id
>>>> information when NUMA=n. In other words why cannot we simply do
>>>  
>>> We can, I think nobody cared to change it.
>>
>> It would be great if somebody with the actual HW could try it out.
>> I can throw a patch but I do not even have a cross compiler in my
>> toolbox.
> 
> Well, it compiles :)

Adding Michal Simek <monstr@monstr.eu>.

It's not clear that the MICROBLAZE maintainer is still supporting MICROBLAZE.

>>>> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
>>>> index a015a951c8b7..3a47e8db8d1c 100644
>>>> --- a/arch/microblaze/mm/init.c
>>>> +++ b/arch/microblaze/mm/init.c
>>>> @@ -175,14 +175,9 @@ void __init setup_memory(void)
>>>>  
>>>>  		start_pfn = memblock_region_memory_base_pfn(reg);
>>>>  		end_pfn = memblock_region_memory_end_pfn(reg);
>>>> -		memblock_set_node(start_pfn << PAGE_SHIFT,
>>>> -				  (end_pfn - start_pfn) << PAGE_SHIFT,
>>>> -				  &memblock.memory, 0);
>>>> +		memory_present(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
>>>
>>> memory_present() expects pfns, the shift is not needed.
>>
>> Right.
>>
>> -- 
>> Michal Hocko
>> SUSE Labs


-- 
~Randy
