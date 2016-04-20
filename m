Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqyB162hfzDqb0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 09:04:09 +1000 (AEST)
Message-ID: <1461193440.32510.211.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 20 Apr 2016 18:04:00 -0500
In-Reply-To: <1461146533-9500-1-git-send-email-alessio.bogani@elettra.eu>
References: <1461140309-2522-1-git-send-email-alessio.bogani@elettra.eu>
 <1461146533-9500-1-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v3 1/1] powerpc/86xx: Add support for Emerson/Artesyn
 MVME7100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-20 at 12:02 +0200, Alessio Igor Bogani wrote:
> Add support for the Artesyn MVME7100 Single Board Computer.
> 
> The MVME7100 is a 6U form factor VME64 computer with:
> 
>     - A two e600 cores Freescale MPC8641D CPU
>     - 2 GB of DDR2 onboard memory
>     - Four Gigabit Ethernets
>     - Five 16550 compatible UARTs
>     - One USB 2.0 port
>     - Two PCI/PCI eXpress Mezzanine Card (PMC/XMC) Slots
>     - A DS1375 Real Time Clock (RTC)
>     - 512 KB of Non-Volatile Memory (NVRAM)
>     - Two 64 KB EEPROMs
>     - 128 MB NOR and 4/8 GB NAND Flash
> 
> This patch is based on linux-4.6-rc4 and has been only boot tested.
> 
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
> This patch requires 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-April/141813.html
> to be built and 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-April/141980.html to
> work correctly.
> 
> v2 -> v3
>     Simplify device tree using pci1 definition from the header file
>         as suggested bt Scott Wood
>     Move assembly code into a separated file as suggested by Scott Wood
>     Increase from 2 to 5 the number of UARTs
> 
> v1 -> v2
>     Fix BCSR handling
>     Add missing @interrupt-cells in the device tree
>         to avoid 'of_irq_parse_pci() failed with rc=-22'
>     Reduce from 3 to 2 the PCI windows to avoid
>         'Ran out of outbound PCI ATMUs for IO resource'
> 
> Limitations:
>     This patch covers only models 171 and 173
>     No plans to support CPLD timers
> 
> Know issues:
>     All four PHYs work in polling mode
> 
> Configuration is missing for:
>     PCI IDSEL and PCI Interrupt definition
> 
> Support is missing for:
>     Cache and memory controllers (which are very similar to the 85xx ones
>         but right now I don't know if we can re-use their support)
>     Watchdog, USB, NVRAM, NOR, NAND, EEPROMs, VME, PMC/XMC and RTC

All of the above other than the changelog should go above the --- line

Until you figure out the PCI interrupt mapping, the PCI nodes should be marked
disabled.  Likewise anything else that has an incorrect/incomplete device tree
node.

-Scott
