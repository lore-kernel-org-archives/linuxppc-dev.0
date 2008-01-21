Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 87328DDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 05:53:29 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so500114anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 10:53:28 -0800 (PST)
Message-ID: <fa686aa40801211053n7cb13172vb738365b8afb4c6d@mail.gmail.com>
Date: Mon, 21 Jan 2008 11:53:27 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: Patches added to master/for-2.6.25 branch of powerpc.git
In-Reply-To: <fa686aa40801172153v69d948e5hf01d963410123f38@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>
	<fa686aa40801170752j5e41b1cbs82cd21bf47c7d92e@mail.gmail.com>
	<18320.11472.758570.408071@cargo.ozlabs.ibm.com>
	<fa686aa40801172153v69d948e5hf01d963410123f38@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/17/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 1/17/08, Paul Mackerras <paulus@samba.org> wrote:
> > Grant Likely writes:
> >
> > > Paul, can you also please pull the following 52xx changes?
> >
> > Could you please re-do your tree and make sure the headline for each
> > commit starts with "[POWERPC]" (unless it isn't powerpc-specific, in
> > which case it probably shouldn't be in your tree...).
>
> Oops, I thought I had done that.  Sorry, I'll get that respun ASAP.

Here you go; respun the 52xx patches as you requested.  Please pull.

Also, can you please merge your 2.6.25 branch with Linus' top of tree?
 There are some more patches which I'm withholding until then because
they'll cause nasty merge conflicts otherwise.

Thanks,
g.

The following changes since commit 52920df4aa9dd25836b8ed4dc0b177ea14c09e53:
  Paul Mackerras (1):
        Merge branch 'for-2.6.25' of
master.kernel.org:/.../olof/pasemi into for-2.6.25

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.25

Grant Likely (2):
      [POWERPC] mpc5200: eliminate mpc52xx_*_map_*() functions.
      [POWERPC] mpc5200: merge defconfigs for all mpc5200 boards

John Rigby (2):
      [POWERPC] Separate MPC52xx PSC FIFO registers from rest of PSC
      [POWERPC] mpc5200: Cleanup checkpatch.pl problems in mpc52xx_uart.c

Marian Balakowicz (6):
      [POWERPC] mpc5200: Add 'fsl,lpb' bus type for localplus bus
      [POWERPC] mpc5200: Add common mpc52xx_setup_pci() routine
      [POWERPC] mpc5200: Add TQM5200 DTS
      [POWERPC] mpc5200: add CM5200 DTS
      [POWERPC] mpc5200: Add Promess Motion-PRO DTS
      [POWERPC] mpc5200: Add generic support for simple MPC5200 based boards

 arch/powerpc/boot/dts/cm5200.dts             |  236 +++++
 arch/powerpc/boot/dts/lite5200.dts           |    2 +-
 arch/powerpc/boot/dts/lite5200b.dts          |    2 +-
 arch/powerpc/boot/dts/motionpro.dts          |  309 ++++++
 arch/powerpc/boot/dts/tqm5200.dts            |  184 ++++
 arch/powerpc/configs/lite5200_defconfig      |  847 -----------------
 arch/powerpc/configs/mpc5200_defconfig       | 1286 ++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/Kconfig          |   27 +-
 arch/powerpc/platforms/52xx/Makefile         |    1 +
 arch/powerpc/platforms/52xx/lite5200.c       |   22 +-
 arch/powerpc/platforms/52xx/lite5200_pm.c    |    6 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c |   85 ++
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   63 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c    |   14 +
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |    8 +-
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    8 +-
 drivers/serial/mpc52xx_uart.c                |  210 +++--
 drivers/spi/mpc52xx_psc_spi.c                |    9 +-
 include/asm-powerpc/mpc52xx.h                |    7 +-
 include/asm-powerpc/mpc52xx_psc.h            |    3 +
 include/asm-ppc/mpc52xx_psc.h                |    3 +
 21 files changed, 2317 insertions(+), 1015 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/cm5200.dts
 create mode 100644 arch/powerpc/boot/dts/motionpro.dts
 create mode 100644 arch/powerpc/boot/dts/tqm5200.dts
 delete mode 100644 arch/powerpc/configs/lite5200_defconfig
 create mode 100644 arch/powerpc/configs/mpc5200_defconfig
 create mode 100644 arch/powerpc/platforms/52xx/mpc5200_simple.c

>
> Cheers,
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
