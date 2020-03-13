Return-Path: <SRS0=UfTk=46=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76390C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2020 02:17:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13A3206E7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2020 02:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lgVQXF//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13A3206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48dq962pWczDqQk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2020 13:17:46 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48dq7R38H3zDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2020 13:16:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=lgVQXF//; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48dq7Q4z6yz9sQx;
 Fri, 13 Mar 2020 13:16:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1584065778;
 bh=ZphLCIMfAK9We2nJnCnirc5jpsOLTkoIz6jQ5ZFJQBA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lgVQXF//7f17Z63Y/HPKOpZT1x/ad7SljmueK7w5wCbTWFOsmHGV03LC/rrNoaeK1
 FyDS1oBeVCSGm0viqE7McQMNHhw2eQJtr2/38CggsqFdTwRI7cMROzsWUHYZ3B1X5S
 tW0TzEo8ZoMIgp9xEyUSgnwwK6KTZdntWSD3cRNSBjjWrUvSWHqDLTR541OUyKfVyU
 7sPlT7oDVTOvFdQCwtha+4IHZv7QVthfcoEyNT8rMmH/SLWHJMmUmHoVEVEWIX0bVy
 3sYjSv9B+F54O8tKLjNG+oiOjNMhplaZRuWS4phqEIuhn7Qy/77DeSJlKSjVSdvk9o
 49qRcNJaFCtQw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.ibm.com>, Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: fix of_read_drc_info_cell() to point at
 next record
In-Reply-To: <3a3950ed-a7fb-3458-dce0-0dd6e45f93eb@linux.ibm.com>
References: <20200307024547.5748-1-tyreld@linux.ibm.com>
 <87tv2w2kc2.fsf@linux.ibm.com>
 <e99f5e39-4788-a9ef-30d7-8096df7ee36e@linux.ibm.com>
 <87imjai0wp.fsf@mpe.ellerman.id.au>
 <3a3950ed-a7fb-3458-dce0-0dd6e45f93eb@linux.ibm.com>
Date: Fri, 13 Mar 2020 13:16:16 +1100
Message-ID: <87k13pxamn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: mwb@linux.vnet.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 3/11/20 10:43 PM, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
>>> On 3/10/20 10:25 AM, Nathan Lynch wrote:
>>>> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
>>>>> The expectation is that when calling of_read_drc_info_cell()
>>>>> repeatedly to parse multiple drc-info records that the in/out curval
>>>>> parameter points at the start of the next record on return. However,
>>>>> the current behavior has curval still pointing at the final value of
>>>>> the record just parsed. The result of which is that if the
>>>>> ibm,drc-info property contains multiple properties the parsed value
>>>>> of the drc_type for any record after the first has the power_domain
>>>>> value of the previous record appended to the type string.
>>>>>
>>>>> Ex: observed the following 0xffffffff prepended to PHB
>>>>>
>>>>> [   69.485037] drc-info: type: \xff\xff\xff\xffPHB, prefix: PHB , index_start: 0x20000001
>>>>> [   69.485038] drc-info: suffix_start: 1, sequential_elems: 3072, sequential_inc: 1
>>>>> [   69.485038] drc-info: power-domain: 0xffffffff, last_index: 0x20000c00
>>>>>
>>>>> Fix by incrementing curval past the power_domain value to point at
>>>>> drc_type string of next record.
>>>>>
>>>>> Fixes: a29396653b8bf ("pseries/drc-info: Search DRC properties for CPU indexes")
>>>>
>>>> I have a different commit hash for that:
>>>> e83636ac3334 pseries/drc-info: Search DRC properties for CPU indexes
>>>
>>> Oof, looks like I grabbed the commit hash from the SLES 15 SP1 branch. You have
>>> the correct upstream commit.
>>>
>>> Fixes: e83636ac3334 ("pseries/drc-info: Search DRC properties for CPU indexes")
>>>
>>> Michael, let me know if you want me to resubmit, or if you will fixup the Fixes
>>> tag on your end?
>> 
>> I can update the Fixes tag.
>> 
>> What's the practical effect of this bug? It seems like it should break
>> all the hotplug stuff, but presumably it doesn't in practice for some
>> reason?
>> 
>> It would also be *really* nice if we had some unit tests for this
>> parsing code, it's demonstrably very bug prone.
>
> In practice PHBs are the only type of connector in the ibm,drc-info property
> that has multiple records. So, it breaks PHB hotplug, but by chance not pci,
> cpu, slot, or mem because they happen to only ever be a single record.

Thanks. I folded that into the change log.

cheers
