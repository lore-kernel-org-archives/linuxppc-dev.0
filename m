Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16294C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 02:58:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB5E20870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 02:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB5E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zVlY1Gv3zF3WD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:49 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zVjH36MTzF3H4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 13:56:50 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 94BA814D5D736;
 Mon, 19 Nov 2018 18:56:46 -0800 (PST)
Date: Mon, 19 Nov 2018 18:56:45 -0800 (PST)
Message-Id: <20181119.185645.2204566540161345724.davem@davemloft.net>
To: julietk@linux.vnet.ibm.com
Subject: Re: [PATCH net] net/ibmnvic: Fix deadlock problem in reset
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181119215727.22197.97260.stgit@ltcalpine2-lp22.aus.stglabs.ibm.com>
References: <20181119215727.22197.97260.stgit@ltcalpine2-lp22.aus.stglabs.ibm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Mon, 19 Nov 2018 18:56:46 -0800 (PST)
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
Cc: netdev@vger.kernel.org, mwb@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, tyreld@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Juliet Kim <julietk@linux.vnet.ibm.com>
Date: Mon, 19 Nov 2018 15:59:22 -0600

> This patch changes to use rtnl_lock only during a reset to avoid
> deadlock that could occur when a thread operating close is holding
> rtnl_lock and waiting for reset_lock acquired by another thread,
> which is waiting for rtnl_lock in order to set the number of tx/rx
> queues during a reset.
> 
> Also, we now setting the number of tx/rx queues during a soft reset
> for failover or LPM events.
> 
> Signed-off-by: Juliet Kim <julietk@linux.vnet.ibm.com>

Applied.
