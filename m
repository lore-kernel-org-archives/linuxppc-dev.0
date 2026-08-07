Return-Path: <linuxppc-dev+bounces-25621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB42DC2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 19:55:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGvyC1ZFlz3c88;
	Sat, 08 Aug 2026 05:55:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786132515;
	cv=none; b=NhofxfjWKcWNqectxA4qDYgr0/EUIf6gHlQ6wgiHauLUOcS+ztuq4E9lR51WWNSVjmXggJ0ieD3YDBJUfWAS1qsRw/5Abjh3jFLViFQBr+CqHTd4uZgEqgyoF4JPksj1OYiB0eiQzaT6pUM5r1BvzvuiwNM+mKcAUcx8BKwMpr4ykWnG/vIOgwQv74qZ/PKR1RVoqHvWnigI7hvTVzPSC95hV8L9lcqMZag3WJEO8fvKZVt+JTnolvNqixNY41eyaSifXO6X76pJQHEaDTn4aSU92uIkBmRLKn2yaIiQuu/+Fj/jsaEo636i6xsaZmpzYzByFf68eFHNHP5Y1Ym/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786132515; c=relaxed/relaxed;
	bh=PrOR4/4/t9uG1CtfaEroNqxI4nkyR4L3Fs4X29ZI5Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8JZZDdJFVF+Cr9D0AfM6W0WkrSxp8YT37i3uapfLtgNHZAfeaXvWHrmnbB5XJVx62pbvhl+rnUgPc/MakxuW9yM20AkIB8yz6LeRkhpu6ELMibTEQBqqMYo2FT8wLMPzSP9U6FyYnLF7pR3i7bM/snyylFDiL6YbyzxaurQR/rRrR80dgvlKTs8JoL1Y/wEkhPoUiovbiAluMMEuzGHyTaqyezu2bSUOsD1sYxbdkxwtaNnG8npSj3rZotqgSLzq2rTmtOibgvkY4HDe1SLIHDZ6rnCyBcIOpQNKneXUcOFRST5owJmrd89QzdO3gmsYcm0EL+P3DeedZCK3sAeZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s6y3zKpZ; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=s6y3zKpZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGvy70Rfzz3c7d
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 05:55:08 +1000 (AEST)
Date: Fri, 7 Aug 2026 21:54:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786132483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrOR4/4/t9uG1CtfaEroNqxI4nkyR4L3Fs4X29ZI5Dg=;
	b=s6y3zKpZHU+aZcNxy6YGjgjgaPL3UYtCHdzXp8mLcd7fURv/u7PHyuhY+NB0toWasmS2SV
	LVf6stI3JTDqxtTe/XMMn2HVl7hZpYG7Jzyr1viXUKfJbVrcMeq7C6BqHEjFRTRyOGeoRe
	Hk7igqPYuBtcPhTHV1kErkE0YC3NmFI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: Mark exit() and ps3_exit() as __noreturn
Message-ID: <anY3_-9jmKUvxT6r@linux.dev>
References: <20260807152353.306889-2-thorsten.blum@linux.dev>
 <41e20610-6bc5-400c-9e44-c214162605e0@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41e20610-6bc5-400c-9e44-c214162605e0@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 07, 2026 at 05:32:44PM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 07/08/2026 à 17:23, Thorsten Blum a écrit :
> > Since neither exit() nor ps3_exit() return, annotate both functions with
> > the __noreturn attribute to improve compiler optimizations.
> 
> Is it worth spending time optimising a boot sequence that will run only once
> at startup ?
> 
> Do you have any figure on the improvement ?

No, and I haven't checked its impact. Maybe compilers can already infer
that both functions never return and optimize them accordingly. Besides
potential compiler optimizations, it also serves as documentation.

I can reword the commit message to clarify that, or drop the patch.

Thanks,
Thorsten

