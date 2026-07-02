Return-Path: <linuxppc-dev+bounces-23357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883F6C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:58:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grNQR1djZz2yXj;
	Thu, 02 Jul 2026 13:58:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782964687;
	cv=pass; b=T8FNJrFrT9jaN8ETQzDgv1XtXdTSWK4124jxTDAwHJSRaRQSFowx0c0e7itCKGg06cndy99h6Gso+SGqDpBX7NrMUXu5Ci5Dq74bsijoewC2M5ID8xU1kFZQE2Ku9TljweQ5hYz7Z9qpwI1iAvigL7KtnAd8+WXZV7t/xMz4Wt2Jab7/57VCZzzjr15aCJU8GWDw1dGZwKR/Ijr0U2ZLleepk37LPSAS7PngXtuTXSUR4AVETFPHvDbzKF/AEE+t0Ec3ln19m+xbjsJdTUN5Y80Ab5DQZSftoHsh/BHAZs1ZS9LjXMgsE+2hhcGDC67T3d55DrdTkZXrwqJ3aZucxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782964687; c=relaxed/relaxed;
	bh=aIkQ8IN3xHbMywmSrDszmtgRl9f7AodSm2z9bwEdl1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQVmlNtIjG7UQbTBeouUUzzzratUxP15fqGj1j9eUP1lkou8yB+pEmEU4bsxj2cl7t2yx+rHdCV9MmlhHO87BGGPxiW6ZVf4Hg4BBeQO0iBpqlaaUGjBGBIwldFJGeDlj6vGRDUkz3RJ1/DNXPjKyWudTPI3K0n/6dlVznAH5Ac3MYoEicCCKEDE06mN9U25Jq1ehWma+ZnlR4rtyhpmG+eZd11tNqA9LQpIt/o2aP8P+t9TfvLUW59CmlTGtCqUuAjKhfE6p4ynpInN9e1pRmJmneU4O8ykCAuk+CgU0EAcJRGYx8uRMnqnVD7hhrmSo03RzK+Rr2zgKgGeoZHIrQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aRZQAINM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aRZQAINM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com [IPv6:2607:f8b0:4864:20::b131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grNQP6PPDz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:58:05 +1000 (AEST)
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-664d530fcfdso1699742d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 20:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782964681; cv=none;
        d=google.com; s=arc-20260327;
        b=kImpYCJ2js8awrAnYTpbFyREtd7vODcxfa7X1lkAPbZz5L8m8+S7UAYpFYJQHnYrMP
         DahneyafjQmw1/6HW0ezafoeKbvImXdIAS6cesuOA6NTLVpA9Tr08toSz+thICe2KaZp
         qV4zkOMw3a/NGIWrSb+c5TwgO+M+spSxjM4rzF8vsiN7b08/bqLE6NwttodctCzCh1gZ
         dGYDgyStVC2NcOVNWyO2I4ldYX4zlH6d0PGq26y584hY0xKboSe4+0mmujk+wq8aFuki
         ToyZUenhYmcrGNue1aBxpyCgV+9RBebRHy5dPWg9o+IoEM6lHLIjxsFYB0VGvWXhd8IP
         nbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aIkQ8IN3xHbMywmSrDszmtgRl9f7AodSm2z9bwEdl1U=;
        fh=aS5xvoVC/ZjVJzQMXcNaM5LYzIpNcvkDwJCNKWix/a4=;
        b=VwPb4DYQvDjzFLF0PbXIGzQxclgVUBEDm/L4X2sIE2tWmM21PTj1QoVL03lq3TdqfT
         s1qYbC2uIQMmMG0ow4KrGZab5FBBfpN5SRBn6PlkVMNesg22j2P4focrOGL8T0gnQWve
         DVCMdYH/Uk+yWSzYgKFrNJemGzF4JLtRXJkWaxNKUFm0mXZBvOKunubMS2kaBnO7VnY0
         oKdqSsYGEmBwOKy0UOlbzUuvsw+xWEVo2MnBopT5/7Jhwj1K4/ArbUv6OVlb0lqYHNe2
         nx6jhc2DOU0d9bK42b2EekQoFbKSWTKSa4AsaKSeKf/lLzDfqISfKypLzvXRBGDg4f9z
         okSw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782964681; x=1783569481; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIkQ8IN3xHbMywmSrDszmtgRl9f7AodSm2z9bwEdl1U=;
        b=aRZQAINMwFxlNNyoa1pcukEieplFyzcLRnMEJodylGtNZwls3PBc2V7sqX3NsmgSe1
         QHzdp2d/W0/JJ1da9tHnmJyi0yel7JIuh4NDQIEpq1j8/rlo9MRoNzbwT9cB2XoGVzcO
         ce6yPrz5S0DX7peN2JGE3htpAyOirTY/hIc6uErJ4o7t2ohuQR2WiGTb68CcbFpoqmqe
         /KO2rmf5cGXlTMv2r7orL3AJa3OSmsBs02+rNF0QKtwbvImVOU8aNeTVkrDynm+ai5rX
         cOJP80RlDKiupGntLdS6rL85gNg4J8oq9dVsBtWi4/YLf6GSS7BRXdab8o8GO4yQTGm1
         tP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782964681; x=1783569481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIkQ8IN3xHbMywmSrDszmtgRl9f7AodSm2z9bwEdl1U=;
        b=gNDEZARSElo2C3cHFmzPIhcpKwYXazmcJzHq1/QYopK+Aq0WBaq/PcbuPrBsJuoVAC
         ocavwdG5MrY57DXDpSaHdNqUXHXaSoS4tgDd4fZjIflZ8ONlwKFR/Dys6rPUjjNrNmMi
         z+PolXxgxlLo5Hb5zO1qbyQEg+PSbGvTuC3uarQ/LPmpdeLqU+WRJ9gxnG5bCqa8e1Kn
         bvOL/DQVgG3s4j5OxZs4FBqxG33SPwdbXVg1Sl8rI2UuMvT3lsyjzKB922ODHo1kHwD6
         lCkxx2CEfGX0mwvyXJUnCj26rISM/9lBgFJsBlVUIp3DA5u73UQCBgt/aVxMeBLuq935
         71fA==
X-Forwarded-Encrypted: i=1; AHgh+Rq794MVN9MKjJuQIDSYym7J83kcvO2iXyYfl08dLWBTCPr9Qd7EF+KePKJA5cAqTWtazc4z6XZ2TVl0DKc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx0DFSrPLPZXS2JBivJpjrQC/CyPVl99sNz7T/vHH9SP/Yn00mN
	b81BxLBXgJhBkOmB3ouom1qJzWLsIEif+RNOahr92sw0e7CetgYpe7FffBFbK7FLYsq5PVNoGAK
	Bxpa68A+IPWGU7MK24HsYyvXTWYc7Y1Y=
X-Gm-Gg: AfdE7claiNEmUgefu596yyauN56KZg6+wEHD6qPp2TAwoW99JuFoQnUw5J80rbhAncn
	rML6vm3YMeOZkKkfcQR8pyUgEGBtthbBpYpQstoSVXBVRv2uET5fqCJ68XORHhLZXPwylF+wrCw
	2viFKES/Xs75hXkiMuCppWtIICtFImZQwKudl7FQZbIerCNJxJfMqrrDEKr8Vip8VNdHkvIdBmP
	YxjgzqBc7UuBWce1tJfJoO3zuqzSAA8CUK1Gt12RdGYEY+dFhEHdFD7Neja8Z1lUZCBUg==
X-Received: by 2002:a05:690e:12cc:b0:665:47a:117e with SMTP id
 956f58d0204a3-66521a0b652mr4737547d50.21.1782964681219; Wed, 01 Jul 2026
 20:58:01 -0700 (PDT)
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
References: <20260701171851.2447626-1-ekffu200098@gmail.com>
 <20260701171851.2447626-4-ekffu200098@gmail.com> <akV-xN18Xtt1rmTL@yury>
In-Reply-To: <akV-xN18Xtt1rmTL@yury>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 2 Jul 2026 12:57:46 +0900
X-Gm-Features: AVVi8Cch3YSOH1Der7Uap-FeZ1Cbw9IWoIMZ-TnG6vsi7XGhuBGNUG4bo_6Bk9s
Message-ID: <CABFDxMGvQG++qRbh2UuDsRCX4910BGA+2j5+5jcm0hJMgSTSqw@mail.gmail.com>
Subject: Re: [PATCH 3/4] powerpc/numa: set node_possible_map from node_online_map
To: Yury Norov <yury.norov@gmail.com>
Cc: akpm@linux-foundation.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	Andreas Larsson <andreas@gaisler.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, 
	Rich Felker <dalias@libc.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Thu, Jul 2, 2026 at 5:55=E2=80=AFAM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> On Thu, Jul 02, 2026 at 02:18:50AM +0900, Sang-Heon Jeon wrote:
> > mem_topology_setup() intersects node_possible_map with node_online_map.
> > Nothing sets node_possible_map before this, so it is NODE_MASK_ALL and
> > the result is just node_online_map.
> >
> > In preparation for changing node_possible_map's initial value,
> > mem_topology_setup() no longer depends on it.
> >
> > No functional change.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  arch/powerpc/mm/numa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index f4cf3ae036de..2fdecae90a01 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -1179,7 +1179,7 @@ void __init mem_topology_setup(void)
> >        * that we expect to make use of for this platform's affinity
> >        * calculations.
> >        */
> > -     nodes_and(node_possible_map, node_possible_map, node_online_map);
> > +     node_possible_map =3D node_online_map;
> >
> >       find_possible_nodes();
>
> And in find_possible_nodes():
>
>          for (i =3D 0; i < max_nodes; i++) {
>                  if (!node_possible(i))
>                          node_set(i, node_possible_map);
>          }
>
> So, assuming the code reaches to that point, you unconditionally
> online all the offlined nodes.

This loop only sets bits in node_possible_map, not in node_online_map,
so I can't find how it onlines the offlined nodes unexpectedly. Please
correct me if I'm wrong or missing something.

Or are you talking about the case where max_nodes exceeds
MAX_NUMNODES, which was also noticed by sashiko? I think it is a
pre-existing issue, and this patch does not affect it.

> This doesn't look correct at the first glance, and definitely it's not
> a "No functional change" type of things.

Best Regards,
Sang-Heon Jeon

