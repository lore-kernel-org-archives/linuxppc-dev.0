Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BCC29DDEDD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 06:37:37 +1000 (EST)
Date: Wed, 22 Aug 2007 13:40:15 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: ravi.rao@rflelect.com
Subject: Re: Kerenel crashes every other Boot..
References: <OFB91276BB.E4B3D063-ON8525733F.005977FC-8525733F.005A5BDF@teal.com>
In-Reply-To: <OFB91276BB.E4B3D063-ON8525733F.005977FC-8525733F.005A5BDF@teal.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20070822203734.82ED868051@mail82-cpk.bigfish.com>
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

Hi Ravi,

I think dumping only the first couple kilbytes is not enough to be sure.
Even a single byte later on can corrupt the image. You need to make sure
that the complete image is correct.

I don't know about the TLB setup changes.

Wolfgang

ravi.rao@rflelect.com wrote:
> 
> Hi Wolfgang, The image is getting loaded from the flash. I am able to
> hook up BDI2000 and dump various locations. I dumped first few kilo
> byte locations of the image and looks no corruption. I also tried
> this on another board and l see the same behaviour.
> 
> Also the board I am using is an existing product but it is running 
> 2.4.18 kernel. Hardware of our next gen product will be based on the
> existing board but it will run 2.6.21 kernel. So to speed software
> development I am using the existing product as the refernce and
> trying to put 2.6.21.
> 
> Other paculiar thing that I have seen is Once I reset the power to 
> chasis or pull the card out and put it back in  it gets stuck at "Now
>  booting the kernel" stage and upon hooking BDI2000 it looks like it 
> hangs in early_init function at the call *to 
> memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start). Only way to
>  get it back working is by burning a 2.4 kernel rebooting the card
> and again burning the 2.6 one..*Any idea what may be happening.....
> 
> The only difference i see in 2.4.x initial code and 2.6.x init code
> is the wired tlb setup in head_4xx.S. Do you know why the wired tlb
> setup code got removed from 2.6 ??
> 
> Thanks, Ravishankar Govindarao RFL Electronics Inc. E-mail :
> _Ravi.Rao@rflelect.com_ <mailto:Ravi.Rao@rflelect.com> Voice:
> 973.334.3100 Ext. 233 Fax: 973.334.3863
> 
> 
> 
> 
> _CONFIDENTIALITY NOTE_
> 
> This e-mail, including any attachments, may contain confidential
> and/or legally privileged information.  The Information is intended
> only for the use of the individual or entity named on this e-mail .
> If you are not the intended recipient, you are hereby notified that
> any disclosure, copying, distribution, or the taking of any action in
> reliance on the contents of this transmitted Information is strictly
> prohibited. Further, if you are not the intended recipient, please
> notify us by return e-mail and delete the Information promptly.
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
> 08/22/2007 11:36 AM
> 
>  To ravi.rao@rflelect.com cc linuxppc-embedded@ozlabs.org Subject Re:
> Kerenel crashes every other Boot..
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
> my first guess would be that there is a problem with your RAM. Could
> be the RAM timing or just a bad RAM chip.
> 
> Try to run the image on another board, see if it works there. If not
> you can check the RAM timing. Given that you have a custom board
> there could be some design issues.
> 
> Where are you loading the image from? Maybe there is a problem in 
> transferring the image into RAM so the image download corrupts the
> data?
> 
> Cheers, Wolfgang
> 
> ravi.rao@rflelect.com wrote:
>> 
>> Hi, Some times it crashes and many times it comes back with an
>> error as Junk in compressed Image.. Below is the screen dump.. 
>> **************** When it does not work ************************** 
>> BOOT MONITOR: .. eth driver not initialized. command aborted ..
>> Invoking Linux PPC Kernel Loader at 0xfe800000 .. Boot Parms:
>> 0x3f72314, Flags: 0x1014, Verbose: 0x3
>> 
>> loaded at:     FE800000 FEA16124 relocated to:  00400000 00616124 
>> board data at: 03F72314 03F72510 relocated to:  00613000 006131FC 
>> zimage at:     00404EDC 0061289C avail ram:     00617000 04000000
>> 
>> Linux/PPC load: console=ttyS0,9600 ip=dhcp root=nfs Uncompressing
>> Linux...done. Now booting the kernel Linux version 2.6.21
>> (root@localhost.localdomain) (gcc version 4.1.0 20060304 (TimeSys
>> 4.1.0-3)) #27 Wed Aug 22 10:10:4 2 EDT 2007 MAC 0:
>> 00:50:cc:0c:e2:30 MAC 1: 00:50:c2:0c:e2:31 Zone PFN ranges: DMA
>> 0 ->    16384 Normal      16384 ->    16384 early_node_map[1]
>> active PFN ranges 0:        0 ->    16384 Built 1 zonelists.  Total
>> pages: 16256 Kernel command line: console=ttyS0,9600 root=/dev/rd/0
>>  ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0 PID hash
>> table entries: 256 (order: 8, 1024 bytes) Dentry cache hash table
>> entries: 8192 (order: 3, 32768 bytes) Inode-cache hash table
>> entries: 4096 (order: 2, 16384 bytes) Memory: 61952k available
>> (1188k kernel code, 280k data, 1504k init, 0k highmem) Mount-cache
>> hash table entries: 512 Kernel panic - not syncing: junk in
>> compressed archive Rebooting in 180 seconds..
>> 
>> ******************** When it works ************************** BOOT
>> MONITOR: .. eth driver not initialized. command aborted .. Invoking
>> Linux PPC Kernel Loader at 0xfe800000 .. Boot Parms: 0x3f72314,
>> Flags: 0x1014, Verbose: 0x3
>> 
>> loaded at:     FE800000 FEA16124 relocated to:  00400000 00616124 
>> board data at: 03F72314 03F72510 relocated to:  00613000 006131FC 
>> zimage at:     00404EDC 0061289C avail ram:     00617000 04000000
>> 
>> Linux/PPC load: console=ttyS0,9600 ip=dhcp root=nfs Uncompressing
>> Linux...done. Now booting the kernel Linux version 2.6.21
>> (root@localhost.localdomain) (gcc version 4.1.0 20060304 (TimeSys
>> 4.1.0-3)) #27 Wed Aug 22 10:10:4 2 EDT 2007 MAC 0:
>> 00:50:cc:0c:e2:30 MAC 1: 00:50:c2:0c:e2:31 Zone PFN ranges: DMA
>> 0 ->    16384 Normal      16384 ->    16384 early_node_map[1]
>> active PFN ranges 0:        0 ->    16384 Built 1 zonelists.  Total
>> pages: 16256 Kernel command line: console=ttyS0,9600 root=/dev/rd/0
>>  ip=10.2.254.33:10.2.1.1:10.2.0.1:255.255.0.0:unknown:eth0 PID hash
>> table entries: 256 (order: 8, 1024 bytes) Dentry cache hash table
>> entries: 8192 (order: 3, 32768 bytes) Inode-cache hash table
>> entries: 4096 (order: 2, 16384 bytes) Memory: 61952k available
>> (1188k kernel code, 280k data, 1504k init, 0k highmem) Mount-cache
>> hash table entries: 512 JFFS2 version 2.2. (NAND) (C) 2001-2006 Red
>> Hat, Inc. io scheduler noop registered io scheduler anticipatory
>> registered io scheduler deadline registered io scheduler cfq
>> registered (default) Serial: 8250/16550 driver $Revision: 1.90 $ 4
>> ports, IRQ sharing enabled serial8250: ttyS0 at MMIO 0x0 (irq = 0)
>> is a 16550A serial8250: ttyS1 at MMIO 0x0 (irq = 1) is a 16550A 
>> RAMDISK driver initialized: 1 RAM disks of 16384K size 1024
>> blocksize loop: loaded (max 8 devices) i2c /dev entries driver IBM
>> IIC driver v2.1 ibm-iic0: using standard (100 kHz) mode Freeing
>> unused kernel memory: 1504k init serial console detected.
>> Disabling virtual terminals. init started:  BusyBox v0.60.2
>> (2003.04.29-11:32+0000) multi-call binary Bummer, could not run
>> '/etc/init.d/rcS': No such file or directory
>> 
>> Please press Enter to activate this console. sh-2.05#
>> 
>> Ravishankar Govindarao RFL Electronics Inc. E-mail :
>> _Ravi.Rao@rflelect.com_ <mailto:Ravi.Rao@rflelect.com> Voice:
>> 973.334.3100 Ext. 233 Fax: 973.334.3863
>> 
>> 
>> 
>> 
>> _CONFIDENTIALITY NOTE_
>> 
>> This e-mail, including any attachments, may contain confidential
>> and/or legally privileged information.  The Information is intended
>> only for the use of the individual or entity named on this e-mail .
>> If you are not the intended recipient, you are hereby notified that
>> any disclosure, copying, distribution, or the taking of any action
>> in reliance on the contents of this transmitted Information is
>> strictly prohibited. Further, if you are not the intended
>> recipient, please notify us by return e-mail and delete the
>> Information promptly.
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> *Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>*
>> 
>> 08/22/2007 11:15 AM
>> 
>> 
>> To ravi.rao@rflelect.com cc linuxppc-embedded@ozlabs.org Subject 
>> Re: Kerenel crashes every other Boot..
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> Hi Ravi,
>> 
>> you need to provide more information, for example, where does the
>> kernel crash, any serial console output that you see when it
>> crashes, etc.
>> 
>> Cheers, Wolfgang
>> 
>> 
>> ravi.rao@rflelect.com wrote:
>>> 
>>> Hi All, I have a PPC 405EP custom target. I based most of my
>>> software on the EP405 Taihu reference and now I am able to load
>>> the 2.6.21 kernel and with a minimum initramfs I also get the
>>> busy box prompt. I see a strange poblem it fails(linux crashes)
>>> every other boot. Can any one please tell me what may be
>>> happening ??? Thanks, Ravishankar Govindarao RFL Electronics Inc.
>>>  E-mail : _Ravi.Rao@rflelect.com_ <mailto:Ravi.Rao@rflelect.com> 
>>> Voice: 973.334.3100 Ext. 233 Fax: 973.334.3863
>>> 
>>> 
>>> 
>>> 
>>> _CONFIDENTIALITY NOTE_
>>> 
>>> This e-mail, including any attachments, may contain confidential
>>> and/or legally privileged information.  The Information is
>>> intended only for the use of the individual or entity named on
>>> this e-mail .  If you are not the intended recipient, you are
>>> hereby notified that any disclosure, copying, distribution, or
>>> the taking of any action in reliance on the contents of this
>>> transmitted Information is strictly prohibited. Further, if you
>>> are not the intended recipient, please notify us by return e-mail
>>> and delete the Information promptly.
>>> 
>>> 
>>> 
>>> 
>>> 
>>> 
>>> 
>>> 
>>> ------------------------------------------------------------------------
>>> 
>>> 
>>> _______________________________________________ Linuxppc-embedded
>>> mailing list Linuxppc-embedded@ozlabs.org 
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> 
>> 
> 
> 
