Subject: RE: sporadic kernel panic during boot (MPC8xx, FEC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 11 Apr 2002 10:00:50 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31937EED@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Steven Scholz" <steven.scholz@imc-berlin.de>,
	"LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have had this "random crashes" for linux 2.4.18-pre1 from
linuxppc-2_4_devel
for some time now, it was not to annoying, since so much other stuff has
been unstable for us. Theses crashses ware mostly during booting of the
kernel, i.e.
if the kernel made it through the boot it seemed to run stable. I
collected at one point some statistics and it crashed in 0.5% - 1% cases
of reboot.
I got 2.4.19-pre6 last weekend from the rsync source at mvista, merged
and compiled. Since
then I had the board in my "reboot loop" and rebooted some 6000 times.
Not one
single crash. So I am happy, and recomend to you to go get the latest
version from
linuxppc_2_4_devel (well I have version 2.4.19pre6 gotten from the rsync
source at
mvista last weekend).

Regards,

K.D.

> -----Original Message-----
> From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
> Sent: 11. apríl 2002 07:08
> To: LinuxPPC
> Subject: sporadic kernel panic during boot (MPC8xx, FEC)
>
>
>
> Hi there,
>
> I am using the linux kernel from bitkeepers
> linuxppc_2_4_devel exported
> as of -rv2.4.18 on a MPC855T based board.
>
> From time to time I see a kernel panic while booting. I suppose it
> related to FEC (or MII) interrupts. The time the kernel panic
> occurs is
> different every time.
>
> Two examples:
> ==============================================================
> ====================
> -------------------------------------------------------
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 50MHz system bus speed for PIO modes; override with
> idebus=xx
> IDE phys mem : fe000000...fe000200 (size 00000200)
> hda: probing with STATUS(0x50) instead of ALTSTATUS(0x00)
> hda: HITACHI_DK239A-65, ATA DISK drive
> ide0 at 0xc2000000-0xc2000007,0xc2000106 on irq 2
> hda: 12685680 sectors (6495 MB) w/512KiB Cache, CHS=13424/15/63
> Partition check:
>  hda: hda1 hda2
> Oops: kernel access of bad area, sig: 11
> NIP: C00AE7E8 XER: 00000000 LR: C0003984 SP: C01E9DC0 REGS: c01e9d10
> TRAP: 0300    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 000000D0, DSISR: 00000129
> TASK = c01e8000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: F0000002 C01E9DC0 C01E8000 0000000A C01D5400 C01E9E30 C0122608
> C01F6000
> GPR08: 00000000 00000000 C0154018 00000001 24008022 100198C8 00FE3A00
> 007FFF83
> GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00001032 001E9E20 00000000
> C000298C
> GPR24: C0003A28 00000140 C01E9E30 C01F6720 0000000A F0000000 C01D5400
> FFF00E00
> Call backtrace:
> C0104CF0 C0003984 C0003A84 C000298C C00032A4 C0003440 C014FE9C
> C014E740 C014E77C C0150608 C014D76C C01477C8 C0147810 C0002558
> C0004D28
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  <0>Rebooting in 180 seconds..
> -------------------------------------------------------
> C0104CF0 C0003984 C0003A84 C000298C C00032A4 C0003440 C014FE9C
> C014E740 C014E77C C0150608 C014D76C C01477C8 C0147810 C0002558
> C0004D28
> 0xc0104cf0 -- 0xc010461c + 0x06d4   vsnprintf
> 0xc0003984 -- 0xc00037f4 + 0x0190   ppc_irq_dispatch_handler
> 0xc0003a84 -- 0xc0003a28 + 0x005c   do_IRQ
> 0xc000298c -- 0xc000298c + 0x0000   ret_from_intercept
> 0xc00032a4 -- 0xc00031b0 + 0x00f4   setup_irq
> 0xc0003440 -- 0xc000339c + 0x00a4   request_8xxirq
> 0xc014fe9c -- 0xc014fc98 + 0x0204   fec_enet_init
> 0xc014e740 -- 0xc014e710 + 0x0030   network_probe
> 0xc014e77c -- 0xc014e76c + 0x0010   net_device_init
> 0xc0150608 -- 0xc015038c + 0x027c   net_dev_init
> 0xc014d76c -- 0xc014d754 + 0x0018   device_init
> 0xc01477c8 -- 0xc0147798 + 0x0030   do_initcalls
> 0xc0147810 -- 0xc01477e8 + 0x0028   do_basic_setup
> 0xc0002558 -- 0xc0002544 + 0x0014   init
> 0xc0004d28 -- 0xc0004cfc + 0x002c   kernel_thread
>
> ==============================================================
> ====================
> ...
> eth0: FEC ENET Version 0.2, FEC irq 9, MII irq 10, addr
> 00:a0:33:00:37:e8
> eth0: Phy @ 0x0, type LXT971 (0x001378e2)
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 1024 bind 1024)
> eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
> IP-Config: Complete:
>       device=eth0, addr=192.168.11.225, mask=255.255.255.0,
> gw=255.255.255.255,
>      host=idif3, domain=, nis-domain=(none),
>      bootserver=192.168.11.91, rootserver=192.168.11.91, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 192.168.11.91
> eth0: status: link up, 100 Mbps Full Duplex, auto-negotiation
> complete.
> Looking up port of RPC 100005/1 on 192.168.11.91
> Oops: kernel access of bad area, sig: 11
> NIP: C00F8510 XER: 00000000 LR: C00F84C4 SP: C01E9DB0 REGS: c01e9d00
> TRAP: 0300    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: C013C2C4, DSISR: 82000000
> TASK = c01e8000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: C013C2A0 C01E9DB0 C01E8000 00000001 C01F68C0 00000000 C01E9E4C
> C01F6000
> GPR08: 00000038 00000001 000006E0 C013C2B4 24008022 100198C8 00FE3A00
> 007FFF83
> GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00FDDD70 C010DDBC 00FA0740
> C0150000
> GPR24: C0140000 00FE5288 007FFEC0 C01E9E58 C01E9EA8 C0FF0E50 C01E9DC8
> C01E9DC8
> Call backtrace:
> C00F84C4 C00F8358 C0070A48 C0070970 C014C838 C014C89C C014ABB8
> C000242C C000255C C0004D28
> Kernel panic: Attempted to kill init!
> -------------------------------------------------------
> Reading symbols from System.map
> C00F84C4 C00F8358 C0070A48 C0070970 C014C838 C014C89C C014ABB8
> C000242C C000255C C0004D28
> 0xc00f84c4 -- 0xc00f847c + 0x0048   rpc_call_setup
> 0xc00f8358 -- 0xc00f82d8 + 0x0080   rpc_call_sync
> 0xc0070a48 -- 0xc00709a4 + 0x00a4   nfs_gen_mount
> 0xc0070970 -- 0xc007095c + 0x0014   nfs_mount
> 0xc014c838 -- 0xc014c7cc + 0x006c   root_nfs_get_handle
> 0xc014c89c -- 0xc014c874 + 0x0028   nfs_root_data
> 0xc014abb8 -- 0xc014ab6c + 0x004c   mount_root
> 0xc000242c -- 0xc00023bc + 0x0070   prepare_namespace
> 0xc000255c -- 0xc0002544 + 0x0018   init
> 0xc0004d28 -- 0xc0004cfc + 0x002c   kernel_thread
> ==============================================================
> ====================
>
> Any ideas?
>
> Thanks,
>
> Steven
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
