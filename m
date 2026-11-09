Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lAwQSCun
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNZmX65vQz2yPR;
	Tue, 10 Nov 2026 03:21:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794241308;
	cv=none; b=T2BgmKG7jG4JhOhYPQpvWoUO8zx7Zrq+olrruwwzWopM0MZcuQD3OH4QwRlgCjl4P5V7iy4iw6UM8SR4M80ONB8IupaZ5sy+4y8E9wgDfdLajh2GVWfGiLZt6nRcHz9GXO+plVqjX0LwyLH4vRifeMiRQNKnDdo7mPOF9snMCcmDUBi/RwUyGF8DGGzj7ljIJxHQTPWmabgZ9inEgRAIIqe33cLVTk3iozhYSOBYVD5JmuLQvMz59Aq/mHbZRE0ZrXZa/jAJBG2Qemdf9U2xTGgWWLj58+tJSiND8DExFz9OBWiIRevrlXCjQO/6SbXr/FCd/g0Zzd0kkJhGNKyNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794241308; c=relaxed/relaxed;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coJ3VUWIHR8l0RXpvw0+P2/r3FXg6/B503SUI/vHkyNJrNpoxcAHaFkIq5k1g341PYeZUFnFcvO6zFEIaeJNm1ofBxpTGXxL0Jgm3qQqpQIM1EOH1SDtvwRbXQXrWSbJx0BcC49PBuOuKejoEOUnpxeQZOyVPiVpvHevJK3eYFjoxADsWksy3IE3gMLWfu3mkgeSEaQ1OCsqhgQ6W/p3Ak1q8lDkoyjSFPouOej69o6prj2W5rYW09fwsw++058sJAJSVzGhn30rSf27nDUS4GmY/op7WOIqFHpP+E3nnHNMgE+c6cKU+NWr73Sv18Qr4poF+0pTPFCJwbSTGMTq/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lAwQSCun; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lAwQSCun;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNZmX0P2bz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 03:21:47 +1100 (AEDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-49429181ce9so628023fac.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794241300; x=1794846100; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=lAwQSCunYouNXYBkYMV88iQaNlHtCL/ul0CIeuHNo3kfxmZUAymPNHFcV9LxxSJZhx
         EJd7gd21F8Z0vLtDwy+zQnBzGIG4LgoUZBjnQL9DKk+98U7olWBERn1aNoho+CYPjJjA
         UlQzdsiUkMepJap81mAJbTjecx3xFtAilZPt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241300; x=1794846100;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=tIOvX2hykG54nYRqFbF0vrhE+qT/0UOqkH+HN9Wz0Hu7+BazoO9kbsm7zOhyuwqx8U
         25rvk69Nl/BW8gPz/apkzUPTb40jOrSu5bqtxZXjVXldMrXCHgf8l2Uwatv0l9ZSVNqD
         XVQ43DGWLBDIvCG/mfnisw4nslhdoDfEKFKix1v2kkpLKaEAK/kxbFQWZTQDuopdazdI
         jl+ArsTqAURTzXXP3AAFGQxartoaRQ/QSReiYCyBJfSKHSlhRq0nyUN1CiOxaFYho4s2
         IEkIR5ZYqYUD9fUbWtSQZ9IAEZGZcHDO57b/JSD60qv+SiEhfG8z3mQp3q9t7KrfMumV
         8y8A==
X-Forwarded-Encrypted: i=1; AL+hErF13bb0uUFW/mSrAg/tP6SURJm8F3dpvwTxN2FOuxEOJk68uwZY2Z37lVIuAQhUeEULObtRD9SilaUthOY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8Q6m5ZuwJVxC0bnn3csxMsOoA9lv+n/9Oa5mTPkgy9QkavrArw
	rC0/6B/erSWyH/5/HIMyyjvtww6JCPqWdVALPfKpthANOcRZFR5WfQdquTgN4vS9MQ==
X-Gm-Gg: AYBFou3rUvGbe7GMQp4cn27PXnfHxbzZGJpGTI/x1dkMCKrP77mIyds2yJp1jpvXRXW
	lny/gkPKgw5/hSWo+y604fbszArF+32lS9hiyu3/ItQhStimvBDNN487JgNPbCDhF8zSAKbqb9n
	IWv2yix8QdvL3sFWhKyRPMk18Kzo0mdIW6NkHeC48D9leISqGU8+Nd/pL4oYsg/wk7/xlUt2qlX
	1P0eDmjZsoljLOwyIYEN2brYYiXCYqawtzvJ7NhU3MSf3jse++1I2rWgZdT2oiREUH3SpQN0Sq3
	fRqXP2citfOVfRUcStMk0pwUwS3YYOpGBpQgrMLED3SHC/TzC1d8Ek4vtRTRtKevjpDBkL79bdI
	YNdKBcz/mcrOUeFmModdBqNVjbzSYRHJvuYqmgRbprAOmIbTKu6UFI8/W4UjfwTudSbOYWEAf77
	KoanpCCWfoynG+knh96FCRurY+ZmcnyFwWmZ6/xgny7L9Bxffzg9cDJ4I/Ptt6UEXCafGVrqXaU
	j61KHVVbDTBjVvRu/pYH/Fz+AxtO8iePchndUFps1ThhOfAGAHCd6PYeAm2NEDN5Qxdr8poR4S8
	4nUv1uUZdTiB9tbjcczNyObHqvRdPZmJKFgafsSc5gEEwZ33aiptmS2hFHedzCBFuM+6neq+vH5
	UXCZgxet2ZdGZqIZoRaMoMQlTxmN0vIjsgIf0
X-Received: by 2002:a05:6871:3321:b0:4ad:2386:45ca with SMTP id 586e51a60fabf-4adecba6a5bmr2379052fac.55.1794241300604;
        Mon, 09 Nov 2026 08:21:40 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade694062csm5510676fac.8.2026.11.09.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:21:39 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Raul E Rangel <rrangel@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 8/8] serial: 8250: retain DMA resources when termination fails
Date: Mon,  9 Nov 2026 09:21:35 -0700
Message-ID: <20261109162135.906262-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-8-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com> <20261108-submit-serial-8250-dma-cancel-v1-v10-8-e6227ddb95b1@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Raul E Rangel <rrangel@chromium.org>

