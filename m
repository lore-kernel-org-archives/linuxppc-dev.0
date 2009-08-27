Return-Path: <fixed-term.Thomas.Seeh@de.bosch.com>
Received: from smtp2-v.fe.bosch.de (smtp2-v.fe.bosch.de [139.15.237.6])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 747CEB7B9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 00:15:01 +1000 (EST)
From: "FIXED-TERM Seeh Thomas (BEG/EMS1)" <fixed-term.Thomas.Seeh@de.bosch.com>
To: Wolfgang Denk <wd@denx.de>
Date: Thu, 27 Aug 2009 16:14:57 +0200
Subject: AW: LITE5200 configuration
Message-ID: <6E9D235B18CE694399D781F05D9C42E79F0C2F04@SI-MBX11.de.bosch.com>
References: <6E9D235B18CE694399D781F05D9C42E79F0C2C12@SI-MBX11.de.bosch.com>
	<20090827131151.537EC833DBD2@gemini.denx.de>
In-Reply-To: <20090827131151.537EC833DBD2@gemini.denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Mr Denk,

thanks for your reply. I checked out kernel 2.6.30.3 stable for testing too=
.
I mean it's really a Lite5200. That is the U-boot boot message:

        U-Boot 2009.06 (Aug 26 2009 - 08:23:36)
        CPU:   MPC5200 v1.2, Core v1.1 at 231 MHz
         Bus 66 MHz, IPB 33 MHz, PCI 16.500 MHz
        Board: Motorola MPC5200 (IceCube)
        I2C:   85 kHz, ready
        DRAM:  64 MB
        FLASH: 16 MB
        PCI:   Bus Dev VenId DevId Class Int
                 00  1a  1057  5803  0680  00
        In:    serial
        Out:   serial
        Err:   serial
        Net:   FEC ETHERNET
        IDE:   Bus 0: not available

For kernel I use:
        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- mrproper
        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- 52xx/lite5200b_defconf=
ig
        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- uImage
      make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- modules
        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- modules_install

And the device tree lite5200.dts
      make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- lite5200.dtb

And the U-boot configuration:

=3D> print kernel_addr fdt_addr bootargs
kernel_addr=3D900000
fdt_addr=3Db00000
bootargs=3Dconsole=3DttyPSC0,115200 root=3D/dev/nfs rw nfsroot=3D10.10.0.2:=
/opt/eldk/ppc
_82xx ip=3D10.10.0.99:10.10.0.2::255.255.255.0:icecube::off panic=3D1
=3D> print bootfile dtbfile
bootfile=3D/tftpboot/uImage
dtbfile=3D/tftpboot/lite5200.dtb

=3D> tftp ${kernel_addr} ${boofile}; tftp ${fdt_addr} ${dtbfile}
Using FEC ETHERNET device
TFTP from server 10.10.0.2; our IP address is 10.10.0.99
Filename '/tftpboot/uImage'.
Load address: 0x900000
Loading: #################################################################
         #################################################################
         #################################################################
           ################################################################=
#
         #############################
done
Bytes transferred =3D 1478573 (168fad hex)
Using FEC ETHERNET device
TFTP from server 10.10.0.2; our IP address is 10.10.0.99
Filename '/tftpboot/lite5200.dtb'.
Load address: 0xb00000
Loading: ##
done
Bytes transferred =3D 5375 (14ff hex)

=3D> bootm ${kernel_addr} - ${fdt_addr}
## Booting kernel from Legacy Image at 00900000 ...
   Image Name:   Linux-2.6.30.3-00002-gdae6b8c
   Created:      2009-08-27  13:55:57 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1478509 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 00b00000
   Booting using the fdt blob at 0xb00000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 007fb000, end 007ff4fe ... OK
