Return-Path: <SRS0=O+98=EN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E935C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 01:41:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544FE2078B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 01:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPwAsrf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544FE2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CSg3K0mHJzDrQp
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 12:41:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=VPwAsrf4; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CSg1M6gzRzDrKL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2020 12:40:07 +1100 (AEDT)
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604713204;
 bh=p/Ly8ykcdpwFjkgtFxIWKavOGzJ4smgguMtzXX9FEwg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=VPwAsrf4cmdEEBM4P70dgJW8Xi485XJ7KCOew5OZUBbSljYawQwUxuCoJA8Ciq5Eu
 tpb+KIKH4tp8BC2f8uL+TaSUgvyxqdaIzMX+pRHy6cNR47zoRf/vvgEn27LA5XHu6Y
 OyjbJrxecJnKlTXriztWmnTgQV9kvbs972Q8Zfw4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Revert ibmvnic merge do_change_param_reset into
 do_reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <160471320435.9446.8395334114876368944.git-patchwork-notify@kernel.org>
Date: Sat, 07 Nov 2020 01:40:04 +0000
References: <20201106191745.1679846-1-drt@linux.ibm.com>
In-Reply-To: <20201106191745.1679846-1-drt@linux.ibm.com>
To: Dany Madden <drt@linux.ibm.com>
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri,  6 Nov 2020 14:17:45 -0500 you wrote:
> This reverts commit 16b5f5ce351f8709a6b518cc3cbf240c378305bf
> where it restructures do_reset. There are patches being tested that
> would require major rework if this is committed first.
> 
> We will resend this after the other patches have been applied.
> 
> Signed-off-by: Dany Madden <drt@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next] Revert ibmvnic merge do_change_param_reset into do_reset
    https://git.kernel.org/netdev/net-next/c/9f32c27eb4fc

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


