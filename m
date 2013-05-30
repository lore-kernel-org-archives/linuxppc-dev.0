Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A508A2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 00:21:28 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpc85xx: match with the pci bus address used by
 u-boot for all p1_p2_rdb_pc boards
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1369781156.18630.24@snotra>
Date: Thu, 30 May 2013 09:21:19 -0500
Message-Id: <9845CB5F-0E99-49A5-A10B-CD2E2379E903@kernel.crashing.org>
References: <1368685785-10677-1-git-send-email-haokexin@gmail.com>
 <1369781156.18630.24@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 28, 2013, at 5:45 PM, Scott Wood wrote:

> On 05/16/2013 01:29:45 AM, Kevin Hao wrote:
>> All these boards use the same configuration file p1_p2_rdb_pc.h in
>> u-boot. So they have the same pci bus address set by the u-boot.
>> But in some of these boards the bus address set in dtb don't match
>> the one used by u-boot. And this will trigger a kernel bug in 32bit
>> kernel and cause the pci device malfunction. For example, on a
>> p2020rdb-pc board the u-boot use the 0xa0000000 as both bus address
>> and cpu address for one pci controller and then assign bus address
>> such as 0xa00004000 to some pci device. But in the kernel, the dtb
>> set the bus address to 0xe0000000 and the cpu address to 0xa0000000.
>> The kernel assumes mistakenly the assigned bus address 0xa0004000
>> in pci device is correct and keep it unchanged. This will definitely
>> cause the pci device malfunction. I have made two patches to fix
>> this in the pci subsystem.
>> http://patchwork.ozlabs.org/patch/243702/
>> http://patchwork.ozlabs.org/patch/243703/
>> But I still think it makes sense to set these bus address to match
>> with the u-boot. This issue can't be reproduced on 36bit kernel.
>> But I also tweak the 36bit dtb for the above reason.
>=20
> IIRC the reason for using 0xe0000000 on all PCIe roots is to maximize =
the memory that is DMA-addressable without involving swiotlb.
>=20
> Maybe U-Boot should be fixed?
>=20
> -Scott

I feel that u-boot was the way it is to allow accessing each bus from =
the command line in u-boot w/o big changes for >32-bit addressing.

Linux was able to handle the PCI bus addresses all being the same.

- k=
