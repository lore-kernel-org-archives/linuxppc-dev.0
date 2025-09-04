Return-Path: <linuxppc-dev+bounces-11740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F8ACA1002
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Sep 2025 13:37:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHgXP3sVyz2xSd;
	Thu,  4 Sep 2025 23:37:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756993077;
	cv=none; b=SQ4iQp/qQlYhLa5OZptwUk3+hGbSWyRNo7eHM7GjnpQ1RQBqW8q3F+om5VT2cJVE/A/AgPR8GStUzXUL/AA/CS/+Hcc6t36flEKs2Dzcn+xilOaYB4cMHT7LrCBhb/EuhaE/SLf1yNG7DjN75vffLHXyldpPvJpRCHA76w/Hb3la5AgzUGxnAsfEeZDo4edXAD9vb57D8wZ3xIP3AzjzZ/hROl/AC8JROI/8umGEa6DaNeuOZUJRsBR/MfG3s1OhHQ6c+xCjI5W3MiMd6U8zync9+bpFwsTke0wwV4YMQnu4emWlXTNo/fa6wwlWaJLlBnZrAwqL8kaQJxT/GmWYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756993077; c=relaxed/relaxed;
	bh=CKGdY7RmH5cAzEkh5vkCldeRjcibzV04dgx9oeEZxdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gq3vqKih2uOmc4QLEe4g+iPbVj4yZYQtrMbagvcdX+cIJ1ibr+7TRApNkt8j6fzUwsajhoKEw5IMf/GIc3zFoSCW+xFGbA9GnmJCHzqI3m9BMLLC82WdclM82LTNkCif5WlemSQu2n+sDJ05Yk6DmjTaV/sDyOYAOeBnqwRxiebAB/LFVhJ3ZAyTpoJwiNtFB9Yo3nDtCH/jSD/oYtey3GnM7S0d1zXMCZXnFh0znudpwz0c66vhKdLGuu6D2ucuBnWnaM1NYEfD33xC6yQfIy/i5Nf3Q63Fv8EiDFGIK63SDO92wQxWqx0SFiJ4q+QTsgCKnVxj2o2SNxfCr46lsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NLmzmxUP; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NLmzmxUP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHgXN6l6Mz2xQ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2025 23:37:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A651C44BFB;
	Thu,  4 Sep 2025 13:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D530CC4CEF0;
	Thu,  4 Sep 2025 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756993074;
	bh=IZYPvmhp4Lu67EYKMyAIk7sdK71xXGH4/n1ufrRtfgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NLmzmxUPhrUNM/sfjImKJAHD31D8b9GHAc1ioUIZLX12iEeXiOAZOHok9OBF3Fxiq
	 /atb96duOLqQMAa7f/7zFPzpRTmGmiYC5mv8uI4IW7lJMKvFu0BTqDW55qhDwkg842
	 kCjXJrDGNNKTKwUX9NMf6XtG43LxmCYvSgk6U+Q+YUf6mNYWGC0h7glxQkPJ20LbxP
	 YCM5nR0eS7r0XI1J4AtBkwyGsLQkYDWg+NSuzU5bmsmAgu9WqjYgMC+GHpcE5BoI1F
	 8zGtHZHYCtWwbBGd+12NQqWYZIk4Y5GJwFJwntobpugQuXr9tfN2Mt8uV/7LjNXzh6
	 ii9GmFTlCfbQg==
Date: Thu, 4 Sep 2025 06:37:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>, "Y.B. Lu"
 <yangbo.lu@nxp.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>
Subject: Re: [PATCH net-next 0/3] ptp: add pulse signal loopback support for
 debugging
Message-ID: <20250904063752.3183d523@kernel.org>
In-Reply-To: <aLmOfsgjumBX3ftE@hoboy.vegasvil.org>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
	<aLhFiqHoUnsBAVR7@hoboy.vegasvil.org>
	<PAXPR04MB8510785442793740E5237AFA8800A@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<aLmOfsgjumBX3ftE@hoboy.vegasvil.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 06:05:02 -0700 Richard Cochran wrote:
> On Thu, Sep 04, 2025 at 01:55:43AM +0000, Wei Fang wrote:
> > Vladimir helped explain its purpose in the thread, do you still think
> > it is pointless?  
> 
> Vladimir gave practical examples for the use case, so no objection
> from my side.  I just wanted to understand how this is useful.
> 
> Next time, it would be helpful to have that info in the cover letter.

+1, let's get it reposted with updated cover letter.

I'm tempted to ask for a description under Documentation/, tho, 
I'm not 100% clear whether authors expect users or driver developers
to exercise the loop. Maybe such distinction doesn't even makes sense
for embedded devices..

