Return-Path: <linuxppc-dev+bounces-27102-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AE7C88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:23:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2xq6ttqz2yqL;
	Fri, 11 Sep 2026 15:23:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789104191;
	cv=none; b=bpAChayHmeQTlDMLRaNNEYTbtBAcvL7o9IJG98GFMe4dL/GAc1fpMPVgSsXYvv0yHAQhU9cwrIKdxFPANeFU3g2HxThleCOBlfYspnoPHAXdf+qC0gE0ei38kPovLfD/KSqR0ppoDxK18TUbHQV3y8MvaTmrpQGtvyHX/QWsbfO14q3ZohNS+cnMOpMqCpUIgEnGVsHFLT6QvfRUnOeg5VMX3C7dcsUQUgfam/pE4EIssY4Qe10C/lX8Zt1aoNDjt3venALk5S1bh75f1tBx3vuvmgluJvLuxXK+4hOMfgPLqA6EBudSsCTWK/NEu1aibK2e4jKvBr42E9MxkfXoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789104191; c=relaxed/relaxed;
	bh=GwWyMMxaCtNDet1+YlRZ1iSBj+9uB0p8x9XQ2zZ2thg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKQvmsQlO9YYU2N/pAWhZu71S3D2B720iNUi8opZKr+WG6zPls+UbtPbO5EOxC7jk44JJXLvWGXyvhXRq8twPGuFjtMxEUgrLa5EYd1Pe7L3GO7B4GCqFMF27g962NbP37B0pxtQUG0WaSixDayWhOmi1xSYS8bBfm1PMBQ2Pb4Qm3NX4BZWguW6Y3X0ht8JRafis4Ua6xZIJwZ28V1N6wRBljI8GdI8DiJZ3xgFUNO/B6b3dunhP2GoJonTmD1CdxPYuPC4g8Kg3LNK22KORVifTuN4ujOW3FKK6OMT/0d5te0M5AzYmSGcHjBB9dvU8a6Y9Zm5jxmEao39ZrjiJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNd0ZE8e; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNd0ZE8e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2xp0cdbz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:23:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5F8CD43A04;
	Fri, 11 Sep 2026 05:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED521F000FF;
	Fri, 11 Sep 2026 05:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789104185;
	bh=GwWyMMxaCtNDet1+YlRZ1iSBj+9uB0p8x9XQ2zZ2thg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNd0ZE8eJp4NPkAUIq71VAEFFIa2WTMItObvLW5wdNsE7OMuzx6lMjdGo+0qqylX0
	 V6doJOg0wBEMYaA5iurgy5OniZTbR4VOJgZ2za6XnN+TXgIEONoIwrOIbnqQ296zZU
	 p0iiIRmcYUzBl1oqALWh72uiGsHyUfL8rYD3GY1TJBGnR1gCzXI5ZFQ0EhPvIUFBXk
	 3mjxtzeuIjkEsKd3Gzzl7nbAdA8suJ03JPKA2NfbloRPUiMlc8L/yeUcfY30ojhQpZ
	 nZ47D5eA8QAhP5QJC4yp9csofJr6TRNr3GPsmpjGtx67t03cGYbH6dXfY/rCNjpdLf
	 PxZkUWrrSg9Zw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Qiang Zhao <qiang.zhao@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qe: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
Date: Fri, 11 Sep 2026 07:22:49 +0200
Message-ID: <178910416257.316287.11748008875206660253.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908-usb-fhci-drop-gpio-nonexclusive-v1-1-8e405dc67874@oss.qualcomm.com>
References: <20260908-usb-fhci-drop-gpio-nonexclusive-v1-1-8e405dc67874@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=668; i=chleroy@kernel.org; h=from:subject:message-id; bh=JgI8yiblDDqh0RKocIkn7ftaSlBN5bEMR22YME0ulgM=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQtnqBzKnB/8sb9qptWf3i9IP/AzOeC8k+/Mk9YfN0yo mLxkifxvR2lLAxiXAyyYoosx/9z75rR9SU1f+oufZg5rEwgQxi4OAVgImJ2DH84c4O3JK1QYJ19 VPamddAKU8dTn/adb725Yn3iti/azy9JMDK0uTokr1SaP+OwQcMOdpmVfJdTVzC2Tq+72LBlftx VuTXcAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Tue, 08 Sep 2026 11:27:46 +0200, Bartosz Golaszewski wrote:
> The GPIOD_FLAGS_BIT_NONEXCLUSIVE flag for gpiod_get() is deprecated. For
> actually shared GPIOs, it should be replaced by using the functionality
> provided by gpio-shared-proxy. The Freescale QUICC Engine GPIO driver
> uses it as a workaround to access the GPIO descriptor already requested
> by the caller of qe_pin_request() in order to access the private GPIO
> chip data.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qe: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
      commit: 31d42d67c6eb66efc058069f426d69abb48ec0dd

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

