Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 9A4A4B7105
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 15:43:19 +1000 (EST)
Received: by eyg24 with SMTP id 24so69445eyg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 22:43:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52CF90264091A14888078A031D780F4306C8C0A0@ism-mail03.corp.ad.wrs.com>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
	<4C91C77B.8080501@windriver.com>
	<AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com>
	<52CF90264091A14888078A031D780F4306C8BD30@ism-mail03.corp.ad.wrs.com>
	<20100921125247.49f8d101@udp111988uds.am.freescale.net>
	<52CF90264091A14888078A031D780F4306C8C0A0@ism-mail03.corp.ad.wrs.com>
Date: Tue, 21 Sep 2010 22:43:16 -0700
Message-ID: <AANLkTi=kySFBW8Lwt_hoOZMObGc=kFom22GjbwoccQR-@mail.gmail.com>
Subject: Re: [U-Boot] cuImage and multi image?
From: Shawn Jin <shawnxjin@gmail.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
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

>> > > A follow up question. With this method, the total image size
>> > > (uncompressed) is limited to the 4MB (the link address of
>> the boot
>> > > wrapper)?
>> >
>> > No.
>>
>> Yes, unless you change the link address, or provide a
>> vmlinux_alloc callback (which currently only happens on true
>> OF, not cuImage).
>>
>> Unless you're talking about the "(uncompressed)"? =A0The limit
>> applies to the uncompressed boot image -- anything that the
>> bootwrapper itself is decompressing. =A0It does not apply to
>> any further uncompression of the ramdisk itself.
>>
>
> He should point the latter, "the total image size", including ramdisk.
> But the link address should be limited for the boot Image, not for the
> attached ramdisk.

Thanks for the clarification. Scott, so what are the things that the
bootwrapper is decompressing? The kernel for sure. And anything else?
I understand that the ramdisk image will be decompressed later when
trying to boot it.

I have a large ramdisk image. The size of the image itself (i.e. the
*.gz) is about 4MB. When the ramdisk was being decompressed in the
later stage. It had the following errors. It seems to me that the
ramdisk image somehow was corrupted. Did the script wrapper mess up
the image? Is there any known bug in the wrapper? My kernel is 2.6.33.
BTW the ramdisk image can be mounted properly if it's separated from
the kernel image.

RAMDISK: gzip image found at block 0
uncompression error
VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
Freeing unused kernel memory: 104k init
EXT2-fs (ram0): error: ext2_check_page: bad entry in directory #336: :
rec_len is smaller than minimal - offset=3D0, inode=3D0, rec_len=3D0,
name_len=3D0
EXT2-fs (ram0): error: remounting filesystem read-only
Kernel panic - not syncing: No init found.  Try passing init=3D option to k=
ernel.
Call Trace:
[c7821f30] [c0006cd8] show_stack+0x40/0x168 (unreliable)
[c7821f70] [c001cefc] panic+0x8c/0x178
[c7821fc0] [c00026d4] init_post+0xe4/0xf4
[c7821fd0] [c01ee224] kernel_init+0x108/0x130
[c7821ff0] [c000dcc0] kernel_thread+0x4c/0x68
Rebooting in 180 seconds..

Thanks,
-Shawn.
