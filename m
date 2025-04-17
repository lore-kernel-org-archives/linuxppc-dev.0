Return-Path: <linuxppc-dev+bounces-7743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B520BC369B2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Apr 2025 13:10:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZddYf2JmTz3brT;
	Thu, 17 Apr 2025 23:10:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744895446;
	cv=none; b=ZewGwTnP24spMqHiM2xpHRyfhSFIeERBY+7aKI3n9+VfStJ2xxzmPwgob1yAVk2oLzAaNMV+HWy6XiU1igeDXgSgtUj646Zs0Wy5ucNCTX+n+DfMrI9gtM2Lw4wcya5KWB23KhJuWPuda+R1nXsPXUdXB5GCcwJj2Kf2YU41yhX2NuKkkVZhtE/RFHDLNJnoUBZ8XPXwm+H+MlhdJS+Ei1Tcfczna6JijFdjfJSO9N5ynY9KohGZAls0DzZzlP7aJzBNQ7CUgF9AS5HQvEMGewhoelZVO6SEeWDD2Fatf4nmkbU16Y50eYDHsPj7M/hkDm9MZJgRb/IrIBN9CVqA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744895446; c=relaxed/relaxed;
	bh=a49fxGq1XoHyE2U3x1UJ5ixWz+1/3CcS+lXQ+ObVx0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZxMNgZOC023YNbOe7pEEJC7nV3uiR8jHw3cS+zE2z04B8LHfnU6KXUBnMJRHI/mFbVDrrP9wBpCydlR4isDiOlkCLSuYZltt0maE07n3PBQjGNlsfqIevm9j94390m/k8TfAimHNbvqbgBY1izvgrcNuztL22ZMV6F8gsN1GKs4q+b8ejbTuHUtfl9ja12rZLT5R5oDySXdr3OVfwU7pmo+28qokn4EBUUmrxWSeFXAkyNAETTBLN6yC8gEODxYHkP0q3OgaXw5LQc6WQIKwqoH2c+C6DcAKki6s1uhjKjzCtO39phXO/0DFfKsQUMuRZvkzcTw9TwFST5FEdq09A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jQVhPpVg; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jQVhPpVg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZddYd50W5z30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2025 23:10:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2EEA668436;
	Thu, 17 Apr 2025 13:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16539C4CEE4;
	Thu, 17 Apr 2025 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895441;
	bh=UX5aCpiFPWHDn5y5lBqZg3C21rUMdQGu9cwtYACqRIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQVhPpVgwjufYHxGJpES7G6EpaKPVUoh06ZvwZmLlTYAC+vceHN+5dH1EA5pdas5d
	 47tCETUmeOH9XJMp1YCNKlYdN6LZpIkEngGIzw99nIjo0KAwxLZ59LGxlJcihXoNcR
	 AafOC2sU9MAE0Dhsf41hhdjLI3D5xrmORZyfVZTmybLfZ8TUUiLybwJ3Yw71W/MP22
	 tMHTB3P1vubgOdPMt3PgvOzq+ia+xfWJQ3gIBGP2svj0kP+iq7FeCTjxXnJ+viR5fT
	 JT7/n5/p0gCbfMOQQ+NtM5m9n3rxdnwPODhXv/zB6LL9lkUwFKycInnA8q5pivCllq
	 tYdpSPxfWrioQ==
Date: Thu, 17 Apr 2025 15:10:37 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	linuxppc-dev@lists.ozlabs.org, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] i2c: pasemi: Log bus reset causes
Message-ID: <yxzzpnf2eprgaoaghuptj2izxyuu3rzdldm6emsob7asrsxbrk@kzrlellx3qim>
References: <20250415-pasemi-fixes-v2-0-c543bf53151a@svenpeter.dev>
 <20250415-pasemi-fixes-v2-6-c543bf53151a@svenpeter.dev>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-pasemi-fixes-v2-6-c543bf53151a@svenpeter.dev>

Hi Sven,

...

>  static int pasemi_smb_clear(struct pasemi_smbus *smbus)
>  {
> -	unsigned int status;
> +	unsigned int status, xfstatus;

Let's declare the variables in the innermost scope where they are
used.

Andi

>  	int ret;
>  
>  	/* First wait for the bus to go idle */
> @@ -98,7 +99,9 @@ static int pasemi_smb_clear(struct pasemi_smbus *smbus)
>  				 USEC_PER_MSEC, USEC_PER_MSEC * TRANSFER_TIMEOUT_MS);
>  
>  	if (ret < 0) {
> -		dev_err(smbus->dev, "Bus is still stuck (status 0x%08x)\n", status);
> +		xfstatus = reg_read(smbus, REG_XFSTA);
> +		dev_err(smbus->dev, "Bus is still stuck (status 0x%08x xfstatus 0x%08x)\n",
> +			 status, xfstatus);
>  		return -EIO;
>  	}
>  
> 
> -- 
> 2.34.1
> 

