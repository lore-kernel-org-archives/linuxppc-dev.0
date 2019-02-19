Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7932C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 22:17:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416BC21479
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 22:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416BC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443w8f6dTwzDq6j
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:17:38 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 443w6r2YpRzDq9y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 09:16:03 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id D77ED1086DDEC;
 Tue, 19 Feb 2019 14:15:57 -0800 (PST)
Date: Tue, 19 Feb 2019 14:15:57 -0800 (PST)
Message-Id: <20190219.141557.284906726764572414.davem@davemloft.net>
To: colin.king@canonical.com
Subject: Re: [PATCH][next] ptp_qoriq: don't pass a large struct by value
 but instead pass it by reference
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190219142120.11347-1-colin.king@canonical.com>
References: <20190219142120.11347-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Tue, 19 Feb 2019 14:15:58 -0800 (PST)
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
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, claudiu.manoil@nxp.com, yangbo.lu@nxp.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Colin King <colin.king@canonical.com>
Date: Tue, 19 Feb 2019 14:21:20 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Passing the struct ptp_clock_info caps by parameter is passing over 130 bytes
> of data by value on the stack. Optimize this by passing it by reference instead.
> Also shinks the object code size:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   12596	   2160	     64	  14820	   39e4	drivers/ptp/ptp_qoriq.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   12567	   2160	     64	  14791	   39c7	drivers/ptp/ptp_qoriq.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks good, applied, thanks.
