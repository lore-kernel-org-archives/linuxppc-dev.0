Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id ACF20DDFCF
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 09:12:57 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1211819ywt.39
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 16:12:56 -0700 (PDT)
Subject: [PATCH V2 0/9] mpc5200 audio rework for AC97
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk
From: Jon Smirl <jonsmirl@gmail.com>
Date: Sat, 23 May 2009 19:12:55 -0400
Message-ID: <20090523231148.17919.46103.stgit@terra>
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

The following series implements audio support for the mpc5200. It adds an AC97 driver and STAC9766 codec driver. Board support for the Efika and Phytec pcm030 are also included. 

Mark is not enthused about soc-of-simple.c so rather than extend it for AC97 I altered the drivers to not use it. Instead they use the old way of manually binding everything. Mark would like to see OF binding more closely integrated to the core. Once a proper solution for OF binding is agreed upon it is easy to convert the existing drivers. A first step would be converting the existing codec drivers so that they can be dynamically loaded. 

Grant, please check over the spin locking on register access. I'm not clear on why and when the registers have to be protected.

Once these basic drivers are in-kernel and more people are testing them, I can add more features like pause/resume, power management, etc based on feedback.

I2S will get examined in more detail for the next kernel cycle. Our multi-channel prototype I2S hardware is just about working. Once I get the multi-channel hardware I will implement and heavily test a lot more I2S capability.

---

Jon Smirl (9):
      Support for AC97 on Phytec pmc030 base board.
      Fabric bindings for STAC9766 on the Efika
      AC97 driver for mpc5200
      Codec for STAC9766 used on the Efika
      Main rewite of the mpc5200 audio DMA code
      Add a few more mpc5200 PSC defines
      Rename the PSC functions to DMA
      Basic split of mpc5200 DMA code out from mpc5200_psc_i2s
      Register the wm9712 DAIs on module load


 sound/soc/fsl/Kconfig               |   31 +
 sound/soc/fsl/Makefile              |    7 
 sound/soc/fsl/efika-audio-fabric.c  |   94 ++++
 sound/soc/fsl/mpc5200_dma.c         |  635 ++++++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_dma.h         |   80 ++++
 sound/soc/fsl/mpc5200_psc_ac97.c    |  394 ++++++++++++++++++
 sound/soc/fsl/mpc5200_psc_ac97.h    |   15 +
 sound/soc/fsl/mpc5200_psc_i2s.c     |  750 ++---------------------------------
 sound/soc/fsl/mpc5200_psc_i2s.h     |   12 +
 sound/soc/fsl/pcm030-audio-fabric.c |   94 ++++
 10 files changed, 1414 insertions(+), 698 deletions(-)
 create mode 100644 sound/soc/fsl/efika-audio-fabric.c
 create mode 100644 sound/soc/fsl/mpc5200_dma.c
 create mode 100644 sound/soc/fsl/mpc5200_dma.h
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
 create mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h
 create mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

-- 
Jon Smirl
jonsmirl@gmail.com
