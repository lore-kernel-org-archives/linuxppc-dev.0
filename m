Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 0EA34DE919
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 05:45:56 +1000 (EST)
Received: by gxk14 with SMTP id 14so1411828gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 12:45:54 -0700 (PDT)
Message-ID: <fa686aa40808221245q132061d0h8166dd0676c1778c@mail.gmail.com>
Date: Fri, 22 Aug 2008 13:45:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Laxmikant Rashinkar" <lk.atwork@yahoo.com>
Subject: Re: porting linux 2.6.27 to embedded powerpc board
In-Reply-To: <484406.39935.qm@web46302.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <484406.39935.qm@web46302.mail.sp1.yahoo.com>
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

On Fri, Aug 22, 2008 at 12:26 PM, Laxmikant Rashinkar
<lk.atwork@yahoo.com> wrote:
> Hi,
>
> I still haven't gotten anything to work :-(
>
> I'm using Uboot 1.1.4 and Linux 2.6.27 but instead of using uImage, I'm
> using cuImage.<myboard>
> The args to dtc are as listed by David Jander

Please post you .dts file and the filename you are using for it.

g.

>
> My cmd line args are:
> setenv bootargs root=/dev/ram0 init=/rescue rw console=ttyS0,9600
> ramdisk_size=65536
>
> When I attempt to boot my image it just hangs w/o any output. I dearly wish
> I could get some console output.
> Here is the actual display from uboot:
>
> ## Booting image at 00800000 ...
>    Image Name:   Linux-2.6.27-rc2
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1640425 Bytes =  1.6 MB
>    Load Address: 00400000
>    Entry Point:  0040055c
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 01000000 ...
>    Image Name:   flash_root.ext3.gz
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    13450106 Bytes = 12.8 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Loading Ramdisk to 0f29d000, end 0ff70b7a ... OK
>
> Two questions:
>
> 1) the load address and entry point for the kernel (see above) are non-zero.
> When we load via uImage, they are always zero. Is this normal? dtc has not
> options to set the load address and entry point.
>
> 2) When I build my kernel, I get two warnings. Could these be causing a
> problem?
>
> WARNING: mm/built-in.o(.data+0x8ec): Section mismatch in reference from the
> variable contig_page_data to the variable .init.data:bootmem_node_data
> The variable contig_page_data references
> the variable __initdata bootmem_node_data
> If the reference is valid then annotate the
> variable with __init* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
>
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.data+0xfe74): Section mismatch in reference from the
> variable contig_page_data to the variable .init.data:bootmem_node_data
> The variable contig_page_data references
> the variable __initdata bootmem_node_data
> If the reference is valid then annotate the
> variable with __init* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> thanks so much for your help.
>
> LK
>
> ----- Original Message ----
> From: David Jander <david.jander@protonic.nl>
> To: linuxppc-embedded@ozlabs.org
> Cc: Laxmikant Rashinkar <lk.atwork@yahoo.com>
> Sent: Thursday, August 21, 2008 2:43:45 AM
> Subject: Re: porting linux 2.6.27 to embedded powerpc board
>
> On Thursday 21 August 2008 01:24:46 Laxmikant Rashinkar wrote:
>> Hi,
>>
>> I have an embedded PowerPC (MPC8347) board that works fine with uboot and
>> Linux 2.6.15.
>>
>> I am trying to upgrade the kernel so that it runs on the latest release -
>> Linux 2.6.27. So far, I have gotten the kernel to compile on my platform,
>> but of course it does not boot.
>
> Well, honestly I don't know where to look for information either (other than
> the source-code and examples from others), but here is a list with points to
> look out for (I have just done the same thing as you for a MPC5200B-based
> board):
>
> 1. Upgrade to latest u-boot first (recent git seems to be fine). There have
> been a lot of changes in u-boot lately about OF and device-tree related
> things. I suspect you need a fairly recent version of u-boot to go well with
> the latest kernel. It's also generally a good idea IMHO.
>
> 2. I assume you are porting to arch/powerpc (the old arch/ppc you used back
> in
> 2.6.15 is obsolete and broken now).
>
> 3. Look at other platforms that use the same processor, and pick a simple
> one
> as starting point. Look out for the dts (device-tree-source file in
> arch/powerpc/boot/dts), copy and modify one to reflect your hardware.
> Recently a lot of changes happend in the kernel, changing device names,
> obsoleting "device-type" tags, etc..., so some of the current DTS sources
> included in the kernel might not even work (wrong device name, missing
> information, wrong use of "device-type", etc...), so watch out for these
> kind
> of issues too.
>
> 4. Be sure that the device(s) necessary to produce output on your console
> are
> correctly placed in the DT. Also make sure that u-boot knows about it
> (#define OF_STDOUT_PATH... in your u-boot board config file)
>
> 5. When compiling the device tree, it may be necessary to add some extra
> reserved entries to the compiled tree (I am using dtc -p 10240 -R 20, which
> might be slightly exaggerated), because u-boot may add something to it, and
> if it can't, linux won't boot.
>
> 6. Remember to always specify the "rootfstype=" option on the commandline if
> booting from anything other than NFS. This was not necessary back in the
> 2.6.15-times AFAICR.
>
> 7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb",
> don't forget the dash if you are not using an initrd). If you don't do this,
> u-boot can't fix your DT, and the kernel probably won't find it either.
>
> 8. Be sure to use the correct version of the DTC (DT compiler) for your
> kernel
> (the sources are included nowadays, somewhere in arch/powerpc/boot IIRC).
> The
> command used to compile, should probably be something like this:
>
> $ ./dtc -p 10240 -R 20 -I dts -o myplatform.dtb -O dtb -b 0
> dts/myplatform.dts
>
> Load the resulting .dtb file directly with u-boot (don't make an u-image out
> of it).
>
> That's all I remember right now... hope it helps.
>
> Regards,
>
> --
> David Jander
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
