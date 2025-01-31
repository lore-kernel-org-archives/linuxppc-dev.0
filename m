Return-Path: <linuxppc-dev+bounces-5755-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E52C02190
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jan 2025 16:57:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yl2Bh5lytz30TY;
	Sat,  1 Feb 2025 03:57:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738342668;
	cv=none; b=AplKxA3hJWzAV/S9IvjKlg7MtLVJcK+T9+j8Q9V2SvHI6GjQmpdG28zedzODzHGgeQ6IQLh6drH0nMRfcitM4mYHHChiAxNzvsTBJhqG0eajKyIMjN7/PJTbs4OceJiu5S7HH48dn//8T8G8e46Fth1tIVvlZeO65ewgYQZbfZyQz2U7lXl/taeXp3zdE7ZgjY+9Hmom73ieRUTeSkYGK0KogVQn/brhxdz+bUpqSwD13TR9HOPTMF5eyXFFJCpWXG+2d0Nb5sOkJxEWFZepc8dS+IUzVh5HP3YSuABGZg1rTK3aJJuZEAwYQ7hLlGlannyFya5zIInZoCqFTGRVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738342668; c=relaxed/relaxed;
	bh=zjL3jJGz3GiKtjqY4wyYc5Oa16HgODs7G/M3oJmFWa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxrQSWwAMNkB/EDXczCfjkhP3TX4qLlW1tQVijbns8tNnZMT1UcR/wMq+VMWJ8UmP39aRYyjTzKjqr+0+4W5yxdVNcLnaVLMQuJtJOatu9KCI6Q6F811294dHz9kwjArkPqhl3B12t084AIP3bbDfoePdXGG/8brdYwnmVeyqi5F+AvzFr2PNXODUJml7xVHnrpSmACkfvcM4J8VX/mxF2A1SUoXaqHTUhSXSewXzRYxUbFQ95Sft4A+MWqb1AgKsR3Khks6e7s5l6fdiOiPKqYqltWMed+ZTjbUE1ZlkGzSbc5U3bH8VMB1ydeezhtTOoN4WIqgZdGy7MmhvG4+8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yl2Bg6XNkz2yMh
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2025 03:57:47 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 50VGtjr9028667;
	Fri, 31 Jan 2025 10:55:45 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 50VGtiNE028666;
	Fri, 31 Jan 2025 10:55:44 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 31 Jan 2025 10:55:44 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/microwatt: Device-tree updates
Message-ID: <20250131165544.GD20626@gate.crashing.org>
References: <Z5lfDb8wsLlmSLBZ@thinks.paulus.ozlabs.org> <Z5lfmZtfHD7t2IvK@thinks.paulus.ozlabs.org> <D7ECKPNWAU7O.39PRDJ4PIG0P9@gmail.com> <Z5nWXtdCokYuVbXo@thinks.paulus.ozlabs.org>
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
In-Reply-To: <Z5nWXtdCokYuVbXo@thinks.paulus.ozlabs.org>
User-Agent: Mutt/1.4.2.3i

On Wed, Jan 29, 2025 at 06:18:54PM +1100, Paul Mackerras wrote:
> Interesting.  I looked in my copy of v2.07 (PowerISA_V2.07_PUBLIC.pdf)
> and it mentions rfscv in a couple of places, but has no description of
> scv or rfscv.  I'll change it to v3.0.

Huh, rfscv is 3.0 and later according to later versions of the ISA.


Segher

