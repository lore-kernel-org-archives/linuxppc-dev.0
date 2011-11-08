Return-Path: <r58472@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BC8B21007D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 21:27:58 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Felix Radensky <felix@embedded-sol.com>, Zhao Chenhui-B35336
 <B35336@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 3/7] powerpc/85xx: add sleep and deep sleep support
Date: Tue, 8 Nov 2011 10:27:41 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052BC8BB@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320410014-14453-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4229C.1050403@embedded-sol.com>
In-Reply-To: <4EB4229C.1050403@embedded-sol.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>To: Zhao Chenhui-B35336; linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH 3/7] powerpc/85xx: add sleep and deep sleep support
>
>Hi Zhao,
>
>From: Li Yang <leoli at freescale.com>
>
>Some Freescale chips like MPC8536 and P1022 has deep sleep PM mode in
>addtion to the sleep PM mode.
>
>In sleep PM mode, the clocks of e500 core and unused IP blocks is turned
>off. IP blocks which are allowed to wake up the processor are still
>running
>
>While in deep sleep PM mode, additionally, the power supply is removed
>from e500 core and most IP blocks. Only the blocks needed to wake up the
>chip out of deep sleep are ON.
>
>This patch supports 32-bit and 36-bit address space.
>
>The deep sleep mode is equal to the Suspend-to-RAM state of Linux Power
>Management.
>
>Command to enter deep sleep mode.
>  echo mem > /sys/power/state
>
>
>Thanks a lot for bringing this code to mainline. I was recently involved
>in enabling deep sleep on a custom P1022 board, and would like to make
>some remarks based on this experience.
>
>1. I think 85xx deep sleep code would be more complete if you also port
>FSL
>=A0=A0=A0 BSP code that saves eLBC configuration before entering deep slee=
p and
>=A0=A0=A0 restores it afterwards. Otherwise all eLBC customization done by=
 u-
>boot is lost.

Thanks for the comment.  That work is also being considered for upstream, b=
ut not in this series.

>
>2. You should implement fsl_deep_sleep() routine for 85xx. The default
>implementation
>=A0=A0=A0 in include/linux/fsl_devices.h always returns 0. The routine is =
used
>by FSL USB host
>=A0=A0=A0 driver, drivers/usb/host/ehci-fsl.c to restore USB hardware stat=
e
>after deep sleep.
>=A0=A0=A0 With default implementation USB is dead on 85xx after deep sleep=
 if
>USB PHY is
>=A0=A0=A0 powered down completely.

Added to the to-do list.  Thanks.

- Leo
