Return-Path: <gabriele.paoloni@huawei.com>
Received: from lhrrgout.huawei.com (lhrrgout.huawei.com [194.213.3.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC9BX4cp1zDrWh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 18:27:32 +1000 (AEST)
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Daniel Axtens <dja@axtens.net>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
CC: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "Liuxinliang
 (Matthew Liu)" <z.liuxinliang@hisilicon.com>, "zourongrong@gmail.com"
 <zourongrong@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "airlied@linux.ie" <airlied@linux.ie>,
 "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 0/4] Allow non-legacy cards to be vgaarb default
Date: Wed, 19 Jul 2017 08:19:54 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B57B8A@FRAEML521-MBX.china.huawei.com>
References: <20170719021516.24718-1-dja@axtens.net>
In-Reply-To: <20170719021516.24718-1-dja@axtens.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel many thanks for your patch

> -----Original Message-----
> From: Daniel Axtens [mailto:dja@axtens.net]
> Sent: 19 July 2017 03:15
> To: linux-pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> arm-kernel@lists.infradead.org
> Cc: benh@kernel.crashing.org; Liuxinliang (Matthew Liu);
> zourongrong@gmail.com; catalin.marinas@arm.com; will.deacon@arm.com;
> Gabriele Paoloni; bhelgaas@google.com; airlied@linux.ie;
> daniel.vetter@intel.com; alex.williamson@redhat.com; Daniel Axtens
> Subject: [PATCH v2 0/4] Allow non-legacy cards to be vgaarb default
>=20
> [v2, in which I send the right patches. My apologies to you all.]
>=20
> Hi all,
>=20
> Previously I posted a patch that provided a quirk for a hibmc card
> behind a particular Huawei bridge that allowed it to be marked as the
> default device in the VGA arbiter.[0] This lead to some discussion.[1]
> It was broadly suggested that a more generic solution would be better,
> something in the style of powerpc's fixup_vga() quirk.
>=20
> Here is my suggested solution:
>=20
>  - Create a Kconfig option ARCH_WANT_VGA_ARB_FALLBACK and

In my opinion we could avoid depending on a Kernel config options.
I.e. we can have generic code that, after all PCI devs are enumerated:
1) check if we have a default vga device
2) if not check each registered PCI device and make default device the firs=
t
   one that is a VGA device, capable to respond to IO and MEM requests
   and that has a driver bound to it=20

>=20
>  - if an arch selects that option, install PCI_FIXUP_CLASS_ENABLE
>    hook. This hook fires when a card is enabled, which will require
>    that a driver has been bound.
>=20
>  - if there is no default device when the hook fires, and the device
>    can control memory and I/O, mark it as default.

I am worried that the patchset you proposed has a race condition with the
VGA arbiter. In fact you see:
subsys_initcall(vga_arb_device_init) is not guaranteed to be called before
subsys_initcall(acpi_init)

acpi_init->acpi_scan_init->acpi_pci_root_init() at this stage the PCI enume=
ration
is done and as soon as a device is added the Kernel will look for a driver
to bind to it and therefore you quirk could be called before the VGA arbite=
r...
Do you agree?

What about modifying vgaarb.c to add a late_initcall() checking what I sugg=
ested
above?

Thanks
Gab

[...]
