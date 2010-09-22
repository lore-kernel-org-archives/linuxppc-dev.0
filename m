Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 774DAB6EEE
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 00:28:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [U-Boot] cuImage and multi image?
Date: Wed, 22 Sep 2010 16:28:22 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C0E5@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <AANLkTi=kySFBW8Lwt_hoOZMObGc=kFom22GjbwoccQR-@mail.gmail.com>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com><4C91C77B.8080501@windriver.com><AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com><52CF90264091A14888078A031D780F4306C8BD30@ism-mail03.corp.ad.wrs.com><20100921125247.49f8d101@udp111988uds.am.freescale.net><52CF90264091A14888078A031D780F4306C8C0A0@ism-mail03.corp.ad.wrs.com>
	<AANLkTi=kySFBW8Lwt_hoOZMObGc=kFom22GjbwoccQR-@mail.gmail.com>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "Shawn Jin" <shawnxjin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, ppcdev <linuxppc-dev@ozlabs.org>,
	uboot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Shawn Jin [mailto:shawnxjin@gmail.com]=20
> Sent: Wednesday, September 22, 2010 1:43 PM
> To: Chen, Tiejun
> Cc: Scott Wood; ppcdev; uboot
> Subject: Re: [U-Boot] cuImage and multi image?
>=20
> >> > > A follow up question. With this method, the total image size
> >> > > (uncompressed) is limited to the 4MB (the link address of
> >> the boot
> >> > > wrapper)?
> >> >
> >> > No.
> >>
> >> Yes, unless you change the link address, or provide a=20
> vmlinux_alloc=20
> >> callback (which currently only happens on true OF, not cuImage).
> >>
> >> Unless you're talking about the "(uncompressed)"? =A0The=20
> limit applies=20
> >> to the uncompressed boot image -- anything that the bootwrapper=20
> >> itself is decompressing. =A0It does not apply to any further=20
> >> uncompression of the ramdisk itself.
> >>
> >
> > He should point the latter, "the total image size",=20
> including ramdisk.
> > But the link address should be limited for the boot Image,=20
> not for the=20
> > attached ramdisk.
>=20
> Thanks for the clarification. Scott, so what are the things=20
> that the bootwrapper is decompressing? The kernel for sure.=20
> And anything else?

I think you can read the file, arch/powerpc/boot/zImage.lds.S, to =
understand this :)

> I understand that the ramdisk image will be decompressed=20
> later when trying to boot it.
>=20
> I have a large ramdisk image. The size of the image itself (i.e. the
> *.gz) is about 4MB. When the ramdisk was being decompressed=20

Did you try to change link_address on the file, =
arch/powerpc/boot/wrapper?

> in the later stage. It had the following errors. It seems to=20
> me that the ramdisk image somehow was corrupted. Did the=20
> script wrapper mess up the image? Is there any known bug in=20
> the wrapper? My kernel is 2.6.33.

I tried this mechanism on v2.6.34 and it's fine.

> BTW the ramdisk image can be mounted properly if it's=20
> separated from the kernel image.
>=20

Did you try boot the uImage and the ramdisk separately? For example, you =
can boot this as the following command:
# bootm ${kernel_addr} ${ramdisk_addr} ${fdt_addr}

Please use this to check if your ramdisk is valid.

Can you paste the whole log from the u-boot prompt?

Tiejun

> RAMDISK: gzip image found at block 0
> uncompression error
> VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
> Freeing unused kernel memory: 104k init
> EXT2-fs (ram0): error: ext2_check_page: bad entry in directory #336: :
> rec_len is smaller than minimal - offset=3D0, inode=3D0,=20
> rec_len=3D0, name_len=3D0 EXT2-fs (ram0): error: remounting=20
> filesystem read-only Kernel panic - not syncing: No init=20
> found.  Try passing init=3D option to kernel.
> Call Trace:
> [c7821f30] [c0006cd8] show_stack+0x40/0x168 (unreliable)=20
> [c7821f70] [c001cefc] panic+0x8c/0x178 [c7821fc0] [c00026d4]=20
> init_post+0xe4/0xf4 [c7821fd0] [c01ee224]=20
> kernel_init+0x108/0x130 [c7821ff0] [c000dcc0]=20
> kernel_thread+0x4c/0x68 Rebooting in 180 seconds..
>=20
> Thanks,
> -Shawn.
>=20
