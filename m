Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D848C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:59:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B0C2098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B0C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QkJd51L5zDqjl
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:59:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjR80zqkzF3C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:19:47 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 70F2AAF93;
 Thu,  4 Oct 2018 06:19:43 +0000 (UTC)
Date: Thu, 4 Oct 2018 08:19:38 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Message-ID: <20181004061938.GB22173@dhcp22.suse.cz>
References: <20181001084038.GD18290@dhcp22.suse.cz>
 <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
 <20181002134734.GT18290@dhcp22.suse.cz>
 <98fb8d65-b641-2225-f842-8804c6f79a06@redhat.com>
 <8736tndubn.fsf@vitty.brq.redhat.com>
 <20181003134444.GH4714@dhcp22.suse.cz>
 <87zhvvcf3b.fsf@vitty.brq.redhat.com>
 <49456818-238e-2d95-9df6-d1934e9c8b53@linux.intel.com>
 <87tvm3cd5w.fsf@vitty.brq.redhat.com>
 <06a35970-e478-18f8-eae6-4022925a5192@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a35970-e478-18f8-eae6-4022925a5192@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Rashmica Gupta <rashmica.g@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org,
 Michael Neuling <mikey@neuling.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Rob Herring <robh@kernel.org>, "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Oscar Salvador <osalvador@suse.de>,
 Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 devel@linuxdriverproject.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed 03-10-18 19:14:05, David Hildenbrand wrote:
> On 03/10/2018 16:34, Vitaly Kuznetsov wrote:
> > Dave Hansen <dave.hansen@linux.intel.com> writes:
> > 
> >> On 10/03/2018 06:52 AM, Vitaly Kuznetsov wrote:
> >>> It is more than just memmaps (e.g. forking udev process doing memory
> >>> onlining also needs memory) but yes, the main idea is to make the
> >>> onlining synchronous with hotplug.
> >>
> >> That's a good theoretical concern.
> >>
> >> But, is it a problem we need to solve in practice?
> > 
> > Yes, unfortunately. It was previously discovered that when we try to
> > hotplug tons of memory to a low memory system (this is a common scenario
> > with VMs) we end up with OOM because for all new memory blocks we need
> > to allocate page tables, struct pages, ... and we need memory to do
> > that. The userspace program doing memory onlining also needs memory to
> > run and in case it prefers to fork to handle hundreds of notfifications
> > ... well, it may get OOMkilled before it manages to online anything.
> > 
> > Allocating all kernel objects from the newly hotplugged blocks would
> > definitely help to manage the situation but as I said this won't solve
> > the 'forking udev' problem completely (it will likely remain in
> > 'extreme' cases only. We can probably work around it by onlining with a
> > dedicated process which doesn't do memory allocation).
> > 
> 
> I guess the problem is even worse. We always have two phases
> 
> 1. add memory - requires memory allocation
> 2. online memory - might require memory allocations e.g. for slab/slub
> 
> So if we just added memory but don't have sufficient memory to start a
> user space process to trigger onlining, then we most likely also don't
> have sufficient memory to online the memory right away (in some scenarios).
> 
> We would have to allocate all new memory for 1 and 2 from the memory to
> be onlined. I guess the latter part is less trivial.
> 
> So while onlining the memory from the kernel might make things a little
> more robust, we would still have the chance for OOM / onlining failing.

Yes, _theoretically_. Is this a practical problem for reasonable
configurations though? I mean, this will never be perfect and we simply
cannot support all possible configurations. We should focus on
reasonable subset of them. From my practical experience the vast
majority of memory is consumed by memmaps (roughly 1.5%). That is not a
lot but I agree that allocating that from the zone normal and off node
is not great. Especially the second part which is noticeable for whole
node hotplug.

I have a feeling that arguing about fork not able to proceed or OOMing
for the memory hotplug is a bit of a stretch and a sign a of
misconfiguration.
-- 
Michal Hocko
SUSE Labs
