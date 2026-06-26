Return-Path: <linuxppc-dev+bounces-23025-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7A8C43327
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 14:30:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmykq22bTz2yYf;
	Sat, 27 Jun 2026 00:30:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782484227;
	cv=none; b=PNnN3YK2PxQ5/uYcLZjmEARP5MApdrYOeAT6WFP40Nlvrj2HdqLtxXJtJCKu209HLj/MkadCIV+XPgH3qBOo6UcQFt9J6bd+KXWrjXzLc9wbOZBZywoZyBtdrg54o/4V3ygexjSlZtoXD/TvJIfc1hS2nkAkRXy9GY95/uN4MH//HyxtV73EQ8l9XU9q9VYoh/PtS0/I0S7WgN5JJZzxX3CoDwRi4TmcobKMersNmL/dJ1+OJSl+v1vnf6At5rftdeSHF0SteOAGPo4jZ6zrHkLVzNisNF++yJPOgNubULJlT5xxYl1bV+nNA6DoirR3Xx0Ahg1oq7FhWSGAySt/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782484227; c=relaxed/relaxed;
	bh=dHg8zD+A9+9MkpkQA473g/bgyHlKu3rVom5SaUpwIp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLIAr/yzLOUYXKW4aAKrDFfVjKoIvwhZ1gz+ti+bVzBdqIv7KBxV3aLTMpBFHMk3U92g2Ysavw1WwC6BTJPCTgBRlQkmY1O0JAUBGYhM7w720oXaBMVarsPDZ2aJcg2Mrtz3J1TnHc5myRrMD5ziONp6CDlabVO9DGG2YBC+gRyswxv7kGVHDgxQEK9KiO4e32Bc94aWrV7E4X8yd9TnqAlMZtluytmru0/HEtWIF+fEc0sADuX5jimclQxbhR7UTGu/3gwhVgt2h580OhMlKqxS8VEgI/nMhlP1ubG1nqImSrnx+xemQie5wRePAgL3x1fE8WVu1GqmL9n9vRFFMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdOmdrGl; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdOmdrGl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmykp1S7gz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 00:30:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4355A600D9;
	Fri, 26 Jun 2026 14:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E461F000E9;
	Fri, 26 Jun 2026 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782484223;
	bh=dHg8zD+A9+9MkpkQA473g/bgyHlKu3rVom5SaUpwIp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AdOmdrGl00v9I1bMVIkf91PFY5tCMMGI3X8nUlpN+w8ipS0L+hyVOVkII84Ozgvqc
	 MBP24nCQR5VOD5sRtsiIp8TTAQXDwvQhlz3otkP7t5gpyDssPe6D1+BbcvBux1KsVy
	 hSRAbWMF4EigC7eSL6gZrhbzNsjtzbQH20eX167wWSyLJNlJ8akS2w9MbTgiUdiHoW
	 1FLBnLfGnoMzEHZdBG7zD43Tk5HozeT4G8VJlYuTbCba1T9jH8dacam9Z10pF8DJXW
	 jUxKPga0lG2+wB8IEB6+fiG1f96JwJr25dOPg/8G09yoaEFQX0tWKnhL2ZQHvxqLx5
	 Q3COR1un4sziA==
Message-ID: <09223f23-b4e6-4ba6-bafb-3969e2710c61@kernel.org>
Date: Fri, 26 Jun 2026 16:30:17 +0200
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
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
To: Kees Cook <kees@kernel.org>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 sshegde@linux.ibm.com, mkchauras@linux.ibm.com, mark.rutland@arm.com,
 ryan.roberts@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>
References: <20260624171520.772408-1-mkchauras@gmail.com>
 <202606260050.681FAA94E@keescook>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <202606260050.681FAA94E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/06/2026 à 09:50, Kees Cook a écrit :
> On Wed, Jun 24, 2026 at 10:45:20PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
>> After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
>> SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
>> (Function not implemented) instead of the expected EPERM (Operation
>> not permitted).
> 
> Was this noticed by the seccomp_bpf kselftest? (If not, I'd love a
> regression test added for this case...)
> 

Was reported here:

https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/

