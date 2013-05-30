Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 611FF2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 04:57:51 +1000 (EST)
Date: Thu, 30 May 2013 13:57:42 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: match with the pci bus address used by
 u-boot for all p1_p2_rdb_pc boards
To: Kevin Hao <haokexin@gmail.com>
References: <1368685785-10677-1-git-send-email-haokexin@gmail.com>
 <1369781156.18630.24@snotra>
 <20130530032525.GA18702@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130530032525.GA18702@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Wed May 29 22:25:25 2013)
Message-ID: <1369940262.14679.15@snotra>
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

On 05/29/2013 10:25:25 PM, Kevin Hao wrote:
> On Tue, May 28, 2013 at 05:45:56PM -0500, Scott Wood wrote:
> > On 05/16/2013 01:29:45 AM, Kevin Hao wrote:
> > >All these boards use the same configuration file p1_p2_rdb_pc.h in
> > >u-boot. So they have the same pci bus address set by the u-boot.
> > >But in some of these boards the bus address set in dtb don't match
> > >the one used by u-boot. And this will trigger a kernel bug in 32bit
> > >kernel and cause the pci device malfunction. For example, on a
> > >p2020rdb-pc board the u-boot use the 0xa0000000 as both bus address
> > >and cpu address for one pci controller and then assign bus address
> > >such as 0xa00004000 to some pci device. But in the kernel, the dtb
> > >set the bus address to 0xe0000000 and the cpu address to =20
> 0xa0000000.
> > >The kernel assumes mistakenly the assigned bus address 0xa0004000
> > >in pci device is correct and keep it unchanged. This will =20
> definitely
> > >cause the pci device malfunction. I have made two patches to fix
> > >this in the pci subsystem.
> > >http://patchwork.ozlabs.org/patch/243702/
> > >http://patchwork.ozlabs.org/patch/243703/
> > >
> > >But I still think it makes sense to set these bus address to match
> > >with the u-boot. This issue can't be reproduced on 36bit kernel.
> > >But I also tweak the 36bit dtb for the above reason.
> >
> > IIRC the reason for using 0xe0000000 on all PCIe roots is to
> > maximize the memory that is DMA-addressable without involving
> > swiotlb.
>=20
> OK, this sounds reasonable. I can drop the changes for the 36bit dts. =20
> But for
> the 32bit dts, it does cause the kernel hang on my p2020rdb-pca board =20
> when the
> SiI3132 driver probe the on-board pcie to sata controller. I think =20
> this issue
> should apply to all these boards if it has a pci device plugged. So =20
> we should
> fix them ASAP.

Is this what your 3.11 patch fixes, or does it hang even with that?

> > Maybe U-Boot should be fixed?
>=20
> Maybe. I have created patch for kernel to detect this kind of =20
> mismatch between
> kernel and bootloader and then try to reassign the bus address =20
> automatically.
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3D=
next&id=3Dcf4d1cf5ac5e7d2b886af6ed906ea0dcdc5b6855
>=20
> So with this patch the kernel should just work even without this =20
> patch and
> the fix for u-boot. But this patch is just queued for 3.11. So I wish =20
> we can
> tweak the 32bit dts to accommodate to the u-boot now so that we can =20
> make sure
> that these boards are at least bootable for 3.10 or previous kernel. =20
> Then we
> can revert this patch for more DMA address space once the pci patch =20
> are
> merged into mainline.

Is this a regression, or has it been broken for a while?

-Scott=
