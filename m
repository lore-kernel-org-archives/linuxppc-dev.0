Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679DC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 09:36:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D1D20652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 09:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D1D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NxxX72yrzF37n
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:36:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NxvQ0PnYzF31w
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 19:34:42 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A2B381DFA;
 Mon,  1 Oct 2018 09:34:39 +0000 (UTC)
Received: from [10.36.117.4] (ovpn-117-4.ams2.redhat.com [10.36.117.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDFF660BC3;
 Mon,  1 Oct 2018 09:34:25 +0000 (UTC)
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
To: Michal Hocko <mhocko@kernel.org>
References: <20180928150357.12942-1-david@redhat.com>
 <20181001084038.GD18290@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
Date: Mon, 1 Oct 2018 11:34:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181001084038.GD18290@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 01 Oct 2018 09:34:40 +0000 (UTC)
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
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Rashmica Gupta <rashmica.g@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-s390@vger.kernel.org,
 Michael Neuling <mikey@neuling.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Rob Herring <robh@kernel.org>, Len Brown <lenb@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
 Nicholas Piggin <npiggin@gmail.com>, Joe Perches <joe@perches.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Oscar Salvador <osalvador@suse.de>,
 Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 01/10/2018 10:40, Michal Hocko wrote:
> On Fri 28-09-18 17:03:57, David Hildenbrand wrote:
> [...]
> 
> I haven't read the patch itself but I just wanted to note one thing
> about this part
> 
>> For paravirtualized devices it is relevant that memory is onlined as
>> quickly as possible after adding - and that it is added to the NORMAL
>> zone. Otherwise, it could happen that too much memory in a row is added
>> (but not onlined), resulting in out-of-memory conditions due to the
>> additional memory for "struct pages" and friends. MOVABLE zone as well
>> as delays might be very problematic and lead to crashes (e.g. zone
>> imbalance).
> 
> I have proposed (but haven't finished this due to other stuff) a
> solution for this. Newly added memory can host memmaps itself and then
> you do not have the problem in the first place. For vmemmap it would
> have an advantage that you do not really have to beg for 2MB pages to
> back the whole section but you would get it for free because the initial
> part of the section is by definition properly aligned and unused.

So the plan is to "host metadata for new memory on the memory itself".
Just want to note that this is basically impossible for s390x with the
current mechanisms. (added memory is dead, until onlining notifies the
hypervisor and memory is allocated). It will also be problematic for
paravirtualized memory devices (e.g. XEN's "not backed by the
hypervisor" hacks).

This would only be possible for memory DIMMs, memory that is completely
accessible as far as I can see. Or at least, some specified "first part"
is accessible.

Other problems are other metadata like extended struct pages and friends.

(I really like the idea of adding memory without allocating memory in
the hypervisor in the first place, please keep me tuned).

And please note: This solves some problematic part ("adding too much
memory to the movable zone or not onlining it"), but not the issue of
zone imbalance in the first place. And not one issue I try to tackle
here: don't add paravirtualized memory to the movable zone.

> 
> I yet have to think about the whole proposal but I am missing the most
> important part. _Who_ is going to use the new exported information and
> for what purpose. You said that distributions have hard time to
> distinguish different types of onlinining policies but isn't this
> something that is inherently usecase specific?
> 

Let's think about a distribution. We have a clash of use cases here
(just what you describe). What I propose solves one part of it ("handle
what you know how to handle right in the kernel").

1. Users of DIMMs usually expect that they can be unplugged again. That
is why you want to control how to online memory in user space (== add it
to the movable zone).

2. Users of standby memory (s390) expect that memory will never be
onlined automatically. It will be onlined manually.

3. Users of paravirtualized devices (esp. Hyper-V) don't care about
memory unplug in the sense of MOVABLE at all. They (or Hyper-V!) will
add a whole bunch of memory and expect that everything works fine. So
that memory is onlined immediately and that memory is added to the
NORMAL zone. Users never want the MOVABLE zone.

1. is a reason why distributions usually don't configure
"MEMORY_HOTPLUG_DEFAULT_ONLINE", because you really want the option for
MOVABLE zone. That however implies, that e.g. for x86, you have to
handle all new memory in user space, especially also HyperV memory.
There, you then have to check for things like "isHyperV()" to decide
"oh, yes, this should definitely not go to the MOVABLE zone".

As you know, I am working on virtio-mem, which can basically be combined
with 1 or 2. And user space has no idea about the difference between
added memory blocks. Was it memory from a DIMM (== ZONE_MOVABLE)? Was it
memory from a paravirtualized device (== ZONE_NORMAL)? Was it standby
memory? (don't online)


That part, I try to solve with this interface.

To answer your question: User space will only care about "normal" memory
and then decide how to online it (for now, usually MOVABLE, because
that's what customers expect with DIMMs). The use case of DIMMS, we
don't know and therefore we can't expose. The use case of the other
cases, we know exactly already in the kernel.

Existing user space hacks will continue to work but can be replaces by a
new check against "normal" memory block types.

Thanks for looking into this!

-- 

Thanks,

David / dhildenb
