Return-Path: <lk.atwork@yahoo.com>
Received: from n75.bullet.mail.sp1.yahoo.com (n75.bullet.mail.sp1.yahoo.com
	[98.136.44.51]) by ozlabs.org (Postfix) with SMTP id 69558DE744
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 04:27:32 +1000 (EST)
Date: Fri, 22 Aug 2008 11:26:20 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: porting linux 2.6.27 to embedded powerpc board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-79516427-1219429580=:39935"
Message-ID: <484406.39935.qm@web46302.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-79516427-1219429580=:39935
Content-Type: text/plain; charset=us-ascii

Hi,

I still haven't gotten anything to work :-(

I'm using Uboot 1.1.4 and Linux 2.6.27 but instead of using uImage, I'm using cuImage.<myboard>
The args to dtc are as listed by David Jander

My cmd line args are:
setenv bootargs root=/dev/ram0 init=/rescue rw console=ttyS0,9600 ramdisk_size=65536

When I attempt to boot my image it just hangs w/o any output. I dearly wish I could get some console output.
Here is the actual display from uboot:


## Booting image at 00800000 ...
   Image Name:   Linux-2.6.27-rc2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1640425 Bytes =  1.6 MB
   Load Address: 00400000
   Entry Point:  0040055c
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 01000000 ...
   Image Name:   flash_root.ext3.gz
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    13450106 Bytes = 12.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0f29d000, end 0ff70b7a ... OK

Two questions:

1) the load address and entry point for the kernel (see above) are non-zero. When we load via uImage, they are always zero. Is this normal? dtc has not options to set the load address and entry point.

2) When I build my kernel, I get two warnings. Could these be causing a problem?

WARNING: mm/built-in.o(.data+0x8ec): Section mismatch in reference from the variable contig_page_data to the variable .init.data:bootmem_node_data
The variable contig_page_data references
the variable __initdata bootmem_node_data
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,


  MODPOST vmlinux.o
WARNING: vmlinux.o(.data+0xfe74): Section mismatch in reference from the variable contig_page_data to the variable .init.data:bootmem_node_data
The variable contig_page_data references
the variable __initdata bootmem_node_data
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

thanks so much for your help.

LK


----- Original Message ----
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Cc: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Sent: Thursday, August 21, 2008 2:43:45 AM
Subject: Re: porting linux 2.6.27 to embedded powerpc board

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



      
--0-79516427-1219429580=:39935
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hi,<br><br>I still haven't gotten anything to work :-(<br><br>I'm using Uboot 1.1.4 and Linux 2.6.27 but instead of using uImage, I'm using cuImage.&lt;myboard&gt;<br>The args to dtc are as listed by David Jander<br><br>My cmd line args are:<br>setenv bootargs root=/dev/ram0 init=/rescue rw console=ttyS0,9600 ramdisk_size=65536<br><br>When I attempt to boot my image it just hangs w/o any output. I dearly wish I could get some console output.<br>Here is the actual display from uboot:<br><br></div><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">## Booting image at 00800000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.27-rc2<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp;
 1640425 Bytes =&nbsp; 1.6 MB<br>&nbsp;&nbsp; Load Address: 00400000<br>&nbsp;&nbsp; Entry Point:&nbsp; 0040055c<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>## Loading RAMDisk Image at 01000000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; flash_root.ext3.gz<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 13450106 Bytes = 12.8 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Loading Ramdisk to 0f29d000, end 0ff70b7a ... OK<br><br>Two questions:<br><br>1) the load address and entry point for the kernel (see above) are non-zero. When we load via uImage, they are always zero. Is this normal? dtc has not options to set the load address and entry point.<br><br>2) When I build my kernel, I get two warnings. Could these be causing a
 problem?<br><br>WARNING: mm/built-in.o(.data+0x8ec): Section mismatch in reference from the variable contig_page_data to the variable .init.data:bootmem_node_data<br>The variable contig_page_data references<br>the variable __initdata bootmem_node_data<br>If the reference is valid then annotate the<br>variable with __init* (see linux/init.h) or name the variable:<br>*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,<br><br><br>&nbsp; MODPOST vmlinux.o<br>WARNING: vmlinux.o(.data+0xfe74): Section mismatch in reference from the variable contig_page_data to the variable .init.data:bootmem_node_data<br>The variable contig_page_data references<br>the variable __initdata bootmem_node_data<br>If the reference is valid then annotate the<br>variable with __init* (see linux/init.h) or name the variable:<br>*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,<br><br>thanks so much for your
 help.<br><br>LK<br><br><div style="font-family: arial,helvetica,sans-serif; font-size: 13px;">----- Original Message ----<br>From: David Jander &lt;david.jander@protonic.nl&gt;<br>To: linuxppc-embedded@ozlabs.org<br>Cc: Laxmikant Rashinkar &lt;lk.atwork@yahoo.com&gt;<br>Sent: Thursday, August 21, 2008 2:43:45 AM<br>Subject: Re: porting linux 2.6.27 to embedded powerpc board<br><br>
