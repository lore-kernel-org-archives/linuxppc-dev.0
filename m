Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 89097B7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 01:15:39 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A9B6EDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 01:15:38 +1000 (EST)
Date: Fri, 28 Aug 2009 19:15:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/5] powerpc/85xx: Add suspend/resume support
Message-ID: <20090828151537.GA21551@oksana.dev.rtsoft.ru>
References: <20090827173021.GD739@oksana.dev.rtsoft.ru>
	<28CAE6C1-8A32-4482-B606-6A22EE5BA5A9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <28CAE6C1-8A32-4482-B606-6A22EE5BA5A9@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2009 at 12:38:51AM -0500, Kumar Gala wrote:
> 
> On Aug 27, 2009, at 12:30 PM, Anton Vorontsov wrote:
> 
> >This patch adds suspend/resume support for MPC8540-compatible and
> >MPC8569 CPUs.
> >
> >MPC8540-compatible PMCs are trivial: we just write SLP bit into PM
> >control and status register.
> >
> >MPC8569 is a bit trickier, QE turns off during suspend and so on
> >resume we must reload QE microcode firmware and reset QE.
> >
> >So far we don't support Deep Sleep mode as found in newer MPC85xx
> >CPUs (i.e. MPC8536). It can be relatively easy implemented though,
> >and for it we reserve 'mem' suspend type.
> >
> >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >---
> >arch/powerpc/Kconfig                  |    2 +-
> >arch/powerpc/platforms/85xx/Makefile  |    1 +
> >arch/powerpc/platforms/85xx/suspend.c |  115
> >+++++++++++++++++++++++++++++++++
> >3 files changed, 117 insertions(+), 1 deletions(-)
> >create mode 100644 arch/powerpc/platforms/85xx/suspend.c
> 
> How did you test this?

--- Prerequisites:

1. Following patches should be applied in addition:

   rtc: Set wakeup capability for I2C and SPI RTC drivers
   [5/5] ucc_geth: Implement suspend/resume and Wake-On-LAN support
   [4/5] ucc_geth: Remove UGETH_MAGIC_PACKET Kconfig symbol and code
   [3/5] ucc_geth: Factor out MAC initialization steps into a call
   [2/5] powerpc/qe: Implement qe_alive_during_sleep() helper function
   [1/5] ucc_geth: Fix NULL pointer dereference in uec_get_ethtool_stats()

2. QE microcode should be placed into /lib/firmware/, i.e.
   wget http://opensource.freescale.com/firmware/fsl_qe_ucode_8569_10.zip
   unzip fsl_qe_ucode_8569_10.zip
   cp fsl_qe_ucode_8569_10.bin /<nfsroot>/lib/firmware/fsl_qe_ucode_8569.bin

--- Wakeup on RTC alarm:

# cd /sys/class/rtc/rtc0/
# echo $(( `cat since_epoch` + 10 )) > wakealarm
# echo standby > /sys/power/state
mpc85xx-pmc e00e0080.power: firmware: requesting fsl_qe_ucode_8569.bin
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.


The board is now suspended, CPU asserted ASLEEP signal that is
reflected by the ASLEEP LED on the board (the LED is near UEC2
port). 10 seconds later the board will wakeup:

qe-firmware: firmware 'MPC8569 QE Microcode Rel_B6900155' for 8569 V1.0
qe-firmware: uploading microcode 'MPC8569 QE Microcode Rel_B69001' version 1.0.0
pci 0000:00:00.0: enabling device (0106 -> 0107)
Restarting tasks ... done.
PHY: mdio@e0082120:07 - Link is Up - 100/Full

--- Wakeup on PHY/link changes (no magic packet support in MPC8569, as
    QE turns off during sleep):

# ethtool -s eth0 wol p
# echo standby > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.


To wakeup, trigger the PHY interrupt (e.g. pull out the ethernet
cable from eth0):

qe-firmware: firmware 'MPC8569 QE Microcode Rel_B6900155' for 8569 V1.0
qe-firmware: uploading microcode 'MPC8569 QE Microcode Rel_B69001' version 1.0.0
pci 0000:00:00.0: enabling device (0106 -> 0107)
Restarting tasks ... done.


UCC magic packet detection was tested on MPC8360E-MDS boards
(ethtool -s eth0 wol g), I'll send power management support
patches for 83xx QE boards soon.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
