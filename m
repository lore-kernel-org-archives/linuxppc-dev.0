Return-Path: <linuxppc-dev+bounces-5752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC89C0218F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jan 2025 16:35:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yl1hN0cFKz30MM;
	Sat,  1 Feb 2025 03:35:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738341300;
	cv=none; b=nVqNwFAwUi1a1qwYweBVcwe2yWXCwwS9ENBZeDp7xHfWpQ6VkWiB4YX/6afkEG4sUQWVYq9J/sH6gjd/nThaNKg8wO34x66JNfle56o6Ay6JoWP8gk4Y3nwGM/7gffMfavqn2veD4vvkHfz9KWkytPy9C2Q7ukEpR59E0auHBQrSE27rUnNii2UGRNc8RO7drXPJ3NooICj3rKmx2jXtjn+sPscjGzY1fzkeHY2hBJtiy64fMlPSCGWvbT+OoXbuRawAXwA5h+8Ly+jayGpIpfBr3Osterjz4O52ja7oE1+bjv3GnuNKgFCMvdiCMaUWqKzmAnFpP+CWQeD8ahZ8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738341300; c=relaxed/relaxed;
	bh=816S/FJrSvf37obKqMeFwdjSIuY9jvurU953DQSNjOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP9v5+KH/KpKTfy9YP+BJesTTSuEgvyNDkWGrao8RSA5DuhbnAmE3aw4CQzhtPvaeDJUoL5Fiz2C9hrZeD6+rBubNnEgbJywLJ1RU+Czt4cXONuMFPr9Wq1JDRfG6qaN57KEFsiIShYH1C1DvxRy8FmYSQ1CYrx2zQ2mSm+eKdlBbSg5RVujq/+ngsREf0O76Vt+i9SI8LYLul7SCbiGs7MXnlTkpbpFRyj83PoIdaN621R/ilBsk637Y6n8P66MiOJJh/UCj3UD6VJpya8kPZlwn3ZC7D6dkqOEVQN8v5eiNa0xUcRvBkqRQkAmoY99r/v+v/i58NhvKA+nV68RHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yl1hL6r9wz2yMh
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2025 03:34:58 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 50VGWuF8026990;
	Fri, 31 Jan 2025 10:32:56 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 50VGWtgH026987;
	Fri, 31 Jan 2025 10:32:55 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 31 Jan 2025 10:32:55 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] powerpc/microwatt: Define an idle power-save function
Message-ID: <20250131163255.GA20626@gate.crashing.org>
References: <Z5lfDb8wsLlmSLBZ@thinks.paulus.ozlabs.org> <Z5lfyDQbGjxYT_eF@thinks.paulus.ozlabs.org> <D7EBXLB9JMZU.2T4WD5BP9C1GD@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7EBXLB9JMZU.2T4WD5BP9C1GD@gmail.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Jan 29, 2025 at 04:06:03PM +1000, Nicholas Piggin wrote:
> Does wait cause MSR[EE] to be set? If not, do you need to use
> prep_irq_for_idle_irqsoff() here maybe?

Assuming this does implement the standard ISA 2.03 wait instruction
(and it better), this does not do anything other than to stop fetching
and execution until some later event happens.

What values of the WC field does uwatt implement?


Segher

