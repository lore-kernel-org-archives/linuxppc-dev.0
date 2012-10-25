Return-Path: <crsrivatstechnical@gmail.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 176E52C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2012 09:07:05 +1100 (EST)
Received: by mail-we0-f179.google.com with SMTP id z49so1079275wey.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 15:07:02 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 25 Oct 2012 18:07:01 -0400
Message-ID: <CAO_L5k-D2jMZaoxpxk_tu_=nT5T0PSSp_PUesh9gm-rNq0Qhcg@mail.gmail.com>
Subject: Power Management issues in MPC8313 processor
From: Srivatsan Canchivaram <crsrivatstechnical@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=f46d04428354399bab04cce96cf9
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04428354399bab04cce96cf9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,


I have a modem with a Freescale MPC8313E processor. I am trying to enable
power savings in the processor by placing it in Standby mode and resume
normal operation with a Wake-On-LAN magic packet.


Following the directions in the Freescale Power Management app note, I
enabled Power Management Support in the Linux kernel and device tree
configurations.


I ran the following command on the board:

echo standby > /sys/power/state


This caused the console to hang and there was no further response to
keyboard inputs. I enabled =91no_console_suspend=92 in the kernel and when =
I
loaded the new build and enabled standby mode, I observed an Oops trace:



RASCOM_QCU.7.0.0013 $ echo standby > /sys/power/state

<6>PM: Syncing fFreezing user space processes ... ilesystems ... <7>PM:
Entering standby sleep

Unable to handle kernel paging request for instruction fetch

Faulting instruction address: 0x616d6570

