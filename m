Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id EA039B6EF5
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 08:55:02 +1100 (EST)
Received: by ywh11 with SMTP id 11so1704845ywh.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Dec 2009 13:55:01 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa40912081333r53cdc5d4ldc45dcfdd2e7536f@mail.gmail.com>
References: <fa686aa40911042210q5bbbca2fi82911b7245d17588@mail.gmail.com>
	<fa686aa40912081333r53cdc5d4ldc45dcfdd2e7536f@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 8 Dec 2009 14:54:40 -0700
Message-ID: <fa686aa40912081354o4ac44070v7f2fa53ca385c3fb@mail.gmail.com>
Subject: Re: 2.6.33 -next tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wim Van Sebroeck <wim@iguana.be>,
	David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben, here's an updated pull request.  Can you please pull and send
them up to Linus?

I've added 4 more commits related to the 5200 GPT timer.  These
commits have also have linux-next exposure, I just had them in the
wrong branch.  One commit touches drivers/watchdog, but I got an ack
from Wim to merge it.

Cheers,
g.

The following changes since commit 22763c5cf3690a681551162c15d34d935308c8d7=
:
  Linus Torvalds (1):
        Linux 2.6.32

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next

Albrecht Dre=C3=83=C5=B8 (5):
      powerpc: tiny memcpy_(to|from)io optimisation
      mpc5200/gpt: tiny fix for gpt period limitation
      mpc52xx/wdt: OF property to enable the WDT on boot
      mpc52xx/wdt: merge WDT code into the GPT driver
      mpc52xx/wdt: remove obsolete old WDT implementation

Grant Likely (4):
      spi/mpc5200: Register SPI devices described in device tree
      powerpc/5200: Add mpc5200-spi (non-PSC) device driver
      powerpc/5200: add general purpose timer API for the MPC5200
      mmc: fix missing module license declaration in of_mmc_spi.c

John Bonesio (1):
      powerpc/5200: add LocalPlus bus FIFO device driver

John Linn (1):
      Xilinx: SPI: Fix bits_per_word for transfers

Wolfram Sang (2):
      spi/mpc52xx-psc-spi: check for valid PSC
      spi/mpc52xx: replace printk with dev_err

 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |   17 +-
 arch/powerpc/include/asm/mpc52xx.h                 |   47 ++
 arch/powerpc/kernel/io.c                           |    4 +-
 arch/powerpc/platforms/52xx/Kconfig                |    5 +
 arch/powerpc/platforms/52xx/Makefile               |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |  428 +++++++++++++++-
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c      |  560 ++++++++++++++++=
++++
 drivers/mmc/host/of_mmc_spi.c                      |    2 +
 drivers/spi/Kconfig                                |    8 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/mpc52xx_psc_spi.c                      |   25 +-
 drivers/spi/mpc52xx_spi.c                          |  520 ++++++++++++++++=
++
 drivers/spi/xilinx_spi.c                           |    3 +-
 drivers/watchdog/Kconfig                           |    4 +-
 drivers/watchdog/Makefile                          |    1 -
 drivers/watchdog/mpc5200_wdt.c                     |  293 ----------
 include/linux/spi/mpc52xx_spi.h                    |   10 +
 17 files changed, 1609 insertions(+), 320 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
 create mode 100644 drivers/spi/mpc52xx_spi.c
 delete mode 100644 drivers/watchdog/mpc5200_wdt.c
 create mode 100644 include/linux/spi/mpc52xx_spi.h


On Tue, Dec 8, 2009 at 2:33 PM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Wed, Nov 4, 2009 at 11:10 PM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>> Hi Ben, Stephen.
>>
>> I just prepared my next branch for 2.6.33:
>> git://git.secretlab.ca/git/linux-2.6 next
>>
>> Steven, can you please add this tree to your linux-next pull list?
>> This is the branch where I put stuff that gets fed up to Ben. =C2=A0This=
 is
