Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B250C6FA82
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Sep 2022 23:03:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRMbC6bM3z3bmc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Sep 2022 09:03:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=o6t7XEtd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=185.16.172.187; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=o6t7XEtd;
	dkim-atps=neutral
X-Greylist: delayed 2320 seconds by postgrey-1.36 at boromir; Tue, 13 Sep 2022 09:02:59 AEST
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRMZW2cVDz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2022 09:02:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4cWj7BmYoa2XWzpuvLvGBLtsVV+SECXBa/VKQOAK6YY=; b=o6t7XEtdNBPBXi50TzN5rAct1N
	DbG4hT2wBZ7KBveGZcJeS1IGY/P9EwGxheWIGd8FNhXYazTPwlBFpcOVQvOmRiY0XFRjJkZ/0xoRD
	7EbWILBx2FEq9mekw1yCsZ8iRNvu8xeoxQR63V2EBadx/zUSUJ7oKgheSKkSSrbg3yw8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1oXrqS-00GWxN-5D; Tue, 13 Sep 2022 00:24:00 +0200
Date: Tue, 13 Sep 2022 00:24:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: Re: [PATCH] net: ethernet: remove fs_mii_disconnect and
 fs_mii_connect declarations
Message-ID: <Yx+xgHjNTDcpqdwO@lunn.ch>
References: <20220909062959.1144493-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909062959.1144493-1-cuigaosheng1@huawei.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com, vbordug@ru.mvista.com, kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 09, 2022 at 02:29:59PM +0800, Gaosheng Cui wrote:
> fs_mii_disconnect and fs_mii_connect have been removed since
> commit 5b4b8454344a ("[PATCH] FS_ENET: use PAL for mii management"),
> so remove them.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