Oops: Kernel access of bad area, sig: 11 [#1]

MPC831x RDB

Modules linked in: dsp rcspi modem i2c_mpc thermal_sys lm92 hwmon [last
unloaded: modem]

NIP: 616d6570 LR: c0165224 CTR: 616d6573

REGS: cd087d30 TRAP: 0400   Not tainted  (2.6.27)

MSR: 20001032 <ME,IR,DR>  CR: 28002024  XER: 20000000

TASK =3D cc312400[1196] 'echo' THREAD: cd086000

GPR00: 00000002 cd087de0 cc312400 cf821800 cd087de8 00000002 c06e0000
c06da4a0

GPR08: c06da948 616d6573 00003fff c06c6308 28002022 10091248 0fffc000
100050b8

GPR16: 1008a270 10068810 100687c8 10068814 00000000 1008c284 1008c294
c0246180

GPR24: c02ab9e4 c02ab9dc c06cc4f4 00000006 cd087e08 00000002 c06c595c
cf821808

NIP [616d6570] 0x616d6570

LR [c0165224] platform_pm_suspend_noirq+0x84/0x88

Call Trace:

[cd087de0] [c0167e6c] pm_dev_dbg+0x70/0x18c (unreliable)

[cd087df0] [c0167cb4] pm_noirq_op+0x58/0xc8

[cd087e00] [c0168e08] device_power_down+0x78/0x1c4

[cd087e40] [c00471bc] suspend_devices_and_enter+0x1ec/0x258

[cd087e70] [c00473ac] enter_state+0x13c/0x198

[cd087e90] [c00474bc] state_store+0xb4/0xf8

[cd087eb0] [c013af68] kobj_attr_store+0x24/0x3c

[cd087ec0] [c00bf734] sysfs_write_file+0xe8/0x1e8

[cd087ef0] [c0078bbc] vfs_write+0xb4/0x16c

[cd087f10] [c0078d7c] sys_write+0x4c/0xa4

[cd087f40] [c000fa88] ret_from_syscall+0x0/0x38

--- Exception: c01 at 0x4802679c

    LR =3D 0x4803f0e8

Instruction dump:

XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX

XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX

---[ end trace b6a2457eea68b760 ]---

done.

<7>PM: Preparing system for standby sleep

<1>Freezing user space processes ... <7>PM: Entering standby sleep

<7>platform mpc83xx_wdt.0: preparing suspend

<7>fsl-gianfar fsl-gianfar.0: preparing suspend

<7>fsl-gianfar fsl-gianfar.1: preparing suspend

<7>fsl-gianfar_mdio fsl-gianfar_mdio.14: preparing suspend

<7>serial8250 serial8250.0: preparing suspend

<7>serial8250 serial8250: preparing suspend

<7>platform Fixed MDIO bus.0: preparing suspend

<7>lm92 0-0049: legacy suspend

<7>lm92 0-0048: legacy suspend

<7>platform Fixed MDIO bus.0: suspend

<7>mdio_bus 24520:1f: legacy suspend

<7>Generic PHY 24520:01: legacy suspend

<7>Generic PHY 24520:00: legacy suspend

<7>serial8250 serial8250: suspend

<7>of_platform ee000600.timer: legacy suspend

<7>of_platform ee000500.timer: legacy suspend

<7>mpc83xx-pmc ee000b00.power: legacy suspend

<7>of_platform ee000700.pic: legacy suspend

<7>of_platform ee030000.crypto: legacy suspend

<7>of_platform ee004600.serial: legacy suspend

<7>of_platform ee004500.serial: legacy suspend

<7>of_platform ee025000.ethernet: legacy suspend

<7>of_platform ee024000.ethernet: legacy suspend

<7>of_platform ee024520.mdio: legacy suspend

<7>of_platform ee024e00.ptimer: legacy suspend

<7>of_platform ee0082a8.dma: legacy suspend

<7>mpc-i2c ee003100.i2c: legacy suspend

<7>mpc-i2c ee003000.i2c: legacy suspend

<7>of_platform ee000200.wdt: legacy suspend

<7>of_platform ee000000.soc8313: legacy suspend

<7>of-flash fc000000.flash: legacy suspend

<7>of_platform ee005000.localbus: legacy suspend

<7>serial8250 serial8250.0: suspend

<7>fsl-gianfar_mdio fsl-gianfar_mdio.14: suspend

<7>fsl-gianfar fsl-gianfar.1: suspend

<7>fsl-gianfar fsl-gianfar.0: suspend

<7>platform mpc83xx_wdt.0: suspend

<6>PM: suspend devices took 0.000 seconds

<7>platform Fixed MDIO bus.0: LATE suspend

<7>serial8250 serial8250: LATE suspend

<7>serial8250 serial8250.0: LATE suspend

<7>fsl-gianfar_mdio fsl-gianfar_mdio.14: LATE suspend

<1>Unable to handle kernel paging request for instruction fetch

<1>Faulting instruction address: 0x616d6570

<1>Oops: Kernel access of bad area, sig: 11 [#1]

<1>MPC831x RDB

<1>Modules linked in: dsp rcspi modem i2c_mpc thermal_sys lm92 hwmon [last
unloaded: modem]

<1>NIP: 616d6570 LR: c0165224 CTR: 616d6573

<1>REGS: cd087d30 TRAP: 0400   Not tainted  (2.6.27)

<1>MSR: 20001032 <ME,IR,DR>  CR: 28002024  XER: 20000000

<1>TASK =3D cc312400[1196] 'echo' THREAD: cd086000

<6>GPR00: 00000002 cd087de0 cc312400 cf821800 cd087de8 00000002 c06e0000
c06da4a0

<6>GPR08: c06da948 616d6573 00003fff c06c6308 28002022 10091248 0fffc000
100050b8

<6>GPR16: 1008a270 10068810 100687c8 10068814 00000000 1008c284 1008c294
c0246180

<6>GPR24: c02ab9e4 c02ab9dc c06cc4f4 00000006 cd087e08 00000002 c06c595c
cf821808

<1>NIP [616d6570] 0x616d6570

<1>LR [c0165224] platform_pm_suspend_noirq+0x84/0x88

<1>Call Trace:

<1>[cd087de0] [c0167e6c] pm_dev_dbg+0x70/0x18c (unreliable)

<1>[cd087df0] [c0167cb4] pm_noirq_op+0x58/0xc8

<1>[cd087e00] [c0168e08] device_power_down+0x78/0x1c4

<1>[cd087e40] [c00471bc] suspend_devices_and_enter+0x1ec/0x258

<1>[cd087e70] [c00473ac] enter_state+0x13c/0x198

<1>[cd087e90] [c00474bc] state_store+0xb4/0xf8

<1>[cd087eb0] [c013af68] kobj_attr_store+0x24/0x3c

<1>[cd087ec0] [c00bf734] sysfs_write_file+0xe8/0x1e8

<1>[cd087ef0] [c0078bbc] vfs_write+0xb4/0x16c

<1>[cd087f10] [c0078d7c] sys_write+0x4c/0xa4

<1>[cd087f40] [c000fa88] ret_from_syscall+0x0/0x38

<1>--- Exception: c01 at 0x4802679c

<1>    LR =3D 0x4803f0e8

<1>Instruction dump:

<1>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX

<1>XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX

<4>---[ end trace b6a2457eea68b760 ]---

Segmentation fault




I tried commenting out the kernel code in drivers/base/platform.c ->
platform_legacy_suspend_late() function:

/*     if (dev->driver && drv->suspend_late)

       { } */


This prevents the segmentation fault but it causes the resume functions for
all the peripherals to be called as soon as the suspend operations are
complete i.e. the processor goes into standby and then immediately goes
back to normal operation.


I found another thread that dealt with Power Management issues on the
Freescale MPC8313 processor:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-January/095240.html

The resolution of this issue seems to be related to the JTAG TRST pin being
disabled. This is not relevant in my case as the TRST on my board is
already inactive.


Any advice or suggestions are most welcome.


Thanks,

Srivatsan

--f46d04428354399bab04cce96cf9
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<p class=3D"MsoNormal">Hi,</p><p class=3D"MsoNormal"><br></p>

<p class=3D"MsoNormal">I have a modem with a Freescale MPC8313E processor. =
I am trying
to enable power savings in the processor by placing it in Standby mode and
resume normal operation with a Wake-On-LAN magic packet. </p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Following the directi=
ons in the Freescale Power Management
app note, I enabled Power Management Support in the Linux kernel and device
tree configurations. =A0</p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">I ran the following c=
ommand on the board:</p>

<p class=3D"MsoNormal">echo standby &gt; /sys/power/state</p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">This caused the conso=
le to hang and there was no further response
to keyboard inputs. I enabled =91no_console_suspend=92 in the kernel and wh=
en I
loaded the new build and enabled standby mode, I observed an Oops trace:</p=
>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal"><br></p><p class=3D"M=
soNormal">RASCOM_QCU.7.0.0013 $ echo standby &gt; /sys/power/state</p>

<p class=3D"MsoNormal">&lt;6&gt;PM: Syncing fFreezing user space processes =
...
ilesystems ... &lt;7&gt;PM: Entering standby sleep</p>

<p class=3D"MsoNormal">Unable to handle kernel paging request for instructi=
on fetch</p>

<p class=3D"MsoNormal">Faulting instruction address: 0x616d6570</p>

<p class=3D"MsoNormal">Oops: Kernel access of bad area, sig: 11 [#1]</p>

<p class=3D"MsoNormal">MPC831x RDB</p>

<p class=3D"MsoNormal">Modules linked in: dsp rcspi modem i2c_mpc thermal_s=
ys lm92
hwmon [last unloaded: modem]</p>

<p class=3D"MsoNormal">NIP: 616d6570 LR: c0165224 CTR: 616d6573</p>

<p class=3D"MsoNormal">REGS: cd087d30 TRAP: 0400=A0=A0
Not tainted=A0 (2.6.27)</p>

<p class=3D"MsoNormal">MSR: 20001032 &lt;ME,IR,DR&gt;=A0 CR: 28002024=A0
XER: 20000000</p>

<p class=3D"MsoNormal">TASK =3D cc312400[1196] &#39;echo&#39; THREAD: cd086=
000</p>

<p class=3D"MsoNormal">GPR00: 00000002 cd087de0 cc312400 cf821800 cd087de8 =
00000002
c06e0000 c06da4a0</p>

<p class=3D"MsoNormal">GPR08: c06da948 616d6573 00003fff c06c6308 28002022 =
10091248
0fffc000 100050b8</p>

<p class=3D"MsoNormal">GPR16: 1008a270 10068810 100687c8 10068814 00000000 =
1008c284
1008c294 c0246180</p>

<p class=3D"MsoNormal">GPR24: c02ab9e4 c02ab9dc c06cc4f4 00000006 cd087e08 =
00000002
c06c595c cf821808</p>

<p class=3D"MsoNormal">NIP [616d6570] 0x616d6570</p>

<p class=3D"MsoNormal">LR [c0165224] platform_pm_suspend_noirq+0x84/0x88</p=
>

<p class=3D"MsoNormal">Call Trace:</p>

<p class=3D"MsoNormal">[cd087de0] [c0167e6c] pm_dev_dbg+0x70/0x18c (unrelia=
ble)</p>

<p class=3D"MsoNormal">[cd087df0] [c0167cb4] pm_noirq_op+0x58/0xc8</p>

<p class=3D"MsoNormal">[cd087e00] [c0168e08] device_power_down+0x78/0x1c4</=
p>

<p class=3D"MsoNormal">[cd087e40] [c00471bc] suspend_devices_and_enter+0x1e=
c/0x258</p>

<p class=3D"MsoNormal">[cd087e70] [c00473ac] enter_state+0x13c/0x198</p>

<p class=3D"MsoNormal">[cd087e90] [c00474bc] state_store+0xb4/0xf8</p>

<p class=3D"MsoNormal">[cd087eb0] [c013af68] kobj_attr_store+0x24/0x3c</p>

<p class=3D"MsoNormal">[cd087ec0] [c00bf734] sysfs_write_file+0xe8/0x1e8</p=
>

<p class=3D"MsoNormal">[cd087ef0] [c0078bbc] vfs_write+0xb4/0x16c</p>

<p class=3D"MsoNormal">[cd087f10] [c0078d7c] sys_write+0x4c/0xa4</p>

<p class=3D"MsoNormal">[cd087f40] [c000fa88] ret_from_syscall+0x0/0x38</p>

<p class=3D"MsoNormal">--- Exception: c01 at 0x4802679c</p>

<p class=3D"MsoNormal">=A0=A0 =A0LR =3D 0x4803f0e8</p>

<p class=3D"MsoNormal">Instruction dump:</p>

<p class=3D"MsoNormal">XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXX=
X
XXXXXXXX XXXXXXXX</p>

<p class=3D"MsoNormal">XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXX=
X
XXXXXXXX XXXXXXXX</p>

<p class=3D"MsoNormal">---[ end trace b6a2457eea68b760 ]---</p>

<p class=3D"MsoNormal">done.</p>

<p class=3D"MsoNormal">&lt;7&gt;PM: Preparing system for standby sleep</p>

<p class=3D"MsoNormal">&lt;1&gt;Freezing user space processes ... &lt;7&gt;=
PM:
Entering standby sleep</p>

<p class=3D"MsoNormal">&lt;7&gt;platform mpc83xx_wdt.0: preparing suspend</=
p>

<p class=3D"MsoNormal">&lt;7&gt;fsl-gianfar fsl-gianfar.0: preparing suspen=
d</p>

<p class=3D"MsoNormal">&lt;7&gt;fsl-gianfar fsl-gianfar.1: preparing suspen=
d</p>

<p class=3D"MsoNormal">&lt;7&gt;fsl-gianfar_mdio fsl-gianfar_mdio.14: prepa=
ring
suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;serial8250 serial8250.0: preparing suspend<=
/p>

<p class=3D"MsoNormal">&lt;7&gt;serial8250 serial8250: preparing suspend</p=
>

<p class=3D"MsoNormal">&lt;7&gt;platform Fixed MDIO bus.0: preparing suspen=
d</p>

<p class=3D"MsoNormal">&lt;7&gt;lm92 0-0049: legacy suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;lm92 0-0048: legacy suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;platform Fixed MDIO bus.0: suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;mdio_bus 24520:1f: legacy suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;Generic PHY 24520:01: legacy suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;Generic PHY 24520:00: legacy suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;serial8250 serial8250: suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee000600.timer: legacy suspend<=
/p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee000500.timer: legacy suspend<=
/p>

<p class=3D"MsoNormal">&lt;7&gt;mpc83xx-pmc ee000b00.power: legacy suspend<=
/p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee000700.pic: legacy suspend</p=
>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee030000.crypto: legacy suspend=
</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee004600.serial: legacy suspend=
</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee004500.serial: legacy suspend=
</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee025000.ethernet: legacy suspe=
nd</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee024000.ethernet: legacy suspe=
nd</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee024520.mdio: legacy suspend</=
p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee024e00.ptimer: legacy suspend=
</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee0082a8.dma: legacy suspend</p=
>

<p class=3D"MsoNormal">&lt;7&gt;mpc-i2c ee003100.i2c: legacy suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;mpc-i2c ee003000.i2c: legacy suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee000200.wdt: legacy suspend</p=
>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee000000.soc8313: legacy suspen=
d</p>

<p class=3D"MsoNormal">&lt;7&gt;of-flash fc000000.flash: legacy suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;of_platform ee005000.localbus: legacy suspe=
nd</p>

<p class=3D"MsoNormal">&lt;7&gt;serial8250 serial8250.0: suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;fsl-gianfar_mdio fsl-gianfar_mdio.14: suspe=
nd</p>

<p class=3D"MsoNormal">&lt;7&gt;fsl-gianfar fsl-gianfar.1: suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;fsl-gianfar fsl-gianfar.0: suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;platform mpc83xx_wdt.0: suspend</p>

<p class=3D"MsoNormal">&lt;6&gt;PM: suspend devices took 0.000 seconds</p>

<p class=3D"MsoNormal">&lt;7&gt;platform Fixed MDIO bus.0: LATE suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;serial8250 serial8250: LATE suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;serial8250 serial8250.0: LATE suspend</p>

<p class=3D"MsoNormal">&lt;7&gt;fsl-gianfar_mdio fsl-gianfar_mdio.14: LATE =
suspend</p>

<p class=3D"MsoNormal">&lt;1&gt;Unable to handle kernel paging request for
instruction fetch</p>

<p class=3D"MsoNormal">&lt;1&gt;Faulting instruction address: 0x616d6570</p=
>

<p class=3D"MsoNormal">&lt;1&gt;Oops: Kernel access of bad area, sig: 11 [#=
1]</p>

<p class=3D"MsoNormal">&lt;1&gt;MPC831x RDB</p>

<p class=3D"MsoNormal">&lt;1&gt;Modules linked in: dsp rcspi modem i2c_mpc
thermal_sys lm92 hwmon [last unloaded: modem]</p>

<p class=3D"MsoNormal">&lt;1&gt;NIP: 616d6570 LR: c0165224 CTR: 616d6573</p=
>

<p class=3D"MsoNormal">&lt;1&gt;REGS: cd087d30 TRAP: 0400=A0=A0 Not tainted=
=A0
(2.6.27)</p>

<p class=3D"MsoNormal">&lt;1&gt;MSR: 20001032 &lt;ME,IR,DR&gt;=A0 CR: 28002=
024=A0
XER: 20000000</p>

<p class=3D"MsoNormal">&lt;1&gt;TASK =3D cc312400[1196] &#39;echo&#39; THRE=
AD: cd086000</p>

<p class=3D"MsoNormal">&lt;6&gt;GPR00: 00000002 cd087de0 cc312400 cf821800 =
cd087de8
00000002 c06e0000 c06da4a0</p>

<p class=3D"MsoNormal">&lt;6&gt;GPR08: c06da948 616d6573 00003fff c06c6308 =
28002022
10091248 0fffc000 100050b8</p>

<p class=3D"MsoNormal">&lt;6&gt;GPR16: 1008a270 10068810 100687c8 10068814 =
00000000
1008c284 1008c294 c0246180</p>

<p class=3D"MsoNormal">&lt;6&gt;GPR24: c02ab9e4 c02ab9dc c06cc4f4 00000006 =
cd087e08
00000002 c06c595c cf821808</p>

<p class=3D"MsoNormal">&lt;1&gt;NIP [616d6570] 0x616d6570</p>

<p class=3D"MsoNormal">&lt;1&gt;LR [c0165224] platform_pm_suspend_noirq+0x8=
4/0x88</p>

<p class=3D"MsoNormal">&lt;1&gt;Call Trace:</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087de0] [c0167e6c] pm_dev_dbg+0x70/0x18c
(unreliable)</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087df0] [c0167cb4] pm_noirq_op+0x58/0xc8=
</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087e00] [c0168e08] device_power_down+0x7=
8/0x1c4</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087e40] [c00471bc] suspend_devices_and_e=
nter+0x1ec/0x258</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087e70] [c00473ac] enter_state+0x13c/0x1=
98</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087e90] [c00474bc] state_store+0xb4/0xf8=
</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087eb0] [c013af68] kobj_attr_store+0x24/=
0x3c</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087ec0] [c00bf734] sysfs_write_file+0xe8=
/0x1e8</p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087ef0] [c0078bbc] vfs_write+0xb4/0x16c<=
/p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087f10] [c0078d7c] sys_write+0x4c/0xa4</=
p>