>> separate from the branch that I'm using to collect OF related changes
>> and that you are already pulling in.
>>
>> Ben, can you please pull this branch into your -next tree for 2.6.33?
>
> Ben: ping?
>
> Are you able to pull this tree, or should I ask Linus to pull it directly=
?
>
> It contains mpc5200 and xilinx stuff. =C2=A0Some of it is SPI related, bu=
t
> I'm now the SPI co-maintainer, so I have no problem with it going in
> via your tree. =C2=A0:-) =C2=A0Regardless, I want to get it out to Linus =
ASAP.
>
> This tree has also been in linux-next for a while now, so it should be
> a safe pull.
>
> Thanks,
> g.
>
>> Andrew & David, you'll notice that I've also got some SPI and MMC
>> changes in this branch (PPC and OF related stuff) since there is no
>> current MMC maintainer, and some of these SPI patches have been
>> hanging around for a while now. =C2=A0Let me know if you object to me
>> pushing these changes personally instead of going through another
>> maintainer.
>>
>> Thanks,
>> g.
>>
>> The following changes since commit b419148e567728f6af0c3b01965c1cc141e3e=
13a:
>> =C2=A0Linus Torvalds (1):
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Linux 2.6.32-rc6
>>
>> are available in the git repository at:
>>
>> =C2=A0git://git.secretlab.ca/git/linux-2.6 next
>>
>> Albrecht Dre=C3=9F (1):
>> =C2=A0 =C2=A0 =C2=A0powerpc: tiny memcpy_(to|from)io optimisation
>>
>> Grant Likely (4):
>> =C2=A0 =C2=A0 =C2=A0spi/mpc5200: Register SPI devices described in devic=
e tree
>> =C2=A0 =C2=A0 =C2=A0powerpc/5200: Add mpc5200-spi (non-PSC) device drive=
r
>> =C2=A0 =C2=A0 =C2=A0powerpc/5200: add general purpose timer API for the =
MPC5200
>> =C2=A0 =C2=A0 =C2=A0mmc: fix missing module license declaration in of_mm=
c_spi.c
>>
>> John Bonesio (1):
>> =C2=A0 =C2=A0 =C2=A0powerpc/5200: add LocalPlus bus FIFO device driver
>>
>> John Linn (1):
>> =C2=A0 =C2=A0 =C2=A0Xilinx: SPI: Fix bits_per_word for transfers
>>
>> Wolfram Sang (2):
>> =C2=A0 =C2=A0 =C2=A0spi/mpc52xx-psc-spi: check for valid PSC
>> =C2=A0 =C2=A0 =C2=A0spi/mpc52xx: replace printk with dev_err
>>
>> =C2=A0arch/powerpc/include/asm/mpc52xx.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 46 ++
>> =C2=A0arch/powerpc/kernel/io.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +-
>> =C2=A0arch/powerpc/platforms/52xx/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A05 +
>> =C2=A0arch/powerpc/platforms/52xx/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c =C2=A0 =C2=A0 | =C2=A013=
3 ++++++-
>> =C2=A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =C2=A0560 ++++++++=
+++++++++++++++++
>> =C2=A0drivers/mmc/host/of_mmc_spi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
>> =C2=A0drivers/spi/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A08 +
>> =C2=A0drivers/spi/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0drivers/spi/mpc52xx_psc_spi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 25 +-
>> =C2=A0drivers/spi/mpc52xx_spi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0520 +++++++++++++++++++++++
>> =C2=A0drivers/spi/xilinx_spi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03 +-
>> =C2=A0include/linux/spi/mpc52xx_spi.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 10 +
>> =C2=A013 files changed, 1297 insertions(+), 21 deletions(-)
>> =C2=A0create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
>> =C2=A0create mode 100644 drivers/spi/mpc52xx_spi.c
>> =C2=A0create mode 100644 include/linux/spi/mpc52xx_spi.h
>>
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
