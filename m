Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6497C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 16:50:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2958C208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 16:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2958C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4348t41PdMzDqkd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 03:50:36 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4348qR4yW1zDqjc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 03:48:19 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D79F30012C3;
 Tue, 27 Nov 2018 16:48:16 +0000 (UTC)
Received: from [10.36.117.202] (ovpn-117-202.ams2.redhat.com [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3872C5E7B6;
 Tue, 27 Nov 2018 16:47:48 +0000 (UTC)
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20180928150357.12942-1-david@redhat.com>
 <b01a956b-080c-c643-6473-eb132b9f7200@redhat.com>
 <20181123190653.6da91461@kitsune.suse.cz>
 <fad04d80-4e72-1bd8-3e67-a3f7dd0bc2fa@redhat.com>
 <b64a0e1e-6aaa-66a9-2fb7-12daa6383ce1@redhat.com>
 <20181126152015.7464c786@naga>
 <2d05e5d1-c5b5-8884-e642-89421685052f@redhat.com>
 <20181127173241.6dde763e@kitsune.suse.cz>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <e5f40780-965b-0b34-9ce7-f63129675380@redhat.com>
Date: Tue, 27 Nov 2018 17:47:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127173241.6dde763e@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 27 Nov 2018 16:48:17 +0000 (UTC)
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
 Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Rashmica Gupta <rashmica.g@gmail.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Michael Neuling <mikey@neuling.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Rob Herring <robh@kernel.org>, "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>,
 Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
 Mathieu Malaterre <malat@debian.org>, linux-s390@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
 devel@linuxdriverproject.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 27.11.18 17:32, Michal Suchánek wrote:
> On Mon, 26 Nov 2018 16:59:14 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 26.11.18 15:20, Michal Suchánek wrote:
>>> On Mon, 26 Nov 2018 14:33:29 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> On 26.11.18 13:30, David Hildenbrand wrote:  
>>>>> On 23.11.18 19:06, Michal Suchánek wrote:    
>>>   
>>>>>>
>>>>>> If we are going to fake the driver information we may as well add the
>>>>>> type attribute and be done with it.
>>>>>>
>>>>>> I think the problem with the patch was more with the semantic than the
>>>>>> attribute itself.
>>>>>>
>>>>>> What is normal, paravirtualized, and standby memory?
>>>>>>
>>>>>> I can understand DIMM device, baloon device, or whatever mechanism for
>>>>>> adding memory you might have.
>>>>>>
>>>>>> I can understand "memory designated as standby by the cluster
>>>>>> administrator".
>>>>>>
>>>>>> However, DIMM vs baloon is orthogonal to standby and should not be
>>>>>> conflated into one property.
>>>>>>
>>>>>> paravirtualized means nothing at all in relationship to memory type and
>>>>>> the desired online policy to me.    
>>>>>
>>>>> Right, so with whatever we come up, it should allow to make a decision
>>>>> in user space about
>>>>> - if memory is to be onlined automatically    
>>>>
>>>> And I will think about if we really should model standby memory. Maybe
>>>> it is really better to have in user space something like (as Dan noted)  
>>>
>>> If it is possible to designate the memory as standby or online in the
>>> s390 admin interface and the kernel does have access to this
>>> information it makes sense to forward it to userspace (as separate
>>> s390-specific property). If not then you need to make some kind of
>>> assumption like below and the user can tune the script according to
>>> their usecase.  
>>
>> Also true, standby memory really represents a distinct type of memory
>> block (memory seems to be there but really isn't). Right now I am
>> thinking about something like this (tried to formulate it on a very
>> generic level because we can't predict which mechanism might want to
>> make use of these types in the future).
>>
>>
>> /*
>>  * Memory block types allow user space to formulate rules if and how to
>>  * online memory blocks. The types are exposed to user space as text
>>  * strings in sysfs. While the typical online strategies are described
>>  * along with the types, there are use cases where that can differ (e.g.
>>  * use MOVABLE zone for more reliable huge page usage, use NORMAL zone
>>  * due to zone imbalance or because memory unplug is not intended).
>>  *
>>  * MEMORY_BLOCK_NONE:
>>  *  No memory block is to be created (e.g. device memory). Used internally
>>  *  only.
>>  *
>>  * MEMORY_BLOCK_REMOVABLE:
>>  *  This memory block type should be treated as if it can be
>>  *  removed/unplugged from the system again. E.g. there is a hardware
>>  *  interface to unplug such memory. This memory block type is usually
>>  *  onlined to the MOVABLE zone, to e.g. make offlining of it more
>>  *  reliable. Examples include ACPI and PPC DIMMs.
>>  *
>>  * MEMORY_BLOCK_UNREMOVABLE:
>>  *  This memory block type should be treated as if it can not be
>>  *  removed/unplugged again. E.g. there is no hardware interface to
>>  *  unplug such memory. This memory block type is usually onlined to
>>  *  the NORMAL zone, as offlining is not beneficial. Examples include boot
>>  *  memory on most architectures and memory added via balloon devices.
> 
> AFAIK baloon device can be inflated as well so this does not really
> describe how this memory type works in any meaningful way. Also it
> should not be possible to see this kind of memory from userspace. The
> baloon driver just takes existing memory that is properly backed,
> allocates it for itself, and allows the hypervisor to use it. Thus it
> creates the equivalent to s390 standby memory which is not backed in
> the VM. When memory is reclaimed from hypervisor the baloon driver
> frees it making it available to the VM kernel again. However, the whole
> time the memory appears present in the machine and no hotplug events
> should be visible unless the docs I am looking at are really outdated.

It's all not optimal yet.

Don't confuse what I describe here with inflated/deflated memory. XEN
and Hyper-V add *new* memory to the system using add_memory(). New
memory blocks. This memory will never be removed using the typical
"offline + remove_memory()" approach. It will be removed using
ballooning (if at all) and only in pieces. So it will usually be onlined
to the NORMAL zone. (but userspace can later on implement whatever rule
it wants)

I am not talking about any kind of inflation/deflation. I am talking
about memory blocks added to the system via add_memory().

Inflation/deflation does not belong into the memory block interface.

> 
>>  *
>>  * MEMORY_BLOCK_STANDBY:
>>  *  The memory block type should be treated as if it can be
>>  *  removed/unplugged again, however the actual memory hot(un)plug is
>>  *  performed by onlining/offlining. In virtual environments, such memory
>>  *  is usually added during boot and never removed. Onlining memory will
>>  *  result in memory getting allocated to a VM. This memory type is usually
>>  *  not onlined automatically but explicitly by the administrator. One
>>  *  example is standby memory on s390x.
> 
> Again, this does not meaningfully describe the memory type. There is
> no memory on standby. There is in fact no backing at all unless you
> online it. So this probably is some kind of shared memory. However, the
> (de)allocation is controlled differently compared to the baloon device.
> The concept is very similar, though.

We have memory blocks and we have to describe them somehow. On s390x
standby memory is model via memory blocks that are offline - that is the
way it is modeled. I am still thinking about possible ways to describe
this via a memory type. And here the message should be "don't online
this unless you are aware of the consequences, this is not your ordinary
DIMM".

Which types of memory would you have in mind? The problem we are trying
to solve is to give user space an idea of if and how to online memory.
And to make it aware that there are different types that are expected to
be handled differently.

-- 

Thanks,

David / dhildenb
