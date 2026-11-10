Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B9606A320
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Hq/4C1NB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPK1K1by8z2xBb;
	Wed, 11 Nov 2026 08:05:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794344725;
	cv=none; b=dI7s9fkajObhssjW5SkhNhDs6vH0UbQ0HVb541Yn1s7Fic1LIYWhfIB0usubG+qzumfSqawa3PTzQx56HZo2ok7ijRqn3kyPawSkkzVg0u8/GGMUz0ms6B29H+TjudywFV0uKP2ZpYAtaIQQgoJTUHYAtqHgI2bdSwmB1HxtiQ5sF7fa3jYVesuoRMenFIfU6KTdXu36OnfU2u9Aky67h0Nzg5MYdl62RCv3pqwtcKdrardzNV1/DqCqtm9C158Jiaiks/XKMkGKrxO034eFxlYucFSDUee/ThI+Io8WGiNYwcOn5XDqgCKSgbowYHe+GkZvDN8OvNXreEQ1wpBhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794344725; c=relaxed/relaxed;
	bh=r0F/G1/cCd6YtCyJox781fOcwZWIec41wc+ColCaqik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PE0rN5t7/g9O3Ru2cUo4FC9isCqaPrhKdAT2VjcIPM3Mi4ev5p8z+vCfZLkzut9+WkRLCoe1eREl3kdHgNtrDOiztBeauhoOBDOlQx7gb0L4YKdgSAMOsQsuaFJ1NTi61j8DL5GvKwDGyXhH8bcvpAy44IZyqBN5542N1PIKLjWQJuVbm8dJh9Va2b1Rr8pzZXUTOgRB5I6t1RdFFmmVyokbXGIqyey1IRjzfWW1Vv4boN8+hZiUNteMNLd1PHN0h54cda4Mr06IiNuppq45iiO3Wyfo7Y/uo9IR6CUxst1NmsfT06QY49twI9nimEKnL5h/xzE0WJrqjYb+EgBjOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Hq/4C1NB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Hq/4C1NB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPK1H4V73z2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 08:05:22 +1100 (AEDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-70b875f6f1fso1912104eaf.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 13:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794344719; x=1794949519; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r0F/G1/cCd6YtCyJox781fOcwZWIec41wc+ColCaqik=;
        b=Hq/4C1NBYxaBdtmC5w5Be8aOVm6ERNnbNL+0mKIKIrIx3TWgEjfSyyJHalDhQ3PIMC
         efH8hD/AaTsGBmphpabpuLdMhHIstpEoGTIw/ggEfE07KgBxyVx6CyJn8XDh6T4yQkns
         ZqxkulwM1c82Nn/AUKyW7ITITUucffkKUyBJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344719; x=1794949519;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0F/G1/cCd6YtCyJox781fOcwZWIec41wc+ColCaqik=;
        b=u3wjHorj85vbN9Y9CCgD5LY8YSek2UJFciZvcMJPrP/faJPZVvgNhn3xo7R5Wl6TXm
         pNoT2TC+x6MuL2kI0ZdnWwpxlkcd9mrlcjmndblardCTwQmZjTiyTFcR7Ye+rt4GSg7t
         p/whBTDOkyrz8c2k7wa3PkN9fejT+QjhbzClD3skx75aNwQzHuk+WTzBDQXwX4S+hs0e
         LvPSp9e0iqv8xxNdTslFIPBvBRIMJf7auJeTifOj0NHe4NtNJrgpATUAY7Pjy9EuGCyB
         5EkKfuHn3qkyi+sSvDa/M7joQ6dXxXA9cMe5RfVFbANO6NuVT0xJjsaAiQjOMYTyTBtX
         xVgw==
X-Forwarded-Encrypted: i=1; AL+hErHS9U4iXLgJ/hlcdSNZ5H6AsqP2kOqb2AQng7ukySfrRFwg6Q+bkOtCXW5IKR7vHfn5nsPKcLjvBAI/IDw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9dBzr7eEZU+E3KoKqgovuOMFMk3yXUT6oZTGcvbRP4mhnX32/h
	XoGMF4y/CVbJcZimBL4g6+zmJaaX4N0HLIHcAal3/sA4FdkK8eYoFs1RO0dHGq/5Eg==
X-Gm-Gg: AYBFou31mEI0dGx0KR9zVxWjPY9Ali3L4gbvUSucO6v61BUNGFBYEuTQYCtnCpRVEjY
	n+DoICRzGUiNYdVmeZ8aqc/abxd14J8myGk2pk7ChPKpg0bObaC1eD2bbOk8UKDMd0DrQOLDa8B
	XIe+Pm9i1hx6oJy/fLMoNH31NeL/hp28pIFyFDfrl+1CsfB+rcq/c+wUnuAs7FVlCyCp3ueT9P6
	VmcOMHf3l4P5s0f49hVROot/527WsrEgNnop7eoxeLXEXGZnYpmW6u7qzFvYgMb0KDm4SU8bWph
	P5Lz41gZ5XTT8IcpzTalQJf4hhwYyXzHwscE0FZUmaBugCbyfhub7XXZZdUYzQ5AphMoFvEHY1m
	fFEsQb0bwyEVt1Iyfz9/sMk8/XJKB9peg0lJCQimHFKg7yPtGV0SNJLHIy8ZCubEToyUZHe/pDA
	vDl5jpMq+C3DwiOw9gJ0jUv1iEEQAcn/JO4pt3lgGw7IIKHaLPsX72q03r1NZ8xfeMuX1larWvn
	iLps7rElXGzefS8BCDpsb7qduarIycitz+Mx6cAzgUAJLGc0KhB2oWwXl44irExUELON9F0ZWiB
	UBk0ggPFqLKH2Dank9E/93tZi83DJzi407oCTv61mdl6g+aYqNYvF+kc2CeimVjJFH9p8BrXfcQ
	Oijk5ImX6XdfhmHVFvbCyvclKj8O/A2awht4IrQ==
X-Received: by 2002:a05:6820:c44a:20b0:6d9:979e:22ad with SMTP id 006d021491bc7-71917934e44mr119108eaf.54.1794344719257;
        Tue, 10 Nov 2026 13:05:19 -0800 (PST)
Received: from rrangel.c.googlers.com.com (57.128.170.34.bc.googleusercontent.com. [34.170.128.57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb62443sm2856553a34.6.2026.11.10.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:17 -0800 (PST)
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
Subject: Re: [PATCH v11 7/8] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Tue, 10 Nov 2026 14:05:14 -0700
Message-ID: <20261110210514.1091741-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-7-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com> <20261109-submit-serial-8250-dma-cancel-v1-v11-7-6364edca63d6@gmail.com>
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

On Mon, Nov 09, 2026 at 09:00:22PM -0700, James Hilliard wrote:
> After one second of unsuccessful pause retries, stop the transfer with
> dmaengine_terminate_sync() outside the port lock. An indefinite wait could
> otherwise leave a request/response peer waiting for data that is stuck in
> a partial DMA buffer. Report that recovery discards the pending payload:
> without a stable residue it cannot safely be copied. Keep rx_running,
> rx_pause_pending and rx_terminating set until termination has stopped DMA
> and drained its callbacks. Then restore receive handling and allow another
> DMA descriptor, without latching a permanent PIO fallback for a pause
> timeout. This trades the stalled transfer's data for continued reception.

Reviewed-by: Raul E Rangel <rrangel@chromium.org>

