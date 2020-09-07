Return-Path: <SRS0=3aS+=CQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E8AC43461
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2020 21:12:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBF92145D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2020 21:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkHhuiu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBF92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Blgvv1qpQzDqRY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2020 07:12:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=ZkHhuiu9; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Blgsz4TnDzDqLD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2020 07:10:31 +1000 (AEST)
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown
 [163.114.132.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D8172137B;
 Mon,  7 Sep 2020 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599513028;
 bh=UumymxLYqQ3OdFcuPJn2ZB1M+tzni4fLO4l47tqH7+k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZkHhuiu9ZoRLcegon6Y/AEMkvXigJt6M7xUdk/kLGxrtjXqKhVAlvA6HGeT9FJN6m
 LULLn7TGxYPs/2221nPMepiYegr0A2034KetdvY09R5iNIVvW4ELk+G0zB334V510e
 C74SUt/pUql/DMHv9a6kfyCTXaQlR01MAuFm8ShQ=
Date: Mon, 7 Sep 2020 14:10:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.8 14/53] ibmvnic fix NULL tx_pools and
 rx_tools issue at do_reset
Message-ID: <20200907141026.093fc160@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200907163220.1280412-14-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
 <20200907163220.1280412-14-sashal@kernel.org>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mingming Cao <mmc@linux.vnet.ibm.com>,
 Dany Madden <drt@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S .
 Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon,  7 Sep 2020 12:31:40 -0400 Sasha Levin wrote:
> [ Upstream commit 9f13457377907fa253aef560e1a37e1ca4197f9b ]

> @@ -2024,10 +2033,14 @@ static int do_reset(struct ibmvnic_adapter *adapter,
>  		} else {
>  			rc = reset_tx_pools(adapter);
>  			if (rc)
> +				netdev_dbg(adapter->netdev, "reset tx pools failed (%d)\n",
> +						rc);
>  				goto out;
>  
>  			rc = reset_rx_pools(adapter);
>  			if (rc)
> +				netdev_dbg(adapter->netdev, "reset rx pools failed (%d)\n",
> +						rc);
>  				goto out;
>  		}
>  		ibmvnic_disable_irqs(adapter);

Hi Sasha!

I just pushed this to net:

8ae4dff882eb ("ibmvnic: add missing parenthesis in do_reset()")

You definitely want to pull that in if you decide to backport this one.
