Return-Path: <linuxppc-dev+bounces-12381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DB7CAC59A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:19:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSLSr10spz3cYH;
	Fri, 19 Sep 2025 02:19:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758212396;
	cv=none; b=XU57FWHDqkiq3zE/rEAEICNuuyNRNBvxYVLn5wk4o+QDfkqM7IB1EckdFSBrGTp46tSKxOkjNeUMaZ8fkFtwnncN8LvoExfT8yt7Qq/u2UXugpMY3se3Ne7imkgKb4RTFieAtbKvUmDBVWyGLnBfzaP4yY5nqA6X/GRDLLoqTNhpq2IgyCuMuPP2LbtN6tz6pqrM/uVaO3YzM4zFPAvUpX7j1aCi9oSUy1ZRZv1JYtZMz0CIBUXiP3SKu28ATGqWCbmdUEozcBpkZhOzqQLqeSk2mzykIiXN8ccRiqmLOTT9r4DHIZm+ceLZgjGOQEiGuJW+5w3w8p4atWpfV7VAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758212396; c=relaxed/relaxed;
	bh=R3YaFvsq3uINRfCCbs56G3wnP3CeYGsUAqcZG7qAxLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtJPmLPM4hA89oEascg10UAUq6PHrwcjsF4HqYBNYsUSC4XIJSq64m/0y6tZ1N3qDOaUUF5xrnxSnIQtmMA82R6uEkxv7H32QedZD2DA1Ubl3ENOZcP/Fdf07iR2qbxqp42G1yscWwETv4zxoCys+Y/zZ/vfA9FYGYJ2AXgSmPYEJRlI9VpJYz9C9u+mgLJAJ65sP2iuD3oWLh1YfW2nQWMwTY2VryWHkHre7rx506HF6bUWrAnK2QLFWhehydqlBiBbWPySNfV4mk3IAy3YjSgZmPw2lqLDYiARX9NLtOa029kkbpk2lTUbPjVpCxHJGlySl4JHPyczgoCgkVGMYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Fn1dEJE1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Fn1dEJE1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSLSq5H7Lz2xnr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2025 02:19:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 33BC4419E6;
	Thu, 18 Sep 2025 16:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2715C4CEE7;
	Thu, 18 Sep 2025 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758212394;
	bh=BCl2Y81AvA63jtmwL4iwpUPio3B452TBnre79Y6BoTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn1dEJE1JXTiwUKpTUUDSOQ9cLWQEMbfnAfw1Z221Kp7lCtdum+nRYvnidhioJr5O
	 gPVncUauhmrPocCTfMl3c27/ConvtU8IhmMULYvv0ZS4zqeEsmWGBQRrSoApX0mWtv
	 ksSv/bTMUwZn6XXdiZaXiNFTo/ZQCno3FJtp3NxY=
Date: Thu, 18 Sep 2025 18:19:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] powerpc: pseries: making bus_type structures const
Message-ID: <2025091845-subtract-friction-37d2@gregkh>
References: <20250918140816.335916-1-abarnas@google.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918140816.335916-1-abarnas@google.com>

On Thu, Sep 18, 2025 at 02:08:14PM +0000, Adrian Barnaś wrote:
> Current driver core properly handle constant bus_type structures.
> Both changes are moving bus_type structures to be constant.
> It is a part of tree clean-up from non const bus_type structures
> 
> Adrian Barnaś (2):
>   powerpc: pseries: make suspend_subsys const
>   powerpc: pseries: make cmm_subsys const
> 
>  arch/powerpc/platforms/pseries/cmm.c     | 2 +-
>  arch/powerpc/platforms/pseries/suspend.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


