Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DEA09B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 15:12:17 +1100 (EST)
Subject: Re: [linuxppc-release] [powerpc] boot up problem
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
Date: Thu, 1 Dec 2011 22:12:16 -0600
Message-Id: <D762CECC-33EC-4D5D-8AD6-7E5150D15117@kernel.crashing.org>
References: <1320040492-6407-1-git-send-email-B38951@freescale.com>
 <1320040492-6407-2-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5DFD4DB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <3E825AD9-1CD5-4D6D-8161-E6B4F1D32457@kernel.crashing.org>
 <3F607A5180246847A760FD34122A1E052DBCD1@039-SN1MPN1-003.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5DFD6BAB@039-SN1MPN1-005.039d.mgd.msft.net>
 <3EC6F9E0-C847-4DA8-AD8C-313976982A10@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5DFDC478@039-SN1MPN1-005.039d.mgd.msft.net>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Cc: LinuxPPC-dev list <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 1, 2011, at 8:21 PM, Jia Hongtao-B38951 wrote:

> Hi
>=20
> I just found that the 'next' branch you mentioned have problem to boot =
up.
> I test it in p1022ds and p1010rdb boards and the result are both the =
same.
> Note that for p1022ds I use "make p1022ds.dtb" to make the dtb =
file(36bit) with 36bit-uboot.
> And for p1010rdb I use all 32bit image.
> The problem list below:

Can you try Linus's tree and v3.2-rc4

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dsummary=


and see if you have same issue.

> scsi0 : sata_fsl
> ata1: SATA max UDMA/133 irq 74
> fsl-sata fffe19000.sata: Sata FSL Platform/CSB Driver init
> scsi1 : sata_fsl
> ata2: SATA max UDMA/133 irq 41
> Fixed MDIO Bus: probed
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc0451630
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=3D2 P1022 DS
> Modules linked in:
> NIP: c0451630 LR: c0451618 CTR: 00000007
> REGS: ef03fce0 TRAP: 0300   Not tainted  (3.2.0-rc3-00099-g883381d)
> MSR: 00029000 <EE,ME,CE>  CR: 24042022  XER: 00000000
> DEAR: 00000000, ESR: 00800000
> TASK =3D ef040000[1] 'swapper' THREAD: ef03e000 CPU: 0
> GPR00: ef03fd98 ef03fd90 ef040000 ef1ab22c 00000000 00000002 ffeb0000 =
0000fffe
> GPR08: b0541215 00000000 00000000 00000000 24042028 23c406c2 00000000 =
00000000
> GPR16: c0000a00 00000014 3fffffff 03ff9000 00000015 7ff3a760 f1044030 =
fffffff4
> GPR24: c053e128 ef1ab230 c056a3a8 ef03e000 ef040000 ef1ab22c 00000000 =
ef1ab228
> NIP [c0451630] __mutex_lock_slowpath+0xb4/0x190
> LR [c0451618] __mutex_lock_slowpath+0x9c/0x190
> Call Trace:
> [ef03fdd0] [c0451758] mutex_lock+0x4c/0x50
> [ef03fde0] [c02b5124] mdiobus_read+0x38/0x74
> [ef03fe00] [c02b41f4] get_phy_id+0x24/0x80
> [ef03fe20] [c02b9de4] fsl_pq_mdio_probe+0x3b4/0x580
> [ef03feb0] [c0266120] platform_drv_probe+0x20/0x30
> [ef03fec0] [c0264bbc] driver_probe_device+0xa4/0x1d4
> [ef03fee0] [c0264da8] __driver_attach+0xbc/0xc0
> [ef03ff00] [c0263ac0] bus_for_each_dev+0x60/0x9c
> [ef03ff30] [c02647f4] driver_attach+0x24/0x34
> [ef03ff40] [c0264444] bus_add_driver+0x1ac/0x274
> [ef03ff70] [c02651b0] driver_register+0x88/0x154
> [ef03ff90] [c0266450] platform_driver_register+0x68/0x78
> [ef03ffa0] [c05d93b8] fsl_pq_mdio_init+0x18/0x28
> [ef03ffb0] [c0001eb8] do_one_initcall+0x34/0x1a8
> [ef03ffe0] [c05bb82c] kernel_init+0xa0/0x13c
> [ef03fff0] [c000d878] kernel_thread+0x4c/0x68
> Instruction dump:
> 801c0020 2f800063 419dffe8 3bbf0004 7fa3eb78 48001aad 813f000c =
38010008
> 3b3f0008 901f000c 93210008 9121000c
> 3800ffff 93810010 7c0004ac
> ---[ end trace 1643a9a9c5097f8f ]---
> Kernel panic - not syncing: Attempted to kill init!
> Call Trace:
> [ef03fbc0] [c0008044] show_stack+0x44/0x154 (unreliable)
> [ef03fc00] [c04532c8] panic+0xa4/0x1d8
> [ef03fc50] [c0049a00] do_exit+0x5dc/0x684
> [ef03fca0] [c000a6f0] die+0xdc/0x1b4
> [ef03fcc0] [c00128d0] bad_page_fault+0xb4/0xfc
> [ef03fcd0] [c000ebe4] handle_page_fault+0x7c/0x80
> --- Exception: 300 at __mutex_lock_slowpath+0xb4/0x190
>    LR =3D __mutex_lock_slowpath+0x9c/0x190
> [ef03fd90] [00000000]   (null) (unreliable)
> [ef03fdd0] [c0451758] mutex_lock+0x4c/0x50
> [ef03fde0] [c02b5124] mdiobus_read+0x38/0x74
> [ef03fe00] [c02b41f4] get_phy_id+0x24/0x80
> [ef03fe20] [c02b9de4] fsl_pq_mdio_probe+0x3b4/0x580
> [ef03feb0] [c0266120] platform_drv_probe+0x20/0x30
> [ef03fec0] [c0264bbc] driver_probe_device+0xa4/0x1d4
> [ef03fee0] [c0264da8] __driver_attach+0xbc/0xc0
> [ef03ff00] [c0263ac0] bus_for_each_dev+0x60/0x9c
> [ef03ff30] [c02647f4] driver_attach+0x24/0x34
> [ef03ff40] [c0264444] bus_add_driver+0x1ac/0x274
> [ef03ff70] [c02651b0] driver_register+0x88/0x154
> [ef03ff90] [c0266450] platform_driver_register+0x68/0x78
> [ef03ffa0] [c05d93b8] fsl_pq_mdio_init+0x18/0x28
> [ef03ffb0] [c0001eb8] do_one_initcall+0x34/0x1a8
> [ef03ffe0] [c05bb82c] kernel_init+0xa0/0x13c
> [ef03fff0] [c000d878] kernel_thread+0x4c/0x68
> Rebooting in 180 seconds..
>=20
> Do you or anyone else have any idea about this?
> Thanks.