<p class=3D"MsoNormal">&lt;1&gt;[cd087f40] [c000fa88] ret_from_syscall+0x0/=
0x38</p>

<p class=3D"MsoNormal">&lt;1&gt;--- Exception: c01 at 0x4802679c</p>

<p class=3D"MsoNormal">&lt;1&gt;=A0=A0=A0 LR =3D
0x4803f0e8</p>

<p class=3D"MsoNormal">&lt;1&gt;Instruction dump:</p>

<p class=3D"MsoNormal">&lt;1&gt;XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXX=
X
XXXXXXXX XXXXXXXX XXXXXXXX</p>

<p class=3D"MsoNormal">&lt;1&gt;XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXX=
X
XXXXXXXX XXXXXXXX XXXXXXXX</p>

<p class=3D"MsoNormal">&lt;4&gt;---[ end trace b6a2457eea68b760 ]---</p>

<p class=3D"MsoNormal">Segmentation fault</p>

<p class=3D"MsoNormal">=A0</p><p class=3D"MsoNormal"><br></p>

<p class=3D"MsoNormal">I tried commenting out the kernel code in drivers/ba=
se/platform.c
-&gt; platform_legacy_suspend_late() function:</p>

<p class=3D"MsoNormal">/*=A0=A0=A0=A0 if
(dev-&gt;driver &amp;&amp; drv-&gt;suspend_late)</p>

<p class=3D"MsoNormal">=A0=A0=A0=A0=A0=A0 { } */</p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">This prevents the seg=
mentation fault but it causes the resume
functions for all the peripherals to be called as soon as the suspend
operations are complete i.e. the processor goes into standby and then immed=
iately
goes back to normal operation.</p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">I found another threa=
d that dealt with Power Management
issues on the Freescale MPC8313 processor:</p>

<p class=3D"MsoNormal"><a href=3D"https://lists.ozlabs.org/pipermail/linuxp=
pc-dev/2012-January/095240.html">https://lists.ozlabs.org/pipermail/linuxpp=
c-dev/2012-January/095240.html</a>
</p>

<p class=3D"MsoNormal">The resolution of this issue seems to be related to =
the JTAG
TRST pin being disabled. This is not relevant in my case as the TRST on my
board is already inactive.</p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Any advice or suggest=
ions are most welcome.</p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Thanks,</p>

<p class=3D"MsoNormal">Srivatsan</p>

--f46d04428354399bab04cce96cf9--
