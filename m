Return-Path: <linuxppc-dev+bounces-29569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA39ECC6B39
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:07:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5DyQ5MPJz2xSZ;
	Fri, 16 Oct 2026 04:07:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792084030;
	cv=none; b=Q7qIvBVvVyf0RCb1vJJ7by1UhRR6zmZDJA6bTMlnEXGuiIzL/5gA4TQ88eULHvY9GGH6sB/G3VhWOZsvJkc9sn5QW7wCQunnlxYlJLD0ezkBj4WVXgkLxbO4PD7wYe20ySJJ6QIu1Q05IQzzIIWomnyfXGykYftxwpDVk30M7PBT/cu5GU3+zeGr8v1M/aIaG1SWhAHNyWv563RQThXLLJL+3jhCCu+tavbQdVN4aN0dlRyAKy1uWv0oUXumncEW2YA5dkSG4c4jj56GRvo6XiwyWJtBrZiXgsX6laLBJIftjjZP/nj3cPUFVAOh4dn5tYbKWIMGEV+S3NZ+nW4CqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792084030; c=relaxed/relaxed;
	bh=VWkfSRkT/w+lVOCbl0O97VWBKRGnrtBmH8DzMAgCTEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmaneCuaDriZxjeRq8RzlEAnLktMZ7li/TyNZRnFcx0m8BRQ+NJonCLgKl1V8y5D9Y3yKYQwlBcmqtQH7AYp5s3oH/rAfqSGAc0s38r7euSy0Yc2byiTgpkSKO1aqC//ZAGsPvmBxhrWxOrCTNytGCl/YPfA/qxVM8e0+9hiIblRrDylVxtw0pLla8xW0gMWD5HIDqCS1x3eFa3tOwseNBBtBp5FYLEjCkYxlsF04bxwbPLUKzNfQ4fWnIKsXgj5m8VCqcxYyHJaVdoU59svMS4vwM0r0uJJdD2NKATTBwZspmE29X3B0GBuNmMrJgKOlZKZwkePmy/oAs5jvRxA+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGdB/70J; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGdB/70J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5DyQ021mz2xRv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 04:07:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5296D60232;
	Thu, 15 Oct 2026 17:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EE51F000C4;
	Thu, 15 Oct 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792084027;
	bh=VWkfSRkT/w+lVOCbl0O97VWBKRGnrtBmH8DzMAgCTEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fGdB/70JJ8gmWqUnw6NDgZZ0goLzwn+lUJEbTuIRQbKApZ3NQMoGeOiGaqEMwookG
	 sEV3RBeT7uhuIPufi6BCW074FrQKPCFa/KBM/uWgpW3eAXy2ZYNROEqxOR8cIdxqB2
	 95yjEP57Ppofbe+skjxT0bYMkBjt5W1FvDOWeE9wpMA9KaTug0T0cGvfFino6k4hS5
	 hBr/4KzMyTH3JpbZf63/6IwRXxzyP2hMXrVdQo2gdjUqpwxJY8c9E5OHut6/5qD2dS
	 ZhbXr6WDezUHCz3Y0MTxYRG4i4ALxkVof/YGLk3M4eZgQP+Upx3MhmYOLxBfpTgvy6
	 801XU3qsxQZWA==
Date: Thu, 15 Oct 2026 10:07:06 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Brad Spengler <spender@grsecurity.net>,
	PaX Team <pageexec@gmail.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
	Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC in netdev_from_priv()
Message-ID: <202610151006.E2F587A60@keescook>
References: <20261015165959.i.798-kees@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015165959.i.798-kees@kernel.org>

geh, for the subject "net" and "net-next" glitch: I've poked my 
subject-building tooling again, this should be for "net", not
"net-next"... 

-- 
Kees Cook

