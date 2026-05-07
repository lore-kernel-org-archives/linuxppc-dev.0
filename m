Return-Path: <linuxppc-dev+bounces-20563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAEDCD343F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 12:50:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBBtM2yvDz2xPb;
	Thu, 07 May 2026 22:50:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778158219;
	cv=none; b=YPRiDuXNWqCKIpKiC31y1mIgH7xJVvVPQh/e+k4x5j4oSrs6oLfKmRMX8s/FX6KmMi6qjoA+MMsZ4KHAvTDDg7hQctsDA7cN/F/SLyoajx6Bn4ngh2HCtmKbARuZRxCqcc8md/QppWwUXIKFQRDLAdeFbVflLQI0Fgsb87h7SiJ3DRZstO4ZqpdjsF8gnkLqZxoxuvluzQzQyAy6mUFGRjOAqXyQ7urSaRpQ+ysqOhXZoO2x3fmL60Xk10zm6YO6EX9PuYsAOasZKm1accfUCDAtMi/dN+gHfIvgO5JepU5CXZI8RWQ3CzAaQhDjw58V/Z6GFz0bKAgDbLrwEYyOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778158219; c=relaxed/relaxed;
	bh=bo1N8BT4nUM3Xf+DFBwKu6u367KAJVgO33uK2o1ktBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbcyV4FlxK9K/0ap2+xjX9m+5kvTecbD2Zu/8LC4IL2VeERaWNRyThtCupsbruroIKf4LMXnyrq8BO5NaKGA+wrBFg6YUzPzFdRkapv6VMHF0kD2bkYmUFi9YGR8RJ9fyb5BcSIIhXws/H4OU1jOJQlEu+s/gJsUdjq8dJoaLCCInu+FjZkVogygEzOApti4PofnbbZfRdi8MvEvqa2b6G1TIpSCBqcrPK7Z3F2zDY6oTYEYApE9KAFhoT7nTPmaC9E1+sWuSR3/fmnwT47XjKFdGne4ECOuasbv9x3jPLPQGPM0G9j972+k8OYcuCEbUWJr1Cib1KbXUELgbwGhgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XWgXThuk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XWgXThuk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBBtL2PQ7z2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 22:50:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 08CC06015B;
	Thu,  7 May 2026 12:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4AAC2BCB2;
	Thu,  7 May 2026 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158214;
	bh=QSh8jThHICXuUVGJgINpqRM8HlLwfBMnkbu7JT3NLMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XWgXThukIABwKYJsWjwsKa6pppZBzUzvOsXejT9LTPb6Vj+KsuunwfkQF62VWNKKb
	 E1Byhvhmx5SgzrehPT92r9oIPopjMfJTi6+JPcRwfIbS5ivLUu2gv03rh8f55xDbNR
	 uavfnBA1TxsKA3de+tWcY69nD+P089C/0JaCNE77eZLxf02MPy6euk8Axv19Su2aPe
	 IpIW/Xa4mjdoeVEvWTFOLFp9fFj74MOGEQB3lCLmJABJZ3GNUuEGyd+XJKp1uyrpKN
	 kVHNtsFBll8nzgfOilmjznQj6TUbad6WKdlDch4vPtwQUHWU0hQNjpPW+MsyKsGBDj
	 a3n74uKsIi5kw==
Message-ID: <342c49e7-fdcc-43c1-a11e-b52d626730ef@kernel.org>
Date: Thu, 7 May 2026 22:50:09 +1000
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] powerpc/g5: Enable all windfarms by default
To: Linus Walleij <linusw@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
 <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>
 <CAD++jLmBn4moNJKp8TLmMvdmSVaT4qnY10OuBMEQmaZnO8D1JQ@mail.gmail.com>
Content-Language: en-US
From: Michael Ellerman <mpe@kernel.org>
In-Reply-To: <CAD++jLmBn4moNJKp8TLmMvdmSVaT4qnY10OuBMEQmaZnO8D1JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/5/2026 03:30, Linus Walleij wrote:
> On Wed, May 6, 2026 at 1:41 PM Michael Ellerman <mpe@kernel.org> wrote:
> 
>> I don't have any G5s anymore, but the ones I did have used the other
>> windfarm drivers so I never hit this.
>>
>> You might be the last person on earth booting Linux on those :)
> 
> Not really, Sean (Action Retro) did this thing and follow-ups on
> YouTube:
> https://www.youtube.com/watch?v=g-Ugfqj1ank
> 
> Including installing a contemporary graphics card:
> https://www.youtube.com/watch?v=WPDd1Y0flSg

Nice.

But the driver you enabled, PM72, is for PowerMac7,2, which is 2-3 years 
older, and does not have PCI-E.
So if you have one of those it's even more special.

 > This likely means he inspired a whole bunch of geeks to
 > go and do the same. :)

Hopefully one of them volunteers to be powermac maintainer ;)

cheers

