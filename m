Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id AC845101B03
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 19:34:58 +1100 (EST)
Received: by mail-px0-f177.google.com with SMTP id 7so1163330pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 00:34:58 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 6/6] ASoC/mpc5200: Add fudge factor to value reported by
	.pointer()
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com
Date: Sat, 07 Nov 2009 01:34:55 -0700
Message-ID: <20091107083448.18908.80366.stgit@angua>
In-Reply-To: <20091107081631.18908.82921.stgit@angua>
References: <20091107081631.18908.82921.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ALSA playback seems to be more reliable if the .pointer() hook reports
a value slightly into the period, rather than right on the period
boundary.  This patch adds a fudge factor of 1/4 the period size
to better estimate the actual position of the DMA engine in the
audio buffer.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 9c88e15..ee5a606 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -297,7 +297,7 @@ psc_dma_pointer(struct snd_pcm_substream *substream)
 	else
 		s = &psc_dma->playback;
 
-	count = s->period_current * s->period_bytes;
+	count = (s->period_current * s->period_bytes) + (s->period_bytes >> 2);
 
 	return bytes_to_frames(substream->runtime, count);
 }
