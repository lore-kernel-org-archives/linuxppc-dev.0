Return-Path: <dja@axtens.net>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG0j05z2TzDqxl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 09:15:16 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id z1so10120409pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 16:15:16 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, linux-pci <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 "Liuxinliang \(Matthew Liu\)" <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Zou Rongrong <zourongrong@gmail.com>, daniel.vetter@intel.com,
Subject: Re: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
In-Reply-To: <CAKv+Gu-O7cyJSgDrqSNi6F_n9eBnFEgz==aqowMqhy+81YK=CQ@mail.gmail.com>
References: <20170719012839.20124-1-dja@axtens.net>
 <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
 <87pocusm2x.fsf@linkitivity.dja.id.au>
 <CAKv+Gu-O7cyJSgDrqSNi6F_n9eBnFEgz==aqowMqhy+81YK=CQ@mail.gmail.com>
Date: Mon, 24 Jul 2017 09:15:02 +1000
Message-ID: <87r2x6vj7t.fsf@linkitivity.dja.id.au>
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

Hi Ard,

> But the fact remains that we are going about this the wrong way.
> Whether a graphics card decodes legacy VGA ranges or not has *nothing*
> to do with whether or not it is in fact the primary device on a
> non-x86 system, and so I still think the VGA arbiter should be omitted
> entirely for such platforms, and Xorg should be fixed instead.

OK, I see where you're coming from. I've been trying to keep my changes
small as I don't want to end up on the hook for the almost limitless
range of problems that changing this sort of code can have, but I do
take your point that it's a bit of an ugly hack of a solution.

Say we were to change Xorg instead. What would correct Xorg behaviour
look like? Xorg would need to honour the boot_vga file if it existed so
as not to break x86, etc. So your proposed Xorg - if it couldn't find a
default card that way, and if there was no helpful config file info,
would arbitrarily pick a card that has an Xorg driver? In other words,
much like the proposed kernel approach but at a different level of the
stack?

Are there other graphical applications we care about (other than Xorg)
that would need to be patched? I'm happy to do the Xorg patch, but I
don't know if anything other than Xorg keys off the boot_vga file.

I'm not fundamentally opposed to this approach if the Xorg community is
happy with it, the kernel community is happy with it, and no-one expects
me to provide patches to any other user-space applications that depend
on boot_vga.

Regards,
Daniel
