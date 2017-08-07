Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQpln3qY2zDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 17:18:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: gabriele.paoloni@huawei.com, airlied@linux.ie,
 Brian King <brking@linux.vnet.ibm.com>, will.deacon@arm.com,
 z.liuxinliang@hisilicon.com, bhelgaas@google.com, alex.williamson@redhat.com,
 catalin.marinas@arm.com, zourongrong@gmail.com, daniel.vetter@intel.com,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 3/3] powerpc: replace vga_fixup() with generic code
In-Reply-To: <20170804102033.27731-4-dja@axtens.net>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-4-dja@axtens.net>
Date: Mon, 07 Aug 2017 17:18:12 +1000
Message-ID: <87efsnq217.fsf@concordia.ellerman.id.au>
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

> Currently, we do a PCI fixup to mark a default card so that Xorg
> autoconfiguration works.
>
> There is a new generic method to do this sort of vga fixup, and
> it occurs by default.
>
> Drop our old method.
>
> This method is different:
>  - it will only mark a card as default if a driver is bound
>  - the marking will happen at late_initcall time, or even later
>    if a card is enabled later on (via an ENABLE hook). Currently
>    things are enabled in a FINAL hook.
>
> This *does* change behaviour under some circumstances.
>
> For example, pseries_le_defconfig doesn't have DRM drivers for
> many of the qemu GPU models, including the 'standard' vga.

Should we enable them/it?

cheers
