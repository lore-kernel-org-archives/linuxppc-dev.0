Return-Path: <linuxppc-dev+bounces-20492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE7AFF8855
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 23:47:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9FYm2C0Yz2xjd;
	Wed, 06 May 2026 09:47:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778024860;
	cv=none; b=ceqhc73LQWb5vZHbUfKvi8ca55qZgIdVdvviyQYpoed7FM3+o1TCbP6RkXcjBQdYQ1+0SDgUhEWQZUJ9+dt66XkynRBxcBSefiqnGw6QDvRt6VLabXYIFKcospahTV3G3XRbvnJirE0oDqz3xItYPCwPRejDLGRFzLVz+lYoC+0aybS/KT3unA0TEr3K2O5wszwtlfRJ46kSIW297d8NjyefWydohZBLYnyHI7NKwH5fvAw5rImFKo2APEln9bpLhBL+0oWjRh83ojivuNj/90ghRqu02woHbgWcuoCHxrDdDfh/u3xVePVrWLewNTpSsv1v+qyOBcHhrHkEDBchUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778024860; c=relaxed/relaxed;
	bh=2iuMIIuaxy+LxY6r3I3UWO/Kp0tjbJC+0BF4bNilSQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvzwixJN/txH1ffPGuMY8rCbOoHt7P06D04gMd+WywD5J8IyGScB1TwCU76yRRsw5CeEukd+u6F7tO+0tRPsJpeD5Is09DY+50dx52MP5VUZIi2y+ALFKip+hUxwVhm4noOsgpHbaHVGUQ9+D2Pz2HVs3FEfo+BvzJgYYVAXuhR/cHA6P6c8vzAHVQ2Lwm1iIk4wFEk2VU0C3vkGydely3XAlau1RIfSSgiVjHOix8iWEpoZ6nQpg/h5qQpBQkaCYIadCwMI62uiVx8rQBUTCCqrhWA7d2h+yU98htctKamPSKfu/WTyh5keAl1OiR5JsKrQRCPVUCkHIAKQC72bIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mSZqag/N; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mSZqag/N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9FYl4F0gz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 09:47:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 85BA36132B;
	Tue,  5 May 2026 23:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4839C2BCB4;
	Tue,  5 May 2026 23:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778024857;
	bh=3r0ZNyX7X5IFV2nmj70h8MMAibad4YbMGo46z2KFL3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mSZqag/N7r8AJmkmWKSMWc2XDHcFWL0l2IRahDmpTvkdMKpw0q5vX/uyu1YxkwexJ
	 OJEYOiGJiXJx/edjOD5FZ0SnOBHB5aBpjgoiy+OGXUW2gOYQAclwhnUE/wheB9K7kU
	 J+V0ow0Mf25DcPNpw5YCZgeF4/zaFAJ2eWlpOxdqKgBpnSPCRIVih0Li0BIYc3nIzv
	 Wxxm3XLwajFtHA2Iti3ZedeI3UGVgY9ZmDOHBKpMuYxsthWO5Je2ARt4n6OyPkb+lg
	 8xHsqfmznJ9lUUK8MiY2Tp1COk/s+/rIXhmTZ+nWHY7yY2v9bulRxbchQfXwSEOPp7
	 Ie/iBEug+i0kw==
Date: Tue, 5 May 2026 16:47:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
 <qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <20260505164736.26d203a8@kernel.org>
In-Reply-To: <AM0PR06MB103966EF99B706158C49CB3EAF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
	<3e1a653b-81bc-4008-8f84-77c823aeef49@kernel.org>
	<AM0PR06MB103966EF99B706158C49CB3EAF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
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

On Tue, 5 May 2026 08:33:34 +0000 Holger Brunck wrote:
> > I don't think you can just kfree() an skb like this.
> > 
> > I think you have to call dev_kfree_skb_any() instead.
> 
> yes you are right or at least dev_kfree_skb() as the error handling code in
> ucc_hdlc_tx does.

Please make it clear in the commit message how you discovered
the issue and how you tested your patches.

