Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id A3BACDDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 01:47:26 +1100 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 246D38780D9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 06:47:15 -0800 (PST)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id E098F8780BE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 06:47:14 -0800 (PST)
Message-ID: <45B61FF2.6070706@gmail.com>
Date: Tue, 23 Jan 2007 20:17:14 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: regarding kgdb in ppc
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>	<458E384A.108@gmail.com>	<198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>	<758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>	<45964D27.6020708@gmail.com>	<758a2bbf0612301753q27727b01w92681214a6296434@mail.gmail.com>	<45B5A499.4060401@gmail.com>
	<20070123114917.5668a578@localhost.localdomain>
In-Reply-To: <20070123114917.5668a578@localhost.localdomain>
Content-Type: multipart/alternative;
	boundary="------------040605000007080507010209"
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

This is a multi-part message in MIME format.
--------------040605000007080507010209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>> In my setup i have one serial port on the target(MPC8540) and one on 
>> host(x86). The document(kgdb_docu_full-2.4.pdf) by default considers 
>> having two serial ports(two on target and two on host).
> To be correct, usually one serial is for serial console, the other-for kgdb. Yet you can either disable serial console, or 
> have its output into kgdb. host requires only one serial to be tied on ppc_85xx-gdb.
>
>   
>> Can anyone plz guide me how to proceed when i have only one serial
>> port . ?
> having one serial is not a comfy case for serial kgdb.
>
>   
>> I want to know the initilization steps for estrablishing the serial 
>> communication between kgdb(in target) and gdb on host. I tried one or 
>> two ways but couldnot succeed.
>>     
>
> I'd consider kgdboe - it works pretty well with 8540 gianfar (or at least used to work for me so tinkering might be trivial).
>   
I have tried with kgdboe. The kernel doesn't wait at any point of time 
and boots completely.

I gave the following bootargs:
console=ttyS0,115200 root=/dev/ram rw kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA kgdbwait

My Host IP is 192.168.3.14 and that of target's is 80

I could see the following failure comments while kernel booting.

kgdboe: eth0 doesn't support polling, aborting.
kgdboe: netpoll_setup failed kgdboe failed

NET: Registered protocol family 17
kgdb: Waiting for connection from remote gdb...
KGDB cannot initialize I/O yet.
RAMDISK: Compressed image found at block 0

Please help me in sorting out this issue and pl let if am wrong in giving the bootargs.

The whole dump of boot process is as below:

