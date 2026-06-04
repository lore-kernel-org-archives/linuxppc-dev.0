Return-Path: <linuxppc-dev+bounces-22062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DE9CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 20:58:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWcP03wfZz2yQG;
	Fri, 05 Jun 2026 06:58:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780606724;
	cv=none; b=VkpYIkbeNq7YnMJ+nYGLWszckH5Io1DujVhVnuDtCPqa2gyknRzHSCdbsb2M7RK9OT3weOydufIEZrdH3jska7LPr1QrrBcWrEZpXt7ZXvfs8ZQ/StuWKuUeRf8i45lbxOS7vkldr2scFEL3RdATrYU04zEkwSEIEpErEXTp3Kcl6KN9J00uP8C2XAoVJPeI3gK+FI5N1XKjYExgdhN1xVFGr2/9UidW/sq0WRBdadKJER9266TPGhH6ioT4pjQZyhCUpdq5lsaFIIZww0oYYypgLcCSq0XDoP5If5IXlNRjI/h/3thj7sP4jKI7ClI/8ZqLSZ3FwiwtOqNAGBHaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780606724; c=relaxed/relaxed;
	bh=DQTkf1lHMIqbwK47/czYzHj+glOCSShwPoAIlDnSnRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlmPsVPuxN4VAFw3Vch1zvkMjRergN2qA+ZLSVSvC/JVz/UE4TcUQViqNMzqp0/ZKridb7npnqHa2aAqPQuuD9/9uBckWuCbq+TeG754Y08vwaxDA22Kjge2T+D8OsagYvOVwTxobCZyYpYreqBxAjQlY8whIHDh0uKCwRRPsJG52ffuEf7+tl2OH/4M0DUw+FfiuaaOClvr+m3n7dCfwkgogk3ZhmVx8H8LT/bNuRAEeXpurX52jswdcdb4CbF1lxltT4+/gdW2DXY7YUix235V/JTl7Ubpr/AzLcj2xoMONDW2yyOwt2h331zy6U0iMiTocA7xMuJGWw47+iAnSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UgGXGgCY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UgGXGgCY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWcNy5N1Vz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 06:58:41 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-490af320e2aso14117075e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780606718; x=1781211518; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQTkf1lHMIqbwK47/czYzHj+glOCSShwPoAIlDnSnRw=;
        b=UgGXGgCY4oyGsnaSBSl5/qeDkGbsRW+kwM+8D6iIGd+uEkCq1GmlBAv8/SqWPXulYa
         xbxRTYlkcdFppOHqUkFZTj99F0I3P8r1PS0oNEA3XX/2IjIsaKRKZO/ArRTp6c1tMJs+
         2qAv1YhD2NR6dmuOh6SA1OAxMMqynqTWBfwqie31JVuxPtE87eRBO04RBh2J3Np6uW8T
         ZlTW3bi1cl3CQfFzE8I492OMY016u/igY2h7D3o1msK3JBrtvemmdLMVFTj3h+jAyBrL
         JvqxulacEUoH1YT54snw3K6EJ5vqxT34h3vdh+oEFkgyDJZOC4q9/DHdzcwOQAgFA7zR
         8zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780606718; x=1781211518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQTkf1lHMIqbwK47/czYzHj+glOCSShwPoAIlDnSnRw=;
        b=nENlomKzlnpyrC9TPHUNMDW9gIkcrGj6Qbm3i1+HR9MQv4OePZk0EX3N9YbOXtRsGn
         nzBAZillwkcR6/bMaWun2vgTDy8T+IyW++GlJiPLjBHlJJZ8PZD4sQ7tWUeK/UXxloob
         I48FNhd6wcmAb21URtCD15piKggRh/aOwwoIYCf8zQ6IzeAlKJbvJPnl5LADnjEOqrM8
         kHV8qoZwDtuXYLTaaHTA9qO4Du0ZMiZvbbKJrcrLKMJTwgFmyZmANVWbyTeCOlBASbG+
         UV+kY+gscnINdsg59kO5h5jnc3WpL5H0/yKi25pzrYZti6hToIN5qS4rXSFjZsYzsdzt
         +LIg==
X-Forwarded-Encrypted: i=1; AFNElJ9VqkTnTm1YuRNW+IavKCrm79BX2GqANoY4q3tqpIXIH3Defar1cI6IhxGQgKinMcBaqQDigeINjZ+ndOQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzwA2FEAKA6iLq/veNme1ty5hMLBgPSLYgPpSez/+cYFtPsNEtu
	jCXxTGhDE30yXAdf5Vz2vBjKVrjR4oE7JI1SPDVsYPsFMKLv61w5BXpG
X-Gm-Gg: Acq92OHBCXUtJBFpzl2gSHdGVKUE4gA54O+lmiR9JaDRrYevjeeriATZxEhXhqYKwrB
	H9nfWSfXDe7/2aVQiNj6DNJSxdxctQOWEL7uOwNi090kDVkJIWc6FL4mi+LTHQuWXC23uTBs+Rw
	CKznpCQjMRRImPziJ2DyclyxETxFnjUuwIznD8preAL5l72IL8z59SfmVRJ27BSZwLtGWWzJnON
	F699VvDUGtRLMITWWTZUnx/27BpdLPPxoyd0BV9udSYx6XIl0TC6iMW+ymT8zMFdoYxrfh1hPER
	xZClJcLlFVh+krMuE3bsIvzywRX1l309TyDBUvteBp8ITE3tpodLddAnbp4thd/yozY2l7BdSMw
	MU9bl+ccQfhb5HQOTpxnK51d5ojF3okp1m9rjL07J5GzjJFxbAmxLhG1r7NgZ26oM2Q+nQgkyV0
	6KXmq3aT3HVqs/3jxtgqOBJhwqVugR3lrT
X-Received: by 2002:a05:600c:83c3:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490c25a21a9mr4351475e9.9.1780606717742;
        Thu, 04 Jun 2026 13:58:37 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm100278155e9.15.2026.06.04.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:58:36 -0700 (PDT)
Date: Thu, 4 Jun 2026 23:59:21 +0300
From: Catalin Iacob <iacobcatalin@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Remove remaining references to the pktcdvd driver
Message-ID: <aiHbj0zn4y9X6qV2@toolbx>
References: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
 <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <96a48e65-6ee2-4b81-91f8-821a2de707db@acm.org>
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
In-Reply-To: <96a48e65-6ee2-4b81-91f8-821a2de707db@acm.org>

On Thu, Jun 04, 2026 at 08:50:22AM -0700, Bart Van Assche wrote:
> If this series is reposted, please combine patches 1/6 and 2/6. Anyway,
> this series looks good to me.

Thanks for taking a look.

I will repost in a few days when back to a computer to fix the subject
of patch 2 since you are right, it does wrongly suggest that the
implementation is moved.

For learning purposes, do you mind quickly sharing your rationale for
combining 1 and 2? To me they are in the same area but still separate
things: one removes dead code, the other increases encapsulation. Each
is a small but worthwhile cleanup, they can be applied in any order and
each can be applied without the other. It's true that, while patch 2
without patch 1 works, it would increase confusion but I find that an
argument to order 2 after 1, not to say they are one thing.

I'd also find it hard to describe what that combined patch does except
by calling out two things: "remove dead code and move the declaration".
Your suggested "unexport" seems more confusing than clarifying, I'd
argue that today the symbol is not exported since that ifdef always
compiles the export out.

