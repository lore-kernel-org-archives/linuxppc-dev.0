Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id EC1EE67C5A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 11:42:16 +1100 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 67225467D8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 13:42:16 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 57CFF467D7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 13:42:15 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J8Q00501XNQ6K00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 15 Nov 2006 13:42:15 +1300 (NZDT)
Received: from [172.25.140.15] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0J8Q00I0RXYFTR90@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Wed, 15 Nov 2006 13:42:15 +1300 (NZDT)
Date: Wed, 15 Nov 2006 13:42:06 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Ode to a failed root fs on mpc859 target...
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <455A625E.6060200@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Having failed miserably to get a filesystem up on my 859 target, I 
thought I'd look for assistance.

First off, a ramfs (initrd):
Kernel command line: root=/dev/ram rw 
ip=172.25.206.113:172.25.140.15::255.255.0.0:unset:eth0:off panic=1 
console=ttyCPM0 
mtdparts=asif.0:64K(param),3008K(jffs),256K(u-boot),-(kernel)


[   24.745349] Oops: kernel access of bad area, sig: 11 [#1]
[   24.755838] NIP: C004E4B8 LR: C004E3D4 CTR: 00000000
[   24.765698] REGS: c021de30 TRAP: 0300   Not tainted  (2.6.18-buildroot)
[   24.778801] MSR: 00009032 <EE,ME,IR,DR>  CR: 84084044  XER: 0000005F
[   24.791426] DAR: FF80100F, DSISR: C2000000
[   24.799556] TASK = c01ea7b0[0] 'swapper' THREAD: c021c000
[   24.809905] GPR00: 00000000 C021DEE0 C01EA7B0 FF800FFF 00000000 
00000000 00000000 00000000
[   24.826493] GPR08: 00000001 C3F5F1E0 00000002 03F5F000 24084048 
00000000 03FF9000 00000000
[   24.843082] GPR16: 00000001 C01F0000 00000000 C01F0000 C0230000 
00000000 C0230000 0000000F
[   24.859671] GPR24: 0000000D 000000D0 00000001 C02322D4 C3F5F000 
C3F5F000 C027E0E0 000001E0
[   24.876606] NIP [C004E4B8] cache_alloc_refill+0x410/0x59c
[   24.887322] LR [C004E3D4] cache_alloc_refill+0x32c/0x59c
[   24.897857] Call Trace:
[   24.902710] [C021DEE0] [C004E3D4] cache_alloc_refill+0x32c/0x59c 
(unreliable)
[   24.916880] [C021DF10] [C004E0A4] kmem_cache_alloc+0x70/0x74
[   24.928112] [C021DF30] [C004F1BC] kmem_cache_create+0x488/0x534
[   24.939862] [C021DF80] [C0229808] kmem_cache_init+0x18c/0x3ac
[   24.951267] [C021DFD0] [C021E670] start_kernel+0x184/0x228
[   24.962153] [C021DFF0] [C0002050] start_here+0x4c/0xb0
[   24.972335] Instruction dump:
[   24.978211] 3f8bc000 2f9c0000 419e0198 801e0018 2f800000 419c016c 
801e0034 7c7cfa14
[   24.993589] 7fff0214 7c7d1b79 38000000 7d3cfa14 <90030010> 9123000c 
b0030018 93e30008
[   25.009923] Kernel panic - not syncing: Attempted to kill the idle task!

Next off is an nfs mount - which works (i.e. mounts according to the 
target and the server) but fails to find any files despite all possible 
init= options:
Kernel command line: root=/dev/nfs rw 
nfsroot=172.25.140.15:/home/gilksr/asif/root_fs 
ip=172.25.206.113:172.25.140.15::255.255.0.0:unset:eth0:off panic=1 
console=ttyCPM0 
mtdparts=asif.0:64K(param),3008K(jffs),256K(u-boot),-(kernel)

[    9.855238] IP-Config: Complete:
[    9.860737]       device=eth0, addr=172.25.206.113, mask=255.255.0.0, 
gw=255.255.255.255,
[    9.876816]      host=unset, domain=, nis-domain=(none),
[    9.887434]      bootserver=172.25.140.15, rootserver=172.25.140.15, 
rootpath=
[    9.904557] Looking up port of RPC 100003/2 on 172.25.140.15
[    9.929743] Looking up port of RPC 100005/1 on 172.25.140.15
[   11.466032] VFS: Mounted root (nfs filesystem).
[   11.475311] Freeing unused kernel memory: 92k init
[   11.498158] Kernel panic - not syncing: No init found.  Try passing 
init= option to kernel.
[   11.514649]  <0>Rebooting in 1 seconds..


Finally, a jffs2 filesystem:
Kernel command line: root=/dev/mtdblock1 rootfstype=jffs2 rw 
ip=172.25.206.113:172.25.140.15::255.255.0.0:unset:eth0:off panic=1 
console=ttyCPM0 
mtdparts=asif.0:64K(param),3008K(jffs),256K(u-boot),-(kernel)

Two very different crashes here, totally reproducable (but who knows 
which one will appear next!!)

[   76.559564] Oops: kernel access of bad area, sig: 11 [#1]
[   76.569783] NIP: C00B3494 LR: C00B9684 CTR: 00000000
[   76.579644] REGS: c0327a70 TRAP: 0300   Not tainted  (2.6.18-buildroot)
[   76.592746] MSR: 00009032 <EE,ME,IR,DR>  CR: 22002022  XER: 2000005F
[   76.605371] DAR: FF8010EB, DSISR: C0000000
[   76.613502] TASK = c0324b40[1] 'swapper' THREAD: c0326000
[   76.623849] GPR00: C00BA60C C0327B20 C0324B40 FF800FFF 00000139 
D81A5184 C0230000 00000000
[   76.640438] GPR08: C01AD0F0 000002A0 84511AD8 DA2B0DD8 82002022 
00000000 03FF9000 C01C0000
[   76.657027] GPR16: C3CA1F50 00000000 00000000 00000000 C3CA5395 
0000000A 000F3FD0 0000000F
[   76.673615] GPR24: 000F0000 00010000 C5183FD0 00000139 C5180000 
00000139 C3C01C00 000F3FD0
[   76.690551] NIP [C00B3494] jffs2_get_ino_cache+0x0/0x4c
[   76.700922] LR [C00B9684] jffs2_scan_make_ino_cache+0x1c/0xa8
[   76.712320] Call Trace:
[   76.717173] [C0327B20] [00010000] 0x10000 (unreliable)
[   76.727369] [C0327B40] [C00BA60C] jffs2_scan_medium+0xefc/0xfe4
[   76.739120] [C0327BC0] [C00BCA7C] jffs2_do_mount_fs+0x180/0x8ec
[   76.750870] [C0327BF0] [C00BEF0C] jffs2_do_fill_super+0xbc/0x244
[   76.762794] [C0327C10] [C00BF718] jffs2_get_sb_mtd+0xfc/0x19c
[   76.774199] [C0327C50] [C00BF9C4] jffs2_get_sb+0x180/0x228
[   76.785085] [C0327CE0] [C005A42C] vfs_kern_mount+0x5c/0xbc
[   76.795971] [C0327D00] [C005A4C8] do_kern_mount+0x3c/0x60
[   76.806685] [C0327D30] [C0072374] do_mount+0x394/0x680
[   76.816879] [C0327EB0] [C00729F8] sys_mount+0x98/0xe8
[   76.826902] [C0327EF0] [C021E864] do_mount_root+0x2c/0xc4
[   76.837616] [C0327F10] [C021E9C0] mount_block_root+0xc4/0x248
[   76.849020] [C0327F60] [C021EE3C] prepare_namespace+0xb8/0x190
[   76.860598] [C0327F80] [C0002494] init+0x254/0x2e4
[   76.870101] [C0327FF0] [C000514C] kernel_thread+0x44/0x60
[   76.880801] Instruction dump:
[   76.886678] 9421fff0 386300e4 38c00000 90010014 b0a4000a 38800003 
38a00001 4bf5b661
[   76.902056] 80010014 38210010 7c0803a6 4e800020 <816300ec> 548915fa 
7c69582e 2f030000
[   76.919299] Kernel panic - not syncing: Attempted to kill init!


crash two:

[  100.240137] Oops: kernel access of bad area, sig: 11 [#1]
[  100.250306] NIP: C0113524 LR: C0114128 CTR: C0113524
[  100.260163] REGS: c3cafcd0 TRAP: 0300   Not tainted  (2.6.18-buildroot)
[  100.273266] MSR: 00009032 <EE,ME,IR,DR>  CR: 22008028  XER: 0000005F
[  100.285891] DAR: FF80101B, DSISR: C0000000
[  100.294024] TASK = c036e410[280] 'jffs2_gcd_mtd1' THREAD: c3cae000
[  100.305924] GPR00: 00000000 C3CAFD80 C036E410 FF800FFF C3C2E678 
00000000 C0352A44 749E044A
[  100.322513] GPR08: 000DDCB0 C01AF99C FF800FFF C0113524 22008024 
00000000 C3CAFE38 00000000
[  100.339101] GPR16: C3CAFE24 C01C0000 C3CAFDA8 00000000 C3CAFE28 
C3C2E640 C0352A20 00000000
[  100.355690] GPR24: 000DDCB0 C3C2E640 00000028 00000000 000DDCB0 
C3C2E678 C03FEC14 C3C2E678
[  100.372626] NIP [C0113524] put_chip+0xa0/0x2e8
[  100.381441] LR [C0114128] cfi_intelext_read+0x1a0/0x240
[  100.391803] Call Trace:
[  100.396656] [C3CAFD80] [C3C2E640] 0xc3c2e640 (unreliable)
[  100.407370] [C3CAFDA0] [C0114128] cfi_intelext_read+0x1a0/0x240
[  100.419121] [C3CAFDF0] [C010C8A0] part_read+0x84/0xe0
[  100.429143] [C3CAFE10] [C00B6AD4] 
jffs2_do_read_inode_internal+0x12c/0x1124
[  100.442967] [C3CAFE90] [C00B7B30] jffs2_do_crccheck_inode+0x64/0xc0
[  100.455409] [C3CAFF00] [C00BBF9C] jffs2_garbage_collect_pass+0x194/0x8a4
[  100.468714] [C3CAFF50] [C00BDE04] jffs2_garbage_collect_thread+0xa8/0x178
[  100.482192] [C3CAFFF0] [C000514C] kernel_thread+0x44/0x60
[  100.492892] Instruction dump:
[  100.498769] 3863a000 4beffdf5 387f001c 38800003 38a00001 38c00000 
4befb5d5 80010024
[  100.514147] 83e1001c 38210020 7c0803a6 4e800020 <800a001c> 2f800000 
419effd0 7d435378

  This results in a hang due to the crashed garbage colllector having an 
inode lock

[  105.139802] jffs2_read_inode(): inode->i_ino == 12
[  105.149216] [JFFS2 DBG] (1) jffs2_do_read_inode: read inode #12
[  105.161062] [JFFS2 DBG] (1) jffs2_do_read_inode: waiting for ino #12 
in state 1

Note that *ALL THREE* filesystems run fine on the same target with a 
2.4.22 kernel (and exactly the same kernel command lines).

Is 2.6.18 *REALLY* this broken or is it just me (I'm starting to get 
paranoid now!!)

-- 
Robin




=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
