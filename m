Return-Path: <linuxppc-dev+bounces-25462-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641C5C55ABA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 02:38:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFs0Z1Mfzz2yPR;
	Thu, 06 Aug 2026 12:38:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785983918;
	cv=none; b=P7WKNMmy4p7HLMsJwx5/uhj6dTbJMA6XqOiflW7PgT8it1MzChh5OGCCSk03fIETEjqBVSH9NkY9cx09i1WFB7Iqw0KU/aYU0jwtbvLqdyL3mtW7gWe3bL/cdsT2UaL8/GdJxnZ3S7Mo/FMahIMcgH/g02XfBxMTDdWbzs5dJJd3l/2A0NFnEUKC1bkAEcTcnmQ3NaCaDboIHoDH7qtZcQSxHXNzn1enTJaq98OnAs4zGkOgdPIFQHCrQ1uDZRKO7vAi8CKF62NlIwOWXLXDNql6w/pSiqwho2NcZcx6LQscutM67EyY1JLb1/vnlE/O712s9XOcvE++efL+JJvxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785983918; c=relaxed/relaxed;
	bh=KoHgXbvL30Qgrmwk9JX+SdamFirx6sCrtr9gJ1smc8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6KOtMtNnh+tbE7mg5q1J+0rEDy+Y3JRINHNKey8rpE1m8VDxE8Eo6tRI/C42CQDp9kypf02d5g35SQzdFlcqCth5jePglV92HMGA/WxSQwmxZ2bLs6F/vGqslRPgW+tHPMlUwXL94pJVEue7GLCfsKjmW4vSy9ZjVaX6SdtPo11QBdbVScVnwANKy5fhGGgpwfmphN9XRMSwZj8E1lv2YNmzwOA/ZgeYRi6NdvRLArL3G8EsST6tBBS3S7X6qwRl2oxWBqnyAC7Z2QnP1XxaZGQqZ/7xyKCxFiavzqEfpYraG2W09QgNOf310dJAqOCqsKcc78gopPhZL+hPPBO1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYc/Zn1l; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYc/Zn1l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFs0Y0qT0z2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 12:38:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B2D460A64;
	Thu,  6 Aug 2026 02:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B641F00A3A;
	Thu,  6 Aug 2026 02:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983914;
	bh=KoHgXbvL30Qgrmwk9JX+SdamFirx6sCrtr9gJ1smc8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZYc/Zn1lhVAXgs+g6nlR5jkiiCRnFcKtURnan7/7dYARPGyIIYXQnbyMTKIb7e4Ah
	 OXR44HMtLbJs1TbINMZXQVnKmQQBK2RFX40a/DooWOGy4DjoClV/cd/s8z9O+LRdD7
	 ehW2HeeAkCoqys8Z/Lmu/kmThxZBVb7FQgcT3X/6MSTN2DIH+smj7VCCzw4eUCnY64
	 OQTTHbv2q+dZWAkI70/43FsBtcdhd/Qu7/JGppncO7Di17ht4Sf10O6H8AYAQIcGUi
	 QoTlANCxiUlyx9MqprrkQLT6bBNAsI9NU1ifDhG7RNvjbICfoesaE+jJh1zIuBSNPE
	 pOaIGDwJPEh9A==
Date: Wed, 5 Aug 2026 19:38:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
 ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
 vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU
 values
Message-ID: <20260805193832.645bdb30@kernel.org>
In-Reply-To: <20260805224401.58791-1-mmc@linux.ibm.com>
References: <20260805224401.58791-1-mmc@linux.ibm.com>
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

On Wed,  5 Aug 2026 15:43:55 -0700 Mingming Cao wrote:
> Subject: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU values

Warning: drivers/net/ethernet/ibm/ibmvnic.c:1031 No description found for return value of 'rx_pool_entries'


please DO NOT repost this until your previous series is reviewed and
merged. Please read:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
There aren't supposed to be more than 15 outstanding patches form one
person or company to one tree. We are flooded with AI-assisted code
so reviews are slow. Your place in review queue depends on your
credibility with the community so please help review other patches
or just wait your turn.

