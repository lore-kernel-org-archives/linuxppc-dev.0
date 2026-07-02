Return-Path: <linuxppc-dev+bounces-23360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7794C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 06:35:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grRvq237Wz2yXj;
	Thu, 02 Jul 2026 16:35:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782974119;
	cv=none; b=hmnBMD/UdcMZCxI8+MJrmllPHR47P4piqX6fNyqBseUlhsy5ldF5K4LwSCR7KhA9nirFIDjmimTZyE30DjPq9ooEXspPuZF8yCRe4x2c4mJdARMswAHp79K/L+4hvu4r5Pv7mwPqM625iM68iopRQiGbXvX9Gu6ajyApo/H9k/a5VEIx8pxh5owEsK2Hs+E8W4cL9jAMvuN3Cu2wAUOWuZIphJ1JpHfikgLlafOYs8dQ6+FsM8KkoktL+ALln1gIV6kJcproQ4rWrSTHng8ZO6Bi9MfO7lAGfQa8xw1c8FW9ElPheVU5/D7PtuWYF5LjASmmPD5eJVSG6hXpjd+47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782974119; c=relaxed/relaxed;
	bh=Noief9ZbgMWwjMEa1Uv1EUAk6Y9VcmmMv+j7+9dAjkc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3P0MGOyopEC/GeNKGFQTuBq5wP4v36fcYjTNEVa6wjVUm81L8XTxLRlhKE8Y7MEwf5FmXTrF0P3sFuR0U6KLfwWISa3POM+WJK8oVTupcaoJZ6WuTPM0HP2FJyclYUEAdhM8x0JCbfvH4f1O+l2keW9TI/7L4BMrMfTzHPpzFqJcdZZFFzjQo3GPObk1xtjnDF/mTnDiazRbLBpTwWsFLWyK3vzWaTNU6nL6tie3jH7Zs6qO2wVs1eHXvhFJvve3jj2g5M98BtIaiMKA0yilHVZTogrOKiQlVd71p03St//h39nBU98hwda8cbvm0n5nOfLSSbORVE7yXh/VM18Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W8xV1vNQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W8xV1vNQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com [IPv6:2607:f8b0:4864:20::b12b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grRvn1wSQz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 16:35:16 +1000 (AEST)
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-664dd23829eso1362959d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 23:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782974113; x=1783578913; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Noief9ZbgMWwjMEa1Uv1EUAk6Y9VcmmMv+j7+9dAjkc=;
        b=W8xV1vNQqEnUxl475Sbb7njjow0+Ec1iSdlMfgACpchLbdegEj1+arxdjelwt+Iia0
         fnXIJr2U73KXEPy3z8Bw6GKIQQXi7+3cazQPg3QlmErQg5ItWI/toIwzNwMzxyewMiN7
         iWd3tNvPV1T4LcjHLVr+dOj+VphBZBT6GuDmh/mPifyBN1/7Hhc5Cyxny3YjvZpAL3hf
         0mR8fwwRJI/RMj9P8EzTjwTdReFqE8VIGLEG9ey/NTX/ZQ/vzj6yaQY3CGZIPOn9nmkm
         D7iqpZpSnkmzSayUIXwIu6A26NPnD9JX2T+e0LMiIDjaL5KHiQDrApxYAMM5wDcJjZAB
         v06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782974113; x=1783578913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Noief9ZbgMWwjMEa1Uv1EUAk6Y9VcmmMv+j7+9dAjkc=;
        b=W3sVwnApBJzude2934PoU7qILNaEMcLFoJrF8zuVaAf/e0F/H9IkK/HuUwxbINnaPH
         9osC5wTa7evoucbw2+nv99P7FCIkR9XKARQH5dcgk2ZxLsVQjxLfp58zfCOZC1GArj1o
         a3WhylbPJ1n3wH5ql7x8awwi9WO46eGz+uJ4BXrTktN+1QYWN5FKWSGtX85DladSLNDn
         fxJU9ku1T5uyEAKvyjo9pYHSABk8oOx0wP/fuZlTXPhyxYYnjpFo1sByKZ9YhhtKW0Gq
         dL9qWLhPmcino0giiXQpcm6o9PH3y882TUynr0tEvzW7av7wjK2trm2gGLd1VTbUqtqf
         D9UQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZoOqCgFehvMg4J1xhdX8tshdsdYLMuHtvNaLbDhuwnCp2h71ktgCNhI249RaQYPQLR/BkSqE3jq8/Q+o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMynj9rulXMER1GWYnBJwJqJZ+cNvj70aTdRsj29uAU0OVqiNq
	oIMhygsp6pbmBRBiAyei1bGDflXE9qCjrnDC8PztymMAyEO4wGkc0sG1
