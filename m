Return-Path: <linuxppc-dev+bounces-20137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E269FF8850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 01:51:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3mkh0B5mz2xTh;
	Mon, 27 Apr 2026 11:51:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777254683;
	cv=none; b=fJsGvzPtpPYOprRnwEnO+EncIurAUwQQILmTj0/788y6L4QkHK4pmAXnwoguHJKMg/4+k/06mmy1Wfb/7WrDAFsm/VZHgCmI3w40LbB5US+aArZjIY9Sa9Zx/lotqbJ53XhHw/fFdGcz5kRjEpc/tIXM6/BQv4fRi9wv+tZcrQDlS93PQo2CaAh2D5awzHgiRnkUfCXwjpiijq2j7borbqzYAc6kEanEvjizP+kGQtTO0i51EZ8Wrt3J6mllGSfcvEXznosjGAJxOj93Fv2O5o9vUewC9OCDzlNhLU1rtfXtC+aEJiG5UfDCwDaurh8CONk46InR9NQjdmQNcIfzog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777254683; c=relaxed/relaxed;
	bh=5ILvVMY9IinAdmagfVEGFpLv9wga0zWj49+q4fH7Cbs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=RNvqM4bOgRJwPWzgym9mDotP7tHHbwcwpOQtfPq4kt275DK5yclCVm0hIc/GY86P742/2GeGwv3eTBMwTM8RF5U2Sxq68vWkO2uh2ufiERvuzBV3pKm+Gr8ev/Kl5pfnSb0imIqEF7yb5JO6plHKsJzqpQwDCHxTXsLLLiBggG3/fS34bR6lcg/kg7JHVwbRYh+Ggej/Rlhc+3+rPup3HwhweLaWQyt4543Cf20rz8bopq4nNllYiIHbYdrSFXIHnrlzP3MEHCCR8dVSH2Gz566fIroGLhrbE7oxx5DwrENHM6jBbT8ErJlYcOHCl6PrqpoZE27syql2JxEBg3MZ6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZJIyZvDl; dkim-atps=neutral; spf=pass (client-ip=95.215.58.180; helo=out-180.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZJIyZvDl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.180; helo=out-180.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3mkc3Thzz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 11:51:19 +1000 (AEST)
Content-Type: multipart/alternative; boundary=Apple-Mail-050A2CCA-0B25-444E-BA9B-12E28AE2505E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777254658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ILvVMY9IinAdmagfVEGFpLv9wga0zWj49+q4fH7Cbs=;
	b=ZJIyZvDlFL8EkayOo3eQtFY5LXrE+m7TDlJJmDBQzf7BrJgx95FnAd+AwFcOM58twrSDie
	1DIyRtZp+dNLLMRod0HMAjWIIx0jTT/n0ZURNh5g9g3srlXBDqt7brWnNNogIyPIJkazcL
	LFUAHGxOKk8/twwDWJyMG2+LvRAzM2E=
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
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
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 0/6] mm: Fix vmemmap optimization accounting and initialization
Date: Mon, 27 Apr 2026 09:50:18 +0800
Message-Id: <C8490179-1774-4051-B4D1-46F97841317B@linux.dev>
References: <20260426125422.f9fa79ec47db2e552d75e29b@linux-foundation.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Liam R Howlett <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com, joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260426125422.f9fa79ec47db2e552d75e29b@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT


--Apple-Mail-050A2CCA-0B25-444E-BA9B-12E28AE2505E
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> On Apr 27, 2026, at 03:54, Andrew Morton <akpm@linux-foundation.org> wrote=
:
>=20
> =EF=BB=BFOn Sun, 26 Apr 2026 17:26:34 +0800 Muchun Song <songmuchun@byteda=
nce.com> wrote:
>=20
>> The series fixes several bugs in vmemmap optimization, mainly around
>> incorrect page accounting and memmap initialization in DAX and memory
>> hotplug paths. It also fixes pageblock migratetype initialization and
>> struct page initialization for ZONE_DEVICE compound pages.
>=20
> Thanks.  I'm assuming that none of this is urgent, so there's no need
> to fast-track any of these fixes into 7.1-rcX?

Not urgent.

>=20
> So the cc:stable patches will be offered to -stable maintainers after
> 7.2-rc1 is released?

No problem.

>=20
> Sashiko might have found another bug in there btw
>    https://sashiko.dev/#/patchset/20260426092640.375967-1-songmuchun@byted=
ance.com

I see. it=E2=80=99s a real issue, but not introduced by this series.
I=E2=80=99ve sent a separate series to fix this issue.

See https://lore.kernel.org/linux-mm/20260426144447.817722-1-songmuchun@byte=
dance.com/

Thanks.=

--Apple-Mail-050A2CCA-0B25-444E-BA9B-12E28AE2505E
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html class=3D"apple-mail-supports-explicit-dark-mode"><head><meta http-equi=
v=3D"content-type" content=3D"text/html; charset=3Dutf-8"></head><body dir=3D=
"auto"><div dir=3D"ltr"></div><div dir=3D"ltr"><br></div><div dir=3D"ltr"><b=
r><blockquote type=3D"cite">On Apr 27, 2026, at 03:54, Andrew Morton &lt;akp=
m@linux-foundation.org&gt; wrote:<br><br></blockquote></div><blockquote type=
=3D"cite"><div dir=3D"ltr">=EF=BB=BF<span>On Sun, 26 Apr 2026 17:26:34 +0800=
 Muchun Song &lt;songmuchun@bytedance.com&gt; wrote:</span><br><span></span>=
<br><blockquote type=3D"cite"><span>The series fixes several bugs in vmemmap=
 optimization, mainly around</span><br></blockquote><blockquote type=3D"cite=
"><span>incorrect page accounting and memmap initialization in DAX and memor=
y</span><br></blockquote><blockquote type=3D"cite"><span>hotplug paths. It a=
lso fixes pageblock migratetype initialization and</span><br></blockquote><b=
lockquote type=3D"cite"><span>struct page initialization for ZONE_DEVICE com=
pound pages.</span><br></blockquote><span></span><br><span>Thanks. &nbsp;I'm=
 assuming that none of this is urgent, so there's no need</span><br><span>to=
 fast-track any of these fixes into 7.1-rcX?</span><br></div></blockquote><d=
iv><br></div><div>Not urgent.</div><br><blockquote type=3D"cite"><div dir=3D=
"ltr"><span></span><br><span>So the cc:stable patches will be offered to -st=
able maintainers after</span><br><span>7.2-rc1 is released?</span><br></div>=
</blockquote><div><br></div><div>No problem.</div><br><blockquote type=3D"ci=
te"><div dir=3D"ltr"><span></span><br><span>Sashiko might have found another=
 bug in there btw</span><br><span> &nbsp; &nbsp;https://sashiko.dev/#/patchs=
et/20260426092640.375967-1-songmuchun@bytedance.com</span><br></div></blockq=
uote><br><div>I see. it=E2=80=99s a real issue, but not introduced by this s=
eries.</div><div>I=E2=80=99ve sent a separate series to fix this issue.</div=
><div><br></div><div>See&nbsp;<a href=3D"https://lore.kernel.org/linux-mm/20=
260426144447.817722-1-songmuchun@bytedance.com/">https://lore.kernel.org/lin=
ux-mm/20260426144447.817722-1-songmuchun@bytedance.com/</a></div><div><br></=
div><div>Thanks.</div></body></html>=

--Apple-Mail-050A2CCA-0B25-444E-BA9B-12E28AE2505E--

