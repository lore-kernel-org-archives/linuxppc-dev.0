Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjbFf2jq8zDrZ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 10:31:56 +1100 (AEDT)
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S,U}20
Message-ID: <a54e6905-6124-9a59-b7ca-97cc650a8f99@maciej.szmigiero.name>
Date: Fri, 24 Nov 2017 00:31:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This format is similar to existing SNDRV_PCM_FORMAT_{S,U}20_3 that keep
20-bit PCM samples in 3 bytes, however i.MX6 platform SSI FIFO does not
allow 3-byte accesses (including DMA) so a 4-byte (more conventional)
format is needed for it.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1: Drop "_4" suffix from these formats since they aren't
non-standard ones, use empty format slots starting from format number 25
for them, add information that they are LSB justified formats.

Corresponding alsa-lib changes will be posted as soon as this patch is
merged on the kernel side, to keep alsa-lib and kernel synchronized.

 include/sound/pcm.h         |  8 ++++++++
 include/sound/soc-dai.h     |  2 ++
 include/uapi/sound/asound.h |  9 +++++++++
 sound/core/pcm_misc.c       | 16 ++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 24febf9e177c..e054c583d3b3 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -169,6 +169,10 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_IMA_ADPCM	_SNDRV_PCM_FMTBIT(IMA_ADPCM)
 #define SNDRV_PCM_FMTBIT_MPEG		_SNDRV_PCM_FMTBIT(MPEG)
 #define SNDRV_PCM_FMTBIT_GSM		_SNDRV_PCM_FMTBIT(GSM)
+#define SNDRV_PCM_FMTBIT_S20_LE	_SNDRV_PCM_FMTBIT(S20_LE)
+#define SNDRV_PCM_FMTBIT_U20_LE	_SNDRV_PCM_FMTBIT(U20_LE)
+#define SNDRV_PCM_FMTBIT_S20_BE	_SNDRV_PCM_FMTBIT(S20_BE)
+#define SNDRV_PCM_FMTBIT_U20_BE	_SNDRV_PCM_FMTBIT(U20_BE)
 #define SNDRV_PCM_FMTBIT_SPECIAL	_SNDRV_PCM_FMTBIT(SPECIAL)
 #define SNDRV_PCM_FMTBIT_S24_3LE	_SNDRV_PCM_FMTBIT(S24_3LE)
 #define SNDRV_PCM_FMTBIT_U24_3LE	_SNDRV_PCM_FMTBIT(U24_3LE)
@@ -202,6 +206,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_FLOAT		SNDRV_PCM_FMTBIT_FLOAT_LE
 #define SNDRV_PCM_FMTBIT_FLOAT64	SNDRV_PCM_FMTBIT_FLOAT64_LE
 #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE
+#define SNDRV_PCM_FMTBIT_S20		SNDRV_PCM_FMTBIT_S20_LE
+#define SNDRV_PCM_FMTBIT_U20		SNDRV_PCM_FMTBIT_U20_LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_BE
@@ -213,6 +219,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_FLOAT		SNDRV_PCM_FMTBIT_FLOAT_BE
 #define SNDRV_PCM_FMTBIT_FLOAT64	SNDRV_PCM_FMTBIT_FLOAT64_BE
 #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE
+#define SNDRV_PCM_FMTBIT_S20		SNDRV_PCM_FMTBIT_S20_BE
+#define SNDRV_PCM_FMTBIT_U20		SNDRV_PCM_FMTBIT_U20_BE
 #endif
 
 struct snd_pcm_file {
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 58acd00cae19..d970879944fc 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -102,6 +102,8 @@ struct snd_compr_stream;
 			       SNDRV_PCM_FMTBIT_S16_BE |\
 			       SNDRV_PCM_FMTBIT_S20_3LE |\
 			       SNDRV_PCM_FMTBIT_S20_3BE |\
+			       SNDRV_PCM_FMTBIT_S20_LE |\
+			       SNDRV_PCM_FMTBIT_S20_BE |\
 			       SNDRV_PCM_FMTBIT_S24_3LE |\
 			       SNDRV_PCM_FMTBIT_S24_3BE |\
                                SNDRV_PCM_FMTBIT_S32_LE |\
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index c227ccba60ae..7385024041d2 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -214,6 +214,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
 #define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
 #define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
+#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* \ 			*/
+#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* | 			*/
+#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* | in four bytes,	*/
+#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* / LSB justified	*/
+/* gap in the numbering for a future standard linear format */
 #define	SNDRV_PCM_FORMAT_SPECIAL	((__force snd_pcm_format_t) 31)
 #define	SNDRV_PCM_FORMAT_S24_3LE	((__force snd_pcm_format_t) 32)	/* in three bytes */
 #define	SNDRV_PCM_FORMAT_S24_3BE	((__force snd_pcm_format_t) 33)	/* in three bytes */
@@ -248,6 +253,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_LE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_LE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_LE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
@@ -259,6 +266,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_BE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_BE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_BE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_BE
 #endif
 
 typedef int __bitwise snd_pcm_subformat_t;
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 9be81025372f..c62bfe27106f 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -170,6 +170,22 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
 	[SNDRV_PCM_FORMAT_GSM] = {
 		.le = -1, .signd = -1,
 	},
+	[SNDRV_PCM_FORMAT_S20_LE] = {
+		.width = 20, .phys = 32, .le = 1, .signd = 1,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_S20_BE] = {
+		.width = 20, .phys = 32, .le = 0, .signd = 1,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_U20_LE] = {
+		.width = 20, .phys = 32, .le = 1, .signd = 0,
+		.silence = { 0x00, 0x00, 0x08, 0x00 },
+	},
+	[SNDRV_PCM_FORMAT_U20_BE] = {
+		.width = 20, .phys = 32, .le = 0, .signd = 0,
+		.silence = { 0x00, 0x08, 0x00, 0x00 },
+	},
 	[SNDRV_PCM_FORMAT_SPECIAL] = {
 		.le = -1, .signd = -1,
 	},
