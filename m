Return-Path: <ravi.rao@rflelect.com>
Received: from noteshub1.teal.com (mail.teal.com [67.155.213.211])
	by ozlabs.org (Postfix) with ESMTP id 6B50DDDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 02:28:02 +1000 (EST)
In-Reply-To: <20070822153626.C415873007B@mail29-sin.bigfish.com>
To: wolfgang.reissnegger@xilinx.com
Subject: Re: Kerenel crashes every other Boot..
MIME-Version: 1.0
Message-ID: <OFB91276BB.E4B3D063-ON8525733F.005977FC-8525733F.005A5BDF@rflelect.com>
From: ravi.rao@rflelect.com
Date: Wed, 22 Aug 2007 12:28:00 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 005A5BDD8525733F_="
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 005A5BDD8525733F_=
Content-Type: text/plain; charset="US-ASCII"

Hi Wolfgang,
     The image is getting loaded from the flash. I am able to hook up 
BDI2000 and dump various locations.
I dumped first few kilo byte locations of the image and looks no 
corruption.
I also tried this on another board and l see the same behaviour.

Also the board I am using is an existing product but it is running 2.4.18 
kernel.
Hardware of our next gen product will be based on the existing board but 
it will run 2.6.21 kernel.
So to speed software development I am using the existing product as the 
refernce and trying to put 2.6.21.

Other paculiar thing that I have seen is Once I reset the power to chasis 
or pull the card out and put it back in  it gets stuck at "Now booting the 
kernel" stage and upon hooking BDI2000 it looks like it hangs in 
early_init function at the call to memset_io(PTRRELOC(&__bss_start), 0, 
_end - __bss_start). Only way to get it back working is by burning a 2.4 
kernel rebooting the card and again burning the 2.6 one..Any idea what may 
be happening.....

The only difference i see in 2.4.x initial code and 2.6.x init code is the 
wired tlb setup in head_4xx.S. Do you know why the wired tlb setup code 
got removed from 2.6 ??

Thanks,
Ravishankar Govindarao
RFL Electronics Inc.
E-mail : Ravi.Rao@rflelect.com
Voice: 973.334.3100 Ext. 233
Fax: 973.334.3863
 
CONFIDENTIALITY NOTE
This e-mail, including any attachments, may contain confidential and/or 
legally privileged information.  The Information is intended only for the 
use of the individual or entity named on this e-mail .  If you are not the 
intended recipient, you are hereby notified that any disclosure, copying, 
distribution, or the taking of any action in reliance on the contents of 
this transmitted Information is strictly prohibited.  Further, if you are 
not the intended recipient, please notify us by return e-mail and delete 
the Information promptly.
 
 
 



Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> 
08/22/2007 11:36 AM

To
ravi.rao@rflelect.com
cc
linuxppc-embedded@ozlabs.org
Subject
Re: Kerenel crashes every other Boot..






Hi Ravi,

my first guess would be that there is a problem with your RAM. Could be
the RAM timing or just a bad RAM chip.

Try to run the image on another board, see if it works there. If not you
can check the RAM timing. Given that you have a custom board there could
be some design issues.

Where are you loading the image from? Maybe there is a problem in
transferring the image into RAM so the image download corrupts the data?

Cheers,
   Wolfgang

