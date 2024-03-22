Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496B1C54E58
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2024 02:12:46 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uJhgH++Q;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V15Sr3k9gz3vYh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2024 13:12:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uJhgH++Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V15RZ2fBzz3dWj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2024 13:11:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2D6CECE16C9;
	Fri, 22 Mar 2024 02:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349B1C433C7;
	Fri, 22 Mar 2024 02:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711073495;
	bh=hTimIg/uJvJvo33vzYiVEAj++VGGp4ijV/ldwZKy7lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJhgH++QCxZilOdvUxNAsQcun1SHsliSNVVl22bCa7Iw7BcByjzNZOSK1ZpNjvNzZ
	 x3/bxo4bT3nmMQ24kLMyCEbtCalw/C3MazKim4o67bMXeEunUHiDV83WPfj21Vs09N
	 fbdoXAve+4lHld/d9Xb8l8u43aBvXs8zNZbxzsAqZ6yrydFLmkOD5gkN6b70PkJj4t
	 qR3DnuxBk1r4OqUY4mDx2AAaK5TT9SWnzTf1W7zh8S8cQIJjy8iyevsjEYArXaJK8o
	 1G/cjOY8CNW+yEiKznZqRESnUbLVHLYwJTyEHzpKPiFazPRNQoDyXqi3b1rv/hlF16
	 EqenATDQjlMUQ==
Date: Thu, 21 Mar 2024 21:11:33 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: hwmon: pwm-fan: drop text file
Message-ID: <171107349078.3413056.7212721308899572705.robh@kernel.org>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
 <20240321-hwmon_dtschema-v1-3-96c3810c3930@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-hwmon_dtschema-v1-3-96c3810c3930@gmail.com>
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
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On Thu, 21 Mar 2024 19:43:44 +0100, Javier Carrasco wrote:
> This binding was converted to dtschema a year ago.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

