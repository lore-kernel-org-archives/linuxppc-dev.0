Return-Path: <linuxppc-dev+bounces-20174-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DED7FF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 17:13:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g49BD3Ctzz2yFm;
	Tue, 28 Apr 2026 03:13:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777309988;
	cv=none; b=OiylDKo+vLuUxS4JFMwIJmYovtLJ8ckWBcXJry3ZIE9yrjZBbORhCga6mWgqhcclQ4uF2bJYnsYtgrisQTFCcBL5xw8ZNqHe9d3TeTW/h98K7S38z5npT6EE6oxmNA/AFrQBVggFYFbLC8T3VlTQ+p6LoiQIBv79uJ1My5Kgu9y5Cnnd/6RjskUzAImfre0pG94MK1WB/PWms6HDZWp8TrnacOB9fG/KCws2T8F0RlPZ5Nidnfq0DwCR0m5KCKGhNTme3W7Fm5JbR36WbK2WuRakhYp71dR9FsH8SClRgSRULPiWAmMBXVROUJWv50qXbWt6N0E8wClKz68f/bumyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777309988; c=relaxed/relaxed;
	bh=n8JxTPSQ/aMOuifXoy8OynYQd+bRkPzt0BYWzJ5orFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0L/7a5KfxPNsP5pwJIwsaCOnHOCEX6fCG3gZ1iuM+oH14lKZKD0b/yYLsNhPgpKWNGpyX7BcjQEPajaWsfXFAEqpG6JXhn43gIfw+Ls9/8366O39WUBJQqFJ+FPi5+PjroBM8oLpdliq7usVYYjv4VWur89/8gRrep6hvUO7TUqpvuD5XE1oXtoUy14uu4FWWb3m7T6g/ne1aOE6PSURB/7SYo/a+LC9WPGOdKpgFPT2tOej3STTH7Zc2L5x+Fgm7NHvCgxvVJHU5upOMOiDDsXYjOP0WTPy3kUd83ySR0sljgRWcL19x+Kr8FKju3xrQz6LgBkJMQiBmDKfRDUgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=UOCtvzR7; dkim-atps=neutral; spf=pass (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=UOCtvzR7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 171 seconds by postgrey-1.37 at boromir; Tue, 28 Apr 2026 03:13:05 AEST
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g49B95BRKz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 03:13:05 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g496p6lBwz1XLyYZ;
	Mon, 27 Apr 2026 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777309807; x=1779901808; bh=n8JxTPSQ/aMOuifXoy8OynYQ
	d+bRkPzt0BYWzJ5orFI=; b=UOCtvzR7AtvasEhVxR3fx7j2VyFeB50nQbePpunk
	apBcXTK6O84mxbpX1NRpL0e0vTSdUwYnnYzZO54r7YaKb89C3pHB+cdX8nlcdBUN
	mVXUZXRVFUdp1Oxsfnh2bCsG/pBvWbw31zCI3I7c6P7X2SKKx+Ut5nnkX5rKibYe
	KNpqRffAfNTIPeacQjLe5ddiKqVqW9OtkdVIs0QUhng61hrjML1Czqtjol8D42VC
	M+diMDNJcHQUp7VPLj2cVYbmjV/UpHjK75krmCpFNMU+IYlS0sELw0N2fmykmqnH
	F4OfIJ4bOjlP0olAqI1WtjAMfjWA20QMH8LqIyLBYAwNBw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id inpw4zGc6l9g; Mon, 27 Apr 2026 17:10:07 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g496j3gGmz1XM6JR;
	Mon, 27 Apr 2026 17:10:05 +0000 (UTC)
Message-ID: <5ee49a18-e6cd-4ab8-8430-e1ef64ec353f@acm.org>
Date: Mon, 27 Apr 2026 10:10:04 -0700
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
Subject: Re: [PATCH v2] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>
References: <20260316174747.3871924-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260316174747.3871924-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/26 10:47 AM, Bart Van Assche wrote:
> Commit a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")
> removed the last calls to the pmac_low_i2c_{lock,unlock}() functions.
> Hence, remove these two functions.

It seems like this patch hasn't made it into Linux kernel v7.1-rc1. Has
it been sent to the right maintainer?

Thanks,

Bart.

