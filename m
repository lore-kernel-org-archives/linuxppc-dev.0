Return-Path: <jonsmirl@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 64393DE0FF
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:38:52 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so1577999anc.39
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 18:38:50 -0700 (PDT)
Subject: [PATCH V3 0/4] mpc5200 audio rework for AC97
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@sirena.org.uk
From: Jon Smirl <jonsmirl@gmail.com>
Date: Sun, 24 May 2009 21:38:45 -0400
Message-ID: <20090525013606.3073.86753.stgit@terra>
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

The following series implements audio support for the mpc5200. It adds an AC97 driver and STAC9766 codec driver. 
Board support for the Efika and Phytec pcm030 are also included.

I've tried to implement the feedback received on the previous two versions.

based on commit 0bc53a67ac831ec84f730a657dbcadd80a589ef5 on broonie/for-2.6.31 at
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

---

Jon Smirl (4):
      Fabric bindings for STAC9766 on the Efika
      Support for AC97 on Phytec pmc030 base board.
      AC97 driver for mpc5200
      Main rewite of the mpc5200 audio DMA code


 sound/soc/fsl/Kconfig               |   27 ++
 sound/soc/fsl/Makefile              |    5 
 sound/soc/fsl/efika-audio-fabric.c  |   95 +++++++
 sound/soc/fsl/mpc5200_dma.c         |  504 +++++++++++++++++++++++------------
 sound/soc/fsl/mpc5200_dma.h         |   33 +-
 sound/soc/fsl/mpc5200_psc_ac97.c    |  392 +++++++++++++++++++++++++++
 sound/soc/fsl/mpc5200_psc_ac97.h    |   15 +
 sound/soc/fsl/mpc5200_psc_i2s.c     |  247 +++--------------
 sound/soc/fsl/mpc5200_psc_i2s.h     |   12 +
 sound/soc/fsl/pcm030-audio-fabric.c |   95 +++++++
 10 files changed, 1036 insertions(+), 389 deletions(-)
 create mode 100644 sound/soc/fsl/efika-audio-fabric.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.c
 create mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h
 create mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h
 create mode 100644 sound/soc/fsl/pcm030-audio-fabric.c

-- 
Jon Smirl
jonsmirl@gmail.com