On Thursday 21 August 2008 01:24:46 Laxmikant Rashinkar wrote:<br>&gt; Hi,<br>&gt;<br>&gt; I have an embedded PowerPC (MPC8347) board that works fine with uboot and<br>&gt; Linux 2.6.15.<br>&gt;<br>&gt; I am trying to upgrade the kernel so that it runs on the latest release -<br>&gt; Linux 2.6.27. So far, I have gotten the kernel to compile on my platform,<br>&gt; but of course it does not boot.<br><br>Well, honestly I don't know where to look for information either (other than <br>the source-code and examples from others), but here is a list with points to <br>look out for (I have just done the same thing as you for a MPC5200B-based <br>board):<br><br>1. Upgrade to latest u-boot first (recent git seems to be fine). There have <br>been a lot of changes in u-boot lately about OF and device-tree related <br>things. I suspect you need a fairly recent version of u-boot to go well with <br>the latest kernel. It's also generally a good idea IMHO.<br><br>2. I
 assume you are porting to arch/powerpc (the old arch/ppc you used back in <br>2.6.15 is obsolete and broken now).<br><br>3. Look at other platforms that use the same processor, and pick a simple one <br>as starting point. Look out for the dts (device-tree-source file in <br>arch/powerpc/boot/dts), copy and modify one to reflect your hardware. <br>Recently a lot of changes happend in the kernel, changing device names, <br>obsoleting "device-type" tags, etc..., so some of the current DTS sources <br>included in the kernel might not even work (wrong device name, missing <br>information, wrong use of "device-type", etc...), so watch out for these kind <br>of issues too.<br><br>4. Be sure that the device(s) necessary to produce output on your console are <br>correctly placed in the DT. Also make sure that u-boot knows about it <br>(#define OF_STDOUT_PATH... in your u-boot board config file)<br><br>5. When compiling the device tree, it may be necessary to add
 some extra <br>reserved entries to the compiled tree (I am using dtc -p 10240 -R 20, which <br>might be slightly exaggerated), because u-boot may add something to it, and <br>if it can't, linux won't boot.<br><br>6. Remember to always specify the "rootfstype=" option on the commandline if <br>booting from anything other than NFS. This was not necessary back in the <br>2.6.15-times AFAICR.<br><br>7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb", <br>don't forget the dash if you are not using an initrd). If you don't do this, <br>u-boot can't fix your DT, and the kernel probably won't find it either.<br><br>8. Be sure to use the correct version of the DTC (DT compiler) for your kernel <br>(the sources are included nowadays, somewhere in arch/powerpc/boot IIRC). The <br>command used to compile, should probably be something like this:<br><br>$ ./dtc -p 10240 -R 20 -I dts -o myplatform.dtb -O dtb -b 0 dts/myplatform.dts<br><br>Load
 the resulting .dtb file directly with u-boot (don't make an u-image out <br>of it).<br><br>That's all I remember right now... hope it helps.<br><br>Regards,<br><br>-- <br>David Jander<br></div></div></div><br>

      </body></html>
--0-79516427-1219429580=:39935--
