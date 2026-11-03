Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548D606D812
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ut5a3GYb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtqF2CxPz30DH;
	Wed, 04 Nov 2026 03:11:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722281;
	cv=none; b=mq9HCOmVpv4BkMIFQ5Y/tfoB1zvuBrI6wSL+vj1UVR0xkko/zz+noCZySkg2/VtfpAyqlhp0qvYCtS/ExO0swaPU0DIYp0L/maxWbllRMiSmMnWo6cp6D01dDg4vufffTRPdsjPrVpcmZITF1IoQINoY8yYAopnucVpZjZ8NivLVv+ZT8yyD8pEw1V/x4/nTHMk/CDnlod8n++ADqBJ7xWouyZ+/u0vJVUlNtZ7N0noLPrp4Iz4aVqMvd2L/xlKOGtnisCvjIL5bSfiX7vbYOgKStUPa0+u+dptsFcjFixcYng+aBXPxfI07I4mGuzqi9N3UKfjp6EHm6aN3AbeFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722281; c=relaxed/relaxed;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAla8p4L3ZDtZtgHmcLw1nUR2NQnfEan4tDxl5H4KOR1y9epwyxVtM/ngan05AT5VJ8JP76BBTub4H/RthXgeiTR+msESDc2sbRpt9W8XMwmJWCXI9IOsylIrNiXruiC5KJ/UxHHryECjgPrEznqWhI4yG6avu/zUhaTcgHN7ouXu0NAqTAIp97VPwnYtp5fxZHgA75YbH8ip9mpgWPd9zlLPcwqMmkXEkh8EcIUDiP5+qodTrmXTBrlUK+M0YiHf/ZIg2VLE4u6Lrmk2720p017Pqv73tw4p7rkj+v+YVxXrcLfUgakZ7otyLgvDfXUyNgv72WkcOpHeM1nhubzRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ut5a3GYb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ut5a3GYb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=rrangel@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtqD4clnz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:11:20 +1100 (AEDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-4af81963f35so3183742b6e.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722278; x=1794327078; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=Ut5a3GYborI8h0mxae2hj8lGdSGwIGlaxIsGhzcx69e0olmDBdk2OX8sNp2lZxnOQd
         ivboD9w6IwtGO8g+8PruBh/Sq2m+vFMVXF2Gw6arGfLHH2HkACRNAb7+6HSg620Pdbp/
         32lA/PPUG7LNx4qHHojEaOUEtJ9lzNryGq7V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722278; x=1794327078;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=nCe6bYk50bSL9nn+iqR19mwCjDkAfHq8teJ/3ds7qz+FdO/EGDvvLipHjPld/4Wag9
         4FmckaxOQ/zt5SX5n6HDYPHWU2SMMswFUeuoSvYlp1nDs2wMhFGuQddzvhWItfDDNYF0
         d0/RGI6zzA3IJStRCU5BbZlRucohsajIfDdsSdaNnkMn7pcixrfV+YnWEs2bN/CMEZPP
         3JwJdbp1XWGitNClvnwgnDZxd8pVLcPQEAPRxhEczlP6cMrNcPPBWiYjDbgjZMJRccEu
         piTOCv9aEesAXiTNw7BIAUMe3XMySHHYj9OR/7dUkN+PbfEEp2gadwzE1ywcw5nuGv5a
         T1sw==
X-Forwarded-Encrypted: i=1; AKwUvBx3uXRXvDzj0OHRFH9UtRvRuwJscT//vK/ZYnKnx6r1MODZqTvoaK/rIje23fdsPWgg1MmNrLNjCTyBdvQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+p2gOzccB35+En5UTZwYUcPbazGpKRqEiXiF6Fj6veheUdLzQP
	E3/V2rJ9z1sCLIhXFRlRI7KfikaE7yOPFma1qyq7i8VbCTgdBzgK8v7WtQXQEdU+vQ==
X-Gm-Gg: AYBFou0LNkra5/GHUQcTwtPgXtIKkiIJcctJ9VCim4lEQd0XZkVyybfa0ABvVMcVm2e
	9erTmdAvth+5gc+6xRR1iOeNHxise5gZdjtjpm5gy9CXTA3S/IQdlFiDFGjU15he3z2lAjYw1d8
	ogh8FTEpTTUCBYPGMIg8Psr5gzRHd6ofM4oD3XXHJZIpM/8AO1Jbwss0VQ+DwP6erKB2TpPD1oE
	p5MWwh5FHGboxUvY0ZECLHlkkPJzawwtmoIGl0u06yh164QM/bk43rgn8Nd+HsrBnajQlEnBZZT
	a8Nozp5xnXtoBD4Qi/cC0kHtDzWsasTHsJG7jFfTpb3VQhDaDB8s8Hh4d7OGF0V0Hf6AOh4q5IV
	rn3YjTUGLL/t1+Jp7NxgC3iBengvJidj0oyOCha5S/ecvhiQItiim5dW8uluSDJccSXpLv30njW
	3gXIur7JKLSRhspA268ePadu1NBez5nZ/li6BlkPGCgCnhqdMJwxtSr5eFF0TOz/Vg3Jnleud9l
	luyMcC6NtXS/bZ5jFyMht4MSc4crXz2Dco1vzYu4G5MVA+7c3O86ZUXuDBMIq/os/7JhGKCG0y5
	xjiq23MDSmUzH9owQ7hdTppdCYzEQ7ekSwoAzbfcbKn3WFQqDR12i00opHC3pTNwZGXZqcAfmWd
	6CUzeAER2DLsDEM0=
X-Received: by 2002:a05:6808:1793:b0:540:5827:6d8c with SMTP id 5614622812f47-5640e032a52mr8860527b6e.57.1793722278097;
        Tue, 03 Nov 2026 08:11:18 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:17 -0800 (PST)
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
Subject: Re: [PATCH v9 5/8] serial: core: allow drivers to reserve flushed transmit storage
Date: Tue,  3 Nov 2026 09:11:01 -0700
Message-ID: <20261103161104.2449407-5-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
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

