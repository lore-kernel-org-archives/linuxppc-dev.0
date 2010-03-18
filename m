Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
	[209.85.211.177]) by ozlabs.org (Postfix) with ESMTP id 61D0DB7D1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 01:28:49 +1100 (EST)
Received: by ywh7 with SMTP id 7so943011ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 07:28:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa41003111311w2a2c2707yddfe90c953b92be@mail.gmail.com>
References: <fa686aa41003111311w2a2c2707yddfe90c953b92be@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 08:28:27 -0600
Message-ID: <fa686aa41003180728r4867fedei67c664815679f542@mail.gmail.com>
Subject: [git pull updated] driver bug fixes and mpc5200 defconfig updates
To: linuxppc-dev@lists.ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Miller <davem@davemloft.net>, Scott Ellis <scott@jumpnowtek.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus,  I've updated my merge branch to add a build fix (mpc52xx)
and an OF regression (fix comparison...).  Please pull.

Thanks,
g.

The following changes since commit 57d54889cd00db2752994b389ba714138652e60c=
:
  Linus Torvalds (1):
        Linux 2.6.34-rc1

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

David Miller (1):
      uartlite: Fix build on sparc.

Grant Likely (3):
      powerpc/52xx: update defconfigs
      of: Fix comparison of "compatible" properties
      powerpc/5200: Build fix for mpc52xx watchdog timer code

Scott Ellis (2):
      spi/omap2_mcspi: fix NULL pointer dereference
      spi/omap2_mcspi: Use transaction speed if provided

 arch/powerpc/configs/52xx/cm5200_defconfig    |   24 ++--
 arch/powerpc/configs/52xx/lite5200b_defconfig |   28 +++--
 arch/powerpc/configs/52xx/motionpro_defconfig |   25 +++--
 arch/powerpc/configs/52xx/pcm030_defconfig    |   27 +++---
 arch/powerpc/configs/52xx/tqm5200_defconfig   |   28 +++---
 arch/powerpc/configs/mpc5200_defconfig        |  134 ++++++++++++++++-----=
----
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |    6 +-
 drivers/serial/uartlite.c                     |   10 +-
 drivers/spi/omap2_mcspi.c                     |   18 ++-
 include/linux/of.h                            |    2 +-
 10 files changed, 183 insertions(+), 119 deletions(-)


On Thu, Mar 11, 2010 at 3:11 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> Hi Linus,
>
> Here are some driver bug fixes, and the requisite powerpc-mpc5200
> defconfig updates. =A0The defconfig updates would normally go through
> Ben's tree, but since that is the only change I have that would go
> through his tree I'm hoping that it is okay to have it here.
>
> Cheers,
> g.
>
> The following changes since commit 57d54889cd00db2752994b389ba714138652e6=
0c:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 2.6.34-rc1
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 merge
>
> David Miller (1):
> =A0 =A0 =A0uartlite: Fix build on sparc.
>
> Grant Likely (1):
> =A0 =A0 =A0powerpc/52xx: update defconfigs
>
> Scott Ellis (2):
> =A0 =A0 =A0spi/omap2_mcspi: fix NULL pointer dereference
> =A0 =A0 =A0spi/omap2_mcspi: Use transaction speed if provided
>
> =A0arch/powerpc/configs/52xx/cm5200_defconfig =A0 =A0| =A0 24 ++--
> =A0arch/powerpc/configs/52xx/lite5200b_defconfig | =A0 28 +++--
> =A0arch/powerpc/configs/52xx/motionpro_defconfig | =A0 25 +++--
> =A0arch/powerpc/configs/52xx/pcm030_defconfig =A0 =A0| =A0 27 +++---
> =A0arch/powerpc/configs/52xx/tqm5200_defconfig =A0 | =A0 28 +++---
> =A0arch/powerpc/configs/mpc5200_defconfig =A0 =A0 =A0 =A0| =A0134 +++++++=
+++++++++---------
> =A0drivers/serial/uartlite.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 10 +-
> =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 18 ++-
> =A08 files changed, 177 insertions(+), 117 deletions(-)
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
