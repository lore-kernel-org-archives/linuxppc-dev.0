Return-Path: <jonsmirl@gmail.com>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id E30F5DE0B2
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 08:15:07 +1000 (EST)
Received: by gxk20 with SMTP id 20so2168440gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 15:15:05 -0700 (PDT)
Subject: [PATCH V4 0/5] AC97 driver for mpc5200
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
From: Jon Smirl <jonsmirl@gmail.com>
Date: Mon, 25 May 2009 18:15:05 -0400
Message-ID: <20090525221406.21370.30326.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Version 4. Changed timeouts to use relax_cpu() instead of udelay(). Fixed locking to lock bestcomm instead of
registers. Code reorg as requested in the various comments. Removed sysfs over/underrun reporting. Removed 
reset retries. Removing the retries makes the driver fail to load about 5% of the time. An oscilliscope is 
needed to figure out what is going on with failed resets. Both pcm030 and Efika ocasionally fail to reset 
and they use different codec chips.

---

Jon Smirl (5):
      Fabric bindings for STAC9766 on the Efika
      Support for AC97 on Phytec pmc030 base board.
      AC97 driver for mpc5200
      Main rewite of the mpc5200 audio DMA code
      The macro spin_event_timeout() takes a condition and timeout value


 arch/powerpc/include/asm/delay.h    |   33 +++
 sound/soc/fsl/Kconfig               |   27 ++
 sound/soc/fsl/Makefile              |    5 
 sound/soc/fsl/efika-audio-fabric.c  |   90 +++++++
 sound/soc/fsl/mpc5200_dma.c         |  442 ++++++++++++++++++++++-------------
 sound/soc/fsl/mpc5200_dma.h         |   43 ++-
 sound/soc/fsl/mpc5200_psc_ac97.c    |  331 ++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_psc_ac97.h    |   15 +
 sound/soc/fsl/mpc5200_psc_i2s.c     |  247 +++-----------------
 sound/soc/fsl/mpc5200_psc_i2s.h     |   12 +
 sound/soc/fsl/pcm030-audio-fabric.c |   90 +++++++
 11 files changed, 946 insertions(+), 389 deletions(-)
 create mode 100644 sound/soc/fsl/efika-audio-fabric.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
 create mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h
 create mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

-- 
Jon Smirl
jonsmirl@gmail.com
