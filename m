Return-Path: <SRS0=oaAR=Z7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39E8C43603
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 20:45:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B08620637
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 20:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B08620637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47WwDt070xzDqSN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Dec 2019 07:45:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=deltatee.com (client-ip=207.54.116.67; helo=ale.deltatee.com;
 envelope-from=logang@deltatee.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=deltatee.com
X-Greylist: delayed 1053 seconds by postgrey-1.36 at bilbo;
 Tue, 10 Dec 2019 07:42:23 AEDT
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Ww9W5prmzDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2019 07:42:22 +1100 (AEDT)
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1iePa0-0003kM-0J; Mon, 09 Dec 2019 13:24:29 -0700
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20191209191346.5197-1-logang@deltatee.com>
 <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
Date: Mon, 9 Dec 2019 13:24:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mhocko@suse.com, peterz@infradead.org, luto@kernel.org,
 dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 tglx@linutronix.de, benh@kernel.crashing.org, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, dan.j.williams@intel.com,
 hch@lst.de, linux-mm@kvack.org, platform-driver-x86@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com
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
Cc: Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
> On 09.12.19 20:13, Logan Gunthorpe wrote:
>> devm_memremap_pages() is currently used by the PCI P2PDMA code to create
>> struct page mappings for IO memory. At present, these mappings are created
>> with PAGE_KERNEL which implies setting the PAT bits to be WB. However, on
>> x86, an mtrr register will typically override this and force the cache
>> type to be UC-. In the case firmware doesn't set this register it is
>> effectively WB and will typically result in a machine check exception
>> when it's accessed.
>>
>> Other arches are not currently likely to function correctly seeing they
>> don't have any MTRR registers to fall back on.
>>
>> To solve this, add an argument to arch_add_memory() to explicitly
>> set the pgprot value to a specific value.
>>
>> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a
>> simple change to pass the pgprot_t down to their respective functions
>> which set up the page tables. For x86_32, set the page tables explicitly
>> using _set_memory_prot() (seeing they are already mapped). For sh, reject
>> anything but PAGE_KERNEL settings -- this should be fine, for now, seeing
>> sh doesn't support ZONE_DEVICE anyway.
>>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  arch/arm64/mm/mmu.c            | 4 ++--
>>  arch/ia64/mm/init.c            | 5 ++++-
>>  arch/powerpc/mm/mem.c          | 4 ++--
>>  arch/s390/mm/init.c            | 4 ++--
>>  arch/sh/mm/init.c              | 5 ++++-
>>  arch/x86/mm/init_32.c          | 7 ++++++-
>>  arch/x86/mm/init_64.c          | 4 ++--
>>  include/linux/memory_hotplug.h | 2 +-
>>  mm/memory_hotplug.c            | 2 +-
>>  mm/memremap.c                  | 2 +-
>>  10 files changed, 25 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 60c929f3683b..48b65272df15 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1050,7 +1050,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
>>  }
>>  
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>> -int arch_add_memory(int nid, u64 start, u64 size,
>> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
>>  			struct mhp_restrictions *restrictions)
> 
> Can we fiddle that into "struct mhp_restrictions" instead?

Yes, if that's what people want, it's pretty trivial to do. I chose not
to do it that way because it doesn't get passed down to add_pages() and
it's not really a "restriction". If I don't hear any objections, I will
do that for v2.

Thanks,

Logan
