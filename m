Return-Path: <linuxppc-dev+bounces-25065-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF12C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:51:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dch4zKWz2ygJ;
	Thu, 30 Jul 2026 15:51:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390708;
	cv=none; b=aKEQ+x2o50e0xNreIs/3jLRvBj6Yve9j+s8g+Q5txPDuVnD5xQc/OLghEVuF515jGkbo84ivePIytP9QGkNow3gBb6/sebBdq65hP2kh4k2IX3YvunR1oXEn7fDjJXjR8e65FFY+qRl51IKqA9HBDDi72wuleDqAKjvVnTrSLuLjUfwZJ97ik5XERDNGSOU0KMB8ZciuEONWC6f60scaGFInxyZa+Q0SglDN37vBMf0+2S5YgOOjdKbcX2c/jtmIT6ew210prmamYbufvM8oKyNWZHV3QDCYXGvp1eKUGUMEMXi2UZcwtvMMdc2oqWVIZoGna343vWLEWnX+Om6jKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390708; c=relaxed/relaxed;
	bh=UjUSchQg0I+CuqUd4I911yWy9DuxGtFCha3UjK9DHFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNOsh+YO3NL0hxxjQh1M26JaY9lOiWxMCryFb69iUWiDrf8PkKAUR/zZ63UIMr+jAkYlzd4CdKyhYA5aJ0v6hGWZV+J/ErHBxSMuCj9ii6Tp1wleVZuOZlZDdLtjfYwTlziyzwG//wIOWKykMT7JMI4Tzwj5Y+A2lKEuvtTnLMiXQk2izhtT85W5AJTKY8XDTjRNKedQ7ms9EdwNdsQB61fe2zYQlULFJmTfw3gwxTpkHWpNpm3inXdAn7Vbyaeh5bCeSpAmChl7MF75W/Xq4xCgarql/HahwfQWoqOTWzpt+uIgvaGtgHKongt742SSDNJqGbKCnClb/OTw8HyrBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiHzUuQr; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiHzUuQr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dch0cTJz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:51:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AD78E600AB;
	Thu, 30 Jul 2026 05:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7161F000E9;
	Thu, 30 Jul 2026 05:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785390705;
	bh=UjUSchQg0I+CuqUd4I911yWy9DuxGtFCha3UjK9DHFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YiHzUuQrueagfhMNqF7i9zvPcMaQ/ylXYV7RTPxwlegqZl2/mAgOenL2iR6qPqJ9i
	 cQmj3zdD27PeDddkzfww1LEJM2yx9Ygo1kMBuAE5jHNE1VKfmIPbd6cqrh22sOOlzr
	 Hww0f9vNnw3RZ4qE0z0LfPFdwreiB9bEWr0pwJgGS65NnPUhoEyGC1/Ww4jwh283pC
	 1XlXsl4+pigI967z0JGiuiyuJF33ysXDu2HFMgHFNOxsMqckUNviE9t+8CskGTVUUD
	 2ewMQGHXeDu9P68/Fuxo325kbT2SN5YOe1w9HqdYzuG7oN3CJej4qcT0HL0cHja3P8
	 P4rnbvn4+hUzg==
Message-ID: <5c140099-4448-4091-979a-6f6fe7d92ce8@kernel.org>
Date: Thu, 30 Jul 2026 07:51:40 +0200
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
Subject: Re: [PATCH 0/2] powerpc/sstep: Fix compilation on 32-bit PowerPC
To: Link Mauve <linkmauve@linkmauve.fr>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 techflashYT <officialTechflashYT@gmail.com>, Ash Logan <ash@heyquark.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20260729204958.755143-1-linkmauve@linkmauve.fr>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260729204958.755143-1-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2026 à 22:49, Link Mauve a écrit :
> Two local variables were only set but never read on 32-bit PowerPC,
> which causes an error during compilation.

Are those errors new ? This series and the one from yesterday on ppc64, 
I have the feeling that the code is not new. Has anything changed in the 
building flags or does this pops up with recent versions of GCC ? If it 
is the case it is worth saying it in the commit messages in order to 
clarify the reason for the fix.

> 
> This series first makes the 64-bit guards consistent by converting all
> uses of CONFIG_PPC64 to use __powerpc64__ instead, and then guard the
> two variables rc and suffix behind __powerpc64__ checks.
> 
> Link Mauve (2):
>    powerpc/sstep: Consistently use one define to check arch bit width
>    powerpc/sstep: Don’t define variables we won’t be using
> 
>   arch/powerpc/lib/sstep.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853


