Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-103.bluehost.com (outbound-mail-103.bluehost.com
	[69.89.22.13]) by ozlabs.org (Postfix) with SMTP id 03EB9DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 05:00:44 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 4/6] ARM: move bridge enable out of
	pcibios_enable_resources()
Date: Mon, 3 Mar 2008 09:59:35 -0800
References: <20080228000437.880811124@ldl.fc.hp.com>
	<20080228001053.013269726@ldl.fc.hp.com>
In-Reply-To: <20080228001053.013269726@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803030959.35625.jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> Move bridge enable from pcibios_enable_resources() to
> platform_pci_enable_device() so the former matches other
> architectures and can be shared.

I really like the direction of these patches.  Getting PCI resources assigned 
& devices setup correctly for new arches has always been a bit more trouble 
than it should be...

>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> Index: work6/arch/arm/kernel/bios32.c
> ===================================================================
> --- work6.orig/arch/arm/kernel/bios32.c	2008-02-27 11:25:29.000000000 -0700
> +++ work6/arch/arm/kernel/bios32.c	2008-02-27 11:55:59.000000000 -0700
> @@ -683,15 +683,32 @@
>  			cmd |= PCI_COMMAND_MEMORY;
>  	}
>
> +	if (cmd != old_cmd) {
> +		printk("PCI: enabling device %s (%04x -> %04x)\n",
> +		       pci_name(dev), old_cmd, cmd);

Probably worth giving this printk a prefix at some point (doesn't matter for 
this patchset though since you're just moving it around).

Rest of it looks good.

Jesse
