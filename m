Return-Path: <linuxppc-dev+bounces-23978-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B07C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx92D4BLcz2xWY;
	Fri, 10 Jul 2026 08:42:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783636932;
	cv=none; b=UirObgHnEvqqx8AVW9uwWy0/bIQYK31ixzHvusMKH8BL1CajihFMhGbkA3+tPB3sfpYCsPKWCkqgvioA1HocKzQTiMlfDIzawL5qfFKfUf9fQ7ezPixdAuqbfao1o7FxPLnH0KpaSSj3rf/fUHv6q39mg2OzzqIbkCc8xOOECN2tjPhETMMibdLG94Lkr/ozxhHG51eGlYj+DJ775pMs45gs3OiTp1tYgFKH024IbMUJh8jssvQrqM9djujBXeG1ANhA+250QCZ4litPkUJd2/qrIElnaey4uTsF7l/4PstpYFrvaFVz4RK+bwgbzKHhClJOYzN5ObBN0uaMr7cq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783636932; c=relaxed/relaxed;
	bh=kZqBV0h2Ysco3x+okR7LyFcVjz1JoLkubJmF60s4PQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WRyKCgp2QNOojZ70XbnkDcQVT4ajMejrp41b3ZLKfgKu4jwVaDh9D1c0AknDvLF4s546UG3S+UJuYidaqis9gC3WT1WPiXlJFofwebvH/x31uQDFjHsGOLxpCvyAiKU7d/XJHOgiCTtXHOBVaOcglgbRRWSBmqM0COikhGEYDNnej0FWIi0wcSTdr058fBLOe5nxtARF3Kyw3Z2fFjoGi21h4Qqc94v0M9CMU0EecMNVcUCK6npG01vCrezDOjo1eYs5Qoi82YHS0RdhykEA7AOUfixIg5MBxVn0bfuPab4orQvlWvyCbkr4OYJW7bAiy/QrBrz/A9gQQy6A3rl/Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifBPq5OZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifBPq5OZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx92C3ZGWz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 08:42:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 37AED600C3;
	Thu,  9 Jul 2026 22:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D31F000E9;
	Thu,  9 Jul 2026 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636927;
	bh=kZqBV0h2Ysco3x+okR7LyFcVjz1JoLkubJmF60s4PQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ifBPq5OZNsfvHF4IGu8LuJGf83QUd79cM+cHTY1CR8Batd5orrPwwwF192hm8OKYd
	 mxS+g9rw5lKu1fwymJvdYXcpS0GJZtCUTIsa90eKNL6yhKyeG7IUbYyUgYsBCQa4Q8
	 RiMZM3j79jIPsd1tShNZnh6bk39zsjzNIFKQRSI4i0b10/rigC/GgUoYdEr1waLIwg
	 310VZDFIzWu/ML0A0K9i1SO2wDqQKO04VY7I8lFkM0XHE+uEXmMeAwQbM4pQr0qn7h
	 PcPOtcSFV0xN9v/Nzi3T8ucFtkNPxsc0YPsxXLIr7qPxx9nItyfpLpCCimXOdKkNIh
	 O9b2sLNqsJbwQ==
Date: Thu, 9 Jul 2026 17:42:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Murashka <yurypm@arista.com>
Cc: bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org,
	mahesh@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/2] PCI: Add boot options to disable DPC and AER
 recovery
Message-ID: <20260709224206.GA913007@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709185429.627968-1-yurypm@arista.com>

On Thu, Jul 09, 2026 at 06:54:27PM +0000, Yury Murashka wrote:
> On large modular systems with a complex PCIe tree, the default kernel
> AER recovery and DPC behavior could cause unexpected side effects.

I can't tell what the actual issues are, but if there are kernel
defects in this area, we should fix them.  If this is to work around
platform defects, maybe we need quirks to work around them
automatically?