[    0.000000] Using lite5200 machine description
[    0.000000] Linux version 2.6.30.3-00002-gdae6b8c (root@user-laptop) (gc=
c ver
sion 4.2.2) #1 Thu Aug 27 15:55:37 CEST 2009
------snip---------
[ 2346.499181] VFS: Mounted root (nfs filesystem) on device 0:11.
[ 2346.505748] Freeing unused kernel memory: 160k init
[ 2346.865420] net eth0: FEC_IEVENT_RFIFO_ERROR
[ 2346.871668] ------------[ cut here ]------------
[ 2346.876434] Kernel BUG at c01ae1d0 [verbose debug info unavailable]
[ 2346.882852] Oops: Exception in kernel mode, sig: 5 [#1]
[ 2346.888184] lite5200
[ 2346.890416] Modules linked in:
[ 2346.893544] NIP: c01ae1d0 LR: c01af504 CTR: c0011190
[ 2346.898622] REGS: c02ff9e0 TRAP: 0700   Not tainted  (2.6.30.3-00002-gda=
e6b8
[ 2346.905991] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24000024  XER: 00000000
[ 2346.912796] TASK =3D c02dc588[0] 'swapper' THREAD: c02fe000
[ 2346.918127] GPR00: 00010200 c02ffa90 c02dc588 c3954e00 00000001 00000000=
 0000
8000 00000000
[ 2346.926693] GPR08: 000000a2 c02fe000 c0327000 c5036000 84000022 ffcf5fff=
 03fb
8000 03fa8878
[ 2346.935261] GPR16: 03f81ae8 03fa8854 03f45dcc 03f45ccc 03f45bee c031a138=
 c389
be00 0a0a0063
[ 2346.943830] GPR24: c03191a8 00008000 00000000 00000001 c3835b20 c3954e00=
 c383
5800 08820000
[ 2346.952582] Call Trace:
[ 2346.955088] [c02ffa90] [c01aefac] 0xc01aefac (unreliable)
[ 2346.960611] [c02ffac0] [c01af504] 0xc01af504
[ 2346.964977] [c02ffae0] [c01af8a4] 0xc01af8a4
[ 2346.969344] --- Exception: c38eb0f0 at 0xc38eb0c0
[ 2346.969361]     LR =3D 0xc02ddfc0
[ 2346.977347] [c02ffb00] [c004e6c0] 0xc004e6c0 (unreliable)
[ 2346.982869] [c02ffb20] [c0050a7c] 0xc0050a7c
[ 2346.987232] [c02ffb30] [c0006514] 0xc0006514
[ 2346.991595] [c02ffb50] [c0012014] 0xc0012014
[ 2346.995962] --- Exception: 501 at 0xc0035db8
[ 2346.995978]     LR =3D 0xc0035db0
[ 2347.003522] [c02ffc30] [c0035e70] 0xc0035e70
[ 2347.007889] [c02ffc40] [c02322e4] 0xc02322e4
[ 2347.012255] [c02ffc70] [c0232ddc] 0xc0232ddc
[ 2347.016621] [c02ffc80] [c022d0b8] 0xc022d0b8
[ 2347.020985] [c02ffca0] [c0231250] 0xc0231250
[ 2347.025351] [c02ffcd0] [c01bb904] 0xc01bb904
[ 2347.029715] [c02ffcf0] [c0203cbc] 0xc0203cbc
[ 2347.034082] [c02ffd10] [c02052cc] 0xc02052cc
[ 2347.038447] [c02ffd60] [c01e2f78] 0xc01e2f78
[ 2347.042811] [c02ffd80] [c01e3360] 0xc01e3360
[ 2347.047176] [c02ffdb0] [c01c7688] 0xc01c7688
[ 2347.051541] [c02ffde0] [c01c9ec8] 0xc01c9ec8
[ 2347.055905] [c02ffe10] [c01ca200] 0xc01ca200
[ 2347.060273] [c02ffe40] [c00296c0] 0xc00296c0
[ 2347.064640] [c02ffe70] [c0006474] 0xc0006474
[ 2347.069005] [c02ffe80] [c0029538] 0xc0029538
[ 2347.073368] [c02ffe90] [c0006518] 0xc0006518
[ 2347.077733] [c02ffeb0] [c0012014] 0xc0012014
[ 2347.082097] --- Exception: 501 at 0xc001fa98
[ 2347.082113]     LR =3D 0xc024af4c
[ 2347.089655] [c02fff70] [c030648c] 0xc030648c (unreliable)
[ 2347.095178] [c02fff80] [c024af4c] 0xc024af4c
[ 2347.099544] [c02fff90] [c0009360] 0xc0009360
[ 2347.103912] [c02fffb0] [c0003e04] 0xc0003e04
[ 2347.108280] [c02fffc0] [c02b280c] 0xc02b280c
[ 2347.112644] [c02ffff0] [00003438] 0x003438
[ 2347.116829] Instruction dump:
[ 2347.119865] 4e800020 9421ffd0 7c0802a6 bf210014 54290024 7c7d1b78 900100=
34 7c
9b2378
[ 2347.127818] 7cba2b78 7cd93378 8009000c 5400016e <0f000000> 3b830028 7f83=
e378
4809d545
[ 2347.135966] Kernel panic - not syncing: Fatal exception in interrupt
[ 2347.142459] Rebooting in 1 seconds..

Then I enabled "Verbose debug info" in the kernel:

------snip---------
[    0.000000] Kernel command line: console=3DttyPSC0,115200 root=3D/dev/nf=
s rw nfsr
oot=3D10.10.0.2:/opt/eldk/ppc_82xx ip=3D10.10.0.99:10.10.0.2::255.255.255.0=
:icecube:
:off panic=3D1
[    0.000000] NR_IRQS:512
[    0.000000] MPC52xx PIC is up and running!
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000000] clocksource: timebase mult[f26c9b2] shift[22] registered
[    0.000713] console [ttyPSC0] enabled
[    0.117286] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes=
)
[    0.125426] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.152478] Memory: 61656k/65536k available (2924k kernel code, 3816k re=
serve
d, 144k data, 108k bss, 160k init)
[    0.162876] Kernel virtual memory layout:
[    0.167060]   * 0xffffe000..0xfffff000  : fixmap
[    0.171855]   * 0xfcff7000..0xfe000000  : early ioremap
[    0.177269]   * 0xc5000000..0xfcff7000  : vmalloc & ioremap
[    0.183361] SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=
=3D0, CPUs=3D1, N
odes=3D1
[    0.191369] Calibrating delay loop... 32.89 BogoMIPS (lpj=3D65792)
[    0.282554] Mount-cache hash table entries: 512
[    0.296476] net_namespace: 520 bytes
[    0.302403] NET: Registered protocol family 16
[    0.358376] PCI: Probing PCI hardware
[    0.366037] DMA: MPC52xx BestComm driver
[    0.370969] DMA: MPC52xx BestComm engine @f0001200 ok !
[    0.426505] bio: create slab <bio-0> at 0
[    0.437399] SCSI subsystem initialized
[    0.462352] NET: Registered protocol family 2
[    0.467454] IP route cache hash table entries: 1024 (order: 0, 4096 byte=
s)
[    0.476064] TCP established hash table entries: 2048 (order: 2, 16384 by=
tes)
[    0.483852] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.490731] TCP: Hash tables configured (established 2048 bind 2048)
[    0.497361] TCP reno registered
[    0.501444] NET: Registered protocol family 1
[    0.611975] msgmni has been set to 120
[    0.620172] alg: No test for stdrng (krng)
[    0.624938] io scheduler noop registered
[    0.629262] io scheduler anticipatory registered (default)
[    0.635048] io scheduler deadline registered
[    0.640058] io scheduler cfq registered
[    1.812580] Generic RTC Driver v1.07
[    1.819176] Serial: MPC52xx PSC UART driver
[    1.824364] f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq =3D 129) is=
 a MPC5
