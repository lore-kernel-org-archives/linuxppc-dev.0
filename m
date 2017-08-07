Return-Path: <dja@axtens.net>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRCgt09hPzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 09:01:13 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y192so1588552pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Aug 2017 16:01:13 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: gabriele.paoloni@huawei.com, airlied@linux.ie,
 Brian King <brking@linux.vnet.ibm.com>, will.deacon@arm.com,
 z.liuxinliang@hisilicon.com, bhelgaas@google.com, alex.williamson@redhat.com,
 catalin.marinas@arm.com, zourongrong@gmail.com, daniel.vetter@intel.com
Subject: Re: [PATCH 3/3] powerpc: replace vga_fixup() with generic code
In-Reply-To: <87efsnq217.fsf@concordia.ellerman.id.au>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-4-dja@axtens.net>
 <87efsnq217.fsf@concordia.ellerman.id.au>
Date: Tue, 08 Aug 2017 09:01:06 +1000
Message-ID: <87wp6fq8y5.fsf@linkitivity.dja.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> Daniel Axtens <dja@axtens.net> writes:
>
>> Currently, we do a PCI fixup to mark a default card so that Xorg
>> autoconfiguration works.
>>
>> There is a new generic method to do this sort of vga fixup, and
>> it occurs by default.
>>
>> Drop our old method.
>>
>> This method is different:
>>  - it will only mark a card as default if a driver is bound
>>  - the marking will happen at late_initcall time, or even later
>>    if a card is enabled later on (via an ENABLE hook). Currently
>>    things are enabled in a FINAL hook.
>>
>> This *does* change behaviour under some circumstances.
>>
>> For example, pseries_le_defconfig doesn't have DRM drivers for
>> many of the qemu GPU models, including the 'standard' vga.
>
> Should we enable them/it?

Hard to say.

The 'standard' vga module (bochs_drm) was blacklisted by Ubuntu -
apparently at IBM's request [0] - some years back. Even if you
un-blacklist it, I had trouble with getting it and the openfirmware
framebuffer driver to play nicely together. It may not be worth the
trouble for bochs_drm.

There's a better case for including some of the more modern drivers -
maybe QXL and virtio - but I wasn't able to test them: my particular
build of qemu/TCG refused to start with them and I didn't feel like
rebuilding/debugging qemu.

It would also be legitmate to say that you're focussing on headless use
with pseries_*defconfig and not include them: you need to bring in the
DRM core if you want these drivers.

HTH.

Regards,
Daniel

[0] https://bugs.launchpad.net/ubuntu/+source/kmod/+bug/1378648

>
> cheers
