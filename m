Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E7C482C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2012 11:28:05 +1100 (EST)
Date: Fri, 26 Oct 2012 19:27:52 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Power Management issues in MPC8313 processor
To: Srivatsan Canchivaram <crsrivatstechnical@gmail.com>
In-Reply-To: <CAO_L5k-D2jMZaoxpxk_tu_=nT5T0PSSp_PUesh9gm-rNq0Qhcg@mail.gmail.com>
 (from crsrivatstechnical@gmail.com on Thu Oct 25 17:07:01 2012)
Message-ID: <1351297672.23094.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/25/2012 05:07:01 PM, Srivatsan Canchivaram wrote:
> Hi,
>=20
>=20
> I have a modem with a Freescale MPC8313E processor. I am trying to =20
> enable
> power savings in the processor by placing it in Standby mode and =20
> resume
> normal operation with a Wake-On-LAN magic packet.
>=20
>=20
> Following the directions in the Freescale Power Management app note, I
> enabled Power Management Support in the Linux kernel and device tree
> configurations.
>=20
>=20
> I ran the following command on the board:
>=20
> echo standby > /sys/power/state
>=20
>=20
> This caused the console to hang and there was no further response to
> keyboard inputs. I enabled =E2=80=98no_console_suspend=E2=80=99 in the ke=
rnel and =20
> when I
> loaded the new build and enabled standby mode, I observed an Oops =20
> trace:
>=20
>=20
>=20
> RASCOM_QCU.7.0.0013 $ echo standby > /sys/power/state
>=20
> <6>PM: Syncing fFreezing user space processes ... ilesystems ... =20
> <7>PM:
> Entering standby sleep
>=20
> Unable to handle kernel paging request for instruction fetch
>=20
> Faulting instruction address: 0x616d6570
>=20
> Oops: Kernel access of bad area, sig: 11 [#1]
>=20
> MPC831x RDB
>=20
> Modules linked in: dsp rcspi modem i2c_mpc thermal_sys lm92 hwmon =20
> [last
> unloaded: modem]
>=20
> NIP: 616d6570 LR: c0165224 CTR: 616d6573
>=20
> REGS: cd087d30 TRAP: 0400   Not tainted  (2.6.27)
>=20
> MSR: 20001032 <ME,IR,DR>  CR: 28002024  XER: 20000000
>=20
> TASK =3D cc312400[1196] 'echo' THREAD: cd086000
>=20
> GPR00: 00000002 cd087de0 cc312400 cf821800 cd087de8 00000002 c06e0000
> c06da4a0
>=20
> GPR08: c06da948 616d6573 00003fff c06c6308 28002022 10091248 0fffc000
> 100050b8
>=20
> GPR16: 1008a270 10068810 100687c8 10068814 00000000 1008c284 1008c294
> c0246180
>=20
> GPR24: c02ab9e4 c02ab9dc c06cc4f4 00000006 cd087e08 00000002 c06c595c
> cf821808
>=20
> NIP [616d6570] 0x616d6570
>=20
> LR [c0165224] platform_pm_suspend_noirq+0x84/0x88

What kernel are you using?  platform_pm_suspend_noirq was removed by =20
this commit:

commit 9b39e73d0c2b265a7f8748b0e9a9f09be84079a8
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sun Dec 18 00:34:24 2011 +0100

     PM / Sleep: Remove forward-only callbacks from platform bus type

     The forward-only PM callbacks provided by the platform bus type are
     not necessary any more, because the PM core executes driver =20
callbacks
     when the corresponding subsystem callbacks are not present, so drop
     them.

     Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

It seems that a driver's pm ops are getting corrupted -- maybe used =20
after freeing?  Have you tried enabling slab/slub debug?

Can you instrument the code to see if there are any fields in the =20
device struct that aren't corrupt, that could point out which device =20
this is?

> I found another thread that dealt with Power Management issues on the
> Freescale MPC8313 processor:
>=20
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-January/095240.html
>=20
> The resolution of this issue seems to be related to the JTAG TRST pin =20
> being
> disabled. This is not relevant in my case as the TRST on my board is
> already inactive.

If you were seeing that, you'd see a hang rather than an oops.

-Scott=
