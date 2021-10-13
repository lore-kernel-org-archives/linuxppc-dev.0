Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A030CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 22:16:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C519661151
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 22:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C519661151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HV6Lq3YQZz3cXs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 09:16:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=denx.de header.i=@denx.de header.a=rsa-sha256 header.s=phobos-20191101 header.b=B+fZN8q1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=denx.de
 (client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=agust@denx.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.a=rsa-sha256
 header.s=phobos-20191101 header.b=B+fZN8q1; 
 dkim-atps=neutral
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HV6GY6ndCz2yPG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2021 09:12:37 +1100 (AEDT)
Received: from crub (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8D8E181761;
 Thu, 14 Oct 2021 00:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1634163153;
 bh=vDzTdSOJ5R5ENuBq/d0LcDdztJjFAHgx46FobxeyMS8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=B+fZN8q1o1HRGh4yn42cK/RRHKOEg5c3cOTsMK/dzaae2o56wpiUrJy/V/tlG49+5
 Q+B9DR9LUi8Cc+5wZI8FrvEUieXsh4PiCllh9wpxB/rdmS2UJ0G/gUdjPYSuNq5fMS
 tnvnpFcPL5Sv29Hh4plzOlngnZOhoL7fP67h7CnQ2jIm+Om9aYM46gAoPtbnUN4XXd
 Mp74ybMfij+E4DhTmPpXTkQe9KHrHkcOw2nVp7fIF1Ypsm9ZwRderNQhPl5w1WE6on
 vZBB0+XUQAIiL7C5p+GutuNQwHX2cJMrjRoTgP7Z1eSuJidGeSovnE3oNNhbm8D1Tn
 J3jKVijtJNxdw==
Date: Thu, 14 Oct 2021 00:12:32 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
Subject: Re: linux-next: build warnings in Linus' tree
Message-ID: <20211014001232.3becbe99@crub>
In-Reply-To: <CAK8P3a1EcNuxT-w-8w-HDr2+idsP=vFZ3Cn27fX7o56GOuu_Cg@mail.gmail.com>
References: <20211008164728.30e3d3a3@canb.auug.org.au>
 <20211011082704.3cff4568@canb.auug.org.au>
 <CAL_JsqJE_GHnehBz-71BOGXfjm6q2p0u6FQA5KwO8zK_i1LpMQ@mail.gmail.com>
 <CAK8P3a1EcNuxT-w-8w-HDr2+idsP=vFZ3Cn27fX7o56GOuu_Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd, Rob,

On Tue, 12 Oct 2021 16:39:56 +0200
Arnd Bergmann arnd@arndb.de wrote:
...
>Grant Likely was the original maintainer for MPC52xx until 2011,
>Anatolij Gustschin is still listed as maintainer since then but hasn't
>been active in it for a while either. Anatolij can probably best judge
>which of these boards are still in going to be used with future kernels,
>but I suspect once you start removing bits from 52xx, the newer
>but less common 512x platform can go away as well.

many of these boards are still used, i.e. o2d*, digsy_mtc, tqm5200.
I've sent first series to fix some warnings. Other dts fixes
require driver changes, so it will take some time to fix them.

Anatolij
