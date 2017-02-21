Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS2Jq2SN0zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:02:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: jallen@linux.vnet.ibm.com, sahilmehta17@gmail.com,
 mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Subject: Re: [PATCH v7 2/4] powerpc/pseries: Revert 'Auto-online hotplugged
 memory'
In-Reply-To: <fd545562-0e8c-f98e-2620-4c34752424c2@linux.vnet.ibm.com>
References: <20170215184321.11755.88199.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20170215184528.11755.568.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <87wpcqkb3k.fsf@concordia.ellerman.id.au>
 <fd545562-0e8c-f98e-2620-4c34752424c2@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 12:02:00 +1100
Message-ID: <87y3x0mk53.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> On 02/15/2017 10:34 PM, Michael Ellerman wrote:
>> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>> 
>>> Revert the patch patch to auto-online hotplugged memory, commit
>>> id ec999072442a. Using the auto-online acpability does online added
>>> memory but does not update the associated device struct to
>>> indicate that the memory is online. The result of this is that
>>> memoryXX/online file in sysfs still reports the memory as being offline.
>> 
>> Isn't that just a bug in the auto-online code?
>
> After digging through the code some more and reading some of the email
> chain when the auto-online feature was submitted I can't decide if this
> is a bug or if this is by design. The fact that they only other users
> of this appear to be balloon drivers (hv and xen) makes me think this
> may be by design.

Have we asked the original authors? I don't see them on Cc?

> Changing the auto-online capability to call device_offline() instead
> would appear to also require changes to the hv and xen balloon
> drivers for the new behavior.

OK, if that's the case then that's going to make life tricky.
 
>> If I'm reading it right it's calling online_memory_block(). If that
>> doesn't cause the memory_block to be online that would puzzle me.
>
> The memory is online and usuable when the dlpar operation completes. I
> was mistaken in my original note though, the state file in sysfs does report
> the memory as being online. The underlying issue is that the device struct
> does not get updated (dev->offline) when using the auto-online capability.
> The result is that trying to remove a LMB a second time fails when we call
> device_offline() which checks the dev->offline flag and returns failure.

That still sounds like a bug to me. We asked the core to "auto online"
the added memory, but the dev is still offline? But maybe there's some
subtlety.

> I think reverting the patch to use the auto-online capability may be the
> way to go. This would restore the code so that we call device_online and
> device_offline for add and remove respectively, and not rely on what the 
> auto-online code is doing.
>
> Thoughts?

It's not great, but given we need to backport it to v4.8, yeah I think
we'll have to go with a revert.

But we should also pursue fixing the auto online logic.

>> Also commit ec999072442a went into v4.8, so is memory hotplug broken
>> since then? If so we need to backport this or whatever fix we come up.
>
> Yes, we need to backport whatever fix we do.

Right. I'll queue it up.

cheers
