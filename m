Return-Path: <linuxppc-dev+bounces-19114-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7460B10F9300
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 21:14:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flgq60s3Nz2xQr;
	Wed, 01 Apr 2026 08:14:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774991666;
	cv=none; b=hUS7M9dQEf0yZh1cCoW0nTWjHY5hkvBz6F37JvOyiROjnRBfqj8WUIZrkqTiUi8FG02WwEBERhtRLww3RcF9OtX7ujyj1CuwY5syWsOlGyPp2AfzkFUPXYUzf48JldbgHT2R8RF5U/EzxhufgPkatdqgnJdA1rKzl/ZlM+QE3mvgtSUq5jrS39TgluTqREDzfBWR/EHd1oPn0d4jPECINKBwMfGyRin034gHenXnG1hv6G55IQLVt2N4nGZGSy4s3+cNbMLlniyIQp2mjJ6vhbdNv6pv384mlhal5MLCi8uAPS9H0CjS5eytT2szmBuz4GJmfVfgGqVM93WT69y98g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774991666; c=relaxed/relaxed;
	bh=BP58qPqPxGlCUhciznkv7Din9R33uAXsesYeu9BIBzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KSvipElV/nJa0csWvXAy3LKO/tlOgBiLQfqjxQGOAQcY+i5DApB/GGfPdH0Vu3gZ3kQUph/0Rg2FIAaEZM/Y5r+WkiU13apy7iNJf3bIKE/TVe+LycEXLiaQjShlVhGAtGa8i1MDCKtGr99eYRlcQXq4+VaLlzE6/Q7FnSJP0TCQGL9hP0dny3o41BiVURflw6FlUan02ZcVOTACnlwBqdVsrwPPpIXf2uDBsNcLErASit1l8vjNWJxi3eLVRoe1ukmdDIr1494/1c0R8wiA4Y+bbG1gU2fjRS4JP+kPJkUsOW8h8FlRlTmXT1VaubRSINHNHMBRZT8tJj2tqeCnhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dTM1ZEC0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dTM1ZEC0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flgq50P62z2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 08:14:24 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-2c6f5574d3cso197939eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991661; x=1775596461; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BP58qPqPxGlCUhciznkv7Din9R33uAXsesYeu9BIBzw=;
        b=dTM1ZEC0GUeFbeD6DWEL8ptd6Hc+tQA7FNY/uP5vcB7K0jIT4GmAFTdo2nx3WcVA3o
         AEwnKXUITNH2/tj2OZFfFL0g2j04m3h7pTt+e3G/rxcZcvC99zItzm61Kp+1MiPB5OQx
         fIXGRsbH355qAncqE65JVC4jsW1r24+mv7HcLLpfapv9oI726RliyWz3WKFWJCPqceHw
         e9PslsqPeEQ39naWxkqGSqzcL7Xg456aPXHHKWfGOk1ZIJUNGOt7j098io3D8qR7tGEH
         aAnae3kBgpwxwl3UPVkc1u0PVe06Vk8LVrdX5EfSUAufD1sy17aP/pilOkIkQsgzHOeP
         vkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991661; x=1775596461;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP58qPqPxGlCUhciznkv7Din9R33uAXsesYeu9BIBzw=;
        b=YJYiIbyabRjInQQol3Sjf+qCe31LBbVPT6CWt0wm9lht6urivmEdXee2EyLn4S0WlU
         bN4Xh7zDe45qAO42isCcnpeNfS36LZsKT0x7dET+VHr59aqTnoWq84FbZ8MJjeHJjExu
         qaUCQFaCkcIxTWYfALcOXSy0pPpsb2e5/nd20BaZYVl0X33HraPchjtzfYQiVupSaSAO
         4BpWNqBXe2bbUiLvfXg/UmkM5jm5O23BBiiHeQPoEcUQ2TqldNQhnKALxhGiHHWTEJ6E
         bguPgW3W4bQVOdrENB9DzHWIerNGNkkU03vQgqKNrYuB+5jSUOk7DSQ48+CmivRSPkLS
         2G8A==
