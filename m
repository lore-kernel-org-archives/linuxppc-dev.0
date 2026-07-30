Return-Path: <linuxppc-dev+bounces-25078-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A30CC54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 07:01:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9g8x2vb6z2xnp;
	Thu, 30 Jul 2026 17:01:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785394881;
	cv=none; b=NY1HQT80MzbcsnAfZAgEl7qK6BkXCDGIsqoJs83lJOXVEnq9IixT6cWRhblUWKovXlxVjyKO50koHtpINsFixaXxKGuv+E3EatvwlZGG60GxNKhEYQqTNaWUC57lWfyO6U3AvXnWJBTwkX7mp2BF30a+tnT5C+VbCq6IeoK76zqOqwdwNp7c/19uJyGmRtCnHJG8e5rRAn0pBq7u2w8ltSMg8dOzQ9DT946I0msppZEm7YgyLNgekah96JsMxWEfIOWtVT/pePbCo9E51+lmpkp9JO/fVQw3qwP5XarbEUnjzgoNVvSD/8wtDQ/kOhpJ67bJphihTXvcohRtRjL9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785394881; c=relaxed/relaxed;
	bh=lJzDcSa/Jz3k1AoOMXf/kp3xH6eQcq1mA+xDjqL2CuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtjsQKKFtb4lB1VHgkr5PLufd99AEuN3ZaFRggyKW9DGs6cHp5UOrDgRxwWWAMxNPGxLyVm1O4VFv0UvUtoB0EH9ZNEWCahfaMb7Fsw24VKGzfOFoHsuVhJjkJnQ4w8R2oeQyhOUlP3m76+uN8TCIGWwrggksXndfWf3yyTbs3vY8jiha2hciWF2NzbsGBcnYHJanES95EASLQcLDron6emQ/SSGMQnJd6j1arIKjCqByOnELE1MmnOsDfvgBIpqZTrQGzpQHEYurXyNJZaDS/Br3CLOYw6Ku8CtMIIWBr+PdEIcO3apaBKk2Ythy6miSepZXtdNMPeEaU1so8s/ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfV7cRIl; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfV7cRIl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9g8w1nmVz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 17:01:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 894AF4353C;
	Thu, 30 Jul 2026 07:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A181F000E9;
	Thu, 30 Jul 2026 07:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785394875;
	bh=lJzDcSa/Jz3k1AoOMXf/kp3xH6eQcq1mA+xDjqL2CuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AfV7cRIlGBEzJOmEgm5UqvFvgiVUFLFybVODk4nk6sqhhlGt903bj/OLsr9htBV4a
	 kZRVSgp8wGvqvTh+a7dmmJ4KORfBwRf3qSN/LvbXENe6BE843E1EtmInMOKqoy+66Y
	 6EP9KDc1TLGUZnCXNw5bJI9+NAD6bzqDXPLKmy3uPhDx0FVFRh9rcsZU70fektfRX1
	 JoUdMf9iq2DiHhJw0ABaA/6mJcAHuo8Apml2s+9P6nHtraRMT4nkvVda+KuY+MxALk
	 UpM2KNLOjxzmOX0uJLtzgT4R79qQk4HRXDsq7F7cv8dZUQU7cBwFBE27wjv432Ui1X
	 3WfDT2OdCa6Bw==
Message-ID: <3c39b0e5-8265-4d39-ab39-196ccf560a05@kernel.org>
Date: Thu, 30 Jul 2026 09:01:10 +0200
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
Subject: Re: [PATCH v2 0/2] powerpc/sstep: Fix compilation on 32-bit PowerPC
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 techflashYT <officialTechflashYT@gmail.com>, Ash Logan <ash@heyquark.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260730065007.964703-1-linkmauve@linkmauve.fr>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260730065007.964703-1-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 08:50, Link Mauve a écrit :
> Two local variables were only set but never read on 32-bit PowerPC,
> which causes an error during compilation with W=1.
> 
> This series first makes the 64-bit guards consistent by converting all
> uses of __powerpc64__ to use CONFIG_PPC64 instead, and then guard the
> two variables rc and suffix behind CONFIG_PPC64 checks.
> 

For the two patches,

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> Link Mauve (2):
>    powerpc/sstep: Consistently use one define to check arch bit width
>    powerpc/sstep: Don’t define variables we won’t be using
> 
>   arch/powerpc/lib/sstep.c | 111 ++++++++++++++++++++-------------------
>   1 file changed, 58 insertions(+), 53 deletions(-)
> 
> Changes since v1:
> - Link to v1:
>    https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinuxppc-dev%2Famrpdv0g__ELifId%40desktop%2FT%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C69210bfbc364426c4ce108deee06d0f2%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639209910199709261%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2B%2BdoT%2FTkFxUUy63ED%2B5Kb5dfCSI8hQpjWGfpndI%2Fn0c%3D&reserved=0
> - Switch from __powerpc64__ to CONFIG_PPC64, as it is the preferred
>    check.
> - Document that the build error was only occurring with W=1.
> - Declare both variables on the same line.
> 
> base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853


