Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F75C25B67
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 10:22:54 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=pVDSTwk+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGzJD5ncJz3w21
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 21:22:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=pVDSTwk+;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGyzc01KTz3cBH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2023 21:08:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1698401304;
	bh=c28pYpxArbyuEZ2myHRe2r61OyOEVKqZGscrreOAgrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pVDSTwk+eBFUGccmdM4XYl8JcWr3yHuoEMxytyDIaujDI0NTCs4SyAYnTcFLSe3BM
	 VTqiMb9qhDEWx3OQDKwBxDUyMEnPcuWW0Z9VUjvAKg1sL74cZtJLycA4fAKjXlQeBm
	 du8YetvS0+5ODVNIyDrVw85pH8K3J4s/IqRqCNtgaD3izgRGTUt86hFY23Kb5uZ4u2
	 fWVgTkEWXcWKVU719YvfMBfOjcT6RlMzNPdlt8OivhMmZeqWOOqNwMqr2y2y0MGlPZ
	 jWbmWFL9dNbtGgv6B/OjjoTnb0r1lorK7tmTFEvMI+owBZyZXDLnW5pQI2eEKJ1rWe
	 oyNu9KrqhgJkg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzX65MGz4xWs;
	Fri, 27 Oct 2023 21:08:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Rob Herring <robh@kernel.org>
In-Reply-To: <20231006214516.340589-1-robh@kernel.org>
References: <20231006214516.340589-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: fsl_msi: Use device_get_match_data()
Message-Id: <169840079684.2701453.6831560645739429965.b4-ty@ellerman.id.au>
Date: Fri, 27 Oct 2023 20:59:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 06 Oct 2023 16:45:16 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: fsl_msi: Use device_get_match_data()
      https://git.kernel.org/powerpc/c/89f17016a85280e1b36a6c0305e0191594cbe6ea

cheers