X-Gm-Message-State: AOJu0YwwhclQQy7I1ADoxTMbEW9a9kGT9u6GVHJnBhLu/TEPQTJH6i2E
	+NTC3Gfujhoq7/vwIx84LGdr3oPceUjSGnVlgivMvpadAy7KJgI2QLGm
X-Gm-Gg: ATEYQzyqrvurdMxLhCQMv8eus+CE+HBogqsXYw57hVVCHYIOm1ziC488qIXSW2FcVbh
	h6pkR3UcVnLVaLgqPlq/NNvAZ/qtXCKIBPYj+SpcECUqhz9IL5EDE0+bO2qB1VQq5jfC0HPVCre
	hhpnOje712caYgVl2EUb5M/GbKGHFSY2Eqax1uNAHTXZO/bvCzZcaqTTgIupYg6Y7M/uswTyc/C
	cj2c/IdACZhq1nKYDC4C+dESV147HKQU8Z5akboibWm+O8IB/Ar6zzC+7aCrL8fr5SmsrWBwLQA
	/WJQoSPFuXdFwAJz/ZWkEdVn+ffEqz8dmfUsHe+sYr4Aoxnq23G0luw7XEbigf1HlOcXE0Uzqum
	Ig7Z/dkM76J1V+fTEt12rv676WmWJZ0OCuXh5sT+MMmuAhhqcYjAx1pu/z51UYVUBCQamrJJCPU
	MEQbm6+yAjhBnRFjL6wwJFrs387yqwkcANK84JfKtygdfNuoS+Xlrdvi/2Xmv7czNa0W5QZ8cqh
	XU=
X-Received: by 2002:a05:7022:f10e:b0:12a:8122:24a9 with SMTP id a92af1059eb24-12bde008650mr2430073c88.22.1774991661386;
        Tue, 31 Mar 2026 14:14:21 -0700 (PDT)
