Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95A8DDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jun 2008 01:30:40 +1000 (EST)
Message-Id: <D7261455-1BB8-44E7-940D-84C207A40CA7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Vince Asbridge <vasbridge@sanblaze.com>
In-Reply-To: <13c601c8d612$2af82500$4b01a8c0@sanblaze.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI 1068 SAS
	chip
Date: Wed, 25 Jun 2008 10:30:35 -0500
References: <13c601c8d612$2af82500$4b01a8c0@sanblaze.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 24, 2008, at 10:51 AM, Vince Asbridge wrote:

> All,
>
> I'm new to this mailing list, but have not had any luck finding =20
> information on this issue.
>
> Please be kind if I break the forum rules on my first post.
>
> We recently tried to upgrade our Freescale CDS 8548 look-alike =20
> module (code name ATCA1000) from the 2.6.11 based BSP to the 2.6.23 =20=

> based BSP.
>
> The upgrade went fairly smoothly, until we tried using SOME pci-e =20
> devices (some work fine, some don't show up to lspci).
>
> LSI pci-e controllers no longer show up at all!
>
> We see the ixgbe (intel 10G), SiliconImage SATA controller but do =20
> not see LSI devices (Specifically 1068 SAS, FC949-E fibrechannel).
>
> We're guessing it's a resource issue behind the bridge, because the =20=

> LSI devices try to allocate 1 - 3M behind the bridge, but we can't =20
> find the bug, or where we would debug such an issue.
>
> The devices seem to "train" correctly, because we have an LED on the =20=

> pci-e switch (PLX 8 port pci-e switch), and it's ON indicating pci-e =20=

> link between the bridge and the 1068 device).
>
> We're totally at a loss as to why this always worked on the 2.6.11 =20
> kernel but doesn=92t work on 2.6.23.
>
> Using lspci, the LSI adapters do not show up in the list at all, as =20=

> though they are not plugged into the system.
>
> Is there something that needs to be done with respect to PCI-E =20
> devices that is new in the 2.6.23 based BSP that did not need to be =20=

> done in the 2.6.11 based kit?  For example, are pci resources =20
> allocated by a different piece of code, that may have some issue =20
> allocating resources for the LSI adapters?
>
>
>
Can you tree 2.6.25?  There are some fixes in that kernel related to =20
PCIe support:

[POWERPC] FSL: Rework PCI/PCIe support for 85xx/86xx

However, its odd that lspci doesn't even show the device.  Are you =20
using u-boot?  if so what version? and does u-boot see the LSI?

- k=
