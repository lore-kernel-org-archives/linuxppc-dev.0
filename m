Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACDDC43219
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 16:20:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA03D206C1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 16:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA03D206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rx3y715JzDqg5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Apr 2019 02:20:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=davemloft.net
 (client-ip=2620:137:e000::1:9; helo=shards.monkeyblade.net;
 envelope-from=davem@davemloft.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=davemloft.net
Received: from shards.monkeyblade.net (unknown [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rx2B41dFzDqW5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Apr 2019 02:19:08 +1000 (AEST)
Received: from localhost (unknown [12.154.31.190])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 6471F14C711BA;
 Sat, 27 Apr 2019 09:18:54 -0700 (PDT)
Date: Sat, 27 Apr 2019 12:18:50 -0400 (EDT)
Message-Id: <20190427.121850.1265777273042838957.davem@davemloft.net>
To: laurentiu.tudor@nxp.com
Subject: Re: [PATCH v2 3/9] fsl/fman: backup and restore ICID registers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190427071031.6563-4-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
 <20190427071031.6563-4-laurentiu.tudor@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sat, 27 Apr 2019 09:18:55 -0700 (PDT)
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
Cc: madalin.bucur@nxp.com, netdev@vger.kernel.org, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 iommu@lists.linux-foundation.org, camelia.groza@nxp.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: laurentiu.tudor@nxp.com
Date: Sat, 27 Apr 2019 10:10:25 +0300

> @@ -1914,7 +1936,10 @@ static int fman_reset(struct fman *fman)
>  static int fman_init(struct fman *fman)
>  {
>  	struct fman_cfg *cfg = NULL;
> -	int err = 0, i, count;
> +	int err = 0, count;
> +#ifdef CONFIG_PPC
> +	int i;
> +#endif
>  
>  	if (is_init_done(fman->cfg))
>  		return -EINVAL;
> @@ -1934,6 +1959,7 @@ static int fman_init(struct fman *fman)
>  	memset_io((void __iomem *)(fman->base_addr + CGP_OFFSET), 0,
>  		  fman->state->fm_port_num_of_cg);
>  
> +#ifdef CONFIG_PPC
>  	/* Save LIODN info before FMan reset
>  	 * Skipping non-existent port 0 (i = 1)
>  	 */

Sorry, I'm not OK with littering a networking driver with arch ifdefs
all over the place.

Please create a proper abstraction and set of interfaces.

Thank you.
