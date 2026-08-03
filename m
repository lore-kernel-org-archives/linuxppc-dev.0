Return-Path: <linuxppc-dev+bounces-25264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21638C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 13:05:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDH3J1FHxz3bxM;
	Mon, 03 Aug 2026 23:05:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785762332;
	cv=none; b=Ai55xSQ/SVVCfLvYj2N0H3GRftW4cUHmov6PBJikMy/ln+p+jeMTyCN6TQvrvM2hINHCrtyq/jNyN2o9Q5ZNGfrtZMFVy7Fo6hZimoMvcIAh6SEZAU1C0gSwVRWuKe8iy2PoYTRJFoAOpueupZduQvuYsk9dY4eyCRdhNkjC2p511I3q2yT5gsirwd1Z8ILDWOnwamjXCikgTJaOPA2OQVEYSB9uyAErlkWgJ7+3yfpptTRzFnJjTvINj7uHKC7/lCY8N82UILClJ71IuayemGrcU+ueY683QfnT0KAEbKwdrvmJzO4LpAgh9J9B23QMiiKH+RHb2IKbEt2Wwfj/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785762332; c=relaxed/relaxed;
	bh=E4CdUFjYHxtCtFmqtfplJln3V4Rsrtxnl6ZA+U9+xM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV9iH84zrOLHEP+I1KDTusbUe/oPMO1mJoJ7th7GNZCcZp17dph9nM/47dAvV68e/7125/UKkORxU/SBh9LoyxZT7j2cvhbmPxl95SuzzhQNHhmgHmF/0USfyVqHjvlQOR6+2HtggBxQgkbpmQS4Pv6snGhb7mPu3n/zefAgHFsUuCDUdAvUobNzkK2Dnw2mxea8/cPcSIVScErLG8AjMHhWTZL6TtjpoXFlxS8PEitnMQYS+l9WMpQds40otdz4pjhxdKELS5fwXTwR0Sv6gckMTNwBjKD6we7HlPUS2dT71+ztOtMN0Yd/DqxZ+nVrjh8afddtjftmktrKK06atA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDdWEXGZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDdWEXGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDH3H4N2Nz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 23:05:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 893E942DD4;
	Mon,  3 Aug 2026 13:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7CF1F00A3D;
	Mon,  3 Aug 2026 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762327;
	bh=E4CdUFjYHxtCtFmqtfplJln3V4Rsrtxnl6ZA+U9+xM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDdWEXGZKOWdfmqxkNt98Hxjoi+EQiGMlF6D7BWgkPfP8BdtoN8QO63V2fLiwllxf
	 ncMPFEGsNbPdxnvNb6br/dCYjgAV05OiYaRkmrIXd9rAvVK2F0PqCnqnJsUpV+FDkN
	 lpD9BjA4L9PtgZGXEXWdZsa8GYagZNzZXztH4lxy7r/oCd2IeoLRMAZ79xooDC5FLZ
	 HQxMU6w9ae5JfvERZihYdy//pJCu+KFonlY7YLe30hiChXUy2i6WYo6XVj1X6nYf85
	 RKgfAarLUQLlQ+e99AhxK5sVOO3npsA5x/G7BJNzYDJ+QNTfcxMCIX0ea225jiAp5o
	 sXBWPyRv4wI3g==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: drop unused assignment of acpi_device_id::driver_data
Date: Mon,  3 Aug 2026 15:05:04 +0200
Message-ID: <178576221780.155079.7167126702905291904.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728-acpi-bus-v1-1-12ff25fdea9b@thegoodpenguin.co.uk>
References: <20260728-acpi-bus-v1-1-12ff25fdea9b@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=598; i=chleroy@kernel.org; h=from:subject:message-id; bh=fqxFAx+3pPhehbZRvJnB/iTSAhwmfJI7GyaD7JE09B8=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQVTGKTZ/z46/+qI7bfc4/OdvXtqF998QnPjXfH+r5Ps 99venjOho5SFgYxLgZZMUWW4/+5d83o+pKaP3WXPswcViaQIQxcnAIwEaGjDP+Tr1SYPPZ90WHl waM0wfrhD4fNu3m1xWfbzcztD2966O7K8E/vkXnw49ef2Wsy/8udY2pPsbj51Onc4v/Bmuf6eC5 5XeIBAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Tue, 28 Jul 2026 11:58:56 +0100, Pawel Zalewski (The Capable Hub) wrote:
> This module sets the acpi_device_id::driver_data to 0 but
> the field is not actually used within the module, we can
> just drop it from the table.
> 
> While we are at it - use a named initializer for the
> acpi_device_id::id field as well to make the code more
> readable.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: drop unused assignment of acpi_device_id::driver_data
      commit: ab71a25d6658d2412c74bdd1158cc5fb805cab9e

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

