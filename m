Return-Path: <linuxppc-dev+bounces-26887-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D20C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 07:56:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hftR82t0sz2yps;
	Wed, 09 Sep 2026 17:56:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788940564;
	cv=none; b=SPgOD87wtws/snhvmQ9lypOsUjdLy9mIoMeS03in0Q3TIwdLZB+81FzejFbONMXxz5TWqRbumj7+Bb1oehv8IQx1WUe9mqFQwthyATRwnS9G7KC2TCCejbpEQT0cTV1o6rVbyHZyRKRX/WnaEj0MUclInEIGRIzrq24ZNBSbja9ZMJuTOrT8w1e8vxB4uMl+ao3KzR3SaAGd5fCAqKBlgO0q8/09kUqwvDnpUNE6dv99glYKMaC0++nlWSpbohiE+T1NucS14SbiyeUdn/hF52qpsjxy+Q5nejWp3KDC99coSPlMKMKsU5R/NMvemNkKLHrEFUrAXNyLlAQyxuncLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788940564; c=relaxed/relaxed;
	bh=he19iCzrRxo3WnnUnPY3MDRZb9A1b+Vb2j2sZuDZX/8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WWj+VjU5hjmjJfQXLKJHm7I5hUxzALD9QHVXQ0Sfmcw1RWAQ83Y2ca7DXZ8MDNdw2+R9jkMTmfCmhEQU4zruVTlFB5ND5WLQXMki0f0Fiqt3nVnYEIsST08je05f1NlvkjerXTye8m1J0HR+sxHFSKXXWHV4xYIfNUySltqFfqbjKQbqQQPvFQa2Ty4D78vwucyp9k3gOL/J9SRhIu8MGbroVDP8YQr+94s9HPWFgTj2cFjaWNwlRahgjsxdrMiMwbmPcUHJbQxVRtFVNcOFi2lfp20V2mEiCfQoziaCGZh6zFBjO1CLIDGESRnQpCD5ZVkdC4C/qVvkSkOeZwfwbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h5oled0A; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h5oled0A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hftR65G8pz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 17:56:00 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5C55A4E415AE;
	Wed,  9 Sep 2026 07:55:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C93F60448;
	Wed,  9 Sep 2026 07:55:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 971C411C7AF5E;
	Wed,  9 Sep 2026 09:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940553; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=he19iCzrRxo3WnnUnPY3MDRZb9A1b+Vb2j2sZuDZX/8=;
	b=h5oled0AGuPhSAdx0zPDdS5FhWfOBGaE/iY6ipVGbRdwtrKvHrFmr8uA2iEQhfvZf+pWRk
	8h/6xeXmGjNMFZVBORey+AXyhBxGY3FBkX1/NATYVv8JVw7Yj2AQs7/G1n8Q9dvyKa5bky
	Z6Vnhg1/txiVFHvowq9OC7ul3ddqZp+7v4DhGIyMfnoQ1ImqFB9B3ZxuP1j4jojwwSt0KJ
	poR1gYMLI8PD/u0hu4canhpVonRrRONYA9GCsEQ5/sEYaDBjp5lGOOqsMv+WYXaJDTXrCA
	+33QDDMakLnrELjMKLInCmAnMN4CPd+P8V1xSt616FauIaA8h972KKeXGECg/g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-mtd@lists.infradead.org, Rosen Penev <rosenp@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260907004821.225576-1-rosenp@gmail.com>
References: <20260907004821.225576-1-rosenp@gmail.com>
Subject: Re: [PATCH] mtd: powernv_flash: fix kernel-doc for
 powernv_flash_release
Message-Id: <178894054966.2043044.8945408361627084765.b4-ty@bootlin.com>
Date: Wed, 09 Sep 2026 09:55:49 +0200
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
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 06 Sep 2026 17:48:21 -0700, Rosen Penev wrote:
> The function is powernv_flash_release, not op_release. Update the
> kernel-doc comment to match.
> 
> Fixes W=1 warning:
> 
> Warning: drivers/mtd/devices/powernv_flash.c:271 expecting prototype for op_release(). Prototype was for powernv_flash_release() instead
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: powernv_flash: fix kernel-doc for powernv_flash_release
      commit: 673f0a002d60701af888d2280543b7556c0c2b20

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


