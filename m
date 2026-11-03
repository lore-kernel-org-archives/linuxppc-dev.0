Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D5606A335
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZSLabKme
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtqG3dV5z2yhP;
	Wed, 04 Nov 2026 03:11:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722282;
	cv=none; b=dhmYhDfVDiXhhOL8EmNeG5I6x401+KXvrt2JwQNtJRWbFdG8143FflFB94nVoP6LkBrfjFbjdeJ6AEVyga/rONMjasGE8PPMl3WLBjYKzU5cFPoyFY8x6GgvSzJEGcoDXOYbq31iQWX1nH0GiC0aCU3GLu68HzxYUpOP38I49V0AErxc3Pl6MbufYxbbKxKQCKA5jPtBTyJmfAELggJ61AjfGZiwcRKEFrKUS5+NcnTEfpi1mHXRYK/+0jwYnA6PkvMgCKlsEI4fLpCukosQDn7y9fAMMlvOjDR31B4leMv2Kwx9+jI1To+XoERevsUZIiKJZ1JdZ49UCeEvAOlBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722282; c=relaxed/relaxed;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7d337HEs1nWJUBwrYc+2Ejw2fqjMKq0InwlM/wKvb5X5m7QxoUJRqJvAyZ6du+P6kPJEIkxXmIMPrao87N6TgvfHoKoEoKCE63FSsP9hr5/EEHwkk1vofofR9FPYKNcMZ7DN/NCqsjYleFl7R6eKHG/roeuulM3/mbuZM5eobcAVhFQt5Lg1O1ZJWSl0/fAyEfIxHKgotCpR6Ue9Z+hGmv/ZFCxhJ1RmUWNWyfrZLkF8X4XYYcqzBHRfouBxWLNjI1wDVwAtEqZPVg4JyBrn5e5jw6QjI+hcfPSJpbjqKZ911TtfBHzypAdgabb91Zuld1Vk0fBjA2YpxonEXEHJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZSLabKme; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZSLabKme;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtqF6HBjz30P3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:11:21 +1100 (AEDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-4e4a4d77e5bso565284b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722279; x=1794327079; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=ZSLabKmesSK61bJOJCJHec2GsOR2SpsYtg7MJCEEWR7TXuCsNWrnXTYcNxwBADSMW6
         Sdo5jPoFubov1eygw0CXmT9TBCbat/VPw8SrqbDnS4TMs09d3A73LmrD5erH+waLE9Ec
         zK4xZikLEoZVvJrVfsOb9Gq9cijJNdiXaKgfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722279; x=1794327079;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=EbGszOqwD9y6dSIUYWDJj/NQ44ZIq4S5+yfOAMvWd7sH5OCwy6aPswriIS2tVXc6oh
         SfZcc7n39kN3zm7yyYNGU/msDq6KWOqlbYyamDoQzpiIcAxaXS/fRXNuESWq5dhkBHSa
         qhFBds/HpwHtMuENzUymFIcIU3HAGzJROr5n9rqUODifncIvapl08mHGo+v84BghmfoX
         KWFjDaOoTOd9tDflExrDkV3PEBBbyITiN39xiFacDpc+HNapyFQUg1hcX0mJREhlsCiC
         xhHhstYg1GvnbB0FyYrEWeWuuW151FI1PP3/7uXA6uKQPmzmTVoPLGRaktRjhJ9xUQBT
         0TNg==
X-Forwarded-Encrypted: i=1; AKwUvBxZnW/zpnSjjAgthwrV79KIYQR/Ot66C2qMgojkPPgoEc8+1pcDkSGydQrU+TtJUKN7nzW4hatpZo45utk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8dhxwF/hPLBf9E6OTB6ueSssfZ0yrerctLvGNlmQfJwvNgisb3
	fA/YXf5dTtqIZJijhmBc6hPfAgYAOIWuddttVtgekwE9MNtfM7Dxc3Xj3TGy+qgu6Q==
X-Gm-Gg: AYBFou3L+3o3z1RYk3vaAhQcUbzYSx051oS+AKDGyAd2M4KmcZO1DnAin+mbLZTZ/fu
	WNTWOq55yNANBhMLvbkxbBhrtgiPUo+hEE95Y67/9Lt0cDI8seWnvZBqQSJrKLy7hwF4ZvzHo6u
	iSOdXcovMb2XBU/w8b8R+8eYVvTeblQUiQYAJdFRKuozGyWEFlgFUoCdilbLzrZFTWqrsOs4k/U
	6M0v7v78kH1h2+bfTn7Pm3IrpLpkemVh2RINkS3I25ghmFppbgNx6zQiHFZV33zrIGORfmpqGml
	HvjSH02zFo5w1aNpQnApB1snkMUMEqDkiVvERF18BnnuIvtV+FfBfscGOzx2Ljn225CK9BUKTmf
	2LerTWkMGZ1tv6Wzse8kfGVWzLqlpg7f1oE1OtLZgPL5LuKSsXz+p5gDMpPfx1lsKX1stY4Okur
	vmZ9djiylfm5crDDfuRheVRbf8Ezjv67wgbd9vEtLu4QaZx5tpZKzKPrC47fBBlxWULODfIiPS+
	wCo807O+lRa5bY5YI1wSnsP7tNCFDR6uHCuboDxi1/eN4RbIJ2V3uPICQgz3XUkEm9ZKEVn6YWU
	4dvD3dFz5FZe9oIUd/wJZLQoTgNnLv5owBMyctITHYXE6IupyuVmDNSeueu9ji5IyqdFNppkUNJ
	pnRKZLFLavjyjryI=
X-Received: by 2002:a05:6808:10ce:b0:4b8:46e3:e220 with SMTP id 5614622812f47-5640de87067mr5635130b6e.12.1793722279518;
        Tue, 03 Nov 2026 08:11:19 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:18 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v9 6/8] serial: 8250: drain canceled TX DMA before reusing its buffer
Date: Tue,  3 Nov 2026 09:11:02 -0700
Message-ID: <20261103161104.2449407-6-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Raul E Rangel <rrangel@chromium.org>

