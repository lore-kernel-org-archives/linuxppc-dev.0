Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 92B57DDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 17:08:48 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0H68hlJ020183
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 23:08:43 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0H68eQa023987
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 00:08:41 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Warnings when booting rc5 on a mpc83xx based board
Date: Wed, 17 Jan 2007 14:09:50 +0800
Message-ID: <989B956029373F45A0B8AF0297081890086D0B@zch01exm26.fsl.freescale.net>
In-Reply-To: <1168968034.31963.11.camel@gentoo-jocke.transmode.se>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>,
	"linuxppc-dev Development" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please try:

--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -103,7 +103,7 @@ static void __init mpc832x_sys_setup_arch(void)
 #ifdef CONFIG_QUICC_ENGINE
        qe_reset();

-       if ((np =3D of_find_node_by_name(np, "par_io")) !=3D NULL) {
+       if ((np =3D of_find_node_by_name(NULL, "par_io")) !=3D NULL) {
                par_io_init(np);
                of_node_put(np);

- Leo
> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Joakim
> Tjernlund
> Sent: Wednesday, January 17, 2007 1:21 AM
> To: 'linuxppc-dev Development'
> Subject: Warnings when booting rc5 on a mpc83xx based board
>=20
> after upgrading to rc5 I get this:
>=20
> IPIC (128 IRQ sources) at fdefd700
> QEIC (64 IRQ sources) at fdefc080
> PID hash table entries: 512 (order: 9, 2048 bytes)
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR =3D of_node_get+0x20/0x38
> [C0249F00] [FFFFFFFF] 0xffffffff (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C021992C] generic_calibrate_decr+0x38/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR =3D of_node_get+0x20/0x38
> [C0249F00] [C7FFEB94] 0xc7ffeb94 (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C021999C] generic_calibrate_decr+0xa8/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR =3D of_node_get+0x20/0x38
> [C0249F00] [C7FFEB94] 0xc7ffeb94 (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C021996C] generic_calibrate_decr+0x78/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR =3D of_node_get+0x20/0x38
> [C0249F00] [C7FFEB94] 0xc7ffeb94 (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C02199B8] generic_calibrate_decr+0xc4/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>=20
>=20
> and this:
>=20
> Memory: 127272k/131072k available (2252k kernel code, 3636k reserved,
84k data,
> 95k bs
> s, 128k init)
> Mount-cache hash table entries: 512
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249E00] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249E30] [C00F2158] report_bug+0x84/0xac
> [C0249E40] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E80] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR =3D of_node_get+0x20/0x38
> [C0249F40] [C00F2CA8] idr_get_new+0x1c/0x78 (unreliable)
> [C0249F50] [C000CB0C] of_get_next_child+0x34/0x9c
> [C0249F70] [C009556C] proc_device_tree_add_node+0x4c/0x144
> [C0249F90] [C0095560] proc_device_tree_add_node+0x40/0x144
> [C0249FB0] [C00956D8] proc_device_tree_init+0x74/0x90
> [C0249FC0] [C0224630] proc_root_init+0x11c/0x138
> [C0249FD0] [C02136B4] start_kernel+0x1e0/0x250
> [C0249FF0] [00003438] 0x3438
> NET: Registered protocol family 16
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
