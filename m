Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id E1EA2DE081
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 22:34:09 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1760077ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 05:34:07 -0700 (PDT)
Subject: [PATCH V5 0/5] AC97 driver for mpc5200
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
From: Jon Smirl <jonsmirl@gmail.com>
Date: Tue, 26 May 2009 08:34:04 -0400
Message-ID: <20090526123235.17472.73912.stgit@terra>
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

Version 5. Modified to use spin_event_timeout() as originally written.

---

Jon Smirl (5):
      Fabric bindings for STAC9766 on the Efika
      Support for AC97 on Phytec pmc030 base board.
      AC97 driver for mpc5200
      Main rewite of the mpc5200 audio DMA code
      powerpc: introduce macro spin_event_timeout()


 arch/powerpc/include/asm/delay.h    |   33 +++
 sound/soc/fsl/Kconfig               |   27 ++
 sound/soc/fsl/Makefile              |    5 
 sound/soc/fsl/efika-audio-fabric.c  |   90 +++++++
 sound/soc/fsl/mpc5200_dma.c         |  442 ++++++++++++++++++++++-------------
 sound/soc/fsl/mpc5200_dma.h         |   33 +--
 sound/soc/fsl/mpc5200_psc_ac97.c    |  331 ++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_psc_ac97.h    |   15 +
 sound/soc/fsl/mpc5200_psc_i2s.c     |  247 +++-----------------
 sound/soc/fsl/mpc5200_psc_i2s.h     |   12 +
 sound/soc/fsl/pcm030-audio-fabric.c |   90 +++++++
 11 files changed, 934 insertions(+), 391 deletions(-)
 create mode 100644 sound/soc/fsl/efika-audio-fabric.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
 create mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h
 create mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

-- 
Jon Smirl
jonsmirl@gmail.com
