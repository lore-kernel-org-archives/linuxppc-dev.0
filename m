Return-Path: <linuxppc-dev+bounces-22778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33BDCD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 04:29:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghPkf4KDNz3bpP;
	Fri, 19 Jun 2026 14:29:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781843370;
	cv=none; b=AydHGXafFoAWRkSmVsgVWIQdadQiqrB8c+koke/Lm+Bau+8sXlERi9RPq5QhRVQTLQImj336qJEaqiFt8rfG/z7VmEZ6GBEb2Q/OBMQ4nad6ciQPJ+hTjLxeMxrSrMeWxzWserFiJdA0QMiP31TVTL+LMEnRK+3zSsFE5S5U7/gLuEx2zErgOW8vwYja6UlTXwRHKCYpS/FlkeHfpvaCU8jR4eSlp37MKvqLCVxZbLlfAWI3EXsp5+L6m9EvR1iKcmvXPC7YjmQtf70PYi2lMhwWdYgQmKLOZ97/Lr4sL5LPwfOYZ0G+H0SDwfwvHpW/8kUcC3GcJd5LwBkQ0PQPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781843370; c=relaxed/relaxed;
	bh=B5KNNhrguyxIDTqFMShveEml3TFi7eL+6U6xsaUUrFs=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References; b=miC4aSdewWWgu1FM5FmodXtCK3cwcw6/qudvYjCQKDHaRVMtIl9KBSv7bLe1KKMpbGGdqeVGREZ8dFi6Bbnmvyv8KzvSYRyaCsDoxzEhIxyc7zlaNGqagKisH60AJQ679PJ5joE1ExKp/9YyoomhI9Gu/BhesgzwH0CNXXmDplNN1wW3HglUQ/h2tdTsOGAt/HjB+9AcZTUvYChZt8sQzo8KRri5g4HEeUTH2/6IeBOQgj8mCnyHrYEWtOja7pf+9a/GX6fn3DBKshMLulZH4g5Uh5VhtFUe0unH8/8HbngOLb4i2SZ5+/7bgzkpHbwrEr0KHcgcKx/hsXFaOFiLWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=prJJLyf+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=prJJLyf+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghPkd5hksz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 14:29:28 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so1068421a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 21:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781843366; x=1782448166; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5KNNhrguyxIDTqFMShveEml3TFi7eL+6U6xsaUUrFs=;
        b=prJJLyf+us66guoQY1tjvq48Bv5eXpaO5oe/N8+Su5g4kjH8JiqE9Si+KeZsN4KJ3Y
         pl/3fnSFdxkkvSNAoRInekacXWRDs9jjLTm5kDtqiq/lnqhoIfG0nLB0OMwLeZ/bLHE2
         ikvRRazFGTkTXWdgnCpbJNh4wSJj75FFt1MObYVeaB4+bheuN9blks8wTFGeIYQgIhkU
         m4/KogtkHqp6x9XHEWOIlGj0OkEa6ko4tmqcEmUvK1CqZg4eNbeTy22OdHgiQJjzT/jT
         jm8n7MIjFmJHgkWTVXzcxSsU30Pzst9G5tLu6TDTRq0q1TN9OSu+L1a4Jg2seToydVqm
         5nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781843366; x=1782448166;
        h=references:message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5KNNhrguyxIDTqFMShveEml3TFi7eL+6U6xsaUUrFs=;
        b=ALXo74TBihTE23m8XLuuDmbFTKcy1XWk4hLR1tj3y/4EiQVl/rB/q4eXp+Aot5LyFL
         zZtRKNybQPWjWkDt6qdbNb+O3pvR8uP5jJ7XH4GJs7ZgpP1rpHXwuUFHtV0vwX3m7Mwj
         Y0Cjszzzav5/0MispMLwVcI0yeu9K59EckMDSWE6Z9MAEWgWz3nB8vDaRFKD64EzICS1
         dsOgEkMZ86RbaoF8jedXfIDw9aW2FNXel6LLCCmFd5y3W/c91LbcBKbB5wlkBaVW1GC3
         Cty18joEAaIPqclXnU0dhSJecd4uOX/1Yap1dsMSSN1bo2mNlLwaimZtu1jWOd4g15Us
         mKYw==
X-Forwarded-Encrypted: i=1; AFNElJ+9zUL+W9NeBpMrOuesxJQZRUx0dtk1H4Rq64NXbv0Us9tBhR89J646uNi4QRPKoVJ9Oj0ndsiMF243A3k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOY088NNS43Pvx9ouu/2FQWgeFhwCwBU41qMxXmp1PVEHPLtrs
	AqkTpi0lkYjQNQ0+DcnheYpb5l/2ihnZZl4aatvXyjq2g+2WHk9UHf8C
X-Gm-Gg: AfdE7ckhR/76U4xRep04vVwWSqNqPJ0gqo1AxWy+m+duZqw5blnG45WLDIyBV470lKd
	AYGgYg8U9fGeBE4xjxkqxL4qGm3pLWkuD2jqgILLUv0BwurCAwMmseupN9ppVgePawO6YdpodHd
	vXBgk3Hn4vDJAp9asDpa4ggDDOx7Q3GuKkFkQDsn4YzFKkiGCGYrEWXN9ZA3UgUxXcDtWpWvQED
	M0zB5IB03KOV4FpECVmpr8AIiaGwdac2phRYtJtQstlvr0Tw9OYixgS6SYPZjnjZkJDLdEcItjZ
	oXyv6w39bmRXOrCm5Tz/DmSHZgh68Bxmbe22wU+NwI8Kk4IQL5HVepu+Wy84LuPMq3zPfBu/fsH
	Dtw4+uytsgavkvTJ3VHf/cdI/9SW87XENcTYAvcqMsBlHaypjFnIRzS8KthrWFvufg5DE18rKka
	nlJD0UOWKkDcUj6RU=
X-Received: by 2002:a17:902:ec8b:b0:2c6:b7d5:27ea with SMTP id d9443c01a7336-2c725d37e2bmr9488815ad.17.1781843366397;
        Thu, 18 Jun 2026 21:29:26 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208e2e66sm7864405ad.34.2026.06.18.21.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:29:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, mkchauras@gmail.com, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Put PVR values in ascending order
In-Reply-To: <20260616060625.3617719-1-mkchauras@gmail.com>
Date: Fri, 19 Jun 2026 09:58:13 +0530
Message-ID: <4iizduhu.ritesh.list@gmail.com>
References: <20260616060625.3617719-1-mkchauras@gmail.com>
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

"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> writes:

> Right now few PVR values are not in a sequential order making it
> confusing to read and evaluate. Put PVR values in ascending order making
> it easier to evaluate.
>

Sure. LGTM.
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


