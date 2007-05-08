Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD0F8DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 May 2007 20:04:29 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1HlMGl-0002XR-Ms
	for linuxppc-embedded@ozlabs.org; Tue, 08 May 2007 02:46:07 -0700
Message-ID: <10372619.post@talk.nabble.com>
Date: Tue, 8 May 2007 02:46:07 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: zImage.elf loads but does not start
In-Reply-To: <463B5422.6030105@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
	<10165159.post@talk.nabble.com> <10323147.post@talk.nabble.com>
	<463B5422.6030105@ru.mvista.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thank you Andrei for your hint. I have hard-coded the mac address in the 
arch/ppc/boot/simple/embed_config.c. Maybe it is not the most elegant
solution but it works.

Right now I was able to mount the root file system via nfs but it seems to
be still somthing missing:

[    0.000000] Kernel command line: console=ttyUL0,9600 root=/dev/nfs rw
nfsroot
=129.129.130.106:/opt/eldk41/ppc_4xx,tcp macaddr=00:50:c2:46:d8:01
ip=129.129.10
7.50:129.129.130.106:129.129.107.1:255.255.255.0:ml403-mirek:eth0:off
panic=1
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000424] Console: colour dummy device 80x25
[    0.001483] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.003209] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.034369] Memory: 62720k available (1572k kernel code, 508k data, 96k
init,
 0k highmem)
[    0.121167] Mount-cache hash table entries: 512
[    0.129517] NET: Registered protocol family 16
[    0.166530] NET: Registered protocol family 2
[    0.204693] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    0.205867] TCP established hash table entries: 2048 (order: 2, 16384
bytes)
[    0.206574] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.207009] TCP: Hash tables configured (established 2048 bind 2048)
.
.
.
[    2.670863] XTemac: using FIFO direct interrupt driven mode.
[    2.739134] eth%d: XTemac: PHY detected at address 3.
[    2.802585] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5040000,
irq=1
[    2.886290] eth0: XTemac id 1.0f, block id 5, type 8
[    2.947439] mice: PS/2 mouse device common for all mice
[    3.010300] TCP cubic registered
[    3.049323] NET: Registered protocol family 1
[    3.101718] NET: Registered protocol family 17
[    3.661970] eth0: XTemac: Options: 0xb8f2
[    7.693861] eth0: XTemac: We renegotiated the speed to: 100
[    7.760541] eth0: XTemac: speed set to 100Mb/s
[    8.830367] IP-Config: Complete:
[    8.867105]       device=eth0, addr=129.129.107.50, mask=255.255.255.0,
gw=129.129.107.1,
[    8.964390]      host=ml403-mirek, domain=, nis-domain=(none),
[    9.034414]      bootserver=129.129.130.106, rootserver=129.129.130.106,
rootpath=
[    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
[    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
[    9.303794] VFS: Mounted root (nfs filesystem).
[    9.359316] Freeing unused kernel memory: 96k init
[    9.422162] Warning: unable to open an initial console.


To satisfy last problem "unable to open an initial console" I have created
an entry in the /opt/eldk41/ppc_4xx/dev directory:

mknod ttyUL0 c 204 187
ln -s ttyUL0 console

I have rebooted the kernel once again and this time kernel has reached the
point as listed below.:
 [    8.964390]      host=ml403-mirek, domain=, nis-domain=(none),
[    9.034414]      bootserver=129.129.130.106, rootserver=129.129.130.106,
rootpath=
[    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
[    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
[    9.303794] VFS: Mounted root (nfs filesystem).
[    9.359316] Freeing unused kernel memory: 96k init

I do not know if the console was taken into account or not (the warning has
disapeared but I am not able to ping
to my board nor telnet to it).

Any idea what could be wrong?

I use the root file system from eldk4.1:
/opt/eldk41/ppc_4xx/etc/inittab:
-------------------------------------------------------------------------------------------------------
id:3:initdefault:

# System initialization.
si::sysinit:/etc/rc.d/rc.sysinit

l0:0:wait:/etc/rc.d/rc 0
l1:1:wait:/etc/rc.d/rc 1
l2:2:wait:/etc/rc.d/rc 2
l3:3:wait:/etc/rc.d/rc 3
l4:4:wait:/etc/rc.d/rc 4
l5:5:wait:/etc/rc.d/rc 5
l6:6:wait:/etc/rc.d/rc 6

# Trap CTRL-ALT-DELETE
ca::ctrlaltdel:/sbin/shutdown -t3 -r now

# UPS connected and working correctly.  
pf::powerfail:/sbin/shutdown -f -h +2 "Power Failure; System Shutting Down"

# If power was restored before the shutdown kicked in, cancel it.
pr:12345:powerokwait:/sbin/shutdown -c "Power Restored; Shutdown Cancelled"

# Run gettys in standard runlevels
3:2345:respawn:/sbin/mingetty --noclear console
-----------------------------------------------------------------------------------------------------------------------------------------
The contents of the /opt/eldk41/ppc_4xx/etc/rc3.d/ is as following:

K15appWeb                K80random         S12syslog      
_S30mouse-emulation
K70mouse-emulation  K90network        _S20random    S56xinetd
K75netfs                      S10network        S25netfs          S99local
-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10372619
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
