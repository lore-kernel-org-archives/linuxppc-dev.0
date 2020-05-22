Return-Path: <SRS0=CBJl=7E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FADC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 22:53:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4410E20723
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 22:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4410E20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49TMGB6VtjzDqng
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2020 08:53:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=davemloft.net
 (client-ip=2620:137:e000::1:9; helo=shards.monkeyblade.net;
 envelope-from=davem@davemloft.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=davemloft.net
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49TMD01HGZzDqlr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2020 08:51:07 +1000 (AEST)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 2563D12744E72;
 Fri, 22 May 2020 15:50:55 -0700 (PDT)
Date: Fri, 22 May 2020 15:50:54 -0700 (PDT)
Message-Id: <20200522.155054.352367636201826991.davem@davemloft.net>
To: valentin@longchamp.me
Subject: Re: [PATCH] net/ethernet/freescale: rework quiesce/activate for
 ucc_geth
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200520155350.1372-1-valentin@longchamp.me>
References: <20200520155350.1372-1-valentin@longchamp.me>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 22 May 2020 15:50:55 -0700 (PDT)
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
Cc: matteo.ghidoni@ch.abb.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
 linuxppc-dev@lists.ozlabs.org, kuba@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Valentin Longchamp <valentin@longchamp.me>
Date: Wed, 20 May 2020 17:53:50 +0200

> ugeth_quiesce/activate are used to halt the controller when there is a
> link change that requires to reconfigure the mac.
> 
> The previous implementation called netif_device_detach(). This however
> causes the initial activation of the netdevice to fail precisely because
> it's detached. For details, see [1].
> 
> A possible workaround was the revert of commit
> net: linkwatch: add check for netdevice being present to linkwatch_do_dev
> However, the check introduced in the above commit is correct and shall be
> kept.
> 
> The netif_device_detach() is thus replaced with
> netif_tx_stop_all_queues() that prevents any tranmission. This allows to
> perform mac config change required by the link change, without detaching
> the corresponding netdevice and thus not preventing its initial
> activation.
> 
> [1] https://lists.openwall.net/netdev/2020/01/08/201
> 
> Signed-off-by: Valentin Longchamp <valentin@longchamp.me>
> Acked-by: Matteo Ghidoni <matteo.ghidoni@ch.abb.com>

Applied, thanks.
