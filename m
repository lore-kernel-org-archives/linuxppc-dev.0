Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC273606A332
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C3exd7Bm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc6Z735GMz2xLs;
	Sat, 28 Nov 2026 21:52:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795856005;
	cv=none; b=lBD4AJS8eFYwaSxW5UzahcqACDjEVfvAgOFMXL+xZyHNHQ7DNIH32enN7iAwUyItyPwQoedYlKqFIWGb6V06xb03Djrf/WgI77c+zVBCyGDuw6hALeSkpiNhHoZW/vEu+11K9fJmTVYeNgAnv7N9X6r9vN1sqDhmo8ahFKd6t7+62YyZUO2wnpOIjdTNyKHvNN8f2qxnMj8KBmkYdxJs7drWQkgyIcKGwlp9GWlo9Hb113MDhEogjo/8ZIh5QzKnCXXhVWFYSMVZlz1dVz8sULDjK8yIFMYXA3uNLuiHjFthKAiJLo3wg4ltue9BG/0NN5mSqisidS6oNzC1/A5O8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795856005; c=relaxed/relaxed;
	bh=pYdZRMDlVtYaaI0y/9/AHPDxXWjl0VbWZbrTCTv4mq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9cfwYMPn4Zv7HGbc5+ItwArRbB8SRqET41RAPUZ8l2FDY72cMzBKd/zTgvvELp+66Jjs42WtP1GnoBPm/bNTrpxRRXbB9Y2FYsqJ/0ZHoRGGl2oQg3ZUL+J1XswfqvgUcobDOeTFyOpou0vKKq8w1+tDKNvRbJxKLkrSlSGIkHNBANqsTDkwQMu1Sl0pdcrGVnOHfz5355IkEVEWHXQugB7H2s6JwFtuJDd/BUNNbuBO48K9DpyLv9cFX7JXykYmUrXv5bZOapeu6TBKjOfn9Lw4OMzumLLROuw6aL0gC2nSy30Yp1EjfyDPVe8FwDhstUOLXM0xPuzb/CZ2F6t4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C3exd7Bm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=sreekuttan2156239@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C3exd7Bm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=sreekuttan2156239@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc3wN5MxMz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 19:53:23 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-38699cf08dfso11449677eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 00:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795856001; x=1796460801; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYdZRMDlVtYaaI0y/9/AHPDxXWjl0VbWZbrTCTv4mq8=;
        b=C3exd7BmCIrz6/szQLyXeIX4amqQHDuogsT8pi/SY7ZxxVPcCAlNBbXgFm+f+vFkb+
         Ry2a09aCBXED/E0meiy10cjAt2yccE3JCI739VSU/HbUPYwhww4Jm3mE1uG2VwT+VM6j
         UHkkBRYXw2BsJnpP5l0vhRWy7mDJVvuczoei3ZcJ6f55E+RkGDSuMnPMfzTclH0mv95o
         7FQlyTbD2bm9KUoYL/1ScYfQq65TlJiNC0NfqD00WcILYlGYtpTL7YgnKsHecQubF8vj
         DW5GlzEYBClhBA+uqJrNA7MluxSgjngpLMcjeP74vU+ZwmzdlmEnFDmyQYj1WSE3PkVb
         FmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795856001; x=1796460801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYdZRMDlVtYaaI0y/9/AHPDxXWjl0VbWZbrTCTv4mq8=;
        b=wjF8H8YtMZXhYUL3sx2Hd7ST7TSchJyhSFb5/i5A+15Ci7f3ENckqYOJZd77FpQmJ/
         s3nfc7/GmlPPkRa1VqNTfZU5qr1NUcuicKfbO36UXBc8rUwKKi/Y75OG8cdl1az8b+Qt
         s3n27X50iNT2/2UGUBJOjGEbkh2wOKqTeX8jUR0rxF5xR3nu/CHNwZS97mNrX00pUkgf
         twxxDBAEA3sTU7PT7vi9gCM2Hs5r6eCy8ScwvEEwspqp4TASseFlCHJytN+WYaQVHr1i
         aIy7hgfplqT8KqbwqP5UVANr0PdI/Ne40P/VQLxhPOp5nIID1aUPnILOCItDE7hRE1sh
         +Lrg==
