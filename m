Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41g0tK4R3FzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 01:37:11 +1000 (AEST)
Date: Tue, 31 Jul 2018 16:36:55 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Alexei Colin <acolin@isi.edu>
Cc: Alexandre Bounine <alex.bou9@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Paul Walters <jwalters@isi.edu>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 5/6] arm: enable RapidIO menu in Kconfig
Message-ID: <20180731153655.GM17271@n2100.armlinux.org.uk>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-6-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731142954.30345-6-acolin@isi.edu>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 31, 2018 at 10:29:53AM -0400, Alexei Colin wrote:
> Platforms with a PCI bus will be offered the RapidIO menu since they may
> be want support for a RapidIO PCI device. Platforms without a PCI bus
> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> 
> Tested that kernel builds for ARM with the RapidIO subsystem and switch
> drivers enabled.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Alexei Colin <acolin@isi.edu>
> ---
>  arch/arm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index afe350e5e3d9..602a61324890 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
>  
>  source "drivers/pci/Kconfig"
>  
> +source "drivers/rapidio/Kconfig"
> +
>  source "drivers/pcmcia/Kconfig"

Why not place the new Kconfig file after pcmcia?  That way, it is in
a consistent position wrt architectures such as powerpc, and it is
also in alphabetical order.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
