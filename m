Return-Path: <SRS0=2k7H=2A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BBAC43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 23:57:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8826C206A1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 23:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8826C206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47XcSD5YcYzDqcV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Dec 2019 10:57:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=deltatee.com (client-ip=207.54.116.67; helo=ale.deltatee.com;
 envelope-from=logang@deltatee.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=deltatee.com
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47XcMM2YVTzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2019 10:53:17 +1100 (AEDT)
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1iepJ1-0006ir-2c; Tue, 10 Dec 2019 16:52:40 -0700
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
 <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
 <CAPcyv4hpXCZxV5p7WaeGgE7ceujBBa5NOz9Z8fepDHOt6zHO2A@mail.gmail.com>
 <20191210100432.GC10404@dhcp22.suse.cz>
 <6da2b279-6a6d-d89c-a34c-962ed021d91d@redhat.com>
 <20191210103452.GF10404@dhcp22.suse.cz>
 <a9d6cfe8-39fb-accf-acdc-7cce5578bf2f@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <297b7cc0-c5bc-a4c6-83eb-afc008395234@deltatee.com>
Date: Tue, 10 Dec 2019 16:52:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a9d6cfe8-39fb-accf-acdc-7cce5578bf2f@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: peterz@infradead.org, luto@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de, benh@kernel.crashing.org, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, hch@lst.de,
 linux-mm@kvack.org, platform-driver-x86@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dan.j.williams@intel.com, mhocko@kernel.org, david@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 5/6] mm, memory_hotplug: Provide argument for the pgprot_t
 in arch_add_memory()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, linux-ia64@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 Linux-sh <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019-12-10 4:25 a.m., David Hildenbrand wrote:
> On 10.12.19 11:34, Michal Hocko wrote:
>> On Tue 10-12-19 11:09:46, David Hildenbrand wrote:
>>> On 10.12.19 11:04, Michal Hocko wrote:
>>>> On Mon 09-12-19 12:43:40, Dan Williams wrote:
>>>>> On Mon, Dec 9, 2019 at 12:24 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
>>>>>>> On 09.12.19 20:13, Logan Gunthorpe wrote:
>>>> [...]
>>>>>>>>  #ifdef CONFIG_MEMORY_HOTPLUG
>>>>>>>> -int arch_add_memory(int nid, u64 start, u64 size,
>>>>>>>> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
>>>>>>>>                      struct mhp_restrictions *restrictions)
>>>>>>>
>>>>>>> Can we fiddle that into "struct mhp_restrictions" instead?
>>>>>>
>>>>>> Yes, if that's what people want, it's pretty trivial to do. I chose not
>>>>>> to do it that way because it doesn't get passed down to add_pages() and
>>>>>> it's not really a "restriction". If I don't hear any objections, I will
>>>>>> do that for v2.
>>>>>
>>>>> +1 to storing this information alongside the altmap in that structure.
>>>>> However, I agree struct mhp_restrictions, with the MHP_MEMBLOCK_API
>>>>> flag now gone, has lost all of its "restrictions". How about dropping
>>>>> the 'flags' property and renaming the struct to 'struct
>>>>> mhp_modifiers'?
>>>>
>>>> Hmm, this email somehow didn't end up in my inbox so I have missed it
>>>> before replying.
>>>>
>>>> Well, mhp_modifiers makes some sense and it would reduce the API
>>>> proliferation but how do you expect the prot part to be handled?
>>>> I really do not want people to think about PAGE_KERNEL or which
>>>> protection to use because my experience tells that this will get copied
>>>> without much thinking or simply will break with some odd usecases.
>>>> So how exactly this would be used?
>>>
>>> I was thinking about exactly the same "issue".
>>>
>>> 1. default initialization via a function
>>>
>>> memhp_modifier_default_init(&modified);
>>>
>>> 2. a flag that unlocks the prot field (default:0). Without the flag, it
>>> is ignored. We can keep the current initialization then.
>>>
>>> Other ideas?
>>
>> 3. a prot mask to apply on top of PAGE_KERNEL? Or would that be
>> insufficient/clumsy?
>>
> 
> If it works for the given use case, I guess this would be simple and ok.

I don't see how we can do that without a ton of work. The pgport_t is
architecture specific so we'd need to add mask functions to every
architecture for every page cache type we need to use. I don't think
that's a good idea.

I think I slightly prefer option 2 over the above.  But I'd actually
prefer callers have to think about the caching type seeing when we grew
the second user (memremap_pages()) and it was paired with
track_pfn_remap(), it was actually subtly wrong because it could create
a mapping that track_pfn_remap() disagreed with. In fact, PAGE_KERNEL
has already been specified in memremap_pages() for ages, it was just
ignored when it got to the arch_add_memory() step which is were this
issue comes from.

In my opinion, having a coder and reviewer see PAGE_KERNEL and ask if
that makes sense is a benefit. Having it hidden because we don't want
people to think about it is worse, harder to understand and results in
bugs that are more difficult to spot.

Though, we may be overthinking this: arch_add_memory() is a low level
non-exported API that's currently used in exactly two places. I don't
think there's going to be many, if any, valid new use cases coming up
for it in the future. That's more what memremap_pages() is for.

Logan
