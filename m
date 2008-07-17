Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F31CFDE442
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 21:44:56 +1000 (EST)
Message-ID: <487F307C.50706@denx.de>
Date: Thu, 17 Jul 2008 13:43:56 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Alex_SYS <schmid-grafenau@t-online.de>
Subject: Re: Videomode 800x480
References: <18470632.post@talk.nabble.com>
	<487CEC85.2070801@denx.de>	<18482586.post@talk.nabble.com>
	<18502863.post@talk.nabble.com>
In-Reply-To: <18502863.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8
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

Alex_SYS wrote:
> 
> Alex_SYS wrote:
>> <Here is the Kernel Bootup message that it gives when it crashes!
>>
>> U-Boot 1.2.0-mpc5200b-tiny-3 (Dec 11 2007 - 11:25:01)
>>
>> CPU:   MPC5200 v2.2, Core v1.4 at 399.999 MHz
>>        Bus 133 MHz, IPB 133 MHz, PCI 33 MHz
>> Board: phyCORE-MPC5200B-tiny
>> I2C:   ready
>> DRAM:  64 MB
>> SP:    0x03f73768
>> FLASH: 16 MB
>> Using pcm030 machine description
>> Linux version 2.6.23.1-rt5-pcm030-1trunk (aschmid@LINUX) (gcc version
>> 4.1.2) #39
>> 4 PREEMPT RT Tue Dec 11 17:58:48 CET 2007
>> Zone PFN ranges:
>>   DMA             0 ->    16384
>>   Normal      16384 ->    16384
>> Movable zone start PFN for each node
>> early_node_map[1] active PFN ranges
>>     0:        0 ->    16384
>> Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
>> Built 1 zonelists in Zone order.  Total pages: 16256
>> Kernel command line: video=0x0-16@60 , console=ttyPSC0,115200
----------------------------->^^^^^^^^^
is this intentional?

>> mtdparts=physmap-f
>> lash.0:256k(ubootl),1792k(kernel),13312k(jffs2),256k(uboot)ro,256k(oftree),-(spa
>> ce) rw root=/dev/mtdblock2 rootfstype=jffs2
>> WARNING: experimental RCU implementation.
>> MPC52xx PIC is up and running!
>> PID hash table entries: 256 (order: 8, 1024 bytes)
>> Console: colour dummy device 80x25
>> console [ttyPSC0] enabled
>> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
>> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
>> Memory: 61960k/65536k available (2624k kernel code, 3508k reserved, 144k
>> data, 1
>> 06k bss, 124k init)
>> Mount-cache hash table entries: 512
>> NET: Registered protocol family 16
>> PCI: Probing PCI hardware
>> DMA: MPC52xx BestComm driver
>> DMA: MPC52xx BestComm engine @f0001200 ok !
>> Generic PHY: Registered new driver
>> usbcore: registered new interface driver usbfs
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> NET: Registered protocol family 2
>> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>> TCP established hash table entries: 2048 (order: 4, 73728 bytes)
>> TCP bind hash table entries: 2048 (order: 3, 57344 bytes)
>> TCP: Hash tables configured (established 2048 bind 2048)
>> TCP reno registered
>> JFFS2 version 2.2. (NAND) Â© 2001-2006 Red Hat, Inc.
>> io scheduler noop registered (default)
>> No Options from U-Boot
>> Lime Driver PROBE
>> No Mode
>> Name des Strings 0x0-16@60 with LÃ¤nge 9
>> Schleife mode Options
>> Schleife @
>> Schleife -
>> Schleife x
>> DONE vor CVT xres= 0 , yres=0 , cvt=
>> 0******************************************
>> ************CVT Mode: Trying specified video mode 0x0
>> Trying mode 800x480-16@60 800x600-16@20
>> Error=
>> 0********************************************************************Tryi
>> ng mode noname 640x400-16@70
>> Error=
>> 0********************************************************************Tryi
>> ng mode noname 640x480-16@60
>> Error=
>> 0********************************************************************Tryi
>> ng mode noname 800x600-16@56

What arguments do you pass to fb_find_mode() in the driver? Probing all of
these modes is not necessary.
 
<snip>
>> Error=
>> 0********************************************************************Tryi
>> ng default video mode
>> Trying mode noname 800x480-16@60
>> Error=
>> 0********************************************************************Tryi
>> ng default mode
>> Console: switching to colour frame buffer device 114x34
>> stopped custom tracer.
>> Oops: Exception in kernel mode, sig: 4 [#1]
>> PREEMPT pcm030
>> Modules linked in:
>> NIP: 00000900 LR: c011d94c CTR: c011daf4
>> REGS: c3fe7a30 TRAP: 0700   Not tainted  (2.6.23.1-rt5-pcm030-1trunk)
>> MSR: 00081000 <ME>  CR: 42042022  XER: 00000000
>> TASK = c3fe5c00[1] 'swapper' THREAD: c3fe6000
>> GPR00: ffffffff c3fe7ae0 c3fe5c00 c5128bfc 00000000 00010001 00000020
>> 00000020
>> GPR08: 00000000 00010001 ffffffff 00000020 c3f5f800 fffffffb 03fcb000
>> ffffffff
>> GPR16: 00000001 00000000 c3fe7f78 c024a748 00000000 00000000 00000002
>> 000001e0
>> GPR24: 00010001 c011daf4 00000020 c3f5f800 c5128bfc 00000000 00000005
>> 000001b0
>> NIP [00000900] 0x900

Could you post your current vfb.c and .config file?

Best Regards,
Anatolij
