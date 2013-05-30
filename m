Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BCD7B2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 00:43:40 +1000 (EST)
Date: Thu, 30 May 2013 09:43:28 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: match with the pci bus address used by
 u-boot for all p1_p2_rdb_pc boards
To: Kumar Gala <galak@kernel.crashing.org>
References: <1368685785-10677-1-git-send-email-haokexin@gmail.com>
 <1369781156.18630.24@snotra>
 <9845CB5F-0E99-49A5-A10B-CD2E2379E903@kernel.crashing.org>
In-Reply-To: <9845CB5F-0E99-49A5-A10B-CD2E2379E903@kernel.crashing.org>
 (from galak@kernel.crashing.org on Thu May 30 09:21:19 2013)
Message-ID: <1369925008.14679.1@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2013 09:21:19 AM, Kumar Gala wrote:
>=20
> On May 28, 2013, at 5:45 PM, Scott Wood wrote:
>=20
> > On 05/16/2013 01:29:45 AM, Kevin Hao wrote:
> >> All these boards use the same configuration file p1_p2_rdb_pc.h in
> >> u-boot. So they have the same pci bus address set by the u-boot.
> >> But in some of these boards the bus address set in dtb don't match
> >> the one used by u-boot. And this will trigger a kernel bug in 32bit
> >> kernel and cause the pci device malfunction. For example, on a
> >> p2020rdb-pc board the u-boot use the 0xa0000000 as both bus address
> >> and cpu address for one pci controller and then assign bus address
> >> such as 0xa00004000 to some pci device. But in the kernel, the dtb
> >> set the bus address to 0xe0000000 and the cpu address to =20
> 0xa0000000.
> >> The kernel assumes mistakenly the assigned bus address 0xa0004000
> >> in pci device is correct and keep it unchanged. This will =20
> definitely
> >> cause the pci device malfunction. I have made two patches to fix
> >> this in the pci subsystem.
> >> http://patchwork.ozlabs.org/patch/243702/
> >> http://patchwork.ozlabs.org/patch/243703/
> >> But I still think it makes sense to set these bus address to match
> >> with the u-boot. This issue can't be reproduced on 36bit kernel.
> >> But I also tweak the 36bit dtb for the above reason.
> >
> > IIRC the reason for using 0xe0000000 on all PCIe roots is to =20
> maximize the memory that is DMA-addressable without involving swiotlb.
> >
> > Maybe U-Boot should be fixed?
> >
> > -Scott
>=20
> I feel that u-boot was the way it is to allow accessing each bus from =20
> the command line in u-boot w/o big changes for >32-bit addressing.
>=20
> Linux was able to handle the PCI bus addresses all being the same.

It's a bit of a hack though, in that you're using the device tree to =20
indicate how you want the hardware programmed rather than to describe =20
the hardware or even what U-Boot's done to it, and in that you can't =20
arbitrarily change what U-Boot chose -- it only works because you're =20
picking an address that U-Boot used for one of the PCIe controllers and =20
thus U-Boot covered it with a LAW.

-Scott=
