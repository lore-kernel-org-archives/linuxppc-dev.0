Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id DD0D0B7CEF
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 05:26:06 +1100 (EST)
Received: from antares (xdsl-89-0-173-98.netcologne.de [89.0.173.98])
	by smtp6.netcologne.de (Postfix) with ESMTP id 109FB2A0AE6
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 19:26:04 +0100 (CET)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 722A3BA047
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 19:26:04 +0100 (CET)
Date: Wed, 10 Mar 2010 19:25:56 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: 5200B: BUG in 2.6.34-rc1-dirty while loading at24 driver
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1268245563.2375.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-gXfpNRS8GJawsA6K2/H8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-gXfpNRS8GJawsA6K2/H8
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

not sure if this is the right place to ask:  When I boot a custom 5200B (mo=
re or less Lite-based) board with Linus' git tree (2.6.34-rc1-dirty), I alw=
ays get the following bug:

[    1.110693] i2c /dev entries driver
[    1.117285] mpc-i2c f0003d00.i2c: clock 375000 Hz (fdr=3D137)
[    1.123156] mpc-i2c f0003d00.i2c: timeout 1000000 us
[    1.146528] mpc-i2c f0003d40.i2c: clock 375000 Hz (fdr=3D137)
[    1.152637] mpc-i2c f0003d40.i2c: timeout 1000000 us
[    1.170628] rtc-ds1307 1-0068: rtc core: registered ds1337 as rtc0
[    1.181003] BUG: key cf9ea5ac not in .data!
[    1.185510] ------------[ cut here ]------------
[    1.190257] Badness at kernel/lockdep.c:2706
[    1.194627] NIP: c004d2b4 LR: c004d29c CTR: c01aeb30
[    1.199714] REGS: cf82db70 TRAP: 0700   Not tainted  (2.6.34-rc1-dirty)
[    1.206483] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22084022  XER: 20000000
[    1.213305] TASK =3D cf830000[1] 'swapper' THREAD: cf82c000
[    1.218651] GPR00: 00000000 cf82dc20 cf830000 00000001 00000001 c0023fb4=
 00000000 00000001
[    1.227243] GPR08: 00000000 c03f0000 c03c0000 00000001 42084024 100958e4=
 0ffef000 0ffe41a4
[    1.235834] GPR16: 0ffbf298 0ffe4180 0ff72db4 0ff72cb4 c03d685c c03d6830=
 00000000 00000000
[    1.244423] GPR24: fffffff4 00000001 c03f0000 00000080 cfa1c2d8 cf9ea5ac=
 00000000 cfa1c4d8
[    1.253225] NIP [c004d2b4] lockdep_init_map+0xc4/0x4e4
[    1.258489] LR [c004d29c] lockdep_init_map+0xac/0x4e4
[    1.263657] Call Trace:
[    1.266165] [cf82dc20] [c004d28c] lockdep_init_map+0x9c/0x4e4 (unreliabl=
e)
[    1.273236] [cf82dc50] [c00de478] sysfs_add_file_mode+0x5c/0xe0
[    1.279308] [cf82dc80] [c00e0bbc] sysfs_create_bin_file+0x34/0x50
[    1.285575] [cf82dc90] [c01b8764] at24_probe+0x314/0x460
[    1.291034] [cf82dcd0] [c0215768] i2c_device_probe+0xac/0xc0
[    1.296840] [cf82dcf0] [c01b334c] driver_probe_device+0xa4/0x190
[    1.303000] [cf82dd10] [c01b23c0] bus_for_each_drv+0x70/0xac
[    1.308806] [cf82dd40] [c01b3620] device_attach+0x84/0xa8
[    1.314343] [cf82dd60] [c01b1fd8] bus_probe_device+0x3c/0x54
[    1.320166] [cf82dd70] [c01b0588] device_add+0x374/0x5f4
[    1.325619] [cf82ddc0] [c0216ac4] i2c_new_device+0xf0/0x144
[    1.331344] [cf82dde0] [c021b078] of_register_i2c_devices+0x12c/0x158
[    1.337966] [cf82de60] [c02c1280] fsl_i2c_probe+0x190/0x324
[    1.343687] [cf82de90] [c021abe8] of_platform_device_probe+0x5c/0x84
[    1.350208] [cf82deb0] [c01b334c] driver_probe_device+0xa4/0x190
[    1.356371] [cf82ded0] [c01b36e8] __driver_attach+0xa4/0xa8
[    1.362087] [cf82def0] [c01b259c] bus_for_each_dev+0x60/0x9c
[    1.367890] [cf82df20] [c01b3164] driver_attach+0x24/0x34
[    1.373429] [cf82df30] [c01b2ef4] bus_add_driver+0x1a8/0x264
[    1.379235] [cf82df60] [c01b3964] driver_register+0x6c/0x160
[    1.385043] [cf82df80] [c021aac0] of_register_driver+0x54/0x70
[    1.391040] [cf82df90] [c03ae9fc] fsl_i2c_init+0x24/0x54
[    1.396497] [cf82dfa0] [c00038a0] do_one_initcall+0x40/0x1d4
[    1.402305] [cf82dfd0] [c039a1e0] kernel_init+0xc4/0x16c
[    1.407771] [cf82dff0] [c00110d8] kernel_thread+0x4c/0x68
[    1.413300] Instruction dump:
[    1.416341] 3863256c 4bfd758d 801ac11c 2f800000 40beffd4 48140b11 2f8300=
00 41beffc8
[    1.424309] 3d20c03f 8009c2a0 2f800000 40beffb8 <0fe00000> 80010034 bac1=
0008 38210030
[    1.432600] at24 1-0050: 65536 byte 24c512 EEPROM (writable)

Stock 2.6.33 runs flawlessly.  Maybe I should add here that there is no eep=
rom connected to the I2C bus (just a placeholder in the dts file, for a chi=
p on a separate board).  Any idea what goes wrong here?

Thanks, Albrecht.

--=-gXfpNRS8GJawsA6K2/H8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLl+Q7n/9unNAn/9ERArF1AJ9dcS4NAL5jL30HD4nRyQsvTCePigCaA6v9
nc+KGcNtjQQ5lFM6EbE0kts=
=k+J4
-----END PGP SIGNATURE-----

--=-gXfpNRS8GJawsA6K2/H8--
