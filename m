Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E1BC433EF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Sep 2021 12:31:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B02360FF2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Sep 2021 12:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B02360FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJ27P4kljz3c4p
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Sep 2021 22:31:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jHVBVDlB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jHVBVDlB; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJ25t3Wtlz2yMs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Sep 2021 22:30:10 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 37498611C5;
 Mon, 27 Sep 2021 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632745808;
 bh=vHRvx4bqIrTDmW3gd3OAO2wkD6tvqIjrAO/RflxqAaQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=jHVBVDlBE6WTF8/sZCjZ5wbH5HHspUnup8aDFyZ+YOJEBc/ztmzIbwuUkaeFaYIH0
 TcBuSQDeqYTamVvIiyDca57x5h7oMlIVDmb2bWGA8Bz0C6iqJlEVQFsdM7InUntIlP
 /WZDjNxwtfvHugYoJamTOKatRhlwTqZdk+VvncjEc0PdbAciFiUhS46VArIOPJgas5
 GEAVgMPhUuqx9T73pL5teTTPq6mot1rhPekPfMAMqcI+68VhVexLUSPnj7rZAFOIn4
 GKlC606bV8kAc7XKa0Ue459YizvqxO+O5j5IG/Yym4rGeRxId7RC/d5Ki6rAsNopwl
 lnEpfy1z2vBEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ibmveth: Use dma_alloc_coherent() instead of
 kmalloc/dma_map_single()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <163274580818.1790.2020882951937790208.git-patchwork-notify@kernel.org>
Date: Mon, 27 Sep 2021 12:30:08 +0000
References: <20210926065214.495-1-caihuoqing@baidu.com>
In-Reply-To: <20210926065214.495-1-caihuoqing@baidu.com>
To: Cai Huoqing <caihuoqing@baidu.com>
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
Cc: cforno12@linux.ibm.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, paulus@samba.org, kuba@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Sun, 26 Sep 2021 14:52:14 +0800 you wrote:
> Replacing kmalloc/kfree/dma_map_single/dma_unmap_single()
> with dma_alloc_coherent/dma_free_coherent() helps to reduce
> code size, and simplify the code, and coherent DMA will not
> clear the cache every time.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> 
> [...]

Here is the summary with links:
  - [v2] ibmveth: Use dma_alloc_coherent() instead of kmalloc/dma_map_single()
    https://git.kernel.org/netdev/net-next/c/4247ef026937

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