X-Gm-Gg: AfdE7ckg0yK+DzybnAxEfC6M5XPjQvdPxYKIQoyom/2y9KTAgqw9dQY1ooY4lXDOFy4
	J3nd3HUwStPkguaIT/gePw1Guk6XXF6SW6VJPxfqt3HK+0dHe4689nZShbDZwbW/jOrNuGMEhYR
	xtOw/sFqmQWf7FVdKFOxz1d8t+vj2rxiyi9FvMkMeLWk1bMeRRbkclV/g1Tf52uEmBtWJ4J4Ig8
	E385788xauC48SFtznjNHtmNu8ouNarBksOs7hZJI1rhCkSrXPP9Nt+W9wGKb/MPer+D98bioZN
	vzFjoVEyPGIH8hstLstDFJbL5hZfr35cwVQhp4R7S7OACIVo3sXDzsP5py/c8E5wh1eHdfGhYdK
	YRps9638lKf3rhoZPTfkkBeh0NqdF9GyMmVLEeBerpb4DVxS16KoDVPI2vvF8Ws8zKHbOGWZKUX
	eESFwZiUe7TrKwCXXOA3E=
X-Received: by 2002:a05:690c:6905:b0:80a:9f2a:fca2 with SMTP id 00721157ae682-8138a6a3211mr45338417b3.54.1782974113494;
        Wed, 01 Jul 2026 23:35:13 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b834079sm8875167b3.40.2026.07.01.23.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:35:13 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Thu, 2 Jul 2026 02:35:10 -0400
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, akpm@linux-foundation.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>, Rich Felker <dalias@libc.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 3/4] powerpc/numa: set node_possible_map from
 node_online_map
Message-ID: <akYGnq1AMLCfIdgl@yury>
References: <20260701171851.2447626-1-ekffu200098@gmail.com>
 <20260701171851.2447626-4-ekffu200098@gmail.com>
 <akV-xN18Xtt1rmTL@yury>
 <CABFDxMGvQG++qRbh2UuDsRCX4910BGA+2j5+5jcm0hJMgSTSqw@mail.gmail.com>
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
In-Reply-To: <CABFDxMGvQG++qRbh2UuDsRCX4910BGA+2j5+5jcm0hJMgSTSqw@mail.gmail.com>

On Thu, Jul 02, 2026 at 12:57:46PM +0900, Sang-Heon Jeon wrote:
> Hi Yury,
> 
> On Thu, Jul 2, 2026 at 5:55 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Thu, Jul 02, 2026 at 02:18:50AM +0900, Sang-Heon Jeon wrote:
> > > mem_topology_setup() intersects node_possible_map with node_online_map.
> > > Nothing sets node_possible_map before this, so it is NODE_MASK_ALL and
> > > the result is just node_online_map.
> > >
> > > In preparation for changing node_possible_map's initial value,
> > > mem_topology_setup() no longer depends on it.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > ---
> > >  arch/powerpc/mm/numa.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > > index f4cf3ae036de..2fdecae90a01 100644
> > > --- a/arch/powerpc/mm/numa.c
> > > +++ b/arch/powerpc/mm/numa.c
> > > @@ -1179,7 +1179,7 @@ void __init mem_topology_setup(void)
> > >        * that we expect to make use of for this platform's affinity
> > >        * calculations.
> > >        */
> > > -     nodes_and(node_possible_map, node_possible_map, node_online_map);
> > > +     node_possible_map = node_online_map;
> > >
> > >       find_possible_nodes();
> >
> > And in find_possible_nodes():
> >
> >          for (i = 0; i < max_nodes; i++) {
> >                  if (!node_possible(i))
> >                          node_set(i, node_possible_map);
> >          }
> >
> > So, assuming the code reaches to that point, you unconditionally
> > online all the offlined nodes.
> 
> This loop only sets bits in node_possible_map, not in node_online_map,
> so I can't find how it onlines the offlined nodes unexpectedly. Please
> correct me if I'm wrong or missing something.
> 
> Or are you talking about the case where max_nodes exceeds
> MAX_NUMNODES, which was also noticed by sashiko? I think it is a
> pre-existing issue, and this patch does not affect it.

Oops, sorry, It's my bad. They are nodemask_t, not pointers, so in
"node_possible_map = node_online_map" you copy by value.

Thanks,
Yury

