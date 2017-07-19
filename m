Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-it0-x229.google.com (mail-it0-x229.google.com
 [IPv6:2607:f8b0:4001:c0b::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC98T0v3jzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 18:25:44 +1000 (AEST)
Received: by mail-it0-x229.google.com with SMTP id v127so16303891itd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 01:25:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170719012839.20124-1-dja@axtens.net>
References: <20170719012839.20124-1-dja@axtens.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 19 Jul 2017 09:25:40 +0100
Message-ID: <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
To: Daniel Axtens <dja@axtens.net>, Laszlo Ersek <lersek@redhat.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, zourongrong@gmail.com,
 daniel.vetter@intel.com, helgass@kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(+ Laszlo)

On 19 July 2017 at 02:28, Daniel Axtens <dja@axtens.net> wrote:
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

Hi Daniel,

Given that the whole point of the VGA arbiter is the ability to share
the legacy mem+io ranges between different cards, why do we care about
the VGA arbiter in the first place on arm64?

AFAIK, there have been some recent changes in Xorg to address the
auto-detection problem. I don't remember the exact details, but I have
added Laszlo, who was involved with this at the time.

-- 
Ard.
