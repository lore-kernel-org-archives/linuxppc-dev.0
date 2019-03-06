Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FE4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 20:10:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF43205F4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 20:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF43205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44F4dM6ywNzDqC5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 07:10:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44F4bG4KVLzDqBL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 07:08:55 +1100 (AEDT)
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
 (Authenticated sender: alex@ghiti.fr)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9B140FF806;
 Wed,  6 Mar 2019 20:08:07 +0000 (UTC)
Subject: Re: [PATCH v5 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
To: Dave Hansen <dave.hansen@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-5-alex@ghiti.fr>
 <7c81abe0-5f9d-32f9-1e9a-70ab06d48f8e@intel.com>
From: Alex Ghiti <alex@ghiti.fr>
Message-ID: <82a3f572-e9c1-0151-3d7d-a646f5e5302c@ghiti.fr>
Date: Wed, 6 Mar 2019 15:08:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7c81abe0-5f9d-32f9-1e9a-70ab06d48f8e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/6/19 2:16 PM, Dave Hansen wrote:
> On 3/6/19 11:00 AM, Alexandre Ghiti wrote:
>> +static int set_max_huge_pages(struct hstate *h, unsigned long count,
>> +			      nodemask_t *nodes_allowed)
>>   {
>>   	unsigned long min_count, ret;
>>   
>> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
>> -		return h->max_huge_pages;
>> +	/*
>> +	 * Gigantic pages allocation depends on the capability for large page
>> +	 * range allocation. If the system cannot provide alloc_contig_range,
>> +	 * allow users to free gigantic pages.
>> +	 */
>> +	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>> +		spin_lock(&hugetlb_lock);
>> +		if (count > persistent_huge_pages(h)) {
>> +			spin_unlock(&hugetlb_lock);
>> +			return -EINVAL;
>> +		}
>> +		goto decrease_pool;
>> +	}
> We talked about it during the last round and I don't seen any mention of
> it here in comments or the changelog: Why is this a goto?  Why don't we
> just let the code fall through to the "decrease_pool" label?  Why is
> this new block needed at all?  Can't we just remove the old check and
> let it be?

I'll get rid of the goto, I don't know how to justify it properly in a 
comment,
maybe because it is not necessary.
This is not a new block, this means exactly the same as before (remember
gigantic_page_supported() actually meant CONTIG_ALLOC before this series),
except that now we allow a user to free boottime allocated gigantic pages.
And no we cannot just remove the check and let it be since it would modify
the current behaviour, which is to return an error when trying to allocate
gigantic pages whereas alloc_contig_range is not defined. I thought it was
clearly commented above, I can try to make it more explicit.

