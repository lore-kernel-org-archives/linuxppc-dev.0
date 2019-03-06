Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D459FC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 19:37:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAAC20663
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 19:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAAC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44F3tr14BCzDqBY
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 06:37:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.178.242; helo=mslow2.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44F3qJ6HQszDqCY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 06:34:18 +1100 (AEDT)
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id 3197E3A34A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 19:11:31 +0000 (UTC)
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
 (Authenticated sender: alex@ghiti.fr)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7693C100006;
 Wed,  6 Mar 2019 19:10:55 +0000 (UTC)
From: Alex Ghiti <alex@ghiti.fr>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 2/4] sparc: Advertise gigantic page support
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-3-alex@ghiti.fr>
 <20190306.110436.1714716608828903522.davem@davemloft.net>
Message-ID: <ac0c5166-f1f6-5339-58e3-a33f085c1220@ghiti.fr>
Date: Wed, 6 Mar 2019 14:10:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190306.110436.1714716608828903522.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: dalias@libc.org, linux-sh@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, x86@kernel.org,
 mingo@redhat.com, vbabka@suse.cz, catalin.marinas@arm.com, will.deacon@arm.com,
 bp@alien8.de, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org, mike.kravetz@oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/6/19 2:04 PM, David Miller wrote:
> From: Alexandre Ghiti <alex@ghiti.fr>
> Date: Wed,  6 Mar 2019 14:00:03 -0500
>
>> sparc actually supports gigantic pages and selecting
>> ARCH_HAS_GIGANTIC_PAGE allows it to allocate and free
>> gigantic pages at runtime.
>>
>> sparc allows configuration such as huge pages of 16GB,
>> pages of 8KB and MAX_ORDER = 13 (default):
>> HPAGE_SHIFT (34) - PAGE_SHIFT (13) = 21 >= MAX_ORDER (13)
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Much better.
>
> Acked-by: David S. Miller <davem@davemloft.net>
Thanks !

Alex
