Return-Path: <alex.bou9@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fzJh1HXFzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 00:26:19 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id r15-v6so13170129ioa.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 07:26:19 -0700 (PDT)
Subject: Re: [PATCH 0/6] rapidio: move Kconfig menu definition to subsystem
To: Alexei Colin <acolin@isi.edu>, Andrew Morton <akpm@linux-foundation.org>
Cc: John Paul Walters <jwalters@isi.edu>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>,
 Alexander Sverdlin <alexander.sverdlin@nokia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Anvin <hpa@zytor.com>, Matt Porter <mporter@kernel.crashing.org>,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180730225035.28365-1-acolin@isi.edu>
From: Alex Bounine <alex.bou9@gmail.com>
Message-ID: <37edb8c5-a16f-ea39-5da8-312d138ce442@gmail.com>
Date: Tue, 31 Jul 2018 10:26:15 -0400
MIME-Version: 1.0
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>

On 2018-07-30 06:50 PM, Alexei Colin wrote:
> The top-level Kconfig entry for RapidIO subsystem is currently
> duplicated in several architecture-specific Kconfig files. This set of
> patches does two things:
> 
> 1. Move the Kconfig menu definition into the RapidIO subsystem and
> remove the duplicate definitions from arch Kconfig files.
> 
> 2. Enable RapidIO Kconfig menu entry for arm and arm64 architectures,
> where it was not enabled before. I tested that subsystem and drivers
> build successfully for both architectures, and tested that the modules
> load on a custom arm64 Qemu model.
> 
> For all architectures, RapidIO menu should be offered when either:
> (1) The platform has a PCI bus (which host a RapidIO module on the bus).
> (2) The platform has a RapidIO IP block (connected to a system bus, e.g.
> AXI on ARM). In this case, 'select HAS_RAPIDIO' should be added to the
> 'config ARCH_*' menu entry for the SoCs that offer the IP block.
> 
> Prior to this patchset, different architectures used different criteria:
> * powerpc: (1) and (2)
> * mips: (1) and (2) after recent commit into next that added (2):
>    https://www.linux-mips.org/archives/linux-mips/2018-07/msg00596.html
>    fc5d988878942e9b42a4de5204bdd452f3f1ce47
>    491ec1553e0075f345fbe476a93775eabcbc40b6
> * x86: (1)
> * arm,arm64: none (RapidIO menus never offered)
> 
> Responses to feedback from prior submission (thanks for the reviews!):
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593347.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593349.html
> 
> Changelog:
>    * Moved Kconfig entry into RapidIO subsystem instead of duplicating
> 
> In the current patchset, I took the approach of adding '|| PCI' to the
> depends in the subsystem. I did try the alterantive approach mentioned
> in the reviews for v1 of this patch, where the subsystem Kconfig does
> not add a '|| PCI' and each per-architecture Kconfig has to add a
> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
> 'select HAS_RAPIDIO'. This works too but requires each architecture's
> Kconfig to add the line for RapidIO (whereas current approach does not
> require that involvement) and also may create a false impression that
> the dependency on PCI is strict.
> 
> We appreciate the suggestion for also selecting the RapdiIO subsystem for
> compilation with COMPILE_TEST, but hope to address it in a separate
> patchset, localized to the subsystem, since it will need to change
> depends on all drivers, not just on the top level, and since this
> patch now spans multiple architectures.
> 
> 
> Alexei Colin (6):
>    rapidio: define top Kconfig menu in driver subtree
>    x86: factor out RapidIO Kconfig menu
>    powerpc: factor out RapidIO Kconfig menu entry
>    mips: factor out RapidIO Kconfig entry
>    arm: enable RapidIO menu in Kconfig
>    arm64: enable RapidIO menu in Kconfig
> 
>   arch/arm/Kconfig        |  2 ++
>   arch/arm64/Kconfig      |  2 ++
>   arch/mips/Kconfig       | 11 -----------
>   arch/powerpc/Kconfig    | 13 +------------
>   arch/x86/Kconfig        |  8 --------
>   drivers/rapidio/Kconfig | 15 +++++++++++++++
>   6 files changed, 20 insertions(+), 31 deletions(-)
> 
