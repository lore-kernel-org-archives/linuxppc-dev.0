Return-Path: <linuxppc-dev+bounces-18273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22F4F53D76
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:25:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZMRM1vkcz2yh4;
	Tue, 17 Mar 2026 04:25:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773681903;
	cv=none; b=VDBOydJtLBEEXwmQ7LAFPzx3frdxJTNJ+GeT/TkpjgL1LGgy1pDXe2JPgp6IPCq+qgnT/mavBPBcFWI2Ej84rB6I3EIrta1RZ1Bc0eWp2xJLuVVPuCs4iEDKIxCQekWPbTTtbgfZlwbkbLf2AT5HEICYI4BAnSOfsZtad7+5EAnYl40foeHFvmWFKo9wnCSULoCjLzaAzXwF4BpBZRUIJGL+a3uOXbrfvZeXVMbbULBzZWtFBs/LkAgSQDXLXbqLFPUoHskFR5v7LauMJWKk2Fu38tO1BTX9LZNIOLSxhRAzMt4U8nWwLgQ57JjN0Ww+4TplTah7ayMce+fO2ibEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773681903; c=relaxed/relaxed;
	bh=2zIpJWDuED12p8lWwNhOhNGCbt4qgGPHoPJlAldvFns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oy32VKrQEnPky6UvkaeMzyKmYIWuI51qLR3M1PGEihlUX7jYSosCzszvIqk2w4Sy0xR/bYQYzUL6IsmD+bDrlK5yNDVic+DioY34JZ7onsDKxzqp+vWiUrHipw2M33hyGrrnL80WpvUsqhN2J5WIca1m2wzVADH78vN2nt0lreP+SYgeqZHphcoczMBDHLDumjb247sC1Cy+HqKm6e3ws3uh2lhXUSz7/ctoQi9GxDjk/6MZ+A0dkE7igO2eRJ+0W5nBepsyNvyvErlFdhIDrxLj/KxDkxy96UYd9w6Udq5oJlpoww/TI6ZiZpcW7GA0IUs6tQj32Qim9W3/nnrFqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=fVftXI+h; dkim-atps=neutral; spf=pass (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=fVftXI+h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.16; helo=013.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZMRK25QTz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 04:25:00 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZMRG0fnBzlh1Sr;
	Mon, 16 Mar 2026 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773681895; x=1776273896; bh=2zIpJWDuED12p8lWwNhOhNGC
	bt4qgGPHoPJlAldvFns=; b=fVftXI+hgj2mCsUicY7DROKvKKGI7G9KCjuXCc0R
	8RxdZDElx5mPeuXDvD0B+g61xV/+K9EdxWS79kpTyKYMrxpJPybt/RqA+9r1Amrx
	eyX8m6jR40EPJYu4DnT/QWZKMvQV0j4m3tjxaxu0wobFKtVvXxR5HxJUjkBzFkBY
	lv5pLMq1VLNbpyJsvmwBAMCXSF2tydFL1bsav+Om6e7UnhecaQ7qHjhNRy13UpkH
	YaAm0Wo1AZ/yv0RBlSCWIsS8gAMpBic6nIMup60GKIMwZeSzVOnpAqtf1LQP+Fqs
	AijiLyyaEMf0FwpoTKyMq2UZLNyi1I4jJNDzD1HLKGlO7w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id w3T8FYDL1gUx; Mon, 16 Mar 2026 17:24:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZMR86Ycczlh1ST;
	Mon, 16 Mar 2026 17:24:52 +0000 (UTC)
Message-ID: <972328d4-d870-4674-b5cb-7d32fbe2b3a2@acm.org>
Date: Mon, 16 Mar 2026 10:24:51 -0700
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
Subject: Re: [PATCH] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Kees Cook <kees@kernel.org>
References: <20260313194430.2396286-1-bvanassche@acm.org>
 <95fdd9f7-f7b7-4ab4-9506-f952b9af3a33@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <95fdd9f7-f7b7-4ab4-9506-f952b9af3a33@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/26 12:46 AM, Christophe Leroy (CS GROUP) wrote:
> As far as I can see it was used by i2c-keywest driver until commit 
> a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")

Thanks Christophe for the feedback. I will integrate your feedback in a
new version of this patch and post it soon.

Bart.

