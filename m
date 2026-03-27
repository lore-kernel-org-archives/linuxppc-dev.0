Return-Path: <linuxppc-dev+bounces-18931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2406D10F285E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 17:32:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj75934Lfz2xmX;
	Sat, 28 Mar 2026 04:32:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774632765;
	cv=pass; b=V823qsCeObScmDM+lZa4bFyowbHR1fH9/iGxf5avv708zDRM6EiYpo0pKhnmhpK4AOqcNsDhYGzrvORRU88tTQ5LcyD66B0j5sPlS4u9EpecyZBk7uV7oeXoTXdq1FXacsoCmavpNr5cno8+Xa8LzbCyt8Nme/0eyfgAao+7iUGoKWuHigrQO5+b02EFxKFgQb2Od6nhX764wCysWtr0/JsOMfIAv2/0GhaUzsomcwcG5Ec8WqY766zXxAhSN6M6QqBLfPSyZ/MOhR6/Tn05fqLfz+zAyigPQPbgcyEa+8B9jjk08ScWsWNRdNfelO79pc426yEfFTkDv3R0IpBHCA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774632765; c=relaxed/relaxed;
	bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wrun/yU+Jeo5GV2ERXb2NI74ez7GoAjaogXbjKVa+Xas8x+MX53fNbhy6WU71kTpGzr2bldeDNCLrICgQ+UPcJrRCjTUnJxBrfNCWWTygkvuOW5p2GRMuB2kXKDmGhDeJOOWSfTklct0ENuQ+VUxcwaWzbfZfj6z8hQkM8tIJad+0YkEqL7Tz30MGvrv3a4BFf1CIfFb0xoLZEaFn2fOJbx9SEKmQVmweM8kSuDfmQLqznwTx0PSMNa4RCkwXCrCOK3p35D0D1gGkzN4yvx9ewtmks3bBTtlhN19VOKfd8MWgnoXz0taBvekqYZlzuNgDFKNLXNcEop39pcM7YBusQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ian/eaa0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ian/eaa0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj7573vz2z2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 04:32:43 +1100 (AEDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-509069a7a7fso41061cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 10:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774632760; cv=none;
        d=google.com; s=arc-20240605;
        b=QFlR5VSYKS/RbwBofLHllTSWpbutX/6e8YhOdIC3pgH8WB/cryvNiVU0tcX0fZi/dE
         FpAPtrSIfnjyroSjzaAUtJxYCcnfO4iSTahRiQxsg6pnTM2beXqf59Nr9ZL4mvff80wT
         FwrBGC+LWLNH0uvbdvb/dHLlIDChJN8vWUholTR8HYev7oAFP0bxSy3cS7m3pnfasWcB
         v2GOty8qhgBIzd8SashZiFhj7M3jzJ5zl12/jf+cSj2Yviv0ADfW9CV5Re8CmK2/V+0C
         PBXtbgIwMr+3XsvlJXfZ9L0t2meqZpXZ0tpFB+PbpEA2CqlKz8gLS+jXif9ImW6xH7YC
         nntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        fh=70jzXtM/5u8/wv5tmjArLtnhSPSQHVUmstLYJp3exHk=;
        b=D8ECXaUzSy+rr2JZZMe3752vy9Q2So1fFJCa7yz+S+emkwZj2ul/VHJWWYxwNtG7p/
         MSiqV183w0OvBXI73s9MAnqH9T9NbAwE7hXRLIuVuZxuRyzrvXsOezvYwBoE0wB9YLzD
         79rCnr1EHC+FDcH8BY305AsuiZTTcG6oVQflAwo+O5kbcDa+PfzN/J6Vst0R4VMFsVyx
         cAAbiK6IyLmy6zrDYUJttNQH2ATF3q6rKnb65MCHCkUd2Yt3qVXfDnIHDpzFDW/zNcXF
         nD8TJl5xTolxwGUyLMIkL+PRn7C+ok9PhK4YpxjQ2VNEAUUyYkhVX6C/qBdLt+IGaG73
         zXUA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774632760; x=1775237560; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        b=ian/eaa0f10E5wR+ig4k6aBLHrFJc9BVnsKP5IKVsCwCUMSNhWeXckOHTWvU4G3aU6
         quPN+PqXbLtX01SHJ/e2YhDFLuiH98wL2DzcjUaqwr35gJrz4wTIWBda4Stx+q4sNTth
         WKbu09+L6PiW10npST10Q+0ME91/jC7ZMVNSvi7yZwar1sUKPxr3R6YiJRjqu65JKiA5
         nWhraqhJppg0p0C7UugzxoCqc8464kppFgCjn5j5jxaB9bekiMXsYeTRgCad5iLvTc73
         7HpWERFcGea0OuOHPfLAx1Zv7vXMZhEuiFcTIjG6oxY9hvFnNU5CW7ni30XyAh4ur7Os
         BIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774632760; x=1775237560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        b=sPTPE6WJ0GYmk9s85yHOqYWzwPXQLnVama8l71/tyXPyerhxiuOUJGyQl2Dd4rL+iK
         oiMafHNAXnl/8hMpV43XDJRL9VvLBaVVFsXIJNCE8HZyPhb11XnLjmFZKc1avvXWRFUP
         zT21Q7A9dAEpdfdkUf077WBG8KhoecfHAKtI6NEtqX+pbXWT/d5fVls0QwvHr5O+R4Hi
         scQMDNkMDX/JX4TnPBE20CfvU9ANm75SqvrTPeAxBGfajWX3cxpx1bNoeLG7ZHd0Q95Z
         +jbCch6KHwtro1f9oUYjZylapugZGQrl0tl+wsNLhcK4FE+k6RSl9X8FKx8a6Ug6RDwE
         69sA==
X-Forwarded-Encrypted: i=1; AJvYcCXHX9v+sYHd3bFuxIoXYtbg37Vei1yMbPX7bM0sSiQhMM2G5ndoU/Qop3wUBd2RjMk6tkaomoOSm22OWZY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDnN2p0XbF6CS2J0CnQXB8cAgEXJVppe5vaim7YFmsRTVtr2Ha
	VFYvdJarvK+WpYiZ02Vp4YqhQhlcbKGsyl2tE3c6pRBULyBBcB78FDI9w13nS0RB1hOrvbu5Ipg
	8hBZNCSllye+YtnQbPu+V9cfeUhn46tuIY8U+rIPU
X-Gm-Gg: ATEYQzz+s4xLPAiXgN5vz0b9UZYbpMloA8fY6wGhtAxAtl9eDulvwNTDvx64i5WZnUQ
	a0sC8e7vdT/MU8phtSy+8OdQ9U1kdMd5Hvk3voUmGwfPfcr5BcJpreZB+MkJi08uNb9CjtQR4Ai
	IkyYDreoa1r9QLywWcocwTXrYsQZVu4a+K4Keb/rpzcFUsGwv1keLdr8hZ5qiuiLQQ02tn+jmi7
	LtPUTclgMr9R9mN2h24YGzdCvKnMiIc+A3ai0NjEJkajUeRj7jVG3n7Z+KkTTkb2txTrd5D6lw2
	voRs9Nd90kJTB2886AhVAHIMfDLaEqKkpJpc
X-Received: by 2002:a05:622a:8c05:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-50bb292f320mr200991cf.13.1774632758893; Fri, 27 Mar 2026
 10:32:38 -0700 (PDT)
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
References: <20260326080836.695207-1-surenb@google.com> <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
In-Reply-To: <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 10:32:27 -0700
X-Gm-Features: AQROBzCNRgKBqW9q5PX49UYqB837bDipJe3mVx90Rrm9LZ-wrkWrRewJtwtbwBQ
Message-ID: <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
>
> > Three of your patches lack review tags so now it's 65!
>
> Three is now zero, thanks Lorenzo.

I just finished fixups for issues Sashiko flagged. They are pretty
small but important. Testing them right now and running Sashiko
locally. Once done I'll post v6 and will ask Lorenzo to re-review
those specific changes. Sorry Lorenzo, I'll point out the specific
changes I had to make and will try to make it easy for you.
Thanks,
Suren.

