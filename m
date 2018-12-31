Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9274BC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 04:24:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C826520B1F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 04:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C826520B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SkjJ0h0YzDqHS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 15:24:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=davemloft.net
 (client-ip=2620:137:e000::1:9; helo=shards.monkeyblade.net;
 envelope-from=davem@davemloft.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=davemloft.net
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Skg73YNNzDq9G
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 15:22:26 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 182C314AE83AD;
 Sun, 30 Dec 2018 20:22:22 -0800 (PST)
Date: Sun, 30 Dec 2018 20:22:19 -0800 (PST)
Message-Id: <20181230.202219.1041865778497322666.davem@davemloft.net>
To: peng.hao2@zte.com.cn
Subject: Re: [PATCH v4] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
From: David Miller <davem@davemloft.net>
In-Reply-To: <1546073252-98777-1-git-send-email-peng.hao2@zte.com.cn>
References: <1546073252-98777-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sun, 30 Dec 2018 20:22:22 -0800 (PST)
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 julia.lawall@lip6.fr, linuxppc-dev@lists.ozlabs.org, wen.yang99@zte.com.cn,
 qiang.zhao@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sat, 29 Dec 2018 16:47:32 +0800

> +static struct resource *ucc_get_resource_by_nodename(char *name)
> +{
> +	struct device_node *np;
> +	struct platform_device *pdev;
> +
> +	np = of_find_compatible_node(NULL, NULL, name);
> +	if (!np)
> +		return ERR_PTR(-EINVAL);
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev) {
> +		pr_err("%pOFn: failed to lookup pdev\n", np);
> +		of_node_put(np);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	of_node_put(np);
> +	return platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +}

"of_find_device_by_node()" takes a reference to the underlying device
structure, and you never release that reference.

I am very concerned about your submission because there are many
serious problems in it.  It is absolutely impossible for your v3 to
have been tested, and now this new v4 adds object reference leaks.
