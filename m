Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0660C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 08:42:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00CA60F36
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F00CA60F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gmv7K5GMXz3cW9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 18:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=rpZ/Hf6O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+f92b0dcacd1ebb3841ba+6565+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=rpZ/Hf6O; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gmv6V1xtwz2yN4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Aug 2021 18:41:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=62Vas8vfgaU4Fg6a79+EgFsfJwf25X3qtqREVjssypo=; b=rpZ/Hf6OytEohJ44VJerrJnY/s
 TEFsUGwQv3vlbUI/UJ63t6E2YTwPjll3r0wySKJteuhDjjHUkTC891M2EaZAtSmzc/6A7VtDUYdeZ
 sj04B0bK0q7cXgHrj4BkRf93eUFG3YOvax+SqxiXEMu68HGkPpVwIx3Bxu1nSZfJ9kMUCSzXM+sto
 M6hSpq59VxPiY/BdGTlq9OS61Y6ZM0kqRjZzvGbgjN7M74UQJlVY3yE+PFufg32Mk50/mGh+9hFnM
 AZlp+9VpV1p/UVgYqoI5Yt2M0GsKqu2cVVjHNlp2YnwDTFsE9y6r5rwyYuCw4Obj52pcnajsvDSDo
 yGLfyGTw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mEpBa-00GXfB-Cb; Sat, 14 Aug 2021 08:38:41 +0000
Date: Sat, 14 Aug 2021 09:38:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 4/8] PCI: replace pci_dev::driver usage that gets the
 driver name
Message-ID: <YReBCtWxvmDx7Uqg@infradead.org>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
 <20210811080637.2596434-5-u.kleine-koenig@pengutronix.de>
 <YRTIqGm5Dr8du7a7@infradead.org>
 <20210812081425.7pjy4a25e2ehkr3x@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812081425.7pjy4a25e2ehkr3x@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Alexander Duyck <alexanderduyck@fb.com>, oss-drivers@corigine.com,
 Paul Mackerras <paulus@samba.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Ido Schimmel <idosch@nvidia.com>, Rafa?? Mi??ecki <zajec5@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Vadym Kochan <vkochan@marvell.com>,
 Michael Buesch <m@bues.ch>, Jiri Pirko <jiri@nvidia.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taras Chornyi <tchornyi@marvell.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 linux-crypto@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org,
 Simon Horman <simon.horman@corigine.com>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 12, 2021 at 10:14:25AM +0200, Uwe Kleine-K??nig wrote:
> dev_driver_string() might return "" (via dev_bus_name()). If that happens
> *drvstr == '\0' becomes true.
> 
> Would the following be better?:
> 
> 	const char *drvstr;
> 
> 	if (pdev)
> 		return "<null>";
> 
> 	drvstr = dev_driver_string(&pdev->dev);
> 
> 	if (!strcmp(drvstr, ""))
> 		return "<null>";
> 
> 	return drvstr;
> 
> When I thought about this hunk I considered it ugly to have "<null>" in
> it twice.

Well, if you want to avoid that you can do:

	if (pdev) {
		const char *name = dev_driver_string(&pdev->dev);

		if (strcmp(drvstr, ""))
			return name;
	}
	return "<null>";

Which would be a lot more readable.
