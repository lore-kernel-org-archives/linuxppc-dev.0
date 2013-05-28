Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E49822C0328
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 08:46:08 +1000 (EST)
Date: Tue, 28 May 2013 17:45:56 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: match with the pci bus address used by
 u-boot for all p1_p2_rdb_pc boards
To: Kevin Hao <haokexin@gmail.com>
References: <1368685785-10677-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368685785-10677-1-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Thu May 16 01:29:45 2013)
Message-ID: <1369781156.18630.24@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2013 01:29:45 AM, Kevin Hao wrote:
> All these boards use the same configuration file p1_p2_rdb_pc.h in
> u-boot. So they have the same pci bus address set by the u-boot.
> But in some of these boards the bus address set in dtb don't match
> the one used by u-boot. And this will trigger a kernel bug in 32bit
> kernel and cause the pci device malfunction. For example, on a
> p2020rdb-pc board the u-boot use the 0xa0000000 as both bus address
> and cpu address for one pci controller and then assign bus address
> such as 0xa00004000 to some pci device. But in the kernel, the dtb
> set the bus address to 0xe0000000 and the cpu address to 0xa0000000.
> The kernel assumes mistakenly the assigned bus address 0xa0004000
> in pci device is correct and keep it unchanged. This will definitely
> cause the pci device malfunction. I have made two patches to fix
> this in the pci subsystem.
> http://patchwork.ozlabs.org/patch/243702/
> http://patchwork.ozlabs.org/patch/243703/
>=20
> But I still think it makes sense to set these bus address to match
> with the u-boot. This issue can't be reproduced on 36bit kernel.
> But I also tweak the 36bit dtb for the above reason.

IIRC the reason for using 0xe0000000 on all PCIe roots is to maximize =20
the memory that is DMA-addressable without involving swiotlb.

Maybe U-Boot should be fixed?

-Scott=
