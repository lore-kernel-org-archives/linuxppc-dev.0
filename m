Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED367606A33E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7vsuyjR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRVjv5221z30Sx;
	Sat, 14 Nov 2026 21:29:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794652179;
	cv=none; b=RJH8uPbgReVcgN3aPwUP2UGk2qKy7hX+8R8CsdQYXUdqF7gTa7ay/lPStua79yClLkdi+UqctQGboAF/TMDwMLq72W57AyAzv/9E3pp2yUDhbmmRh0H41HoC1DWJlTyBv2VJeI17KTEgzPjBLHPA01+ZkDkAOBRuB1q+p39hnkNF6CvUbvDhIvb6VP713fnrL9LuU13yGnSRrCLP64Lt/lqjsIymOX34oVN0mbRpa6RZtrsZqJCB+9lZJ8EuXK5d/y+/fofIQZHGh+5Wp9H4ADDHiOSeR60jwlP7cB3YbxP6yvVBm5lQciEhALLHarZ9LTr1wfOUhybTGMQjejC/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794652179; c=relaxed/relaxed;
	bh=uErNLi/2OCf74YqDJoADHzHPm15XqcJZ+OFir4+WK/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMYmx/hHfYFtB27D96etJBrzCkypyVt9CDjecGky7kWstnxI8eegSCxUaDjFh4uzW3TeL017c1Tuqt0cuxY6Tis8A7kYKsEg7CH+J8B7hbYWcpPuHxCmYcsrBzQ9TpdtTSzqErmNpmKaZCsPw5ILmoC2p1YCCL+useWk/9f+52TCsVJr0B9Jwh0H5e1UErP6oPc/wM5sni91rrrJ2eCGJW8XfuRF7ZoB/uN+t37s+W3/ntbuz755LuBRVxMfRSksDqLyanyYOX/W68zlemGFIWWKPMNNwEibN1FGfFqlINvuTFzPJEGlrMxRPRK3vm/xDkJyAAS27uXwssErWuMeaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7vsuyjR; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7vsuyjR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRVjv1D81z30Pp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 21:29:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E6442407F9;
	Sat, 14 Nov 2026 10:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088281F000C5;
	Sat, 14 Nov 2026 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794652176;
	bh=uErNLi/2OCf74YqDJoADHzHPm15XqcJZ+OFir4+WK/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d7vsuyjR1VDuLpCZaVnAcs97CnN378lybAxntYArVAIWpBO/G0QY4MowNay3RH1sJ
	 I/+m4hpMxB6GpMKWDbzb8qtrLlBu3YtDeZvzwuhnMB/yA78hJusU853lj73XvqfQKc
	 EvGzykvrbS4lq/1O6DTLRc08TU7xDNFp/dLuKD+MFITdLvet4hGZDl9JAlBCEPF0xx
	 ij3wqSqFhhR6i0TtGjKrrnP3Z3PpGxrdb9mdx3i2B+5EYxPu0H1yqZC4/aKDGWNr5j
	 ij+bUDu6z74RwEA9jfNDdUvkLcIIa5ya1qlqC26lt0K0Us0aKw8Yg+9nBBNq8D2ZIO
	 OPqicXdnFAsTg==
Message-ID: <ea4068bc-be71-4487-b286-68f0ba9f4334@kernel.org>
Date: Sat, 14 Nov 2026 11:29:29 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/configs: drop CONFIG_INPUT_CM109 from
 ppc6xx_defconfig
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "Alfred E . Heggestad" <aeh@db.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Oliver Neukum <oneukum@suse.com>, Thomas Reitmayr <treitmayr@devbase.at>,
 Shaun Jackman <sjackman@gmail.com>,
 Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
 Florian Euchner <florian.euchner@gmail.com>, Johan Hovold
 <johan@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Xue Lei <Xue.Lei@windriver.com>, linux-input@vger.kernel.org,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
 <20261112001642.243554-2-dmitry.torokhov@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261112001642.243554-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 12/11/2026 à 01:16, Dmitry Torokhov a écrit :
> The cm109 driver is obsolete and being removed. Drop its module
> selection from ppc6xx_defconfig.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/configs/ppc6xx_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index 29acc77573d6..4ba35b9377d7 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -537,7 +537,6 @@ CONFIG_INPUT_PCSPKR=m
>   CONFIG_INPUT_ATI_REMOTE2=m
>   CONFIG_INPUT_KEYSPAN_REMOTE=m
>   CONFIG_INPUT_POWERMATE=m
> -CONFIG_INPUT_CM109=m
>   CONFIG_INPUT_UINPUT=m
>   CONFIG_SERIO_RAW=m
>   CONFIG_GAMEPORT_NS558=m


