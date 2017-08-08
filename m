Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRVZw2s5gzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:12:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: gabriele.paoloni@huawei.com, airlied@linux.ie,
 Brian King <brking@linux.vnet.ibm.com>, will.deacon@arm.com,
 z.liuxinliang@hisilicon.com, bhelgaas@google.com, alex.williamson@redhat.com,
 catalin.marinas@arm.com, zourongrong@gmail.com, daniel.vetter@intel.com
Subject: Re: [PATCH 3/3] powerpc: replace vga_fixup() with generic code
In-Reply-To: <87wp6fq8y5.fsf@linkitivity.dja.id.au>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-4-dja@axtens.net>
 <87efsnq217.fsf@concordia.ellerman.id.au>
 <87wp6fq8y5.fsf@linkitivity.dja.id.au>
Date: Tue, 08 Aug 2017 20:12:55 +1000
Message-ID: <8760dynza0.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> Daniel Axtens <dja@axtens.net> writes:
>>
>>> Currently, we do a PCI fixup to mark a default card so that Xorg
>>> autoconfiguration works.
>>>
>>> There is a new generic method to do this sort of vga fixup, and
>>> it occurs by default.
>>>
>>> Drop our old method.
>>>
>>> This method is different:
>>>  - it will only mark a card as default if a driver is bound
>>>  - the marking will happen at late_initcall time, or even later
>>>    if a card is enabled later on (via an ENABLE hook). Currently
>>>    things are enabled in a FINAL hook.
>>>
>>> This *does* change behaviour under some circumstances.
>>>
>>> For example, pseries_le_defconfig doesn't have DRM drivers for
>>> many of the qemu GPU models, including the 'standard' vga.
>>
>> Should we enable them/it?
>
> Hard to say.
>
> The 'standard' vga module (bochs_drm) was blacklisted by Ubuntu -
> apparently at IBM's request [0] - some years back. Even if you
> un-blacklist it, I had trouble with getting it and the openfirmware
> framebuffer driver to play nicely together. It may not be worth the
> trouble for bochs_drm.
>
> There's a better case for including some of the more modern drivers -
> maybe QXL and virtio - but I wasn't able to test them: my particular
> build of qemu/TCG refused to start with them and I didn't feel like
> rebuilding/debugging qemu.

Yeah OK. Sounds like a bit of mess :)

I'll leave it unless someone who knows Qemu/Gfx etc. tells me otherwise.

> It would also be legitmate to say that you're focussing on headless use
> with pseries_*defconfig and not include them: you need to bring in the
> DRM core if you want these drivers.

True. There's a bit of a tension there between making them useful
configs for developers and also turning on as much code as possible so
it gets tested.

Arguably we should have DRM enabled because the distros will.

cheers
