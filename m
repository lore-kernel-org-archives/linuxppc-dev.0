Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 7492DDE42B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 20:14:27 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: porting linux 2.6.27 to embedded powerpc board
Date: Thu, 21 Aug 2008 11:43:45 +0200
References: <424724.49343.qm@web46312.mail.sp1.yahoo.com>
In-Reply-To: <424724.49343.qm@web46312.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808211143.45782.david.jander@protonic.nl>
Cc: Laxmikant Rashinkar <lk.atwork@yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 21 August 2008 01:24:46 Laxmikant Rashinkar wrote:
> Hi,
>
> I have an embedded PowerPC (MPC8347) board that works fine with uboot and
> Linux 2.6.15.
>
> I am trying to upgrade the kernel so that it runs on the latest release -
> Linux 2.6.27. So far, I have gotten the kernel to compile on my platform,
> but of course it does not boot.

Well, honestly I don't know where to look for information either (other than 
the source-code and examples from others), but here is a list with points to 
look out for (I have just done the same thing as you for a MPC5200B-based 
board):

1. Upgrade to latest u-boot first (recent git seems to be fine). There have 
been a lot of changes in u-boot lately about OF and device-tree related 
things. I suspect you need a fairly recent version of u-boot to go well with 
the latest kernel. It's also generally a good idea IMHO.

2. I assume you are porting to arch/powerpc (the old arch/ppc you used back in 
2.6.15 is obsolete and broken now).

3. Look at other platforms that use the same processor, and pick a simple one 
as starting point. Look out for the dts (device-tree-source file in 
arch/powerpc/boot/dts), copy and modify one to reflect your hardware. 
Recently a lot of changes happend in the kernel, changing device names, 
obsoleting "device-type" tags, etc..., so some of the current DTS sources 
included in the kernel might not even work (wrong device name, missing 
information, wrong use of "device-type", etc...), so watch out for these kind 
of issues too.

4. Be sure that the device(s) necessary to produce output on your console are 
correctly placed in the DT. Also make sure that u-boot knows about it 
(#define OF_STDOUT_PATH... in your u-boot board config file)

5. When compiling the device tree, it may be necessary to add some extra 
reserved entries to the compiled tree (I am using dtc -p 10240 -R 20, which 
might be slightly exaggerated), because u-boot may add something to it, and 
if it can't, linux won't boot.

6. Remember to always specify the "rootfstype=" option on the commandline if 
booting from anything other than NFS. This was not necessary back in the 
2.6.15-times AFAICR.

7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb", 
don't forget the dash if you are not using an initrd). If you don't do this, 
u-boot can't fix your DT, and the kernel probably won't find it either.

8. Be sure to use the correct version of the DTC (DT compiler) for your kernel 
(the sources are included nowadays, somewhere in arch/powerpc/boot IIRC). The 
command used to compile, should probably be something like this:

$ ./dtc -p 10240 -R 20 -I dts -o myplatform.dtb -O dtb -b 0 dts/myplatform.dts

Load the resulting .dtb file directly with u-boot (don't make an u-image out 
of it).

That's all I remember right now... hope it helps.

Regards,

-- 
David Jander