Received: from [192.168.1.8] (177-4-161-218.user3p.v-tal.net.br. [177.4.161.218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm17870444c88.3.2026.03.31.14.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:14:21 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 31 Mar 2026 18:14:04 -0300
Subject: [PATCH v2] ALSA: aoa: i2sbus: clear stale prepared state
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
Message-Id: <20260331-aoa-i2sbus-clear-stale-active-v2-1-3764ae2889a1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6CMBBFf4V07ZjSEgiu/A/DYhgGGcPDtKXRE
 P5dQPcuT3Jzzl2UZyfs1SVZlOMoXqZxA3NKFHU43hmk2VgZbXJtTQk4IYjx9eyBekYHPmDPgBQ
 kMmSNrQudE2lu1eZ4Om7ldfhv1Zf9XD+Ywi7dF534MLn3cSCm++7XsvpPK6aQQlZgThotUsnX+
 4DSn2kaVLWu6webS2Hb3AAAAA==
X-Change-ID: 20260329-aoa-i2sbus-clear-stale-active-4d3b706cc0ef
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6526;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=cEbTkyoIGc+4FGvanw1ToTAF9VBzhvD48F9X5JgbIgU=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJlnLFU7quq+64lsub+v5Efv3SXNjJbfvlywyZl1w2XvT
 qPskm7djlIWBjEuBlkxRZbVSYss93Q9uFoft8IDZg4rE8gQBi5OAZhI5FVGhqeX3GLnHpsxTfYF
 c0DFpQjOiFxGueJDc5Yc9N2/X1lqkz4jw1QTy3O+6T8r5e1eHJyyobzJ/OCXjV+KzIraWB/bL7o
 uygoA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

The i2sbus PCM code uses pi->active to constrain the sibling stream to
an already prepared duplex format and rate in i2sbus_pcm_open().

That state is set from i2sbus_pcm_prepare(), but the current code only
clears it on close. As a result, the sibling stream can inherit stale
constraints after the prepared state has been torn down.

Clear pi->active when hw_params() or hw_free() tears down the prepared
state, and set it again only after prepare succeeds.

Replace the stale FIXME in the duplex constraint comment with a description
of the current driver behavior: i2sbus still programs a single shared
transport configuration for both directions, so mixed formats are not
supported in duplex mode.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604010125.AvkWBYKI-lkp@intel.com/
Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Changes in v2:
- Drop the extra clear of pi->active at the beginning of i2sbus_pcm_prepare()
- Keep the state reset in hw_params() and hw_free() only.
- Fix the newly added .hw_params callbacks to use the proper ALSA prototype
  with struct snd_pcm_hw_params *params, addressing the kernel test robot
  build failure.
- Update the changelog to match the reduced scope of the fix.
- Link to v1: https://patch.msgid.link/20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com
---
 sound/aoa/soundbus/i2sbus/pcm.c | 55 ++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 97c807e67d56..63004ece94f9 100644
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
@@ -283,6 +282,23 @@ void i2sbus_wait_for_stop_both(struct i2sbus_dev *i2sdev)
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
+static inline int i2sbus_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params, int in)
+{
+	i2sbus_pcm_clear_active(snd_pcm_substream_chip(substream), in);
+	return 0;
+}
+
 static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 {
 	struct i2sbus_dev *i2sdev = snd_pcm_substream_chip(substream);
@@ -291,14 +307,27 @@ static inline int i2sbus_hw_free(struct snd_pcm_substream *substream, int in)
 	get_pcm_info(i2sdev, in, &pi, NULL);
 	if (pi->dbdma_ring.stopping)
 		i2sbus_wait_for_stop(i2sdev, pi);
+	i2sbus_pcm_clear_active(i2sdev, in);
 	return 0;
 }
 
+static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	return i2sbus_hw_params(substream, params, 0);
+}
+
 static int i2sbus_playback_hw_free(struct snd_pcm_substream *substream)
 {
 	return i2sbus_hw_free(substream, 0);
 }
 
+static int i2sbus_record_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	return i2sbus_hw_params(substream, params, 1);
+}
+
 static int i2sbus_record_hw_free(struct snd_pcm_substream *substream)
 {
 	return i2sbus_hw_free(substream, 1);
@@ -335,7 +364,6 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		return -EINVAL;
 
 	runtime = pi->substream->runtime;
-	pi->active = 1;
 	if (other->active &&
 	    ((i2sdev->format != runtime->format)
 	     || (i2sdev->rate != runtime->rate)))
@@ -444,9 +472,11 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 
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
@@ -484,6 +514,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		if (cii->codec->switch_clock)
 			cii->codec->switch_clock(cii, CLOCK_SWITCH_SLAVE);
 
+	pi->active = 1;
 	return 0;
 }
 
@@ -728,6 +759,7 @@ static snd_pcm_uframes_t i2sbus_playback_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops i2sbus_playback_ops = {
 	.open =		i2sbus_playback_open,
 	.close =	i2sbus_playback_close,
+	.hw_params =	i2sbus_playback_hw_params,
 	.hw_free =	i2sbus_playback_hw_free,
 	.prepare =	i2sbus_playback_prepare,
 	.trigger =	i2sbus_playback_trigger,
@@ -796,6 +828,7 @@ static snd_pcm_uframes_t i2sbus_record_pointer(struct snd_pcm_substream
 static const struct snd_pcm_ops i2sbus_record_ops = {
 	.open =		i2sbus_record_open,
 	.close =	i2sbus_record_close,
+	.hw_params =	i2sbus_record_hw_params,
 	.hw_free =	i2sbus_record_hw_free,
 	.prepare =	i2sbus_record_prepare,
 	.trigger =	i2sbus_record_trigger,

---
base-commit: 5a8ba15bcbf0cd70cc89d1e1a3d4037b2ab5ccdd
change-id: 20260329-aoa-i2sbus-clear-stale-active-4d3b706cc0ef

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