ravi.rao@rflelect.com wrote:
> 
> Hi,
>   Some times it crashes and many times it comes back with an error as
> Junk in compressed Image..
> Below is the screen dump..
> **************** When it does not work **************************
> BOOT MONITOR:
> .. eth driver not initialized. command aborted
> .. Invoking Linux PPC Kernel Loader at 0xfe800000
> .. Boot Parms: 0x3f72314, Flags: 0x1014, Verbose: 0x3
> 
> loaded at:     FE800000 FEA16124
> relocated to:  00400000 00616124
> board data at: 03F72314 03F72510
> relocated to:  00613000 006131FC
> zimage at:     00404EDC 0061289C
> avail ram:     00617000 04000000
> 
> Linux/PPC load: console=ttyS0,9600 ip=dhcp root=nfs
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.6.21 (root@localhost.localdomain) (gcc version 4.1.0
> 20060304 (TimeSys 4.1.0-3)) #27 Wed Aug 22 10:10:4
> 2 EDT 2007
> MAC 0: 00:50:cc:0c:e2:30
> MAC 1: 00:50:c2:0c:e2:31
> Zone PFN ranges:
>   DMA             0 ->    16384
>   Normal      16384 ->    16384
> early_node_map[1] active PFN ranges
>     0:        0 ->    16384
> Built 1 zonelists.  Total pages: 16256
> Kernel command line: console=ttyS0,9600 root=/dev/rd/0
> ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0
> PID hash table entries: 256 (order: 8, 1024 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 61952k available (1188k kernel code, 280k data, 1504k init, 0k
> highmem)
> Mount-cache hash table entries: 512
> Kernel panic - not syncing: junk in compressed archive
> Rebooting in 180 seconds..
> 
> ******************** When it works **************************
> BOOT MONITOR:
> .. eth driver not initialized. command aborted
> .. Invoking Linux PPC Kernel Loader at 0xfe800000
> .. Boot Parms: 0x3f72314, Flags: 0x1014, Verbose: 0x3
> 
> loaded at:     FE800000 FEA16124
> relocated to:  00400000 00616124
> board data at: 03F72314 03F72510
> relocated to:  00613000 006131FC
> zimage at:     00404EDC 0061289C
> avail ram:     00617000 04000000
> 
> Linux/PPC load: console=ttyS0,9600 ip=dhcp root=nfs
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.6.21 (root@localhost.localdomain) (gcc version 4.1.0
> 20060304 (TimeSys 4.1.0-3)) #27 Wed Aug 22 10:10:4
> 2 EDT 2007
> MAC 0: 00:50:cc:0c:e2:30
> MAC 1: 00:50:c2:0c:e2:31
> Zone PFN ranges:
>   DMA             0 ->    16384
>   Normal      16384 ->    16384
> early_node_map[1] active PFN ranges
>     0:        0 ->    16384
> Built 1 zonelists.  Total pages: 16256
> Kernel command line: console=ttyS0,9600 root=/dev/rd/0
> ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0
> PID hash table entries: 256 (order: 8, 1024 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 61952k available (1188k kernel code, 280k data, 1504k init, 0k
> highmem)
> Mount-cache hash table entries: 512
> JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
> serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
> RAMDISK driver initialized: 1 RAM disks of 16384K size 1024 blocksize
> loop: loaded (max 8 devices)
> i2c /dev entries driver
> IBM IIC driver v2.1
> ibm-iic0: using standard (100 kHz) mode
> Freeing unused kernel memory: 1504k init
> serial console detected.  Disabling virtual terminals.
> init started:  BusyBox v0.60.2 (2003.04.29-11:32+0000) multi-call binary
> Bummer, could not run '/etc/init.d/rcS': No such file or directory
> 
> Please press Enter to activate this console.
> sh-2.05#
> 
> Ravishankar Govindarao
> RFL Electronics Inc.
> E-mail : _Ravi.Rao@rflelect.com_ <mailto:Ravi.Rao@rflelect.com>
> Voice: 973.334.3100 Ext. 233
> Fax: 973.334.3863
> 
> 
> 
> 
> _CONFIDENTIALITY NOTE_
> 
> This e-mail, including any attachments, may contain confidential and/or
> legally privileged information.  The Information is intended only for
> the use of the individual or entity named on this e-mail .  If you are
> not the intended recipient, you are hereby notified that any disclosure,
> copying, distribution, or the taking of any action in reliance on the
> contents of this transmitted Information is strictly prohibited. 
> Further, if you are not the intended recipient, please notify us by
> return e-mail and delete the Information promptly.
> 
> 
> 
> 
> 
> 
> 
> 
> *Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>*
> 
> 08/22/2007 11:15 AM
> 
> 
> To
>                ravi.rao@rflelect.com
> cc
>                linuxppc-embedded@ozlabs.org
> Subject
>                Re: Kerenel crashes every other Boot..
> 
> 
> 
> 
> 
> 
> 
> 
> Hi Ravi,
> 
> you need to provide more information, for example, where does the kernel
> crash, any serial console output that you see when it crashes, etc.
> 
> Cheers,
>   Wolfgang
> 
> 
> ravi.rao@rflelect.com wrote:
>>
>> Hi All,
>>     I have a PPC 405EP custom target. I based most of my software on 
the
>> EP405 Taihu reference and now I am able to load the 2.6.21 kernel and
>> with a minimum initramfs I also get the busy box prompt. I see a 
strange
>> poblem it fails(linux crashes) every other boot. Can any one please 
tell
>> me what may be happening ???
>> Thanks,
>> Ravishankar Govindarao
>> RFL Electronics Inc.
>> E-mail : _Ravi.Rao@rflelect.com_ <mailto:Ravi.Rao@rflelect.com>
>> Voice: 973.334.3100 Ext. 233
>> Fax: 973.334.3863
>>
>> 
>>
>>
>> _CONFIDENTIALITY NOTE_
>>
>> This e-mail, including any attachments, may contain confidential and/or
>> legally privileged information.  The Information is intended only for
>> the use of the individual or entity named on this e-mail .  If you are
>> not the intended recipient, you are hereby notified that any 
disclosure,
>> copying, distribution, or the taking of any action in reliance on the
>> contents of this transmitted Information is strictly prohibited.
>> Further, if you are not the intended recipient, please notify us by
>> return e-mail and delete the Information promptly.
>>
>> 
>>
>> 
>>
>> 
>>
>>
>> 
------------------------------------------------------------------------
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 



--=_alternative 005A5BDD8525733F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi Wolfgang,</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp;The image is getting
loaded from the flash. I am able to hook up BDI2000 and dump various locations.</font>
<br><font size=2 face="sans-serif">I dumped first few kilo byte locations
of the image and looks no corruption.</font>
<br><font size=2 face="sans-serif">I also tried this on another board and
l see the same behaviour.</font>
<br>
<br><font size=2 face="sans-serif">Also the board I am using is an existing
product but it is running 2.4.18 kernel.</font>
<br><font size=2 face="sans-serif">Hardware of our next gen product will
be based on the existing board but it will run 2.6.21 kernel.</font>
<br><font size=2 face="sans-serif">So to speed software development I am
using the existing product as the refernce and trying to put 2.6.21.</font>
<br>
<br><font size=2 face="sans-serif">Other paculiar thing that I have seen
is Once I reset the power to chasis or pull the card out and put it back
in &nbsp;it gets stuck at &quot;Now booting the kernel&quot; stage and
upon hooking BDI2000 it looks like it hangs in early_init function at the
call </font><font size=2 face="Courier New"><b>to memset_io(PTRRELOC(&amp;__bss_start),
0, _end - __bss_start). Only way to get it back working is by burning a
2.4 kernel rebooting the card and again burning the 2.6 one..</b></font><font size=2 face="sans-serif">Any
idea what may be happening.....</font>
<br>
<br><font size=2 face="sans-serif">The only difference i see in 2.4.x initial
code and 2.6.x init code is the wired tlb setup in head_4xx.S. Do you know
why the wired tlb setup code got removed from 2.6 ??</font>
<br>
<br><font size=2 face="sans-serif">Thanks,<br>
</font><font size=2 face="Tms Rmn">Ravishankar Govindarao<br>
RFL Electronics Inc.<br>
E-mail</font><font size=1 face="Tms Rmn"> </font><font size=2 face="Tms Rmn">:
</font><a href=mailto:Ravi.Rao@rflelect.com><font size=2 color=blue face="Tms Rmn"><u>Ravi.Rao@rflelect.com</u></font></a>
<br><font size=2 face="Tms Rmn">Voice: 973.334.3100 Ext. 233<br>
Fax: 973.334.3863</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<div align=center>
<br><font size=2 color=blue face="Tms Rmn"><u>CONFIDENTIALITY NOTE</u></font></div>
<br><font size=1 face="Tms Rmn">This e-mail, including any attachments,
may contain confidential and/or legally privileged information.&nbsp; The
Information is intended only for the use of the individual or entity named
on this e-mail</font><font size=1 face="Tms Rmn"> </font><font size=1 face="Tms Rmn">.&nbsp;
If you are not the intended recipient, you are hereby notified that any
disclosure, copying, distribution, or the taking of any action in reliance
on the contents of this transmitted Information is strictly prohibited.&nbsp;
Further, if you are not the intended recipient, please notify us by return
e-mail and delete the Information promptly.</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=2 face="Tms Rmn">&nbsp;</font>
<p><font size=3>&nbsp;</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Wolfgang Reissnegger &lt;wolfgang.reissnegger@xilinx.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">08/22/2007 11:36 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">ravi.rao@rflelect.com</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">linuxppc-embedded@ozlabs.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: Kerenel crashes every other Boot..</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2><tt>Hi Ravi,<br>
<br>
my first guess would be that there is a problem with your RAM. Could be<br>
the RAM timing or just a bad RAM chip.<br>
<br>
Try to run the image on another board, see if it works there. If not you<br>
can check the RAM timing. Given that you have a custom board there could<br>
be some design issues.<br>
<br>
Where are you loading the image from? Maybe there is a problem in<br>
transferring the image into RAM so the image download corrupts the data?<br>
<br>
Cheers,<br>
 &nbsp; Wolfgang<br>
<br>
ravi.rao@rflelect.com wrote:<br>
&gt; <br>
&gt; Hi,<br>
&gt; &nbsp; Some times it crashes and many times it comes back with an
error as<br>
&gt; Junk in compressed Image..<br>
&gt; Below is the screen dump..<br>
&gt; **************** When it does not work **************************<br>
&gt; BOOT MONITOR:<br>
&gt; .. eth driver not initialized. command aborted<br>
&gt; .. Invoking Linux PPC Kernel Loader at 0xfe800000<br>
&gt; .. Boot Parms: 0x3f72314, Flags: 0x1014, Verbose: 0x3<br>
&gt; <br>
&gt; loaded at: &nbsp; &nbsp; FE800000 FEA16124<br>
&gt; relocated to: &nbsp;00400000 00616124<br>
&gt; board data at: 03F72314 03F72510<br>
&gt; relocated to: &nbsp;00613000 006131FC<br>
&gt; zimage at: &nbsp; &nbsp; 00404EDC 0061289C<br>
&gt; avail ram: &nbsp; &nbsp; 00617000 04000000<br>
&gt; <br>
&gt; Linux/PPC load: console=ttyS0,9600 ip=dhcp root=nfs<br>
&gt; Uncompressing Linux...done.<br>
&gt; Now booting the kernel<br>
&gt; Linux version 2.6.21 (root@localhost.localdomain) (gcc version 4.1.0<br>
&gt; 20060304 (TimeSys 4.1.0-3)) #27 Wed Aug 22 10:10:4<br>
&gt; 2 EDT 2007<br>
&gt; MAC 0: 00:50:cc:0c:e2:30<br>
&gt; MAC 1: 00:50:c2:0c:e2:31<br>
&gt; Zone PFN ranges:<br>
&gt; &nbsp; DMA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 -&gt; &nbsp;
&nbsp;16384<br>
&gt; &nbsp; Normal &nbsp; &nbsp; &nbsp;16384 -&gt; &nbsp; &nbsp;16384<br>
&gt; early_node_map[1] active PFN ranges<br>
&gt; &nbsp; &nbsp; 0: &nbsp; &nbsp; &nbsp; &nbsp;0 -&gt; &nbsp; &nbsp;16384<br>
&gt; Built 1 zonelists. &nbsp;Total pages: 16256<br>
&gt; Kernel command line: console=ttyS0,9600 root=/dev/rd/0<br>
&gt; ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0<br>
&gt; PID hash table entries: 256 (order: 8, 1024 bytes)<br>
&gt; Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
&gt; Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<br>
&gt; Memory: 61952k available (1188k kernel code, 280k data, 1504k init,
0k<br>
&gt; highmem)<br>
&gt; Mount-cache hash table entries: 512<br>
&gt; Kernel panic - not syncing: junk in compressed archive<br>
&gt; Rebooting in 180 seconds..<br>
&gt; <br>
&gt; ******************** When it works **************************<br>
&gt; BOOT MONITOR:<br>
&gt; .. eth driver not initialized. command aborted<br>
&gt; .. Invoking Linux PPC Kernel Loader at 0xfe800000<br>
&gt; .. Boot Parms: 0x3f72314, Flags: 0x1014, Verbose: 0x3<br>
&gt; <br>
&gt; loaded at: &nbsp; &nbsp; FE800000 FEA16124<br>
&gt; relocated to: &nbsp;00400000 00616124<br>
&gt; board data at: 03F72314 03F72510<br>
&gt; relocated to: &nbsp;00613000 006131FC<br>
&gt; zimage at: &nbsp; &nbsp; 00404EDC 0061289C<br>
&gt; avail ram: &nbsp; &nbsp; 00617000 04000000<br>
&gt; <br>
&gt; Linux/PPC load: console=ttyS0,9600 ip=dhcp root=nfs<br>
&gt; Uncompressing Linux...done.<br>
&gt; Now booting the kernel<br>
&gt; Linux version 2.6.21 (root@localhost.localdomain) (gcc version 4.1.0<br>
&gt; 20060304 (TimeSys 4.1.0-3)) #27 Wed Aug 22 10:10:4<br>
&gt; 2 EDT 2007<br>
&gt; MAC 0: 00:50:cc:0c:e2:30<br>
&gt; MAC 1: 00:50:c2:0c:e2:31<br>
&gt; Zone PFN ranges:<br>
&gt; &nbsp; DMA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 -&gt; &nbsp;
&nbsp;16384<br>
&gt; &nbsp; Normal &nbsp; &nbsp; &nbsp;16384 -&gt; &nbsp; &nbsp;16384<br>
&gt; early_node_map[1] active PFN ranges<br>
&gt; &nbsp; &nbsp; 0: &nbsp; &nbsp; &nbsp; &nbsp;0 -&gt; &nbsp; &nbsp;16384<br>
&gt; Built 1 zonelists. &nbsp;Total pages: 16256<br>
&gt; Kernel command line: console=ttyS0,9600 root=/dev/rd/0<br>
&gt; ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0<br>
&gt; PID hash table entries: 256 (order: 8, 1024 bytes)<br>
&gt; Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
&gt; Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<br>
&gt; Memory: 61952k available (1188k kernel code, 280k data, 1504k init,
0k<br>
&gt; highmem)<br>
&gt; Mount-cache hash table entries: 512<br>
&gt; JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.<br>
&gt; io scheduler noop registered<br>
&gt; io scheduler anticipatory registered<br>
&gt; io scheduler deadline registered<br>
&gt; io scheduler cfq registered (default)<br>
&gt; Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled<br>
&gt; serial8250: ttyS0 at MMIO 0x0 (irq = 0) is a 16550A<br>
&gt; serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A<br>
&gt; RAMDISK driver initialized: 1 RAM disks of 16384K size 1024 blocksize<br>
&gt; loop: loaded (max 8 devices)<br>
&gt; i2c /dev entries driver<br>
&gt; IBM IIC driver v2.1<br>
&gt; ibm-iic0: using standard (100 kHz) mode<br>
&gt; Freeing unused kernel memory: 1504k init<br>
&gt; serial console detected. &nbsp;Disabling virtual terminals.<br>
&gt; init started: &nbsp;BusyBox v0.60.2 (2003.04.29-11:32+0000) multi-call
binary<br>
&gt; Bummer, could not run '/etc/init.d/rcS': No such file or directory<br>
&gt; <br>
&gt; Please press Enter to activate this console.<br>
&gt; sh-2.05#<br>
&gt; <br>
&gt; Ravishankar Govindarao<br>
&gt; RFL Electronics Inc.<br>
&gt; E-mail : _Ravi.Rao@rflelect.com_ &lt;mailto:Ravi.Rao@rflelect.com&gt;<br>
&gt; Voice: 973.334.3100 Ext. 233<br>
&gt; Fax: 973.334.3863<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; <br>
&gt; <br>
&gt; _CONFIDENTIALITY NOTE_<br>
&gt; <br>
&gt; This e-mail, including any attachments, may contain confidential and/or<br>
&gt; legally privileged information. &nbsp;The Information is intended
only for<br>
&gt; the use of the individual or entity named on this e-mail . &nbsp;If
you are<br>
&gt; not the intended recipient, you are hereby notified that any disclosure,<br>
&gt; copying, distribution, or the taking of any action in reliance on
the<br>
&gt; contents of this transmitted Information is strictly prohibited. <br>
&gt; Further, if you are not the intended recipient, please notify us by<br>
&gt; return e-mail and delete the Information promptly.<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; <br>
&gt; &nbsp;<br>
&gt; <br>
&gt; <br>
&gt; *Wolfgang Reissnegger &lt;wolfgang.reissnegger@xilinx.com&gt;*<br>
&gt; <br>
&gt; 08/22/2007 11:15 AM<br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
&gt; To<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ravi.rao@rflelect.com<br>
&gt; cc<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;linuxppc-embedded@ozlabs.org<br>
&gt; Subject<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Re:
Kerenel crashes every other Boot..<br>
&gt; <br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Hi Ravi,<br>
&gt; <br>
&gt; you need to provide more information, for example, where does the
kernel<br>
&gt; crash, any serial console output that you see when it crashes, etc.<br>
&gt; <br>
&gt; Cheers,<br>
&gt; &nbsp; Wolfgang<br>
&gt; <br>
&gt; <br>
&gt; ravi.rao@rflelect.com wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi All,<br>
&gt;&gt; &nbsp; &nbsp; I have a PPC 405EP custom target. I based most of
my software on the<br>
&gt;&gt; EP405 Taihu reference and now I am able to load the 2.6.21 kernel
and<br>
&gt;&gt; with a minimum initramfs I also get the busy box prompt. I see
a strange<br>
&gt;&gt; poblem it fails(linux crashes) every other boot. Can any one please
tell<br>
&gt;&gt; me what may be happening ???<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Ravishankar Govindarao<br>
&gt;&gt; RFL Electronics Inc.<br>
&gt;&gt; E-mail : _Ravi.Rao@rflelect.com_ &lt;mailto:Ravi.Rao@rflelect.com&gt;<br>
&gt;&gt; Voice: 973.334.3100 Ext. 233<br>
&gt;&gt; Fax: 973.334.3863<br>
&gt;&gt;<br>
&gt;&gt; &nbsp;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _CONFIDENTIALITY NOTE_<br>
&gt;&gt;<br>
&gt;&gt; This e-mail, including any attachments, may contain confidential
and/or<br>
&gt;&gt; legally privileged information. &nbsp;The Information is intended
only for<br>
&gt;&gt; the use of the individual or entity named on this e-mail . &nbsp;If
you are<br>
&gt;&gt; not the intended recipient, you are hereby notified that any disclosure,<br>
&gt;&gt; copying, distribution, or the taking of any action in reliance
on the<br>
&gt;&gt; contents of this transmitted Information is strictly prohibited.<br>
&gt;&gt; Further, if you are not the intended recipient, please notify
us by<br>
&gt;&gt; return e-mail and delete the Information promptly.<br>
&gt;&gt;<br>
&gt;&gt; &nbsp;<br>
&gt;&gt;<br>
&gt;&gt; &nbsp;<br>
&gt;&gt;<br>
&gt;&gt; &nbsp;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------------------------------------------------<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Linuxppc-embedded mailing list<br>
&gt;&gt; Linuxppc-embedded@ozlabs.org<br>
&gt;&gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded<br>
&gt; <br>
&gt; <br>
<br>
</tt></font>
<br>
--=_alternative 005A5BDD8525733F_=--
