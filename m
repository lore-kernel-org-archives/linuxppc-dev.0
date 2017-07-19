Return-Path: <dja@axtens.net>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC0Vf5yPVzDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 11:55:54 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id q85so4614047pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 18:55:54 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, helgass@kernel.org, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com
Subject: Re: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
In-Reply-To: <20170719012839.20124-1-dja@axtens.net>
References: <20170719012839.20124-1-dja@axtens.net>
Date: Wed, 19 Jul 2017 11:55:48 +1000
Message-ID: <87pocxkx5n.fsf@linkitivity.dja.id.au>
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

Apologies everyone - this got mixed in with another patch set. I'll do a
v2 that isn't completely broken and confusing.

Again, my apologies for the noise.

Regards,
Daniel

Daniel Axtens <dja@axtens.net> writes:

> Hi all,
>
> Previously I posted a patch that provided a quirk for a hibmc card
> behind a particular Huawei bridge that allowed it to be marked as the
> default device in the VGA arbiter.[0] This lead to some discussion.[1]
> It was broadly suggested that a more generic solution would be better,
> something in the style of powerpc's fixup_vga() quirk.
>
> Here is my suggested solution:
>
>  - Create a Kconfig option ARCH_WANT_VGA_ARB_FALLBACK
>  
>  - if an arch selects that option, install PCI_FIXUP_CLASS_ENABLE
>    hook. This hook fires when a card is enabled, which will require
>    that a driver has been bound.
>
>  - if there is no default device when the hook fires, and the device
>    can control memory and I/O, mark it as default.
>
> The patches are as follows:
>
>  (1) powerpc: simplify and fix VGA default device behaviour
>
>      This cleans up some quirks in the powerpc implementation of the
>      vga_fixup. It should make the behaviour match the original
>      intention.
>
>  (2) vgaarb: allow non-legacy cards to be marked as default
>
>      Add the Kconfig option, and create the fixup in vgaarb.c gated
>      behind the option. Nothing happens at this stage because no arch
>      has selected the option yet.
>
>  (3) powerpc: replace vga_fixup() with generic code
>
>      Select the option on powerpc and remove the old code. The only
>      change is that it moves from being a final fixup to an enable
>      fixup.
>  
>  (4) arm64: allow non-legacy VGA devices to be default
>
>      Select the option on arm64. This solves my problem with the D05,
>      but may cause other cards to be marked as default on other
>      boards. This shouldn't cause any real issues but is worth being
>      aware of.
>
> Regards,
> Daniel
>
> [0]: https://patchwork.ozlabs.org/patch/787003/
> [1]: https://www.spinics.net/lists/arm-kernel/msg593656.html
>
> Daniel Axtens (4):
>   powerpc: simplify and fix VGA default device behaviour
>   vgaarb: allow non-legacy cards to be marked as default
>   powerpc: replace vga_fixup() with generic code
>   arm64: allow non-legacy VGA devices to be default
>
>  arch/arm64/Kconfig               |  1 +
>  arch/powerpc/Kconfig             |  1 +
>  arch/powerpc/kernel/pci-common.c | 12 ------------
>  drivers/gpu/vga/Kconfig          |  7 +++++++
>  drivers/gpu/vga/vgaarb.c         | 21 +++++++++++++++++++++
>  5 files changed, 30 insertions(+), 12 deletions(-)
>
> -- 
> 2.11.0