X-Forwarded-Encrypted: i=1; AL+hErE6m+1tDox4HxrjJfL6Lz+bNvVoN+YcTnApCTvNoJYbIhBp27DMYk0cxsw3WDazK0KHyhuTuMKPahJRI8U=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+x+p2tXj5TvPyTkRJURvuJrPHBFzeBM8kogoxF/FPY5qyP+BLA
	V7rYOeZRLJPR0eIPLLT4exNvxwygNT3VwoQ0EwiHniNEbqWdOQ0W3tCkTGeolQ==
X-Gm-Gg: AZFdTZdJeVDVQpGkJy510mhAlqg0ZoxQcznI3TY3de7Z6oysn+kE1bVVjoLc/EaCWnK
	w88bd7hZeH/orU4+2xbz7YPYwJaxoH6ajN870zgsiWa/+JpAm+ACnM9PiVaz9b5llSFem9sFOGm
	akqmp1w8ZFnvo87Q38deLw5fbr1cbVfam6CugGeejPzUBZ5kmdtmZ7PVdnCi5kielr91zmR+0B7
	8LrRgC43ia/THb8cnubFOyDXIqa/Apvmf+l6wYsp1gJEWLkMwNbAZ7ozr4FO+4X9HRKrfAMwDSl
	lnZlV8KID4HzYbCApxf6BFNsbGvw3gw+Og4N0x68apAftRaIpnNu8UBEnWY9z9UFf5Zqi7q19/f
	6mm8oJ32kq9qUnMbRu2v4hApcA3sRRnwKqW7DMn4Mxwhs+x317I+ITcheyGh/2YPLr2U+/eOkr+
	1hsh6KNPrxqs4GsAgm/e5VjE1RBOoKJa1D3n+NU8mi8rpUlrQj1rs3LNP5B+xVBKenAuJX3dPRl
	dyuSMcH4JGMzuQyLrJHIS/hZJmTFA1sAtyuQ+VeQK3r7eKhlfutTGbeWjHSHOCJvMcgvlWaI2cl
	3eKujI2SG2WhmOd6eGXt0TMqbc+960eh3WTQdc7trOXz/LqBTDc1
X-Received: by 2002:a05:693c:4001:b0:370:d6e4:e8aa with SMTP id 5a478bee46e88-38570b34fecmr28389543eec.41.1795856001579;
        Sat, 28 Nov 2026 00:53:21 -0800 (PST)
Received: from localhost.localdomain ([103.179.230.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm99952622eec.11.2026.11.28.00.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 00:53:21 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: sreekuttan2156239@gmail.com,
	johannes@sipsolutions.net,
	perex@perex.cz,
	tiwai@suse.de
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] ALSA: aoa: Fix codec unregister handling
Date: Sat, 28 Nov 2026 08:52:35 +0000
Message-ID: <20261128085235.2984-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261128081025.2878-1-sreekuttan2156239@gmail.com>
References: <20261128081025.2878-1-sreekuttan2156239@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix aoa_codec_unregister() to use the codec's own fabric pointer
when removing a codec.

Previously, the function checked the global fabric pointer instead
of codec->fabric. This could call the fabric's remove_codec()
callback for a codec that was never attached to the fabric.

The function also called module_put() unconditionally, even when
attach_codec_to_fabric() had not acquired a module reference.
This could cause an incorrect module reference count.

Use aoa_fabric_unlink_codec() to detach an attached codec. This
helper calls exit(), remove_codec(), and module_put() and clears
codec->fabric. These operations are now performed only when the
codec is actually attached to a fabric.

This also prevents releasing the module reference a second time
when codec initialization fails and the attach path has already
cleaned up.

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v2:
 - Reuse aoa_fabric_unlink_codec() to detach the codec instead of
   duplicating the cleanup code.
 - Call the helper only when codec->fabric is set.
 - Add Fixes trailer.

 sound/aoa/core/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/aoa/core/core.c b/sound/aoa/core/core.c
index 99b032a4081f..09eeadba4277 100644
--- a/sound/aoa/core/core.c
+++ b/sound/aoa/core/core.c
@@ -72,12 +72,9 @@ EXPORT_SYMBOL_GPL(aoa_codec_register);
 void aoa_codec_unregister(struct aoa_codec *codec)
 {
 	list_del(&codec->list);
-	if (codec->fabric && codec->exit)
-		codec->exit(codec);
-	if (fabric && fabric->remove_codec)
-		fabric->remove_codec(codec);
-	codec->fabric = NULL;
-	module_put(codec->owner);
+
+	if (codec->fabric)
+		aoa_fabric_unlink_codec(codec);
 }
 EXPORT_SYMBOL_GPL(aoa_codec_unregister);
 
-- 
2.55.0


