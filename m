Return-Path: <linuxppc-dev+bounces-28426-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3259CA5FAB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:58:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv0CV5Q3Fz30P3;
	Tue, 29 Sep 2026 10:57:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790643478;
	cv=none; b=fJa1EBOzAx36PBjaIeJfuH3pxHmtLCPvg41bIkqVmcCQfSXm3OQZ7MpXpUTrTh4vn4Fze6PaSjyOcmfWja737+l3gD/epe1+2q3oDrJOsPrRQDYJerQoHifGD+1aAi9N4u3ObZND4xn3LFS7NYMEeV9+fzq471HNqRtbRDX2F0aXruZRM4EmUeq1L/3Nf9WpyOBVP+R0W0fTCiTvyJbsOogYjdWoAhkRUx2vpHZD7NYHmJeh4mjC0fKS1mujjjlPoqHFiQMkqg9EDDWpayH+n4VIKWWbSeO/6tnO6Pup4W2yTFDK5Zr3mwvYKJYLyNtJtSJr2gyqtYv4rRCcfqJz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790643478; c=relaxed/relaxed;
	bh=5hh3I/m4orWpsUVsDP4+Yh/0I6vIU4pHHsleLblqGjQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DaeIqN10Vn8PnH+zYXsjPjSQ6x0gjmJDU2JBJz65EQWF8IYE0KgRNs/75ZYoIQWj+/E1rB+KXz41f32ksKkGThysi50HV5noVfNWgwQn8xmMTqoeqeqw8VrMtYm+2A31dl5omgAiAzKFGD5Ql/t9lwxRCdJycWVAs7HamptSk0wXrwxh7VfmWUI7rj94KaPrdM0XzjSPGEBluU+40EkqUTEqfAazdRcI2ey+4eV5nDgC7BUNOKob5SsH7bJImG0nRfAqRI8H5Jn3GyEYcYvgQ3jXuIHIBTXF31VDfWRbLVKRRdG3fuQdRkPnaRkWU6MD/jGDtBVu9fprNLcfO/lmNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N28GiIEP; dkim-atps=neutral; spf=pass (client-ip=95.215.58.97; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=N28GiIEP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.97; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-97.mta1.migadu.com [95.215.58.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv0CT25WFz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 10:57:56 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=5hh3I/m4orWpsUVsDP4+Yh/0I6vIU4pHHsleLblqGjQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790643457; v=1; x=1791248257;
 b=N28GiIEPRF1vGiZ81ffZ9p1faHc1blJESjVHFUFEplNPEdUvXGvJ2X1suy0kKb3vmRHNpNZC
 K6YeiNhB9bGJ9huwLcqk7WRi58rszp/MN9kwOkH5AxT5WWdFwJH5wwV0zLdAqS2E323fzkRnJ+y
 /0TEVKGLSq2QBaUCAx5teD2E=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id 318fa190a6eb30d5;
	Tue, 29 Sep 2026 00:57:36 +0000
X-Mizu-Trace-ID: 318fa190a6eb30d5
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v2 0/6] mm: Unify device DAX and HugeTLB vmemmap
 population paths
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <se2tjmpk.ritesh.list@gmail.com>
Date: Tue, 29 Sep 2026 08:57:16 +0800
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <655A7615-5885-4733-9E4E-3BDA1FE39362@linux.dev>
References: <20260924075259.2013039-1-songmuchun@bytedance.com>
 <607759bf-59f2-4ad6-b95b-e780ed2acba3@kernel.org>
 <8385F749-0F72-494E-9CA2-2E433A066712@linux.dev>
 <se2tjmpk.ritesh.list@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 29, 2026, at 01:43, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> Muchun Song <muchun.song@linux.dev> writes:
>=20
>>=20
>> If you're planning to review this series, I'd suggest waiting for my =
rebased
>> version.
>>=20
>=20
> Hello Muchun,

Hi,

>=20
> Thanks for taking care of powerpc side of the changes. Is it possible =
to
> share your git/github tree somewhere? Sorry, but it's hard to follow
> which series is based on which and the overall multi-series is based =
on
> which upstream tree. If you could share your updated tree somewhere -
> that would make my life simpler.

Thanks. For now I'll follow David's suggestion and explicitly note which
MM branch each series is based on. That should make things clearer early =
on.

I'll also try to set up a tree later and share it once it's ready. Until
then, let me know if a written summary of the branch/dependency order =
would
help.

Thanks for bearing with me while I get that sorted out.

Thanks,
Muchun

>=20
> Thanks!
> -ritesh