2xx PSC
[    1.882486] brd: module loaded
[    1.909250] loop: module loaded
[    1.914148] Driver 'sd' needs updating - please use bus_type methods
[    1.922284] ata: MPC52xx IDE/ATA libata driver
[    1.929082] scsi0 : mpc52xx_ata
[    1.934723] ata1: PATA max PIO4 ata_regs 0xf0003a00 irq 135
[    1.994561] mpc52xx MII bus: probed
[    2.003553] net eth0: Using PHY at MDIO address 1
[    2.010075] i2c /dev entries driver
[    2.029480] TCP cubic registered
[    2.033132] NET: Registered protocol family 17
[    2.040730] RPC: Registered udp transport module.
[    2.045776] RPC: Registered tcp transport module.
[    2.574473] net eth0: attached phy 1 to driver Generic PHY
[    3.582953] IP-Config: Complete:
[    3.586267]      device=3Deth0, addr=3D10.10.0.99, mask=3D255.255.255.0,=
 gw=3D255.255
.255.255,
[    3.594532]      host=3Dicecube, domain=3D, nis-domain=3D(none),
[    3.600258]      bootserver=3D10.10.0.2, rootserver=3D10.10.0.2, rootpat=
h=3D
[    3.608107] Looking up port of RPC 100003/2 on 10.10.0.2
[    3.619215] Looking up port of RPC 100005/1 on 10.10.0.2
[    3.714264] VFS: Mounted root (nfs filesystem) on device 0:11.
[    3.720825] Freeing unused kernel memory: 160k init
[    3.871314] net eth0: FEC_IEVENT_RFIFO_ERROR
[    3.877660] ------------[ cut here ]------------
[    3.882425] kernel BUG at drivers/net/phy/mdio_bus.c:263!
[    3.887951] Oops: Exception in kernel mode, sig: 5 [#1]
[    3.893276] lite5200
[    3.895502] Modules linked in:
[    3.898630] NIP: c01ae268 LR: c01af59c CTR: c0011190
[    3.903707] REGS: c38253a0 TRAP: 0700   Not tainted  (2.6.30.3-00002-gda=
e6b8c
)
[    3.911070] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22002024  XER: 00000000
[    3.917871] TASK =3D c3820000[1] 'init' THREAD: c3824000
[    3.922933] GPR00: 00010100 c3825450 c3820000 c3922e00 00000001 00000000=
 0000
8000 00000000
[    3.931497] GPR08: 00000035 c3824000 c0329000 c5036000 22002022 ffcf5fff=
 c031
b1a8 0a0a0002
[    3.940061] GPR16: 00000000 00000000 00000000 00000801 00000000 c39366c0=
 0000
0000 c39f6930
[    3.948626] GPR24: 00000000 00008000 00000000 00000001 c383fb20 c3922e00=
 c383
f800 08820000
[    3.957367] Call Trace:
[    3.959867] [c3825450] [c01af044] 0xc01af044 (unreliable)
[    3.965382] [c3825480] [c01af59c] 0xc01af59c
[    3.969745] [c38254a0] [c01af93c] 0xc01af93c
[    3.974108] [c38254c0] [c004e6c4] 0xc004e6c4
[    3.978471] [c38254e0] [c0050a80] 0xc0050a80
[    3.982830] [c38254f0] [c0006514] 0xc0006514
[    3.987189] [c3825510] [c0012014] 0xc0012014
[    3.991552] --- Exception: 501 at 0xc0016540
[    3.991566]     LR =3D 0xc01bed30
[    3.999106] [c38255d0] [c01c9f60] 0xc01c9f60 (unreliable)
[    4.004625] [c3825610] [c022eca8] 0xc022eca8
[    4.008987] [c3825630] [c022ea20] 0xc022ea20
[    4.013349] [c3825670] [c022eae0] 0xc022eae0
[    4.017709] [c3825690] [c0231234] 0xc0231234
[    4.022072] [c38256c0] [c01bb99c] 0xc01bb99c
[    4.026434] [c38256e0] [c0203d54] 0xc0203d54
[    4.030795] [c3825700] [c01ba4f4] 0xc01ba4f4
[    4.035155] [c3825720] [c02059fc] 0xc02059fc
[    4.039518] [c38257d0] [c020cdf0] 0xc020cdf0
[    4.043878] [c38257f0] [c01b8a78] 0xc01b8a78
[    4.048242] [c38258d0] [c01b8e5c] 0xc01b8e5c
[    4.052605] [c38258f0] [c022f448] 0xc022f448
[    4.056967] [c3825930] [c022f4f8] 0xc022f4f8
[    4.061329] [c3825960] [c0231044] 0xc0231044
[    4.065690] [c3825980] [c022defc] 0xc022defc
[    4.070052] [c38259b0] [c022c064] 0xc022c064
[    4.074413] [c38259d0] [c02327b0] 0xc02327b0
[    4.078774] [c3825a10] [c022b200] 0xc022b200
[    4.083136] [c3825a20] [c0101b38] 0xc0101b38
[    4.087499] [c3825a90] [c00ff5c4] 0xc00ff5c4
[    4.091861] [c3825aa0] [c00ff658] 0xc00ff658
[    4.096221] [c3825ab0] [c0101624] 0xc0101624
[    4.100581] [c3825ad0] [c005bcdc] 0xc005bcdc
[    4.104943] [c3825b00] [c01012a4] 0xc01012a4
[    4.109307] [c3825b60] [c005b77c] 0xc005b77c
[    4.113667] [c3825bb0] [c0055454] 0xc0055454
[    4.118029] [c3825bf0] [c0066ac0] 0xc0066ac0
[    4.122392] [c3825c40] [c00147e8] 0xc00147e8
[    4.126754] [c3825cf0] [c0011dac] 0xc0011dac
[    4.131116] --- Exception: 301 at 0xc0016300
[    4.131130]     LR =3D 0xc00b6f18
[    4.138667] [c3825db0] [c396b9b4] 0xc396b9b4 (unreliable)
[    4.144186] [c3825dd0] [c00b8454] 0xc00b8454
[    4.148548] [c3825e60] [c00841b4] 0xc00841b4
[    4.152911] [c3825e90] [c00851d4] 0xc00851d4
[    4.157272] [c3825ed0] [c0008c28] 0xc0008c28
[    4.161634] [c3825ef0] [c001197c] 0xc001197c
[    4.165998] --- Exception: c01 at 0xc0010d54
[    4.166012]     LR =3D 0xc0003a18
[    4.173550] [c3825fb0] [c008c634] 0xc008c634 (unreliable)
[    4.179068] [c3825fc0] [c0003adc] 0xc0003adc
[    4.183431] [c3825fd0] [c02b31f0] 0xc02b31f0
[    4.187792] [c3825ff0] [c00117a0] 0xc00117a0
[    4.192147] Instruction dump:
[    4.195178] 4e800020 9421ffd0 7c0802a6 bf210014 54290024 7c7d1b78 900100=
34 7c
9b2378
[    4.203121] 7cba2b78 7cd93378 8009000c 5400016e <0f000000> 3b830028 7f83=
e378
4809d555
[    4.211252] Kernel panic - not syncing: Fatal exception in interrupt
[    4.217731] Call Trace:
[    4.220227] [c38251f0] [c0008274] 0xc0008274 (unreliable)
[    4.225743] [c3825230] [c0023b4c] 0xc0023b4c
[    4.230103] [c3825280] [c000f678] 0xc000f678
[    4.234463] [c38252a0] [c000f900] 0xc000f900
[    4.238828] [c3825390] [c0011fc8] 0xc0011fc8
[    4.243188] --- Exception: 700 at 0xc01ae268
[    4.243202]     LR =3D 0xc01af59c
[    4.250742] [c3825450] [c01af044] 0xc01af044 (unreliable)
[    4.256259] [c3825480] [c01af59c] 0xc01af59c
[    4.260618] [c38254a0] [c01af93c] 0xc01af93c
[    4.264979] [c38254c0] [c004e6c4] 0xc004e6c4
[    4.269338] [c38254e0] [c0050a80] 0xc0050a80
[    4.273701] [c38254f0] [c0006514] 0xc0006514
[    4.278062] [c3825510] [c0012014] 0xc0012014
[    4.282421] --- Exception: 501 at 0xc0016540
[    4.282435]     LR =3D 0xc01bed30
[    4.289973] [c38255d0] [c01c9f60] 0xc01c9f60 (unreliable)
[    4.295492] [c3825610] [c022eca8] 0xc022eca8
[    4.299858] [c3825630] [c022ea20] 0xc022ea20
[    4.304217] [c3825670] [c022eae0] 0xc022eae0
[    4.308580] [c3825690] [c0231234] 0xc0231234
[    4.312941] [c38256c0] [c01bb99c] 0xc01bb99c
[    4.317304] [c38256e0] [c0203d54] 0xc0203d54
[    4.321666] [c3825700] [c01ba4f4] 0xc01ba4f4
[    4.326027] [c3825720] [c02059fc] 0xc02059fc
[    4.330388] [c38257d0] [c020cdf0] 0xc020cdf0
[    4.334749] [c38257f0] [c01b8a78] 0xc01b8a78
[    4.339111] [c38258d0] [c01b8e5c] 0xc01b8e5c
[    4.343472] [c38258f0] [c022f448] 0xc022f448
[    4.347833] [c3825930] [c022f4f8] 0xc022f4f8
[    4.352195] [c3825960] [c0231044] 0xc0231044
[    4.356557] [c3825980] [c022defc] 0xc022defc
[    4.360920] [c38259b0] [c022c064] 0xc022c064
[    4.365282] [c38259d0] [c02327b0] 0xc02327b0
[    4.369641] [c3825a10] [c022b200] 0xc022b200
[    4.374003] [c3825a20] [c0101b38] 0xc0101b38
[    4.378364] [c3825a90] [c00ff5c4] 0xc00ff5c4
[    4.382726] [c3825aa0] [c00ff658] 0xc00ff658
[    4.387087] [c3825ab0] [c0101624] 0xc0101624
[    4.391448] [c3825ad0] [c005bcdc] 0xc005bcdc
[    4.395810] [c3825b00] [c01012a4] 0xc01012a4
[    4.400171] [c3825b60] [c005b77c] 0xc005b77c
[    4.404533] [c3825bb0] [c0055454] 0xc0055454
[    4.408894] [c3825bf0] [c0066ac0] 0xc0066ac0
[    4.413254] [c3825c40] [c00147e8] 0xc00147e8
[    4.417616] [c3825cf0] [c0011dac] 0xc0011dac
[    4.421977] --- Exception: 301 at 0xc0016300
[    4.421991]     LR =3D 0xc00b6f18
[    4.429529] [c3825db0] [c396b9b4] 0xc396b9b4 (unreliable)
[    4.435045] [c3825dd0] [c00b8454] 0xc00b8454
[    4.439409] [c3825e60] [c00841b4] 0xc00841b4
[    4.443770] [c3825e90] [c00851d4] 0xc00851d4
[    4.448131] [c3825ed0] [c0008c28] 0xc0008c28
[    4.452492] [c3825ef0] [c001197c] 0xc001197c
[    4.456850] --- Exception: c01 at 0xc0010d54
[    4.456865]     LR =3D 0xc0003a18
[    4.464401] [c3825fb0] [c008c634] 0xc008c634 (unreliable)
[    4.469920] [c3825fc0] [c0003adc] 0xc0003adc
[    4.474281] [c3825fd0] [c02b31f0] 0xc02b31f0
[    4.478643] [c3825ff0] [c00117a0] 0xc00117a0
[    4.483009] Rebooting in 1 seconds..

Anyone an idea, what I do wrong?

Best regards,
Thomas.



Dear "FIXED-TERM Seeh Thomas (BEG/EMS1)",

In message <6E9D235B18CE694399D781F05D9C42E79F0C2C12@SI-MBX11.de.bosch.com>=
 you wrote:
>
> I'll try to run a 2.6.31-rc7 kernel on my Lite5200 board.

Is this really a Lite5200, or is it a Lite5200B?

Hint: if U-Boot prints something like "CPU: MPC5200B v2.2, Core v1.4"
then its a 5200B, and thus a Lite5200 board.

> For the device tree I use lite5200.dts and compiled it simply with
>
>         make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- lite5200.dtb

For a Lite5200B you should use the lite5200b device tree.

> But I'm not sure what configuration for the kernel I should choose. There=
 is no
> lite5200_defconfig only one for the lite5200b.

Rigth. Because there are virtually no lite5200 boards out there.

> I tried it with mpc5200_defconfig and lite5200b_defconfig, but I'm not su=
re which
> is the right way.

Both will work. On a Lite5200 board I would use lite5200b_defconfig,
though.

> For compiling the kernel I use:
>
>         make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- "CONFIG_FILE"

That's:

        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- mrproper
        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- 52xx/lite5200b_defconf=
ig

>         make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- uImage
>         make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- modules
>         make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- modules_install


> I use U-Boot 2009.06, with the following settings for bootup:

Looks as if you have a Rev. B CPU with the wrong device tree.

Unfortunaltey you omit the interesting part (i. e. the U-Boot boot
message) which would contain this important piece of information.

> --_000_6E9D235B18CE694399D781F05D9C42E79F0C2C12SIMBX11deboschc_
> Content-Type: text/html; charset"iso-8859-1"
> Content-Transfer-Encoding: quoted-printable

And *please* do not post HTML to mailing lists. Never ever do that.

Best regards,

Wolfgang Denk

--
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If I ever needed a brain transplant, I'd choose a teenager's  because
I'd want a brain that had never been used.
