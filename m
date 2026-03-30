Return-Path: <linuxppc-dev+bounces-19036-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF4A1061B18
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 22:27:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl5VJ1HjKz2yhP;
	Tue, 31 Mar 2026 09:27:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774909672;
	cv=none; b=W/DBA3smH/8oTly0SKy5JDDWck4rEuAz+0xZ0KMFoEHJdYvBRN3toVsS7EBJIc9+dD1Ffc64ozFKsi5i+1Y9cCNuEdO9J+Cpo4BHum+9XzE0JletGKMK9ONc8kYru6VGC1MlOVOPR2JB6SKHJnoythnP8aKXW+PclXOduT7WidV/JBylfw7iy3eD+p0p7qv0XQRaScbkH3K2UzyzCj6qIvGQMI6ROvQc5bt5g/kcPnp8GRinXqxEjOzujijowDeGwGlZSfJvpfWLuMw/n7wY8aG9ZrOgfqG8pvWvCjJu0OFYvJWHxOW7+j8cTLf0ej6C9wPQ4ZPuF0n87EURGOknPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774909672; c=relaxed/relaxed;
	bh=lzyAsYuDiypzhr0nJOs3r8SDJ+17St3td4xXEfgjRxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l8yT4TlP/eGMXZWiUUCo1nNTIpfLbvJzIjLOPpahT6dxdCbVWnhrdYIg2RO32DXocOLRjVgCrckPH3Ti35vX6w1mrLwJ0HVlOdUFpZ4AWf9di+htQfi6agEN6sHy+rxrbxwV+hR7vYXw0Bij5ip71spQ2ik42sDDefY7P8za/Tgk7tbZ4z85TyKlu1hPJ3rTCwl3I9mIW0M3xs5IXEiJwQOfOasVK9szuHTYYLNF1TNVh1SAL/IWnrzJahEya4ChAbdy1WH5e9lkAFfEeZyezoxAN/sL+D2602UpFXELuI+rP4c6/fgHH3gzO5qk46C1PgVKpqv0uE9rZc6f2zB4Sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IfoBHXy8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IfoBHXy8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl5VG4fkMz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 09:27:49 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-126ea4e9694so1281557c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909667; x=1775514467; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzyAsYuDiypzhr0nJOs3r8SDJ+17St3td4xXEfgjRxY=;
        b=IfoBHXy8EvdmSSaztHdKpH+Y5l2wC7VWnsnrkGLtacAv/26TXfVyDxIbdxclJFFviq
         18bG9l0QOc35Ah2215YMaZzPKkHUDdR0kTQg8rivnlz6uhfRKgi1W2uVI+DvOrjeGb88
         NEhja/31RjW2GrM02o/SLGaTc08/eDLa5KPF4KZ59g9Uel1fo3FaGUy50xo6PiyZ0myG
         kSoCbkVHwXlqZ4WU2cmlDM8/U8tkUG7sjvIvCn8/mUpwyKqkymZD2uonsmNWuhK0pdkD
         jsFlbuUyhQDc2kte8vKzVY7Qw1SmgIJ9ctZisjJG3oLLHhoEfqGlObggeK1vnT//xiJE
         q+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909667; x=1775514467;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzyAsYuDiypzhr0nJOs3r8SDJ+17St3td4xXEfgjRxY=;
        b=XgefiucHUVNpSqk41PZhnFEbkr7DYMDMT9bDDBd53tcYg+ZiMWOF5vS8q2rPB20h27
         2c39QJ0t49u2wwqAfdho9jxTUORPuTeJBsWc3RJrTNzC8A8Ntqy0TMV0mCyXAfObVaec
         3JSykAaSa2apcQuy/tkkB8k+CQlUYsaOY9tTPjimDwDJW27GTZr/O4GH5RAczq9NUIA6
         G2qzMpyBfhpNmLLlqbVuojP2RZBtjrsWZ1x55Vv1BSU+pnxapjj273Gi5AGO0MFAegc+
         Ny2RNWCwILQE9yYqRHtj2hc4luUqAmsYp+sAfxK2Jy6FLzZL6/3nVzsprQDCvHOmEgLs
         R7eQ==
X-Gm-Message-State: AOJu0YyaX+iehGYv9NWpMEP4Gi88tWh0oI0wehpGwqwcPSWJUNl+6EhU
	iO29XdmSy8AdoLzm4axv5atRVh02cmqT3yC92sb52dRfdlfeLO1gnyj3
