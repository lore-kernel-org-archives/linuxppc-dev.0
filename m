Return-Path: <linuxppc-dev+bounces-25259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615BEC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 12:15:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDFxX7567z3bpH;
	Mon, 03 Aug 2026 22:15:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785759328;
	cv=none; b=U/BMgZyWJitYGOV15oQ7cDmbbP982qEqyDIax2nb/aWJ+dzXNKAXZj89vIkclme45xaC7CVjG9prKBqH6eQ8OnFkzgLYQI2x8f6Ab/hX4TEqluIcjTs9LIZsOkahsBhRcY6YLrhXft/RJVWRqzAImcgxbNNvcU/1OlENTBT/FdeKFbTzXCjgisuGUfE276Yp/jOr5h510Oc/8GE5/Ae3Ive27aNJnU7caFCCSxyvurwh6J3s4+xB4XzcUL9g+f/C1UYj1ERPJbWUkbZZWvpqBLoDHG5+hOu8IU0xRUZ8g4ywIRci7S9WqSe1RdUzWKCDPR5PR39MeTegzABxcF4RBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785759328; c=relaxed/relaxed;
	bh=hEHMyINoI4O0CExzLk+V5x0PUReFfT6DbYvfpS+vJPo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VolNFH/wxzwJ6GiAYvTs4WR6l2Lyd3qnizZMttlcTjqPvibwTrklomShL4zMS19QnaQkmW7OIGibpTfjnWwsYXnidyPeU5tobhrggGytCXmmrze7CA69SdnOvs0yP4KKU0tAVRnzuKizR63UAdjP7jsWyCBmtCb2/dzhdBnW3N1pm1RAKGdeTUx4hn5j751CSTxvqvv4Xz3pPxhR159+vKqLFEZl3VZCwjqksItAX38KwVlf6wr7qZ1VPWHyFGVGTnxYaW0327yUcfIi1BhuF1qnDwWBEf4AC8DBBm1ZN34X9sT7lMQBy3aP3WEVNacwY6WbZZznrrGy9z1SlBbJYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Az+DCFjY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jikos@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Az+DCFjY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jikos@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDFxX35Xqz3bp7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 22:15:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EA8CD434D4;
	Mon,  3 Aug 2026 12:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8A41F00A3E;
	Mon,  3 Aug 2026 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785759325;
	bh=hEHMyINoI4O0CExzLk+V5x0PUReFfT6DbYvfpS+vJPo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Az+DCFjYcQ11T9PWCYkn5M7ebpriU/O+orU74FKowP5kdJYlLNtHXgPyJUdNzfiSf
	 pL0Z953SA2CyKtxxqSZJQ+as0muqNwRPHAGMXn4GOuN5UgiPA7rNAaUdX3YaXn6gU5
	 MDXYYB25p8+uMX4FFJTi2AqMVMtdi8rXGKixxRnHWwjosrDeoJiri2fEGX54ni4lV0
	 QmVJ60k+h6B41UXCdELcn/Ia1kDMi0CBSC6gZOD3YW5sk809E0b5kf1NvY9hBvLh0e
	 d7zA2G9q8VJc+yBhnmDOFYcFZOh+gTLkN3gq2s9smaOfkB6mOkfAyl3zUEKE6Jiu8X
	 ZXVfFP4uDyssg==
Date: Mon, 3 Aug 2026 14:15:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: David Sterba <dsterba@suse.cz>
cc: Qingfang Deng <qingfang.deng@linux.dev>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Andrew Lunn <andrew@lunn.ch>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Eric Biggers <ebiggers@kernel.org>, 
    Mingyu Wang <25181214217@stu.xidian.edu.cn>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Kees Cook <kees@kernel.org>, 
    linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: remove the ipwireless driver
In-Reply-To: <20260803121409.GA867448@suse.cz>
Message-ID: <1q088894-5178-s9r6-s515-9qn12ronp460@xreary.bet>
References: <20260803091938.259944-1-qingfang.deng@linux.dev> <20260803121409.GA867448@suse.cz>
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

On Mon, 3 Aug 2026, David Sterba wrote:

> > Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> Acked-by: David Sterba <dsterba@suse.com>

FWIW

	Acked-by: Jiri Kosina <jkosina@suse.com>

Thanks,

-- 
Jiri Kosina
SUSE Labs


