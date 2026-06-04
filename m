Return-Path: <linuxppc-dev+bounces-22052-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE69CD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWTZK2jL0z2y1Y;
	Fri, 05 Jun 2026 01:51:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780588281;
	cv=none; b=gDsVkK0wAJHeUzKeWixRPbji4jnPvP3nZKP36phRBymDw9/007n6ZM7p0hLPJTujpk0JbOXyh1E9qlw4vAqCzL7AUfeY/cAsbl6JS5cIdCwxeqd3S7y5kLG6gprF5hxhwo42lcN+GcIwiMUQAdDBZROI1OlcGk0Io8urHU1JXshpsCX8Aq+zaswNAKI8ZNm9dolnvOdjlvq6+r+75JqSmctRTviQ7PEGFVCiGoR/ErGBFh2JwBiP+aDhWVlJWfOyyclrO++usyZDyRe5XW1LL3oMw9gUhAkMqA/414vvtss0jDQpDEcvbET9bmULunsunZvzAZJ39FuvjSWKRnR9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780588281; c=relaxed/relaxed;
	bh=qf7BSRzLg3pE6s+V4fZtBGGx2xpaq4OxAFsqiuFjqnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0Env8XVki2LOwkz4mU0G3E1eHJRG03BiqgaA/7u5lfGsqShRw7SrrmJ4GfUQZbv4fLU/esafiEkf+RNWuV9T1pfblz6xz5L7HvpdH3Kr4Ninib6xSK3mDxmxoRjufsR2TU6recLmKjDRefB9fHgSikklyGH+xwVTeNYYzEGdK2Ld6HCZG3915ZxlUG69uFBH3uxZ3q+PodUW3baUAkaWaiZuK+hEDOV18y9iUnkkqPAgeZOPDn1Bz/0Lxype0TwRrNrS4b1HCueItJ9aDVoYjtbV1q4XjQRvcGq7VOiY7IxgPw7ZFVfmfuEnAcjAqRI+BDllFHyyGVzBZgLhGtzXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=O5BQm2bv; dkim-atps=neutral; spf=pass (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=O5BQm2bv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWTZJ5pnVz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:51:20 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gWTZH38N3z1XM0pG;
	Thu,  4 Jun 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780588270; x=1783180271; bh=qf7BSRzLg3pE6s+V4fZtBGGx
	2xpaq4OxAFsqiuFjqnk=; b=O5BQm2bvIOflduS8ue3Vhs54lkXqxheP5NEQYUix
	BYnUYOGZEZB1F0BkcWsXZWkL3Gj7QuiEN1DEYBsiX9kfWCv8jIMbwQXWebJ14Gv7
	6LXCmOsWlNElQpPL/s1W7MXG388GqFP5WB5CxvHkwlX3xxAlirOUkzicg7/25rof
	+p/Fi+S7RbBtHVD+UgfowNKaEbm10EpOMQw2ZDZhurw3YiaTZsNXIjRU/0ZWKelQ
	9dAesgM8lvsyuUOget83yIauRMNo1ChN84m6DAkkvdHClpvoLNbuopSUeqySyKCX
	4cJ+UFgJM/tgBeK04oJIlbLzqzBZ+i0+IiQRdEb8j6Rjug==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nZ_TMzKG8sVB; Thu,  4 Jun 2026 15:51:10 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gWTZ14FT0z1XM5kD;
	Thu,  4 Jun 2026 15:51:05 +0000 (UTC)
Message-ID: <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
Date: Thu, 4 Jun 2026 08:51:04 -0700
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
Subject: Re: [PATCH v3 1/6] scsi: core: Remove remaining reference to the
 pktcdvd driver
To: Catalin Iacob <iacobcatalin@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/26 6:20 AM, Catalin Iacob wrote:
> Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
> export that is now dead code. Remove it.
The subject should say something like "Unexport
scsi_device_from_queue()".

Thanks,

Bart.

