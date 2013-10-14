Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EF40E2C016E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 06:36:43 +1100 (EST)
Subject: Re: [PATCH] powerpc/qe_lib: Share the qe_lib for the others
 architecture
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <8559CF98-88E4-4271-A873-1409359EFE5C@kernel.crashing.org>
Date: Mon, 14 Oct 2013 14:36:38 -0500
Message-Id: <408A0A65-8C77-4B8C-A28A-EA035A01C739@kernel.crashing.org>
References: <1381750622-1150-1-git-send-email-X.Xie@freescale.com>
 <8559CF98-88E4-4271-A873-1409359EFE5C@kernel.crashing.org>
To: Xie Xiaobo <X.Xie@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 14, 2013, at 2:26 PM, Kumar Gala wrote:

>=20
> On Oct 14, 2013, at 6:37 AM, Xie Xiaobo wrote:
>=20
>> The QUICC Engine (QE) is a communications coprocessors on Freescale
>> embedded processors. The QE had been applied in PowerPC architecture
>> previously, and it will be applied in ARM architecture too.
>> So move the qe_lib from arch/powerpc to driver/ firstly.
>>=20
>> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
>> ---
>> arch/powerpc/Kconfig                         |   2 -
>> arch/powerpc/include/asm/immap_qe.h          | 491 -----------------
>> arch/powerpc/include/asm/qe.h                | 740 =
-------------------------
>> arch/powerpc/include/asm/qe_ic.h             | 144 -----
>> arch/powerpc/include/asm/ucc.h               |  64 ---
>> arch/powerpc/include/asm/ucc_fast.h          | 244 --------
>> arch/powerpc/include/asm/ucc_slow.h          | 290 ----------
>> arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   4 +-
>> arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |   4 +-
>> arch/powerpc/platforms/Kconfig               |  19 -
>> arch/powerpc/sysdev/Makefile                 |   1 -
>> arch/powerpc/sysdev/qe_lib/Kconfig           |  27 -
>> arch/powerpc/sysdev/qe_lib/Makefile          |  10 -
>> arch/powerpc/sysdev/qe_lib/gpio.c            | 317 -----------
>> arch/powerpc/sysdev/qe_lib/qe.c              | 708 =
------------------------
>> arch/powerpc/sysdev/qe_lib/qe_ic.c           | 501 -----------------
>> arch/powerpc/sysdev/qe_lib/qe_ic.h           | 103 ----
>> arch/powerpc/sysdev/qe_lib/qe_io.c           | 218 --------
>> arch/powerpc/sysdev/qe_lib/ucc.c             | 213 -------
>> arch/powerpc/sysdev/qe_lib/ucc_fast.c        | 364 ------------
>> arch/powerpc/sysdev/qe_lib/ucc_slow.c        | 380 -------------
>> arch/powerpc/sysdev/qe_lib/usb.c             |  56 --

> Before this is moved you should address the PPC specific issues in the =
code.  Use of PPC_LIB_RHEAP, the IO macros which are not cross platform, =
etc.
>=20
> Also, copy linux-kernel list as I'm not sure drivers/qe would be the =
recommendation location for this to end up at.

Additionally, some of this should move to using standard driver models =
that now exist.  For example qe_ic.{c,h} should possibly look at going =
into drivers/irqchip/.  gpio.c should be looked to use gpiolib and move =
into drivers/gpio.  Some of the pinmux that exists in qe.c and ucc.c =
should look at the drivers/pinctrl and there is some amount of clk =
config that I wonder if it could move the common clk API and =
drivers/clk.

There will still be some qe_lib specific code, but vastly reduced.

- k=20
