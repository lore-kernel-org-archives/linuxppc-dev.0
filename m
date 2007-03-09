Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 042F0DDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 09:23:06 +1100 (EST)
In-Reply-To: <1173471495.23776.241.camel@ld0161-tx32>
References: <1173471495.23776.241.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <891B901D-FC5E-4AFC-9C79-EFAEFD9C59DB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: The transparent PCI-Express bridge problem
Date: Fri, 9 Mar 2007 16:22:01 -0600
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 9, 2007, at 2:18 PM, Jon Loeliger wrote:

> Kumar,
>
> Here is a lspci -xv from the 8544 DS board.  This is
> the same board as the 8641 HPCN board, so they both have
> the same "root complex is really a transparent bridge"
> problem that needs to be resolved.
>
> Please let me know if you need further or different info here.
>
> HTH,
> jdl
>
>
>
>
> # lspci -xv
> 00:00.0 Power PC: Unknown device 1957:0030 (rev 10)
>         !!! Invalid class 0b20 for header type 01
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
>         I/O behind bridge: 00000000-00000fff
>         Memory behind bridge: 00000000-000fffff
>         Prefetchable memory behind bridge:  
> 0000000000000000-0000000000000000
>         Capabilities: [44] Power Management version 2
>         Capabilities: [4c] #10 [0041]
> 00: 57 19 30 00 06 01 10 00 10 00 20 0b 00 00 01 00
> 10: 00 00 00 00 00 00 00 00 00 01 02 00 00 00 00 20
> 20: 00 00 00 00 01 00 01 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 00 00

(Mainly responding for anyone else reading this)

After some discussion, and reading of the PCI-Express specs the issue  
is that the class information is not being set properly.  Try a quirk  
like the following to fixup and see what happens.

static void __devinit early_fsl_pcie(struct pci_dev *dev)
{
         dev->class &= 0xff;
         dev->class |= (PCI_CLASS_BRIDGE_PCI << 8)
}

DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0030, early_fsl_pcie);

I think this may resolve the following issues:
* Do not skip PCI Express to PCI bridge when scanning OF node
* All the driver/pci/probe.c changes

- k
