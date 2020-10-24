Return-Path: <SRS0=qtOt=D7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88857C4363A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 01:47:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EFC22272
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 01:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xSt1b31L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EFC22272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJ3rS6fbPzDr40
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 12:47:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJ3pM3HfpzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2020 12:45:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=xSt1b31L; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4CJ3pL5Q55z8sx8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2020 12:45:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4CJ3pL4wxzz9sTc; Sat, 24 Oct 2020 12:45:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=xSt1b31L; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4CJ3pL3RgWz9sTL
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2020 12:45:46 +1100 (AEDT)
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net (unknown
 [163.114.132.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C8C4624248;
 Sat, 24 Oct 2020 01:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603503944;
 bh=2kucWq6fIPZuQcW+Bh9h6RNN0nO1xpFidJTTDqAqhEQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=xSt1b31Lvzcc0WIbFkjImUmzJW/wJyfgR6TZDFKtipoEciHyi/V24K3EUw3HA5xKQ
 XDSNDRL5KkSFvnkzOW5MJ3H58NeL53JswhmLyDerWf4aiP+vZw4h7mc0lf+YWg4aZ3
 OOhCc7OBjXGyhv8U+JQrZixHDY4aT3Qc29YYLScs=
Date: Fri, 23 Oct 2020 18:45:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] net: ucc_geth: Drop extraneous parentheses in comparison
Message-ID: <20201023184543.5b0a95c7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201023033236.3296988-1-mpe@ellerman.id.au>
References: <20201023033236.3296988-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linuxppc-dev@ozlabs.org, leoyang.li@nxp.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 23 Oct 2020 14:32:36 +1100 Michael Ellerman wrote:
> Clang warns about the extra parentheses in this comparison:
> 
>   drivers/net/ethernet/freescale/ucc_geth.c:1361:28:
>   warning: equality comparison with extraneous parentheses
>     if ((ugeth->phy_interface == PHY_INTERFACE_MODE_SGMII))
>          ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> It seems clear the intent here is to do a comparison not an
> assignment, so drop the extra parentheses to avoid any confusion.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied, thanks!
