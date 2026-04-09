Return-Path: <linuxppc-dev+bounces-19527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15262EA3C59
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2026 12:53:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs0GR5F3lz2ygf;
	Thu, 09 Apr 2026 22:53:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775739183;
	cv=none; b=WvgYOb3Bj29f/l6uR6dm0kYre/Z//Ym4CxNwCUkMMiRJiQwcklGtVPidX/RCZFsRMgH0rXjGAAvLWCDZnUY5yaMUXSFzc1WMS4xLpZs1uJCnyVru1sHUCoXOs30CphatF583uWC3NawpgVpqrBaBYAzs03sMErXFmi98sUYeemyIGedHIG95cAvn7YaKHl94M1lQlWD6h+2gbtmhRt/R228aaVzHcIHv2xdcJQHRUgAek+Y1C6/kpENqGxXc8Ts3wCCJ1FGmM9UQhc5hIk5mUCQT60zDBQ0msegjb5y2PLiexhkb6Sumaf+/0xPPeuSHr8CzmV/3AUArN5ZmGOcz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775739183; c=relaxed/relaxed;
	bh=7PFz5XtfIRsLNoi9T+yTp0ln50ub+y81S0Yd92D0HNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIDKy5f2xAC5rueqszetwLrh9GWhKePLtGImwBWbgEXZnN6ux9/qPg95CNb4z1Vy9YiiJlC8ewv5idnYXn4wCpHEK8+syw51GaGPAjwJBAeAT3f/bhapzSn1H4mCqvtrWb4EUO20C2nJsw2hmDUQTJpiweXHn3DDVZsUDkRGVv4OT+QOSRb9JMhNoE2IIDqY25a6r5hMaaQi1jOtMG4oITLeOHx1AoF59rnrXaXpLREBbLtUOqhCd4WrO86JMNDVoGdTAE/ZaDYMuCY3Wk6fFQPkB7/9/rbDYj7UCmKwkkyWAReGsv3uUNNK8gu8JLyHZTd9j3lW6mVpivX+6We5Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LczClAb/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LczClAb/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs0GR0c6Sz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 22:53:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E4F4A43616;
	Thu,  9 Apr 2026 12:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE98C4CEF7;
	Thu,  9 Apr 2026 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775739180;
	bh=rR3I96td5Fb7sMzKN7K6rnakhBmE145nsvZyacL0L2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LczClAb/LRbUmKYYPH9OTWIJARoyFSqmlaXBmM1APMyoniy/Bqf7W9ZeeZarcuPyh
	 iPgsO3rWwQLALEcc8UI8erCd0t49abxlHHlRfgEpeAA5qzEqh8m6QWa2fWxLHpfN94
	 9moviaDptq5jChY8TsU2LAosDVo9LcuhFttd1fniQkEOj5xeGnTWHehHqwHvAc3USt
	 TyPJRwjZ5tCzJCogcIgDo/qtEhYAU5S22hUo08OBe83FRj3gfkVk5jQ7Ngc/5i04/3
	 GhUU3CK5XAtJzXJSkbExmQpkgfIGLoBAWToxRg8tHSwUjAHWnwP1uAiUIWSOGpHiiP
	 BWfWpX8APIaig==
Date: Thu, 9 Apr 2026 14:52:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 1/6] pseries/papr-hvpipe: Fix null ptr deref in
 papr_hvpipe_dev_create_handle
Message-ID: <20260409-viadukt-szenarien-4544001038fa@brauner>
References: <cover.1775569027.git.ritesh.list@gmail.com>
 <5984bd91ad6d3541d08dc9f3c99e6de0214dbfcc.1775569027.git.ritesh.list@gmail.com>
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
In-Reply-To: <5984bd91ad6d3541d08dc9f3c99e6de0214dbfcc.1775569027.git.ritesh.list@gmail.com>

On Tue, Apr 07, 2026 at 08:01:35PM +0530, Ritesh Harjani (IBM) wrote:
> Getting the following kernel panic in papr_hvpipe_dev_create_handle()
> when trying to add src_info to the list.
>  Kernel attempted to write user page (0) - exploit attempt? (uid: 0)
>  BUG: Kernel NULL pointer dereference on write at 0x00000000
>  Faulting instruction address: 0xc0000000001b44a0
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  ...
>  Call Trace:
>  papr_hvpipe_dev_ioctl+0x1f4/0x48c (unreliable)
>  sys_ioctl+0x528/0x1064
>  system_call_exception+0x128/0x360
>  system_call_vectored_common+0x15c/0x2ec
> 
> The error handling with FD_PREPARE's file cleanup and __free(kfree) auto
> cleanup is getting too convoluted. This is mainly because we need to
> ensure only 1 user get the srcID handle. To simplify this, we allocate
> prepare the src_info in the beginning and add it to the global list
> under a spinlock after checking that no duplicates exist.
> 
> This simplify the error handling where if the FD_ADD fails, we can
> simply remove the src_info from the list.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
> Reported-by: Haren Myneni <haren@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

Thanks for fixing this!
Reviewed-by: Christian Brauner <brauner@kernel.org>

