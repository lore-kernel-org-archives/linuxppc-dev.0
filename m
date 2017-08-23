Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-io0-x22a.google.com (mail-io0-x22a.google.com
 [IPv6:2607:f8b0:4001:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcpg26h3TzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 23:48:45 +1000 (AEST)
Received: by mail-io0-x22a.google.com with SMTP id g135so609775iog.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 06:48:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822221928.GL6948@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817113028.16853-1-dja@axtens.net>
 <20170817113028.16853-2-dja@axtens.net>
 <20170821105300.GB23287@e107981-lin.cambridge.arm.com>
 <20170822221928.GL6948@bhelgaas-glaptop.roam.corp.google.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 23 Aug 2017 14:48:42 +0100
Message-ID: <CAKv+Gu-FCkV9Dv=yn_CNC9orj8Roiabb75jX34w3mMziWVZaeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Split VGA default device handler out of VGA arbiter
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
 Zou Rongrong <zourongrong@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 daniel.vetter@intel.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22 August 2017 at 23:19, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Aug 21, 2017 at 11:53:01AM +0100, Lorenzo Pieralisi wrote:
>> On Thu, Aug 17, 2017 at 09:30:28PM +1000, Daniel Axtens wrote:
>> > A system without PCI legacy resources (e.g. ARM64) may find that no
>> > default/boot VGA device has been marked, because the VGA arbiter
>> > checks for legacy resource decoding before marking a card as default.
>>
>> I do not understand this paragraph, in particular:
>>
>> - "A system without PCI legacy resources (e.g. ARM64)". What does this
>>   mean ? I take this as "ARM64 does not support IO space"; if a PCI host
>>   bridge supports IO space, there is nothing from an architectural
>>   point of view that prevents an MMIO based IO space implementation to
>>   work on ARM64. It is PCI bridge specific, not arch specific.
>
> This reference to ARM64 is the same thing I stumbled over.  Maybe it
> could be written along the lines of:
>
>   The VGA arbiter selects a default VGA device that is enabled and
>   reachable via the legacy VGA resources (mem 0xa0000-0xbffff, io
>   0x3b0-0x3bb, io 0x3c0-0x3df, etc).
>
>   If there is no such device, e.g., because there's no enabled VGA
>   device, the host bridge doesn't support access to those legacy
>   resources, or a PCI-PCI bridge doesn't have VGA Enable set, a
>   platform may select an arbitrary device by calling
>   vga_set_default_device().
>
> Then I think this patch changes the previous behavior by allowing the
> arbiter to select a device that is enabled and has a driver but may
> not be reachable via the legacy VGA resources.
>
> I don't know what all the consequences of that would be, but it does
> muddy the VGA arbiter waters a bit.  AIUI, the main reason for the
> arbiter is to allow multiple legacy VGA devices by manipulating bridge
> VGA Enable bits so only one receives the legacy resources at a time.
>
> These devices that do not need the legacy resources don't need that
> special treatment because they don't care about the bridge VGA Enable
> bits and several can coexist in the system with no need for VGA
> arbitration.
>
> I guess the powerpc fixup_vga() already selects a device that doesn't
> need the VGA resources, so we already have that situation.
>

Perhaps it is unclear that the whole point of tinkering with the VGA
arbiter is that X may refuse to use a GFX card if it is not tagged as
the default VGA device by the arbiter. I have suggested before that
fixing X may be more appropriate in this case, given that ownership of
the legacy VGA resources may not correlate at all with being the
primary display device on non-x86 architectures.
