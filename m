Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A94C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 15:44:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F4722CAD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 15:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqJ4AUhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F4722CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVddJ3gQpzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 01:44:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=PqJ4AUhN; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVdMb1c6kzDqVv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2020 01:32:25 +1000 (AEST)
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown
 [163.114.132.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC03B207FF;
 Mon, 17 Aug 2020 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597678339;
 bh=2c4Yh95xvolsVljCfBjOgUgBnpWZevsxHtYN4hwUUuQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PqJ4AUhNCRXS/VC9OkD2uAmeo4aNAyZFhtAwYnKIWQMQg4HzuxJiPNeQAvPUunzxL
 vszsyooQh67yVwKcN2epBRLBbjuWuZCRBZX1do/00btQNQEi18MWMihYss83LaZXfH
 JZrLi1BvTDV+8rUaibFK/+EgCNKN/gzQ0u1Bd7vo=
Date: Mon, 17 Aug 2020 08:32:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allen Pais <allen.lkml@gmail.com>
Subject: Re: [PATCH 06/20] ethernet: chelsio: convert tasklets to use new
 tasklet_setup() API
Message-ID: <20200817083216.5367f56a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200817082434.21176-8-allen.lkml@gmail.com>
References: <20200817082434.21176-1-allen.lkml@gmail.com>
 <20200817082434.21176-8-allen.lkml@gmail.com>
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
Cc: jes@trained-monkey.org, borisp@mellanox.com, keescook@chromium.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, kda@linux-powerpc.org,
 cooldavid@cooldavid.org, dougmill@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-acenic@sunsite.dk, oss-drivers@netronome.com,
 Romain Perier <romain.perier@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 mlindner@marvell.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 17 Aug 2020 13:54:20 +0530 Allen Pais wrote:
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

You need to adjust kdoc when you change functions:

drivers/net/ethernet/chelsio/cxgb4/sge.c:2664: warning: Function parameter or member 't' not described in 'restart_ctrlq'
drivers/net/ethernet/chelsio/cxgb4/sge.c:2664: warning: Excess function parameter 'data' description in 'restart_ctrlq'
drivers/net/ethernet/chelsio/cxgb4/sge.c:2965: warning: Function parameter or member 't' not described in 'restart_ofldq'
drivers/net/ethernet/chelsio/cxgb4/sge.c:2965: warning: Excess function parameter 'data' description in 'restart_ofldq'
