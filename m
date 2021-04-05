Return-Path: <SRS0=L/Xq=JC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D8C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 19:00:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB8861359
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Apr 2021 19:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB8861359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDg3B0QbFz3bt9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 05:00:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c0XImX0I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=c0XImX0I; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDg2j2WZlz2xg3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Apr 2021 05:00:13 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id DEAF16128A;
 Mon,  5 Apr 2021 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617649208;
 bh=OeEzPTq+1eWjCXb/NofZTNTh0T36O0z2OIw1nH+R8Q0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=c0XImX0IgP3ld8PDj5mFcm3HMB2v7PeT4nBq/y6/s9n5a4bMXfdhNJIhCQxXDLEQU
 uj+2bnlCkkl/IXkMWZGmRwPz8DA1y5x2CeWLbPZg1zSXhNsngUZQXMkVnwnJAPyLBW
 ZGHp2yFo8fdDTkfZ2764Ua4KVDYFKPm800gpwkGYjNEbieVrbt5W4fmXptAPRndQqw
 y+9GL5PRa4ZRa3vRjuYhy/B4AzdbthYhRQV47W1kCqvxxkGPVaP/1VGv9jevo0IDGH
 GjEAWTLqH1jBaNWLqj3Rs3FQziKqlSWbNsKEviU43RTUj5LyeTSL2kz6jpuT8hTkme
 53OeNdLC8jGdw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ibmvnic: Use 'skb_frag_address()' instead of hand coding
 it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <161764920881.15280.15774493910120301088.git-patchwork-notify@kernel.org>
Date: Mon, 05 Apr 2021 19:00:08 +0000
References: <1638085135ee32d5699983981b6a54a11c49ff23.1617526369.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1638085135ee32d5699983981b6a54a11c49ff23.1617526369.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org, tlfalcon@linux.ibm.com, netdev@vger.kernel.org,
 ljp@linux.ibm.com, drt@linux.ibm.com, paulus@samba.org, sukadev@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Sun,  4 Apr 2021 10:54:37 +0200 you wrote:
> 'page_address(skb_frag_page()) + skb_frag_off()' can be replaced by an
> equivalent 'skb_frag_address()' which is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - ibmvnic: Use 'skb_frag_address()' instead of hand coding it
    https://git.kernel.org/netdev/net-next/c/c3105f848577

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


