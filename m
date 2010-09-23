Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 02052B70D5
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 16:30:27 +1000 (EST)
Received: by eyg24 with SMTP id 24so543310eyg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 23:30:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=xoc+4bDTG5MHuRMEPAwfn5vKsDEXJtO22JKiA@mail.gmail.com>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
	<4C91C77B.8080501@windriver.com>
	<AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com>
	<52CF90264091A14888078A031D780F4306C8BD30@ism-mail03.corp.ad.wrs.com>
	<20100921125247.49f8d101@udp111988uds.am.freescale.net>
	<52CF90264091A14888078A031D780F4306C8C0A0@ism-mail03.corp.ad.wrs.com>
	<AANLkTi=kySFBW8Lwt_hoOZMObGc=kFom22GjbwoccQR-@mail.gmail.com>
	<52CF90264091A14888078A031D780F4306C8C0E5@ism-mail03.corp.ad.wrs.com>
	<AANLkTi=xoc+4bDTG5MHuRMEPAwfn5vKsDEXJtO22JKiA@mail.gmail.com>
Date: Wed, 22 Sep 2010 23:30:25 -0700
Message-ID: <AANLkTimpArvCQVNNaVuMLcNX7WECEmRz+grQsM40zs1m@mail.gmail.com>
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

>> Can you paste the whole log from the u-boot prompt?
>
> In the previous run the ramdisk image was corrupted because the single
> image was loaded at 0x800000. But the boot message showed that the
> initrd image was at 0x0066c000-0x009ae825. So it was over the 8MB
> area.
>
> However after the load address was changed to 0x04000000 (64MB), the
> ramdisk still seemed corrupted but with different error messages.
>
> =3D> bootm
> ## Booting image at 04000000 ...
> =A0 Image Name: =A0 Linux-2.6.33.5
> =A0 Image Type: =A0 PowerPC Linux Kernel Image (gzip compressed)
> =A0 Data Size: =A0 =A04424922 Bytes =3D =A04.2 MB
> =A0 Load Address: 00400000
> =A0 Entry Point: =A000400554
> =A0 Verifying Checksum ... OK
> =A0 Uncompressing Kernel Image ... OK
> Memory <- <0x0 0x8000000> (128MB)
> ENET0: local-mac-address <- 00:09:9b:01:58:64
> CPU clock-frequency <- 0x7270e00 (120MHz)
> CPU timebase-frequency <- 0x7270e0 (8MHz)
> CPU bus-frequency <- 0x3938700 (60MHz)
>
> zImage starting: loaded at 0x00400000 (sp: 0x07d1cbd0)
> Allocating 0x22a1e1 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0040c000:0x0066b0ac)...done 0x21c6c8 bytes
> Attached initrd image at 0x0066c000-0x009ae825
> initrd head: 0x1f8b0808
>
> Linux/PowerPC load: root=3D/dev/ram
> Finalizing device tree... flat tree at 0x9bb300
> Using my870 machine description
> Linux version 2.6.33.5 (shawn@ubuntu) (gcc version 4.2.2) #4 Tue Sep
> 21 09:23:51 PDT 2010
> Found initrd at 0xc066c000:0xc09ae825

The following shows the boot message that the same kernel and the same
ramdisk were loaded separately. The difference is that when boot from
two separate images, the ramdisk is loaded to the top of RAM
(0x79d9000-0x7d1b825). While when booting from the single image, the
ramdisk is loaded to the place immediately after the uncompressed
kernel image (0x0066c000-0x009ae825). I'm not familiar with how the
kernel uses the memory. But it seems clear from this failure that the
kernel overwrites to where the initrd locates.

Anyone can shed some light on why the kernel would overwrite the
initrd area? BTW, if the initrd is small enough, the single image
method works well. Maybe we should have relocated the initrd to the
top of available ram just like u-boot's bootm?

=3D> bootm 1000000 2000000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1040228 Bytes =3D 1015.8 kB
   Load Address: 00400000
   Entry Point:  00400554
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 02000000 ...
   Image Name:   16MB Ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3418149 Bytes =3D  3.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 079d9000, end 07d1b825 ... OK
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:09:9b:01:58:64
CPU clock-frequency <- 0x7270e00 (120MHz)
CPU timebase-frequency <- 0x7270e0 (8MHz)
CPU bus-frequency <- 0x3938700 (60MHz)

zImage starting: loaded at 0x00400000 (sp: 0x07d1cbd0)
Allocating 0x22a1e1 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x0066b0ac)...done 0x21c6c8 bytes
Using loader supplied ramdisk at 0x79d9000-0x7d1b825
initrd head: 0x1f8b0808

Linux/PowerPC load: root=3D/dev/ram
Finalizing device tree... flat tree at 0x678300
Using my870 machine description
Linux version 2.6.33.5 (shawn@ubuntu) (gcc version 4.2.2) #4 Tue Sep
21 09:23:51 PDT 2010
Found initrd at 0xc79d9000:0xc7d1b825

Thanks,
-Shawn.
