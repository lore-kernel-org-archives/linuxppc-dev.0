Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 08C19DDF0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 14:40:00 +1100 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id EF0298780B6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 19:39:57 -0800 (PST)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id AC25F8780AF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 19:39:57 -0800 (PST)
Message-ID: <45C00F88.9050101@gmail.com>
Date: Wed, 31 Jan 2007 09:09:52 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: regarding kgdb in ppc
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>	<458E384A.108@gmail.com>	<198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>	<758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>	<45964D27.6020708@gmail.com>	<758a2bbf0612301753q27727b01w92681214a6296434@mail.gmail.com>	<45B5A499.4060401@gmail.com>	<20070123114917.5668a578@localhost.localdomain>	<45B61FF2.6070706@gmail.com>
	<45B62294.5020900@ru.mvista.com> <45BDDCA8.5020505@gmail.com>
	<45BDEFDE.9090006@ru.mvista.com>
In-Reply-To: <45BDEFDE.9090006@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Sergei Shtylyov

It is working now. Thank you very much  for all the help and  support.
>
> sudheer wrote:
>
>>>> I gave the following bootargs:
>>>> console=ttyS0,115200 root=/dev/ram rw 
>>>> kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA kgdbwait
   I gave the bootargs
console=ttyS0,115200 root=/dev/ram rw 
kgdboe=@192.168.3.80/,@192.168.3.14/ kgdbwait

>
>
>>>    You don't have to specify the remote MAC, IIUC.
>
>> When i dont give the mac address, the mac address all FFs(default) is 
>> considered. So am giving the mac address too, only then its working 
>> properly.
>
>    What, you don't have ARP on host?!
I have added the patch and  the arp entry in the host for the target , 
only then the gdb and kgdb are communicating.

Even now it shows all FFs while booting but after booting i could bring 
up eth0 and ping.

<DUMP>

Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.15.5 (root@Sudheer) (gcc version 3.4.4) #54 Tue Jan 30 
15:30:07 IST 2007
KGDB cannot initialize I/O yet.
Built 1 zonelists
Kernel command line: console=ttyS0,115200 root=/dev/ram rw 
ramdisk_size=12288 kgdboe=@192.168.3.80/,@192.168.3.14/ kgdbwait
kgdboe: local port 6443
kgdboe: local IP 192.168.3.80
kgdboe: interface eth0
kgdboe: remote port 6442
kgdboe: remote IP 192.168.3.14
kgdboe: remote ethernet address ff:ff:ff:ff:ff:ff
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254976k available (1616k kernel code, 444k data, 120k init, 0k 
highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 2260k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO map 0xfdf04500 mem 0xfcffc500 (irq = 26) is 
a 16550A
serial8250.0: ttyS1 at MMIO map 0xfdf04600 mem 0xfcffb600 (irq = 26) is 
a 16550A
RAMDISK driver initialized: 16 RAM disks of 12288K size 1024 blocksize
loop: loaded (max 8 devices)
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:01:af:07:9b:8a
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:01:af:07:9b:8b
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2, 7f:78:36:82:b9:f7
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
netconsole: not configured, aborting
kgdboe: local port 6443
kgdboe: local IP 192.168.3.80
kgdboe: interface eth0
kgdboe: remote port 6442
kgdboe: remote IP 192.168.3.14
kgdboe: remote ethernet address ff:ff:ff:ff:ff:ff
kgdboe: device eth0 not up yet, forcing it
kgdboe: carrier detect appears untrustworthy, waiting 4 seconds
phy0:7: Link is Up - 100/Full
kgdboe: debugging over ethernet enabled
i2c /dev entries driver
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
kgdb: Waiting for connection from remote gdb...               <WAITS 
HERE FOR GDB>
RAMDISK: Compressed image found at block 0
EXT2-fs warning: maximal mount count reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 120k init
init started:  BusyBox v1.1.2 (2006.09.27-13:46+0000) multi-call binary
### Application running ...



Thanks
Sudheer

>
>> I have added few lines of code in driver/net/gianfar.c
>
>> void gfar_poll_gianfar(struct net_device *dev )
>> {
>>    disable_irq(dev->irq);
>>    gfar_interrupt(dev->irq, dev,  NULL);
>>    enable_irq(dev->irq);
>>
>> }
>
>    This isn't complete, please use the community patch.  Gianfar TSEC 
> has 3 interrupts and all of them must be disabled.
>
>> Now am able to boot the target kernel without any error. kgdb waits 
>> for gdb connection.
>
>>>> kgdboe: local port 6443
>>>> kgdboe: local IP 192.168.3.80
>>>> kgdboe: interface eth0
>>>> kgdboe: remote port 6442
>>>> kgdboe: remote IP 192.168.3.14
>>>> kgdboe: remote ethernet address 00:08:a1:84:ef:ca
>>>> kgdboe: eth0 doesn't support polling, aborting.
>>>> kgdboe: netpoll_setup failed kgdboe failed
>
>>>    Have you backported the gianfar netpoll patch from 2.6.20-rc1?
>
>> I haven't backported the 2.6.20-rc1. As there are  many patches under 
>> that tree , i didnt try for it and could not know which one to add.
>
>    You certainly didn't need to backport the whole 2.6.20-rc1, only a 
> signle patch (-:
>
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=f2d71c2d800e68f158a5949e38b23f5140948548 
>
>
> WBR, Sergei
>
