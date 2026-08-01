Return-Path: <linuxppc-dev+bounces-25199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA3DC55172
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Aug 2026 22:07:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCH9W58Qvz2xlw;
	Sun, 02 Aug 2026 08:07:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ba"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785622047;
	cv=none; b=Vze/ECLh6ojHeZ0NFCErIwp0Z5IEnA6rVIGj5mjsEv2QF2EfTwUXLsyArFMepxphayDxqhPJXj7x8PmPtH73x7t8c3jT2/5tvsj6sJE+QEwtC7xOODHj/+Xp4aVZvrIHrYQnHfifDCV9rRvi5qr2IHNubt9IlAQ6S84NNk/WWUQey0RBqYRuTVHvt9Vkd/S0LcEge+G3Kew94YKKJAU9/CvO75s66fDq+FvX+SQMdQS2Fk8cbuXaiiHAaZ2nj/mAq4xbp4pI0p0c7r7XzBBuKKz3YYzEORlkOrpqkK8dj3cwhOfNAJ0WTm0Y1hgGeRBd6COPlOwp5uxnpRYMDQrWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785622047; c=relaxed/relaxed;
	bh=etwQp5nKC/6j0jIPO0+nawBmEUGNysMKUcMCQrhX0c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua/E6VODElxkNqMoPFdZGwh7RG8f576SRqIjfCyrWtIdmyYjcJgKLgkV9E7tN6qmBZrtjtpKDSIhHT5QdMnAGdOXNWmX51NNr00PjBUE8NiXaBTJMc8CY+q9xzSnjZJOILemS/EmvOyDN3/7UkITprDkbX/kHGlMbWDaP9uzbdbp1F/zBHSN+RXGW+cbhqO2xCMDsT7bnlg4F2XFMBZYGkD68dXI45fDC7H5zUqhuF81Zv/xyAfsjUOFXLdP2NP6Lxgn5xJc2p/M2sj3N+mDNZZD8SBdH6zZnMCX2HtxQV3thS3qj0Iv+cFsFGkF9LgLEqWR0WimKJViZz31KXq19g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aa/OjSsV; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ba; helo=out-186.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aa/OjSsV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ba; helo=out-186.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hCH9T01rrz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Aug 2026 08:07:23 +1000 (AEST)
Date: Sun, 2 Aug 2026 00:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785622018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etwQp5nKC/6j0jIPO0+nawBmEUGNysMKUcMCQrhX0c8=;
	b=aa/OjSsVzX8DYWXfUGDkipCHD3V3P/RYtBMfsiXqhvkRsb68+Stmu42Anm5bSVaxxOp698
	yC3fwcYIMdlKmYY0zZgR/oZlerUUTlVM+C1Y4qzxnrY/QJguLZEjUPSuIYcrNLdykkheoW
	uODOIIxcKkCURkvKsdzytGySabgu1Ps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix repository.c build failure
Message-ID: <am5t-ixyIp1IwdV5@linux.dev>
References: <20260703165834.137242-2-thorsten.blum@linux.dev>
 <6be33030-781f-4480-8ccd-81c5b1df220a@kernel.org>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <6be33030-781f-4480-8ccd-81c5b1df220a@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 31, 2026 at 09:34:28AM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 03/07/2026 à 18:58, Thorsten Blum a écrit :
> > GCC fails to build ps3_defconfig with the following errors:
> > 
> >    arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
> >    arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
> >       78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
> >    arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
> >       78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The current use of strnlen(text, sizeof(n)) triggers -Wstringop-overread
> > when text is a short string literal that is smaller than sizeof(n), such
> > as "bi" or "bus". Use strlen(text) instead and clamp the copy length to
> > sizeof(n) before memcpy().
> > 
> > Drop the redundant char * cast while at it.
> > 
> > Fixes: f94a84a09148 ("powerpc/ps3: refactor strncpy usage")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   arch/powerpc/platforms/ps3/repository.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> > index b8c030eab138..0cc755ac3e7f 100644
> > --- a/arch/powerpc/platforms/ps3/repository.c
> > +++ b/arch/powerpc/platforms/ps3/repository.c
> > @@ -6,6 +6,8 @@
> >    *  Copyright 2006 Sony Corp.
> >    */
> > +#include <linux/minmax.h>
> > +
> >   #include <asm/lv1call.h>
> >   #include "platform.h"
> > @@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
> >   static u64 make_first_field(const char *text, u64 index)
> >   {
> >   	u64 n = 0;
> > +	size_t len = min(strlen(text), sizeof(n));
> > -	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> > +	memcpy(&n, text, len);
> >   	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
> >   }
> 
> Maybe change to u32 and remove the n >> 32.
> 
> Shouldn't the same fix be done in make_field() ?

make_field() has two callers where the compiler can't infer the size
of the string at compile time, so it doesn't produce this error.

make_first_field() is called only with constant strings, which lets the
compiler infer that all string lengths are less than 8 bytes.

