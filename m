Return-Path: <bhupi.saharan@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 8FE36DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jul 2007 07:14:02 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so712328pyi
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 14:14:01 -0700 (PDT)
Message-ID: <720399a30707181414ube73186n3902f818044bb66a@mail.gmail.com>
Date: Wed, 18 Jul 2007 14:14:00 -0700
From: "Bhupender Saharan" <bhupi.saharan@gmail.com>
To: "Boris Shteinbock" <borish@batm.co.il>
Subject: Re: Memory Corruption in Linux kernel MPC8347 revision 3
In-Reply-To: <1184683343.3337.57.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_94533_3985985.1184793240607"
References: <AcfIgK+rTnCvhttDQ1uQT0I4x0J72Q==>
	<1184683343.3337.57.camel@localhost.localdomain>
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

------=_Part_94533_3985985.1184793240607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Boris,

When you are running the memory test make sure Data cahe and Instruction
caches are enabled.

Also check your BAT setting, there also Cache enable BIT shall be set.

As the burst transcation will happen only when cache is enabled.

How abt ECC...?

Bhupi



On 7/17/07, Boris Shteinbock <borish@batm.co.il> wrote:
>
>          Hi Everyone.
> I am working on the Linux port for MPC8347 revision 3 custom build board
> with DDR2 memory.
>
> I've successfully ported U-boot (latest git) and the kernel itself,
> however during kernel boot I am encountering serious memory corruption
> errors. The log for one of the examples is at the bottom of this
> message.
>
> Basically, the corruption is always happening somewhere at memory
> management intensive tasks such as networking, JFFS2 mounting etc.
>
> As far as I can see, it is not related to some specific driver, because
> even it happens even at kernel configured at absolute minimum, ( console
> serial driver only and even without it)
> The place of the corruption depends on kernel configuration.
>
> The DDR2 memory controller is configured correctly as far as I can tell,
> since :
> 1. DDR2 controller register values are taken from VxWorks bootrom
> that works on this board without any problems.
> 2. u-boot mtest passes successfully
> 3. u-boot alternative mtest passes successfully
> 4. My own custom mem tests in u-boot pass successfully
> 5. If I manage two boot the board into shell prompt (with absolute
> minimum configuration) memtester application is also successful.
>
> The minimum configuration that is one I am able to boot into shell is a
> kernel configured with serial console and small busybox JFFS2 file
> system in the flash. In this configuration, the boot fails the first
> time JFFS2 root FS is mounted. However it does boot after reset.
>
> I've tried different kernels with the same results  starting from, I
> think, 2.6.16  up to 2.6.22
> I tried the kernel that is provided by Freescale for 834x reference
> boards. ( with my board support of course)
>
> I tried booting both OF flat trees (powerpc) and bd_t based builds (ppc)
>
> I've also tried all memory management options :
> SLAB, SLOB and SLUB (in the latest kernel). They all failed at some
> point of time, so the assumption is that the problem is not in the
> memory management facilities.
>
> The board manufacturer swears that DDR2 memory controller values are
> correct and should work perfectly.
>
> So now I almost out of options and I am seeking your help.
> Any type of input on this issue would be greatly appreciated.
>
> Thanks,
> Boris
>
> PS. Note that an below example represents failure during DHCP
> autoconfiguration. However the similar error happens even when
> networking is disabled completely. just in a different place.
>
> => bootm
> ## Booting image at 00400000 ...
>    Image Name:   Linux-.6.21.5
>    Created:      2007-07-10  14:20:19 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    898361 Bytes = 877.3 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Current stack ends at 0x07FA3CF8 => set upper limit to 0x00800000
> ## cmdline at 0x007FFF00 ... 0x007FFF41
> bd address  = 0x07FA3FBC
> memstart    = 0x00000000
> memsize     = 0x08000000
> flashstart  = 0xFE000000
> flashsize   = 0x02000000
> flashoffset = 0x00033000
> sramstart   = 0x00000000
> sramsize    = 0x00000000
> bootflags   = 0x00000001
> intfreq     =    528 MHz
> busfreq     =    264 MHz
> ethaddr     = 00:04:9F:EF:23:35
> eth1addr    = 00:E0:0C:00:7E:25
> IP addr     = 10.2.222.20
> baudrate    = 115200 bps
> No initrd
> ## Transferring control to Linux (at address 00000000) ...
> !!!! of_flat_tree = 00000000
> Booting without OF Flat tree
> Linux version .6.21.5 (me@localhost) (gcc version
> 4.0.0 (DENX ELDK 4.1 4.0.0)) #24 Tue Jul 10 17:20:09 IDT 2007
> Zone PFN ranges:
>   DMA             0 ->    32768
>   Normal      32768 ->    32768
> early_node_map[1] active PFN ranges
>     0:        0 ->    32768
> Built 1 zonelists.  Total pages: 32512
> Kernel command line: console=ttyS0,115200 root=/dev/mtdblock1
> rootfstype=jffs2 ip=dhcp
> IPIC (128 IRQ sources, 8 External IRQs) at fe000700
> PID hash table entries: 512 (order: 9, 2048 bytes)
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 127744k available (1584k kernel code, 444k data, 84k init, 0k
> highmem)
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> Setup MTD partitions
> Generic PHY: Registered new driver
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP reno registered
> JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing
> disabled
> serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 9) is a 16550A
> serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 10) is a 16550A
> Gianfar MII Bus: probed
> eth0: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ef:23:35
> eth0: Running with NAPI disabled
> eth0: 64/64 RX/TX BD ring size
> Broadcom BCM5241: Registered new driver
> physmap platform flash device: 02000000 at fe000000
> physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> physmap-flash.0: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> cmdlinepart partition parsing not available
> RedBoot partition parsing not available
> Using physmap partition information
> Creating 2 MTD partitions on "physmap-flash.0":
> 0x00000000-0x00100000 : "uboot"
> 0x00100000-0x02000000 : "rootfs"
> IPv4 over IPv4 tunneling driver
> GRE over IPv4 tunneling driver
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> !!!! Gianfar init_phy. phy_id = 0:01
> !!!! phy_attach. phy_id = 0:01
> !!!! phy_attach device found. phy_id = 0:01
> Sending DHCP requests .<3>slab: Internal list corruption detected in
> cache 'files_cache'(21), slabp c0344000(16). Hexdump:
>
> 000: 00 10 01 00 00 20 02 00 00 00 00 70 c0 34 40 70
> 010: 00 00 00 10 00 00 ff 10 00 00 00 00 ff ff ff fe
> 020: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe
> 030: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe
> 040: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe
> 050: ff ff ff fe ff ff ff fe ff ff ff fd 00 00 00 11
> 060: 00 00 00 12 00 00 00 13 00 00 00 14 ff ff ff ff
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:2936!
> Oops: Exception in kernel mode, sig: 5 [#1]
> NIP: C0050F80 LR: C0050F80 CTR: 00000000
> REGS: c034fe00 TRAP: 0700   Not tainted  (.6.21.5)
> MSR: 00021032 <ME,IR,DR>  CR: 24004002  XER: 00000000
> TASK = c032a3c0[3] 'events/0' THREAD: c034e000
> GPR00: C0050F80 C034FEB0 C032A3C0 00000001 00000DF5 FFFFFFFF C00F5B54
> 00000010
> GPR08: C01D0000 C01E0000 00000DF5 00000DF5 00000000 00F1C5DB 07FFD000
> FFFFFFFF
> GPR16: 00000001 00000000 00000000 00800000 00000000 007FFF00 00000000
> C033DAA0
> GPR24: C0339C90 00000007 00000000 C01B0000 C01B0000 C0344000 C033DAA0
> 00000070
> NIP [C0050F80] check_slabp+0xe4/0x11c
> LR [C0050F80] check_slabp+0xe4/0x11c
> Call Trace:
> [C034FEB0] [C0050F80] check_slabp+0xe4/0x11c (unreliable)
> [C034FED0] [C0051450] free_block+0x88/0x138
> [C034FF00] [C0052188] drain_array+0xa0/0xe0
> [C034FF20] [C0052228] cache_reap+0x60/0x144
> [C034FF40] [C00257B0] run_workqueue+0xd0/0x170
> [C034FF60] [C0025960] worker_thread+0x110/0x144
> [C034FFC0] [C00298E4] kthread+0x74/0xb0
> [C034FFF0] [C0005F38] kernel_thread+0x44/0x60
> Instruction dump:
> 387b6538 7c9df8ae 4bfc2b49 3bff0001 813e0020 5529103a 3929001c 7f9f4840
> 419cffcc 3c60c01b 3863336c 4bfc2b25 <0fe00000> 48000000 80030020
> 2f800000
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_94533_3985985.1184793240607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Boris,<br><br>When you are running the memory test make sure Data cahe and Instruction caches are enabled. <br><br>Also check your BAT setting, there also Cache enable BIT shall be set.<br><br>As the burst transcation will happen only when cache is enabled.
<br><br>How abt ECC...?<br><br>Bhupi<br><br><br><br><div><span class="gmail_quote">On 7/17/07, <b class="gmail_sendername">Boris Shteinbock</b> &lt;<a href="mailto:borish@batm.co.il">borish@batm.co.il</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">






<div>


<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font size="2">Hi Everyone.<br>
I am working on the Linux port for MPC8347 revision 3 custom build board<br>
with DDR2 memory.<br>
<br>
I&#39;ve successfully ported U-boot (latest git) and the kernel itself,<br>
however during kernel boot I am encountering serious memory corruption<br>
errors. The log for one of the examples is at the bottom of this<br>
message.<br>
<br>
Basically, the corruption is always happening somewhere at memory<br>
management intensive tasks such as networking, JFFS2 mounting etc.<br>
<br>
As far as I can see, it is not related to some specific driver, because<br>
even it happens even at kernel configured at absolute minimum, ( console<br>
serial driver only and even without it)<br>
The place of the corruption depends on kernel configuration.<br>
<br>
The DDR2 memory controller is configured correctly as far as I can tell,<br>
since :<br>
1. DDR2 controller register values are taken from VxWorks bootrom<br>
that works on this board without any problems.<br>
2. u-boot mtest passes successfully<br>
3. u-boot alternative mtest passes successfully<br>
4. My own custom mem tests in u-boot pass successfully<br>
5. If I manage two boot the board into shell prompt (with absolute<br>
minimum configuration) memtester application is also successful.<br>
<br>
The minimum configuration that is one I am able to boot into shell is a<br>
kernel configured with serial console and small busybox JFFS2 file<br>
system in the flash. In this configuration, the boot fails the first<br>
time JFFS2 root FS is mounted. However it does boot after reset.<br>
<br>
I&#39;ve tried different kernels with the same results&nbsp; starting from, I<br>
think, 2.6.16&nbsp; up to 2.6.22<br>
I tried the kernel that is provided by Freescale for 834x reference<br>
boards. ( with my board support of course)<br>
<br>
I tried booting both OF flat trees (powerpc) and bd_t based builds (ppc)<br>
<br>
I&#39;ve also tried all memory management options :<br>
SLAB, SLOB and SLUB (in the latest kernel). They all failed at some<br>
point of time, so the assumption is that the problem is not in the<br>
memory management facilities.<br>
<br>
The board manufacturer swears that DDR2 memory controller values are<br>
correct and should work perfectly.<br>
<br>
So now I almost out of options and I am seeking your help.<br>
Any type of input on this issue would be greatly appreciated.<br>
<br>
Thanks,<br>
Boris<br>
<br>
PS. Note that an below example represents failure during DHCP<br>
autoconfiguration. However the similar error happens even when<br>
networking is disabled completely. just in a different place.<br>
<br>
=&gt; bootm<br>
## Booting image at 00400000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-.6.21.5<br>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2007-07-10&nbsp; 14:20:19 UTC<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 898361 Bytes = 877.3 kB<br>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>
## Current stack ends at 0x07FA3CF8 =&gt; set upper limit to 0x00800000<br>
## cmdline at 0x007FFF00 ... 0x007FFF41<br>
bd address&nbsp; = 0x07FA3FBC<br>
memstart&nbsp;&nbsp;&nbsp; = 0x00000000<br>
memsize&nbsp;&nbsp;&nbsp;&nbsp; = 0x08000000<br>
flashstart&nbsp; = 0xFE000000<br>
flashsize&nbsp;&nbsp; = 0x02000000<br>
flashoffset = 0x00033000<br>
sramstart&nbsp;&nbsp; = 0x00000000<br>
sramsize&nbsp;&nbsp;&nbsp; = 0x00000000<br>
bootflags&nbsp;&nbsp; = 0x00000001<br>
intfreq&nbsp;&nbsp;&nbsp;&nbsp; =&nbsp;&nbsp;&nbsp; 528 MHz<br>
busfreq&nbsp;&nbsp;&nbsp;&nbsp; =&nbsp;&nbsp;&nbsp; 264 MHz<br>
ethaddr&nbsp;&nbsp;&nbsp;&nbsp; = 00:04:9F:EF:23:35<br>
eth1addr&nbsp;&nbsp;&nbsp; = 00:E0:0C:00:7E:25<br>
IP addr&nbsp;&nbsp;&nbsp;&nbsp; = <a href="http://10.2.222.20" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">10.2.222.20</a><br>
baudrate&nbsp;&nbsp;&nbsp; = 115200 bps<br>
No initrd<br>
## Transferring control to Linux (at address 00000000) ...<br>
!!!! of_flat_tree = 00000000<br>
Booting without OF Flat tree<br>
Linux version .6.21.5 (me@localhost) (gcc version<br>
4.0.0 (DENX ELDK 4.1 4.0.0)) #24 Tue Jul 10 17:20:09 IDT 2007<br>
Zone PFN ranges:<br>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>
&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>
early_node_map[1] active PFN ranges<br>
&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<br>
Built 1 zonelists.&nbsp; Total pages: 32512<br>
Kernel command line: console=ttyS0,115200 root=/dev/mtdblock1<br>
rootfstype=jffs2 ip=dhcp<br>
IPIC (128 IRQ sources, 8 External IRQs) at fe000700<br>
PID hash table entries: 512 (order: 9, 2048 bytes)<br>
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
Memory: 127744k available (1584k kernel code, 444k data, 84k init, 0k<br>
highmem)<br>
Mount-cache hash table entries: 512<br>
NET: Registered protocol family 16<br>
Setup MTD partitions<br>
Generic PHY: Registered new driver<br>
NET: Registered protocol family 2<br>
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<br>
TCP established hash table entries: 4096 (order: 3, 32768 bytes)<br>
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)<br>
TCP: Hash tables configured (established 4096 bind 4096)<br>
TCP reno registered<br>
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.<br>
io scheduler noop registered<br>
io scheduler anticipatory registered (default)<br>
io scheduler deadline registered<br>
io scheduler cfq registered<br>
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing<br>
disabled<br>
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 9) is a 16550A<br>
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 10) is a 16550A<br>
Gianfar MII Bus: probed<br>
eth0: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ef:23:35<br>
eth0: Running with NAPI disabled<br>
eth0: 64/64 RX/TX BD ring size<br>
Broadcom BCM5241: Registered new driver<br>
physmap platform flash device: 02000000 at fe000000<br>
physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank<br>
&nbsp;Amd/Fujitsu Extended Query Table at 0x0040<br>
physmap-flash.0: CFI does not contain boot bank location. Assuming top.<br>
number of CFI chips: 1<br>
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.<br>
cmdlinepart partition parsing not available<br>
RedBoot partition parsing not available<br>
Using physmap partition information<br>
Creating 2 MTD partitions on &quot;physmap-flash.0&quot;:<br>
0x00000000-0x00100000 : &quot;uboot&quot;<br>
0x00100000-0x02000000 : &quot;rootfs&quot;<br>
IPv4 over IPv4 tunneling driver<br>
GRE over IPv4 tunneling driver<br>
TCP cubic registered<br>
NET: Registered protocol family 1<br>
NET: Registered protocol family 17<br>
!!!! Gianfar init_phy. phy_id = 0:01<br>
!!!! phy_attach. phy_id = 0:01<br>
!!!! phy_attach device found. phy_id = 0:01<br>
Sending DHCP requests .&lt;3&gt;slab: Internal list corruption detected in<br>
cache &#39;files_cache&#39;(21), slabp c0344000(16). Hexdump:<br>
<br>
000: 00 10 01 00 00 20 02 00 00 00 00 70 c0 34 40 70<br>
010: 00 00 00 10 00 00 ff 10 00 00 00 00 ff ff ff fe<br>
020: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe<br>
030: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe<br>
040: ff ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe<br>
050: ff ff ff fe ff ff ff fe ff ff ff fd 00 00 00 11<br>
060: 00 00 00 12 00 00 00 13 00 00 00 14 ff ff ff ff<br>
------------[ cut here ]------------<br>
kernel BUG at mm/slab.c:2936!<br>
Oops: Exception in kernel mode, sig: 5 [#1]<br>
NIP: C0050F80 LR: C0050F80 CTR: 00000000<br>
REGS: c034fe00 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp; (.6.21.5)<br>
MSR: 00021032 &lt;ME,IR,DR&gt;&nbsp; CR: 24004002&nbsp; XER: 00000000<br>
TASK = c032a3c0[3] &#39;events/0&#39; THREAD: c034e000<br>
GPR00: C0050F80 C034FEB0 C032A3C0 00000001 00000DF5 FFFFFFFF C00F5B54<br>
00000010<br>
GPR08: C01D0000 C01E0000 00000DF5 00000DF5 00000000 00F1C5DB 07FFD000<br>
FFFFFFFF<br>
GPR16: 00000001 00000000 00000000 00800000 00000000 007FFF00 00000000<br>
C033DAA0<br>
GPR24: C0339C90 00000007 00000000 C01B0000 C01B0000 C0344000 C033DAA0<br>
00000070<br>
NIP [C0050F80] check_slabp+0xe4/0x11c<br>
LR [C0050F80] check_slabp+0xe4/0x11c<br>
Call Trace:<br>
[C034FEB0] [C0050F80] check_slabp+0xe4/0x11c (unreliable)<br>
[C034FED0] [C0051450] free_block+0x88/0x138<br>
[C034FF00] [C0052188] drain_array+0xa0/0xe0<br>
[C034FF20] [C0052228] cache_reap+0x60/0x144<br>
[C034FF40] [C00257B0] run_workqueue+0xd0/0x170<br>
[C034FF60] [C0025960] worker_thread+0x110/0x144<br>
[C034FFC0] [C00298E4] kthread+0x74/0xb0<br>
[C034FFF0] [C0005F38] kernel_thread+0x44/0x60<br>
Instruction dump:<br>
387b6538 7c9df8ae 4bfc2b49 3bff0001 813e0020 5529103a 3929001c 7f9f4840<br>
419cffcc 3c60c01b 3863336c 4bfc2b25 &lt;0fe00000&gt; 48000000 80030020<br>
2f800000<br>
</font>
</p>

</div>
<br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_94533_3985985.1184793240607--
