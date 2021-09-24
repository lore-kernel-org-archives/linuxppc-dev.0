Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD0C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Sep 2021 11:48:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2276610F7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Sep 2021 11:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2276610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HG9KJ3kgZz3c4p
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Sep 2021 21:48:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QM7R24l8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QM7R24l8; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HG9JW51jkz2ynG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2021 21:47:55 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B3146124F;
 Fri, 24 Sep 2021 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632484072;
 bh=cfBrH7ovTdnfnA95LdMTguUG9WGpg9tzmCDexuwMXbQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QM7R24l8RqPxsvVnpNH4VPvjLYEGbjIzH5phU1hLwImuDn5LtYQs6A0ZFGBF8DkVw
 k7vZxG2CymW3k6h3rN0nNKi+gQfTIpnaU3NzPUWhpnOWC4DSwM7+ScCZtP9idJrz6I
 E20BNqsZe9KanyUprc7ulTQGiTj3rq3SeEOZTboVu1gQd69fRetPLje4UCaVG+wyM9
 dmQMF8RlfEnyNGOx/XyczJ2jWttHRYEprGVJDVd+llse3lpz5SoQxBOOSNVLsOuhsJ
 n/Ri+smge6o+HDL/aAwwIRbgGn7IXv53ttEUBQ0NweOH0pRm9+erZ6IcqvjtnJtCoW
 YX+ANSfRzxgQw==
Date: Fri, 24 Sep 2021 07:47:51 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL 5.10 01/26] ibmvnic: check failover_pending in
 login response
Message-ID: <YU265yembZGBojsf@sashalap>
References: <20210923033839.1421034-1-sashal@kernel.org>
 <20210923073347.GA2056@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210923073347.GA2056@amd>
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 netdev@vger.kernel.org, drt@linux.ibm.com, kuba@kernel.org,
 Sukadev Bhattiprolu <sukadev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 23, 2021 at 09:33:47AM +0200, Pavel Machek wrote:
>Hi!
>
>Something went wrong with this series. I only see first 7 patches. I
>thought it might be local problem, but I only see 7 patches on lore...

Huh, yes, apparently git-send-email timed out. I'll resend. Thanks!


-- 
Thanks,
Sasha
