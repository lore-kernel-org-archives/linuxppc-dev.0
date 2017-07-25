Return-Path: <lersek@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGwp42SNnzDqm7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 21:22:52 +1000 (AEST)
Subject: Re: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
To: Daniel Axtens <dja@axtens.net>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Zou Rongrong <zourongrong@gmail.com>, daniel.vetter@intel.com
References: <20170719012839.20124-1-dja@axtens.net>
 <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
 <87pocusm2x.fsf@linkitivity.dja.id.au>
 <CAKv+Gu-O7cyJSgDrqSNi6F_n9eBnFEgz==aqowMqhy+81YK=CQ@mail.gmail.com>
 <87r2x6vj7t.fsf@linkitivity.dja.id.au>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
Date: Tue, 25 Jul 2017 13:22:43 +0200
MIME-Version: 1.0
In-Reply-To: <87r2x6vj7t.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/17 01:15, Daniel Axtens wrote:
> Hi Ard,
> 
>> But the fact remains that we are going about this the wrong way.
>> Whether a graphics card decodes legacy VGA ranges or not has *nothing*
>> to do with whether or not it is in fact the primary device on a
>> non-x86 system, and so I still think the VGA arbiter should be omitted
>> entirely for such platforms, and Xorg should be fixed instead.
> 
> OK, I see where you're coming from. I've been trying to keep my changes
> small as I don't want to end up on the hook for the almost limitless
> range of problems that changing this sort of code can have, but I do
> take your point that it's a bit of an ugly hack of a solution.
> 
> Say we were to change Xorg instead. What would correct Xorg behaviour
> look like? Xorg would need to honour the boot_vga file if it existed so
> as not to break x86, etc. So your proposed Xorg - if it couldn't find a
> default card that way, and if there was no helpful config file info,
> would arbitrarily pick a card that has an Xorg driver? In other words,
> much like the proposed kernel approach but at a different level of the
> stack?
> 
> Are there other graphical applications we care about (other than Xorg)
> that would need to be patched? I'm happy to do the Xorg patch, but I
> don't know if anything other than Xorg keys off the boot_vga file.
> 
> I'm not fundamentally opposed to this approach if the Xorg community is
> happy with it, the kernel community is happy with it, and no-one expects
> me to provide patches to any other user-space applications that depend
> on boot_vga.

Ard both identified the Xorg commit that I would have, and CC'd Hans
which I would have recommended as well.

I assume the symptom is that now there's a class of platform GPU devices
that is neither PCI nor legacy VGA, so neither the kernel's boot_vga
logic matches it, nor Xorg's commit in question.

I agree that it should be possible to add more logic to Xorg to detect
this kind device as primary. However, I share Daniel's worry that it
wouldn't cover all user space apps -- I see "Wayland this, Wayland that"
on reddit every week.

Having practically zero background in gfx development (either kernel or
Xorg), I think the problem is that vga_default_device() /
vga_set_default_device(), which -- apparently -- "boot_vga" is based
upon, come from "drivers/gpu/vga/vgaarb.c". Namely, the concept of
"primary / boot display device" is tied to the VGA arbiter, plus only a
PCI device can currently be marked as primary/boot display device.

Can these concepts be split from each other? (I can fully imagine that
this would result in a userspace visible interface change (or addition),
so that e.g. "/sys/devices/**/boot_gpu" would have to be consulted by
display servers.)

(Sorry if I'm totally wrong.)

... Hm, reading the thread starter at
<https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg120851.html>,
and the references within... It looks like this work is motivated by
hardware that is supposed to be PCI, but actually breaks the specs. Is
that correct? If so, then I don't think I can suggest anything useful.
Specs exist so that hardware vendors and software authors follow them.
If hardware does not conform, then software should either refuse to work
with it, or handle it with quirks, on a case-by-case basis. I guess this
means that I don't agree with the

  broad[] suggest[ion] that a more generic solution would be better

which seems to disqualify me from the discussion, as it must have been
suggested by people with incomparably more experience than what I have :)

Thanks
Laszlo
