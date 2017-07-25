Return-Path: <dja@axtens.net>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHCNq6gNRzDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 08:20:27 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g69so4862353pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 15:20:27 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Laszlo Ersek <lersek@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 "Liuxinliang \(Matthew Liu\)" <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Zou Rongrong <zourongrong@gmail.com>, daniel.vetter@intel.com
Subject: Re: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
In-Reply-To: <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
References: <20170719012839.20124-1-dja@axtens.net>
 <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
 <87pocusm2x.fsf@linkitivity.dja.id.au>
 <CAKv+Gu-O7cyJSgDrqSNi6F_n9eBnFEgz==aqowMqhy+81YK=CQ@mail.gmail.com>
 <87r2x6vj7t.fsf@linkitivity.dja.id.au>
 <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
Date: Wed, 26 Jul 2017 08:20:18 +1000
Message-ID: <87lgncupjx.fsf@linkitivity.dja.id.au>
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

Hi Laszlo,

Thanks for your input!

>> Are there other graphical applications we care about (other than Xorg)
>> that would need to be patched? I'm happy to do the Xorg patch, but I
>> don't know if anything other than Xorg keys off the boot_vga file.
>> 
>> I'm not fundamentally opposed to this approach if the Xorg community is
>> happy with it, the kernel community is happy with it, and no-one expects
>> me to provide patches to any other user-space applications that depend
>> on boot_vga.
>
> Ard both identified the Xorg commit that I would have, and CC'd Hans
> which I would have recommended as well.
>
> I assume the symptom is that now there's a class of platform GPU devices
> that is neither PCI nor legacy VGA, so neither the kernel's boot_vga
> logic matches it, nor Xorg's commit in question.
>
> I agree that it should be possible to add more logic to Xorg to detect
> this kind device as primary. However, I share Daniel's worry that it
> wouldn't cover all user space apps -- I see "Wayland this, Wayland that"
> on reddit every week.
>
> Having practically zero background in gfx development (either kernel or
> Xorg), I think the problem is that vga_default_device() /
> vga_set_default_device(), which -- apparently -- "boot_vga" is based
> upon, come from "drivers/gpu/vga/vgaarb.c". Namely, the concept of
> "primary / boot display device" is tied to the VGA arbiter, plus only a
> PCI device can currently be marked as primary/boot display device.

You're right, the issue is that the primary/boot device is tied to the
VGA arbiter.

>
> Can these concepts be split from each other? (I can fully imagine that
> this would result in a userspace visible interface change (or addition),
> so that e.g. "/sys/devices/**/boot_gpu" would have to be consulted by
> display servers.)

Yes, they can be split or a way of marking the default vga device that
doesn't depend on the arbiter can be added.

(But there is some question about what it actually means to be a boot
vga card - it's better defined on an x86 system, but on a ppc or arm64
system we're reduced to guessing based on the first driver loaded.)

> (Sorry if I'm totally wrong.)
>
> ... Hm, reading the thread starter at
> <https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg120851.html>,
> and the references within... It looks like this work is motivated by
> hardware that is supposed to be PCI, but actually breaks the specs. Is
> that correct? If so, then I don't think I can suggest anything useful.
> Specs exist so that hardware vendors and software authors follow them.
> If hardware does not conform, then software should either refuse to work
> with it, or handle it with quirks, on a case-by-case basis. I guess this
> means that I don't agree with the
>
>   broad[] suggest[ion] that a more generic solution would be better
>
> which seems to disqualify me from the discussion, as it must have been
> suggested by people with incomparably more experience than what I have :)

Originally this was brought to the fore through a PCI bridge that wasn't
spec compliant, and originally I proposed a simple quirk: [0]. However,
that highlighted the related issue that platforms that don't use legacy
resources still go through the VGA arbiter process which is built around
legacy resource arbitration. Changing that behaviour also fixes the
issue with the non-spec-compliant bridge because the new model doesn't
rely upon the particular part of the spec that the bridge violates.

I'm not fussy about how we solve this problem, so long as we solve this
problem somehow.

Regards,
Daniel

[0]: https://patchwork.ozlabs.org/patch/787003/

>
> Thanks
> Laszlo
