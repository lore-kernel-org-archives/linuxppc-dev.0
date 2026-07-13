Return-Path: <linuxppc-dev+bounces-24120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF782C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 15:09:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzQnx2mqQz2xwN;
	Tue, 14 Jul 2026 01:09:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783955365;
	cv=none; b=cLl5d/ibZcwRNkQGoiMSRZGqWbNhpl/olXFJnYpLfK6xFwAnHDO95kzL3XT8V8kOXtS0ShQ3e8zs7Z/Q+pK9ULicI/q752Kug5brsco4scho7+AhFVGv5qS74Sx/UqAvjgUwTedOPSQxm7i4oHgy4bsCEgKHObA6g2EsjdGYDiiZqhsqCv/9cogc4j8SHRailzrDeNHVll81DtX3K1p1Ch3qQK5+V05MgJ9NaMbl7u1mycwQmY6fxPOhTS6x0/tiV5mOlL+AFXSexuv6HjhKVHLFfgRZ6i2X4VoBZgYZ7hMZIlx59GBaIdcnlhXH8LHGKZteaCtpBBTFL8Zo+febKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783955365; c=relaxed/relaxed;
	bh=+M1zr9rTUgQMNlUXBESdweoGf9U7X+OYDnRmO6YXH1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddlh0E06E9PCYgSIkbxn+/RuqN+xSpENiSM2UByLrbXQU138wqg5xC0Hf30lFb6DcLpwUsdPEMQEUb7uTMCL++2sbAUg9Z/ijXWqNBIgqMVpRJCXLiOLBhXYYoDbZgD/j6oH7sGZI9tuTm52/tuxFxIckYK0hXTL7kCvXB5aHhfYq68vhFDJWsiTYVTZo6sD0tEP4a53emZi5Enbpwm24Eabsqh4diPNYSRMirN9nIZlRJr2AyIW1jESq9ywGp8bXV6qMvnKnO/YxwfKVYgNeJ56roE3uUTTVl6KDODYDpZl1W1Ev2V+vQyT8qmAQiTkHh3ohuzYXiuBiveb3CZ9XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a9xF0d/2; dkim-atps=neutral; spf=pass (client-ip=95.215.58.182; helo=out-182.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a9xF0d/2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.182; helo=out-182.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzQnr73nJz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 01:09:19 +1000 (AEST)
Date: Mon, 13 Jul 2026 17:08:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783955338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+M1zr9rTUgQMNlUXBESdweoGf9U7X+OYDnRmO6YXH1M=;
	b=a9xF0d/2L71ONYPVPsefz3XZSfE3ZamyNJyyyZjrgNziQQUb/Ozdcat8yaN8Sx4s0lz75g
	QLt3rFlj1NCfC7V+n2SdodAEZULM4owumuDrhIRpdxnMki8Kp/jw5NRdoH0OUJNWOD/Nc6
	hZYkn0mKy11XwwDe/1Bb79Xwt/TZwbI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>, stable@vger.kernel.org,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Message-ID: <alT_fEu9AtQT9PxU@linux.dev>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
 <ik6jukrj.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ik6jukrj.ritesh.list@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 13, 2026 at 06:08:56PM +0530, Ritesh Harjani wrote:
> Thorsten Blum <thorsten.blum@linux.dev> writes:
> 
> > If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> > decrements iopage but keeps using the failed mapping's offset. As a
> > result, it repeatedly tries to invalidate the failed IOPTE slot and
> > leaves the already installed IOPTEs valid.
> >
> > Recompute offset and invalidate the installed IOPTEs instead.
> >
> 
> Nice catch! I wonder how did you catch this?
> Do you have ps3 console where you somehow ran into this ;)
> Or was it a manual inspection?

I do have a PS3 somewhere, but I stumbled upon this while reading and
trying to understand the code.

> I wonder whether PS3 consoles are still being used?

Not sure.

> > Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
> 
> Looks like this was from 2007.
> 
> However, the change looks good to me. So:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks,
Thorsten

