Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C9BD1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 20:12:35 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p43ACT19027159
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2011 12:12:29 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Bootp hangs
Date: Tue, 3 May 2011 12:12:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201105031212.28988.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
maybe a bit off topic, more network than kernel, but who knows...
I've had problems booting a new design (ML405 derivative), so I reverted to the old tested one... and it won't boot 
either.
The kernel is in flash and my bootloader puts it in RAM and runs it. The root filesystem  is obtained by NFS, but now it 
hangs:

[...]
[   43.615490] Device Tree Probing 'ethernet'
[   43.619162] xilinx_lltemac 81c00000.ethernet: MAC address is now  0: a:35:72:43: 0
[   43.626002] xilinx_lltemac 81c00000.ethernet: XLlTemac: using DMA mode.
[   43.632799] XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc8020100
[   43.639456] XLlTemac: buffer descriptor size: 32768 (0x8000)
[   43.644843] XLlTemac: Allocating DMA descriptors with kmalloc
[   43.650455] XLlTemac: (buffer_descriptor_init) phy: 0x68b8000, virt: 0xc68b8000, size: 0x8000
[   43.664316] XTemac: PHY detected at address 7.
[   43.670570] xilinx_lltemac 81c00000.ethernet: eth0: Xilinx TEMAC at 0x81C00000 mapped to 0xC801A000, irq=18
[   43.683934] mice: PS/2 mouse device common for all mice
[   43.690323] TCP cubic registered
[   43.692503] NET: Registered protocol family 17
[   44.204479] eth0: XLlTemac: Options: 0x3fa
[   44.207642] eth0: XLlTemac: allocating interrupt 20 for dma mode tx.
[   44.213830] eth0: XLlTemac: allocating interrupt 19 for dma mode rx.
[   46.230373] eth0: XLlTemac: speed set to 1000Mb/s
[   46.233931] eth0: XLlTemac: Send Threshold = 24, Receive Threshold = 4
[   46.240422] eth0: XLlTemac: Send Wait bound = 254, Receive Wait bound = 254
[   47.251413] Sending BOOTP requests .

On the DHCP server this is all I get (which is correct):
May  3 11:58:24 lpsc6186x dhcpd: BOOTREQUEST from 00:0a:35:72:43:00 via eth1
May  3 11:58:24 lpsc6186x dhcpd: BOOTREPLY for 192.168.1.233 to gandalf (00:0a:35:72:43:00) via eth1

After that nothing happens (no new dots after "Sending BOOTP requests ." like when there's no physical connection)

I've tried with 2 different network cards on the server, a crossover cable and 3 switches (10, 100 and 1gbps)
I haven't changed the NFS/DHCP server configuration since it last ran fine.
I haven't updated the system on the server.
I haven't reflashed the kernel on the card.

$ cat /etc/dhcpd.conf:
allow bootp;
allow booting;
ddns-update-style interim;
subnet 192.168.1.0 netmask 255.255.255.0 {
        default-lease-time 21600;
        option routers 192.168.1.185;
        option subnet-mask 255.255.255.0;
        option ntp-servers 192.168.1.185;
#       range dynamic-bootp 192.168.1.128 192.168.1.254;
}
host gandalf {
        hardware ethernet 0:a:35:72:43:0;
        fixed-address 192.168.1.233;
        server-name "192.168.1.185";
        option host-name "gandalf";
        option root-path "192.168.1.185:/media/gandalf,v3,rsize=1024,wsize=1024,proto=udp,nolock,intr";
}


$ cat /etc/sysconfig/dhcpd 
DHCPDARGS=eth1

$ cat /etc/exports
/media/gandalf gandalf(rw,no_root_squash,sync,insecure,fsid=0)


Any idea ?!?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