X-Gm-Gg: ATEYQzy58x1TPT6iuvvm1TenWwc/yL44ez35xqCI9bjb0MkubqzvEjcybVAUu1O/Usx
	sRwplmytvNsVW1/kEUPfpOvqMpO0opJ/EdCcxAdQXbV2vyvK4wOTQ7G/wFLEJJ85cGiMZHI0h3L
	MGA3qEycrwrJGb7tcBg+v8KZcyKdcNRfgnr2LZxQgd8AcRlbBRta36k3kN5NOPK4w4G+AMHMN+b
	t8kkplXNk2zMknwfJ+tl4L3suHY2QL1l0Wh986OQg3YUVL+il/duGZtznhSyWR1PxmEGd7oseEB
	e1ALO1LSAvV6G+EbeS0nOGRTuZkQgR8/qGnNb9USMBgDIDoIqjAYfsF+Z5iWAxIQWPaKsV0Gxdx
	N58ZnJgnMQwXHSnr2bEu0DlusqsQ/ohdozJLVsD1pjMhYXh4q5kW44c6GVnAxkHewiKdDyCPqPH
	RQb2ve9cOLAO2abGWeGGRapE6ozNZtFUncLp/Br1kW0IXCGQ4RGZ+4VHOD5YYE5VqWjKHYwVtzg
	B5RtxQdAf1UFHQ=
X-Received: by 2002:a05:7022:b98:b0:127:33e0:ea33 with SMTP id a92af1059eb24-12ab28e4da2mr8360408c88.22.1774909666880;
        Mon, 30 Mar 2026 15:27:46 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-254.user3p.v-tal.net.br. [177.4.161.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ac09e3872sm10025298c88.13.2026.03.30.15.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:27:46 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 30 Mar 2026 19:27:28 -0300
Subject: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqCQBAG4FeROTewrWHUq0SH2fG3JkRjR0UQ3
 72tjt/l28iRDU7XaqOMxdzGoeB4qEifMjzA1hZTDLEJdbywjMIWPc3O2kMy+yQ9WHSyBXxq63Q
 OjWpAR+V4Z3S2/v7b/W+f0ws6fVPa9w/IFGDhgQAAAA==
X-Change-ID: 20260329-aoa-i2sbus-clear-stale-active-4d3b706cc0ef
To: Johannes Berg <johannes@sipsolutions.net>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5868;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=b41s+FN6uiztHgjfDAeztxkSjquTUWhRy3iOENgs/Tg=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmnftzW7coz2LdKSCMkoOHoyiO9dRvY1pz01FLj4lq+/
 Lb5kRbmjlIWBjEuBlkxRZbVSYss93Q9uFoft8IDZg4rE8gQBi5OAZhIegXDX/kpFfZ6GZadE9fv
 8FNZzT3n9Orsnx3/pK4eVmTpqVHbmcjIsNhoe9XiF2ffhTXUZn0Uf+J2ynvS9r3/y6sauGxuS0z
 W4gQA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

The i2sbus PCM code uses pi->active to constrain the sibling stream to
an already prepared duplex format and rate in i2sbus_pcm_open().

That state is set from i2sbus_pcm_prepare(), but the current code only
clears it on close. As a result, the sibling stream can inherit stale
constraints after the prepared state has been torn down, or after a new
prepare attempt fails before completing.

Clear pi->active when hw_params() or hw_free() drops the prepared state,
clear it before starting a new prepare attempt, and set it again only
after prepare succeeds.

Replace the stale FIXME in the duplex constraint comment with
a description of the current driver behavior: i2sbus still programs a
single shared transport configuration for both directions, so mixed
formats are not supported in duplex mode.

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/aoa/soundbus/i2sbus/pcm.c | 53 ++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 97c807e67d56..47a89da43cff 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -165,17 +165,16 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	 * currently in use (if any). */
 	hw->rate_min = 5512;
 	hw->rate_max = 192000;
-	/* if the other stream is active, then we can only
-	 * support what it is currently using.
-	 * FIXME: I lied. This comment is wrong. We can support
-	 * anything that works with the same serial format, ie.
-	 * when recording 24 bit sound we can well play 16 bit
-	 * sound at the same time iff using the same transfer mode.
+	/* If the other stream is already prepared, keep this stream
+	 * on the same duplex format and rate.
+	 *
+	 * i2sbus_pcm_prepare() still programs one shared transport
+	 * configuration for both directions, so mixed duplex formats
+	 * are not supported here.
 	 */
 	if (other->active) {
-		/* FIXME: is this guaranteed by the alsa api? */
 		hw->formats &= pcm_format_to_bits(i2sdev->format);
-		/* see above, restrict rates to the one we already have */
+		/* Restrict rates to the one already in use. */
 		hw->rate_min = i2sdev->rate;
 		hw->rate_max = i2sdev->rate;
 	}
@@ -283,6 +282,22 @@ void i2sbus_wait_for_stop_both(struct i2sbus_dev *i2sdev)
 }
 #endif
 
