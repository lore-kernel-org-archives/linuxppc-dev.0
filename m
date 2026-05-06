Return-Path: <linuxppc-dev+bounces-20535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7BCCD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 23:14:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9rmx5KQDz2xqJ;
	Thu, 07 May 2026 09:14:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778109265;
	cv=none; b=b8mO1SqoNhHOv2FIokaq01Zz84ICs0ZNWSygY0cxH8RoxxKC2AZBy8BT8IdGpe8TZ2jbSwJlc6Bpa2ZefxTTB5ip3YZU3v/sGlAStu0uNNOVJbO7uhqxv8mM7147w8iKs02xNkG8euKbkoZ9qo33rlbLGUicJW2CPDJH4c26DkXnVe6l9GZi5pvbfvfWcdKaUz3WcX2G9KqUmEAIgctWGL9wvmQVo9DbhtxpOVQHtd401ZodLOUz/RUCMZpxCB0XksFFyIsdwlt1G205y6SReUhI01uXr/KFENdAeqgOyrXANtv4I1MGictbRwB5D+mF2KleWBPdU/BbKk7P0qDA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778109265; c=relaxed/relaxed;
	bh=x1QfCEO3rYV72LhSL5ZehwU0Cu98D+G5B5lrPqJrh+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSYDjTwBD/YqONyIAlxcaOtq2mQCwQN356HkQoxKtZG2RN9YfRtr4mJNXApJvmk9evSuuygs3Cu342MGml+WHxpCq9Qo6zdBQea6YYEHl4NAyNLi9AAH1OCRYpZyybyZDSsTyKp/RvEdK2hOc9anuU5nd7W5WiuOWjiFijA+ECkP02+PB/pJ5g0YEHTxBMh5y/g5Ncri5xx5JxalvUAHAt3+TXuxI+E7oW91NiU/Z7NKbFyxqMwY2rryGuuPz4zAwdYIuvMgW+kjhrWPZUN9pNq7XIYWlTTl5YUtk+aa+rFXG9oFFBP2h98Dz3eCnqLW7zL6cpN+mx1F127cb0TFhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VjkP6/4e; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VjkP6/4e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9rmw6CFGz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 09:14:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A948844274;
	Wed,  6 May 2026 23:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC0C2BCB0;
	Wed,  6 May 2026 23:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778109262;
	bh=UjfnE7/O3qZFWScF1cgpg1Gv7HfPB1Y2MekRvxqZkh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VjkP6/4epoQ/cKMZAR19PddFjdr5Qm1O+9vM0Bx9MMaGfnxYkzxZz9eOj/zhzwVgQ
	 syrGs+VDc8H/Jo6W7MrqXO6vIwJHD0/jHMVOPmIWagYOprhYU0OQwM/d/XwOXehQSy
	 JAdpznZxFGX3KSO9ei+SzmOk2omMUjYeuRJdsjQ5KgDpWyRHrkxBsYWnw3I56r/Vyj
	 vsOTXlO166IbSS7Cf9TlQUhk/uNxc2r63pnIUFJXXml7idI7KM1kbrhEMV/GzLb3wf
	 jL+79F2D/3wOZl9X9yfd/JS3mRBQx7vYG3iC8niitTJ9nGpXPqOS4SoE/I2dnSAFTd
	 U00PVqhBGR4rg==
Date: Wed, 6 May 2026 16:14:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "chleroy@kernel.org"
 <chleroy@kernel.org>, "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
 "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net] net: wan: fsl_ucc_hdlc: return NETDEV_TX_OK if skb
 was freed
Message-ID: <20260506161421.4e15d466@kernel.org>
In-Reply-To: <AM0PR06MB1039608A8965FE12520901515F73F2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
	<20260505182220.29e5f34e@kernel.org>
	<AM0PR06MB1039608A8965FE12520901515F73F2@AM0PR06MB10396.eurprd06.prod.outlook.com>
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

On Wed, 6 May 2026 09:35:00 +0000 Holger Brunck wrote:
> > On Mon,  4 May 2026 19:44:06 +0200 Holger Brunck wrote:  
> > > If the skb was freed in the ucc_hdlc_tx function and the packet marked
> > > as dropped we need to return NETDEV_TX_OK. Otherwise the above layer
> > > will try to requeue an already freed skb.  
> > 
> > Is this really true? I thought negative returns mean drop.  
> 
> the API suggest to only use NETDEV_TX_OK or NETDEV_TX_BUSY as return value.
> I checked several drivers and they are usually returning NETDEV_TX_OK if an
> error occurred and the driver consumed the packet. But you are right
> dev_xmit_complete will also return true if the return code is smaller than zero
> and the packet is not requeued. Should I update the commit message or should
> the patch be dropped?

Drop the patch. 

