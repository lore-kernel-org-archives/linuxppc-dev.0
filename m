Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTfFk5smVzDr2S
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 08:05:30 +1000 (AEST)
Date: Fri, 11 Aug 2017 17:05:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Daniel Axtens <dja@axtens.net>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-pci <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Zou Rongrong <zourongrong@gmail.com>,
 "daniel.vetter@intel.com" <daniel.vetter@intel.com>
Subject: Re: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
Message-ID: <20170811220527.GJ17039@bhelgaas-glaptop.roam.corp.google.com>
References: <20170719012839.20124-1-dja@axtens.net>
 <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
 <87pocusm2x.fsf@linkitivity.dja.id.au>
 <CAKv+Gu-O7cyJSgDrqSNi6F_n9eBnFEgz==aqowMqhy+81YK=CQ@mail.gmail.com>
 <87r2x6vj7t.fsf@linkitivity.dja.id.au>
 <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B76A1A@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B76A1A@FRAEML521-MBX.china.huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2017 at 03:56:20PM +0000, Gabriele Paoloni wrote:
> > Having practically zero background in gfx development (either kernel or
> > Xorg), I think the problem is that vga_default_device() /
> > vga_set_default_device(), which -- apparently -- "boot_vga" is based
> > upon, come from "drivers/gpu/vga/vgaarb.c". Namely, the concept of
> > "primary / boot display device" is tied to the VGA arbiter, plus only a
> > PCI device can currently be marked as primary/boot display device.
> > 
> > Can these concepts be split from each other? (I can fully imagine that
> > this would result in a userspace visible interface change (or
> > addition),
> > so that e.g. "/sys/devices/**/boot_gpu" would have to be consulted by
> > display servers.)
> > 
> > (Sorry if I'm totally wrong.)
> > 
> > ... Hm, reading the thread starter at
> > <https://www.mail-archive.com/linuxppc-
> > dev@lists.ozlabs.org/msg120851.html>,
> > and the references within... It looks like this work is motivated by
> > hardware that is supposed to be PCI, but actually breaks the specs. Is
> > that correct? If so, then I don't think I can suggest anything useful.
> 
> My understanding is that the current PCIe HW is specs compliant but the
> vgaarb, in order to make a VGA device the default one, requires all the
> bridges on top of such device to have the "VGA Enable" bit set (optional
> bit in the PCI Express™ to PCI/PCI-X Bridge Spec). I.e. all the bridges
> on top have to support legacy VGA devices; and this is not mandatory
> from the specs...right?

Per the PCIe-to-PCI Bridge spec r1.0, sec 5.1.2.13, the VGA Enable bit
is optional, as you say.  The PCI-to-PCI Bridge spec r1.2, sec
3.2.5.18, doesn't say VGA Enable is optional, *but* sec 4.5 says
bridges need not support VGA.  I naively assume one would discover
that by finding VGA Enable to be RO zero.

Of course, in any case, I also assume that (a) there exist VGA cards
that require legacy VGA resources, e.g., memory 0xa0000-0xbffff, and
(b) such cards will not work behind bridges without VGA support.

I have no idea what if anything the VGA arbiter should do about
bridges like this or VGA devices behind them, but it does sound like
the arbiter might need to become smarter.

Bjorn