+static void i2sbus_pcm_clear_active(struct i2sbus_dev *i2sdev, int in)
+{
+	struct pcm_info *pi;
+
+	guard(mutex)(&i2sdev->lock);
+
+	get_pcm_info(i2sdev, in, &pi, NULL);
+	pi->active = 0;
+}
+
+static inline int i2sbus_hw_params(struct snd_pcm_substream *substream, int in)
+{
+	i2sbus_pcm_clear_active(snd_pcm_substream_chip(substream), in);
+	return 0;
+}
+
 static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 {
 	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
@@ -291,14 +306,25 @@ static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 	get_pcm_info(i2sdev, in, &pi, NULL);
 	if (pi->dbdma_ring.stopping)
 		i2sbus_wait_for_stop(i2sdev, pi);
+	i2sbus_pcm_clear_active(i2sdev, in);
 	return 0;
 }
 
+static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream)
+{
+	return i2sbus_hw_params(substream, 0);
+}
+
 static int i2sbus_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	return i2sbus_hw_free(substream, 0);
 }
 
+static int i2sbus_record_hw_params(struct snd_pcm_substream *substream)
+{
+	return i2sbus_hw_params(substream, 1);
+}
+
 static int i2sbus_record_hw_free(struct snd_pcm_substream *substream)
 {
 	return i2sbus_hw_free(substream, 1);
@@ -335,7 +361,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		return -EINVAL;
 
 	runtime = pi->substream->runtime;
-	pi->active = 1;
+	pi->active = 0;
 	if (other->active &&
 	    ((i2sdev->format != runtime->format)
 	     || (i2sdev->rate != runtime->rate)))
@@ -444,9 +470,11 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 
 	/* early exit if already programmed correctly */
 	/* not locking these is fine since we touch them only in this function */
-	if (in_le32(&i2sdev->intfregs->serial_format) == sfr
-	 && in_le32(&i2sdev->intfregs->data_word_sizes) == dws)
+	if (in_le32(&i2sdev->intfregs->serial_format) == sfr &&
+	    in_le32(&i2sdev->intfregs->data_word_sizes) == dws) {
+		pi->active = 1;
 		return 0;
+	}
 
 	/* let's notify the codecs about clocks going away.
 	 * For now we only do mastering on the i2s cell... */
@@ -484,6 +512,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		if (cii->codec->switch_clock)
 			cii->codec->switch_clock(cii, CLOCK_SWITCH_SLAVE);
 
+	pi->active = 1;
 	return 0;
 }
 
@@ -728,6 +757,7 @@ static snd_pcm_uframes_t i2sbus_playback_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops i2sbus_playback_ops = {
 	.open =		i2sbus_playback_open,
 	.close =	i2sbus_playback_close,
+	.hw_params =	i2sbus_playback_hw_params,
 	.hw_free =	i2sbus_playback_hw_free,
 	.prepare =	i2sbus_playback_prepare,
 	.trigger =	i2sbus_playback_trigger,
@@ -796,6 +826,7 @@ static snd_pcm_uframes_t i2sbus_record_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops i2sbus_record_ops = {
 	.open =		i2sbus_record_open,
 	.close =	i2sbus_record_close,
+	.hw_params =	i2sbus_record_hw_params,
 	.hw_free =	i2sbus_record_hw_free,
 	.prepare =	i2sbus_record_prepare,
 	.trigger =	i2sbus_record_trigger,

---
base-commit: 46a6512f4a74dd7b18d9a455669c226843fc49ce
change-id: 20260329-aoa-i2sbus-clear-stale-active-4d3b706cc0ef

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


