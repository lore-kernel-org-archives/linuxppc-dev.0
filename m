Return-Path: <linuxppc-dev+bounces-22063-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D473CCD6E75
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 21:17:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWcpq2sqNz2yQG;
	Fri, 05 Jun 2026 07:17:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780607859;
	cv=none; b=cKawvGjP47eCZ0NB/ni3P0LLB0RvF4ySgozip3lopSXtux0Pb40hQyKgbiVx+cZz+yzel3aKk/VcydWsHNRZHFHmli68PyipO9q/MKZmmY0qHVqlgVqATJmiREAm4x5XAVDw/sf8JN9DxN18d7DRqvznXUC3CtXYXFQw3gYewW6Z/HMgtlJnVpES+Z6sYP7uwYbrWbYc+sDOv+sCnc4+aEgaOAzr+wSRGE3NyyeoiZfxUOOzShuIoxGK1vwxPKWh31ueIR29tttiJvM1ADDu43xFcExb876aqo6+jAah0FJnpZ9QjEO2nqtsY/K/QlvC/AqTvzKw4A3HOD5ie6mwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780607859; c=relaxed/relaxed;
	bh=xb19kbWiqrpSFbyUlwb6WaMy4XfoRK0lb/vr/qLyz9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPIBLhCNwzWJbntUzyVc+al+67q1b3Xooz0MIEANGhAgndy6VfnifMZF0JAwolJQ0ATdDugIY1nvIu8HUhno//Wo7OY/XiE3hjOpzV/9mJA/Un0v6YhDd6iZGrqV48RiUPkbpG239GUBmU3fONtqXZ+h8q8F1r8P48YjqGKZ0uazzclKwVuxHPIn0mzB4l+aC+8Bs7i1v18arPhUQzMgOP15ho/xYUf+A2ATYYPYK7yGpXp2Zh+mc9wGIVNdY+gITxdT9qUtJB/Uy0utow71tHdYmH9iKXA7fWJzSDDvi8rb/bsoa/fP1lp3itefmgiZvWLhIzGsVC6+EpCoXod6Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=CptyadUw; dkim-atps=neutral; spf=pass (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=CptyadUw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWcpn3L4Jz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 07:17:36 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gWcpj1s8Rzlgtd3;
	Thu,  4 Jun 2026 21:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780607843; x=1783199844; bh=xb19kbWiqrpSFbyUlwb6WaMy
	4XfoRK0lb/vr/qLyz9c=; b=CptyadUwIPy8kaG7jLQ+DM8ZF1tvdDQR49aNulrh
	biH5o5y8+awSGeH7xaIZj701xjLsC1bHmc42FVzVlpTIh2OS3Peu/J3qE2vTgqUj
	WJfPQ8IiwOfAoJTyGBKQby/pVQ+vc0RAWGKj17HfYY0rgOM0PJ1HGGwVZsdk0pKH
	meGPJvZL7KzYbTsEN/KB/WvbFufh6zwd9oG3uVsF4x7VmHPXxVgH//3XfzkGvOKc
	2Sr4BitSc4ofZicGR45Q6f13yrmVZ9DqpsIJg7pLZzntbpDTtkAf5IZYA/2iU6Qa
	JRodaXwS6v4/BTVYf2M7DcaY3SHOb9/dTVQCz5Rq0puSqg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2cgALRHoL-Mr; Thu,  4 Jun 2026 21:17:23 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gWcpQ0CxzzlgtdF;
	Thu,  4 Jun 2026 21:17:17 +0000 (UTC)
Message-ID: <99f038f8-04a9-40a0-9520-8df3dd1e609b@acm.org>
Date: Thu, 4 Jun 2026 14:17:16 -0700
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
Subject: Re: [PATCH v3 0/6] Remove remaining references to the pktcdvd driver
To: Catalin Iacob <iacobcatalin@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20260530-remove-pktcdvd-references-v1-1-aa56941d4315@gmail.com>
 <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <96a48e65-6ee2-4b81-91f8-821a2de707db@acm.org> <aiHbj0zn4y9X6qV2@toolbx>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aiHbj0zn4y9X6qV2@toolbx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/26 1:59 PM, Catalin Iacob wrote:
> For learning purposes, do you mind quickly sharing your rationale for
> combining 1 and 2? To me they are in the same area but still separate
> things: one removes dead code, the other increases encapsulation. Each
> is a small but worthwhile cleanup, they can be applied in any order and
> each can be applied without the other. It's true that, while patch 2
> without patch 1 works, it would increase confusion but I find that an
> argument to order 2 after 1, not to say they are one thing.
> 
> I'd also find it hard to describe what that combined patch does except
> by calling out two things: "remove dead code and move the declaration".
> Your suggested "unexport" seems more confusing than clarifying, I'd
> argue that today the symbol is not exported since that ifdef always
> compiles the export out.

"Unexport" is commonly used terminology in the Linux kernel for removing
EXPORT_SYMBOL*().

I proposed to combine patches 1 and 2 because it is normal that the
declaration of a function is moved from a public to a private header
file if it is unexported.

If patches 1 and 2 are combined, the most important change is removal
of EXPORT_SYMBOL_GPL(). So I think that "Unexport
scsi_device_from_queue()" would still be an appropriate description for
such a patch.

Thanks,

Bart.