mpc8540ads_init(): exit
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
mpc8540ads_setup_arch()
arch: exit
openpic: enter
openpic: timer
openpic: external
openpic: spurious
openpic: exit

Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.15.5 (root@Sudheer) (gcc version 3.4.4) #43 Tue Jan 23 15:50:57
IST 2007
KGDB cannot initialize I/O yet.
Built 1 zonelists
Kernel command line: console=ttyS0,115200 root=/dev/ram rw
kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA kgdbwait
kgdboe: local port 6443
kgdboe: local IP 192.168.3.80
kgdboe: interface eth0
kgdboe: remote port 6442
kgdboe: remote IP 192.168.3.14
kgdboe: remote ethernet address 00:08:a1:84:ef:ca
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255744k available (1596k kernel code, 376k data, 120k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1686k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO map 0xfdf04500 mem 0xfcffc500 (irq = 26) is a 16550A
serial8250.0: ttyS1 at MMIO map 0xfdf04600 mem 0xfcffb600 (irq = 26) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:01:af:07:9b:8a
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:01:af:07:9b:8b
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2, ff:f8:fe:ff:fb:ff
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
kgdboe: local port 6443
kgdboe: local IP 192.168.3.80
kgdboe: interface eth0
kgdboe: remote port 6442
kgdboe: remote IP 192.168.3.14
kgdboe: remote ethernet address 00:08:a1:84:ef:ca
kgdboe: eth0 doesn't support polling, aborting.
kgdboe: netpoll_setup failed kgdboe failed
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
kgdb: Waiting for connection from remote gdb...
KGDB cannot initialize I/O yet.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 120k init
/usr/sbin/xinetd: error while loading shared libraries: libcrypt.so.1: canno###
Application running ...


BusyBox v0.60.5 (2005.06.07-01:01+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

# phy0:7: Link is Up - 100/Full

#


Thanks
Sudheer

--------------040605000007080507010209
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid20070123114917.5668a578@localhost.localdomain"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">In my setup i have one serial port on the target(MPC8540) and one on 
host(x86). The document(kgdb_docu_full-2.4.pdf) by default considers 
having two serial ports(two on target and two on host).</pre>
  </blockquote>
  <pre wrap=""><!---->To be correct, usually one serial is for serial console, the other-for kgdb. Yet you can either disable serial console, or 
have its output into kgdb. host requires only one serial to be tied on ppc_85xx-gdb.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Can anyone plz guide me how to proceed when i have only one serial
port . ?</pre>
  </blockquote>
  <pre wrap=""><!---->having one serial is not a comfy case for serial kgdb.

  </pre>
  <blockquote type="cite">
    <pre wrap="">I want to know the initilization steps for estrablishing the serial 
communication between kgdb(in target) and gdb on host. I tried one or 
two ways but couldnot succeed.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I'd consider kgdboe - it works pretty well with 8540 gianfar (or at least used to work for me so tinkering might be trivial).
  </pre>
</blockquote>
I have tried with kgdboe. The kernel doesn't wait at any point of time
and boots completely.<br>
<pre>I gave the following bootargs:
console=ttyS0,115200 root=/dev/ram rw <a class="moz-txt-link-abbreviated" href="mailto:kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA">kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA</a> kgdbwait

My Host IP is 192.168.3.14 and that of target's is 80

I could see the following failure comments while kernel booting.

kgdboe: eth0 doesn't support polling, aborting.
kgdboe: netpoll_setup failed kgdboe failed

NET: Registered protocol family 17
kgdb: Waiting for connection from remote gdb...
KGDB cannot initialize I/O yet.
RAMDISK: Compressed image found at block 0

Please help me in sorting out this issue and pl let if am wrong in giving the bootargs.

The whole dump of boot process is as below:

mpc8540ads_init(): exit
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
mpc8540ads_setup_arch()
arch: exit
openpic: enter
openpic: timer
openpic: external
openpic: spurious
openpic: exit

Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.15.5 (root@Sudheer) (gcc version 3.4.4) #43 Tue Jan 23 15:50:57
IST 2007
KGDB cannot initialize I/O yet.
Built 1 zonelists
Kernel command line: console=ttyS0,115200 root=/dev/ram rw
<a class="moz-txt-link-abbreviated" href="mailto:kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA">kgdboe=@192.168.3.80/,@192.168.3.14/00:08:A1:84:EF:CA</a> kgdbwait
kgdboe: local port 6443
kgdboe: local IP 192.168.3.80
kgdboe: interface eth0
kgdboe: remote port 6442
kgdboe: remote IP 192.168.3.14
kgdboe: remote ethernet address 00:08:a1:84:ef:ca
OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255744k available (1596k kernel code, 376k data, 120k init, 0k highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1686k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO map 0xfdf04500 mem 0xfcffc500 (irq = 26) is a 16550A
serial8250.0: ttyS1 at MMIO map 0xfdf04600 mem 0xfcffb600 (irq = 26) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:01:af:07:9b:8a
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:01:af:07:9b:8b
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2, ff:f8:fe:ff:fb:ff
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
kgdboe: local port 6443
kgdboe: local IP 192.168.3.80
kgdboe: interface eth0
kgdboe: remote port 6442
kgdboe: remote IP 192.168.3.14
kgdboe: remote ethernet address 00:08:a1:84:ef:ca
kgdboe: eth0 doesn't support polling, aborting.
kgdboe: netpoll_setup failed kgdboe failed
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
kgdb: Waiting for connection from remote gdb...
KGDB cannot initialize I/O yet.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 120k init
/usr/sbin/xinetd: error while loading shared libraries: libcrypt.so.1: canno###
Application running ...


BusyBox v0.60.5 (2005.06.07-01:01+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

# phy0:7: Link is Up - 100/Full

#
</pre>
<br>
Thanks<br>
Sudheer<br>
</body>
</html>

--------------040605000007080507010209--
