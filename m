Return-Path: <linuxppc-dev+bounces-22028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2ECCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:16:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQ7z1xcmz2yRC;
	Thu, 04 Jun 2026 23:16:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::630" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780558366;
	cv=pass; b=mCSXOkbdjRM2cFWqmWEwTpPQtL/ump9CrqjLV+u1vye4/tPJtNIqGJRw+aMPmzzKfZl7//GGMMps0ZrmUDsV05JSWH1NdBYC0ijckknvMExaCiwVQttvCpXvK9CJmboguMpKrf4tbT9OAbuxJrcI0jszqhKmYGIaPWcTzWZYY/kpcyGLaeztHDWhRBJVwK3vP1Blgk8J4CB/y8pd1FMl1QFQ9JIKfTfGe21rLy7Fz9SSiYFo4I4c6tiFKy/45LjTNuF97iFAalVGy21OKaS4ewNB1lZeZiWNRnSpI40NuV3YbKbNK5irlPJYorgCS/+yewj7k/GJeyfOx3lVhXQgnw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780558366; c=relaxed/relaxed;
	bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6hQ8Ls0isgANsOs6R2lZHRjoNBhOoxCNcuv5/U5/PkjO1hUwrIxrsMlSgzDXzsz34fi2yjL8+z0CLCs1UY6SlgUKP5zVz5ovlhZfOSdKqAs5U9EWNG+hqSzuokGZtt9UHI53804YK7+s/dlaWopex8/aFbip12V4f06ejAil6c/b8xtK2VYFf/NbNiPawGULHKtvfLLVEEnMm71ZtKnqfaWcvE34UnU9ODW1YI+zMK+O64mbDm18uhpj71Hv07WB2SzBItZilOP7d0k/q6P45tIeSnShvx1OBvWR3SZFrLUaVlhZgMeHExgs7CEPC2sBq5FHVvouiFgwf6AKly0xA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t2gugRVy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t2gugRVy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=sumit.semwal@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWGW111b2z2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 17:32:44 +1000 (AEST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-bf1cdcfd6deso35949466b.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 00:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780558361; cv=none;
        d=google.com; s=arc-20240605;
        b=X52X5QQ0TFFoOh7rs9x/IOInGRHkkQZWiE62YPr9wJhEbvHP27alkhk/u3u0Edmil2
         TnzynAz/PKXyD9Y/Fastf7XbGsI+TDiPMyRWQj/3UJDV/P+Na5PW5IJraVfJhpb+N6Mc
         bsRWVDS1YJvxIbg6iDiiRoX+DNFz2RIxFMaAvAXFOMdZlb5DGVlZsGOtcLzmQpvkmkFc
         kZM/q+1+iJmaxxUiZG4LL1VcJCA+ygJuwksl1MWQXJfwKicAAopjCWba0fZxDhY835s0
         +WSqttnf0VYrl6L3Dr1gYI9fH1eOkqWZpyIs5OujW4r35PY8l4d80y29i9umuwLEHwkF
         qYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        fh=m+AqQSAAulFbk/NL0dhTEWA1rdMDRZYQuUA5BOdskwQ=;
        b=U0WixxG5YBJ8M6iMXpbw+TkCqdpH+efjlLjL44pwokXUNBs5bOJQwRk546Z3TwCxGe
         NdgLfdebyqlF+QsDq0FwyxYRoLG5oZBucS21JeU4O5xteYnnT4+D5EF0DIDhGyf0XoU5
         W2/RI/hLBcD2jJwieS4/kDpPT6OZVQuwBk2MAZVvMHYfVzT3SwT0FsrNeTtBbaFXXfn1
         ZpCTi9+TMAMkRncLPFsQtFAOJZzxcnLa9FwOserp+/zJycfKl4SOSi/0GJS9v5bigDpg
         rsk+QfJRSVQ5Y0FZ2h+rd3e6NgTP1icGTQOhGaQ5ax+94ijQxIWrKwsb8rXLM/322p/z
         ddEA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780558361; x=1781163161; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        b=t2gugRVyR3HW8obEdtClB/TWbV4ltoWYNQwNDGbeADSN6YhAzb4lMPpS+6S0ma3o2L
         c+VHjGgz4bGENQUVXSbMQROOMg3RNMB4XjcyaegNrKo+v2LykJ/L6voH/2TA5aSt8vWs
         VgWMNEQ4VIGSS3edFQgeyH2qZH6ptS0DwRfdR6oOE8Ar+foy0xGe/g6ONxC3HawbNnau
         evwptM8Q9VgFJCYiayUT2L9JKBKQx3DMruFPkIL+11A7wK32288tdVjfirVB8p5nwdRN
         +fta3EaDJzPv7rnFO+k5bD5Gtdb/fhL5cLda70/d+wEoSrG1s1DM2HbfEHvjG02OBF9P
         HRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780558361; x=1781163161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        b=nUYKgkI1acR4ih+yfW9SkT+UAsUY5rJf7zc/dbOFfTKTJ3YwVoi6Fs9I8wF6fVWCOe
         tC60BZw0y/pfUkYvmmofIyZ8WCE/HDeNPFKknlNCBHbExisClNBoS71akL5xXHkhDt3D
         W3MsONbZPpivcZAm/XjzKWdOBiYjwMtZgKbyY29dJSO3QqVcRiTYRzb8L4TnVWoahYww
         Pfm2Cv213dmy+P9LZtGGXRbKvWke3O4O7pEOCnuEIO1La+DKPoLJJc8d96gQ+nPn2TRx
         CuTrvx4/HA9QNIDEXqOtjm1i92ZXe26C+6I9kpCZbCSci7U2qxPcoy6UyVidA5kVedcu
         xKhA==
X-Forwarded-Encrypted: i=1; AFNElJ+7043Jidjn53b6sTHYEImuSUNuAAAtW/37YTuZUyNopDrBP1xDJEQwDMuaC3mkWeniK41hrkLxyVi/rz0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzGFajte/uvWI7/OVQUvn2z2UEhmVisWE/wEOYi5Ks8tjXwLXxi
	EOY8jmH6wUUkn0mlFVrslEqUBUk1I11gEtbYJdIJFnoxaCAKMurnQvjj8AMOa2WsoolCmUSsNc3
	AVnBjKoZrj+Kth35/xM4Fzi4ucXfBpx4o5L2OR6UXWA==
X-Gm-Gg: Acq92OEBP9AiGqg2ldhTjGhRzI7hThvrGSSFC+7/ezhQ91T1apwbkGkLnk7JSWc9xEV
	3e/SF9g5QwuOoN92SgZB1hJphdqDzg5dxsc+tBah7Po4F0ifWLYbFezQSc8VBx0FfgYyCpfjTvF
	uR35xMIPTmZrkYoF/j8zJyDPqA82LiqRUNvcUVv+fmoZiJvxAtKSzPFCp/bg+uC1q4KLyO4wpCY
	omCyaWe4yx3bG1QrHzKV9No7D8ZjCPL3NSpU+md9AnjemF8+0WvCucPuKFeTPNA/NiR7l2jK6nv
	X5l7Jy8sk6fGT6ialUjLbJPQHJj7tSsKPqnG9E0VDyhvf8Q=
X-Received: by 2002:a17:907:8e0e:b0:bea:4c91:fe88 with SMTP id
 a640c23a62f3a-bf0ad204057mr309239166b.18.1780558360935; Thu, 04 Jun 2026
 00:32:40 -0700 (PDT)
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
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
In-Reply-To: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 4 Jun 2026 13:02:28 +0530
X-Gm-Features: AVHnY4Iu3YbvJ8smZ2k5Oglofp60PZLnbqbe_g3OJ5J_F-575g430amKBK4ebP4
Message-ID: <CAO_48GGCdU6znkdHW5gns=s+N0wtNAq4U8s4OtLEyW6Y73oMUA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>, 
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	lkp@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mm@kvack.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 12:51, Sumit Semwal <sumit.semwal@linaro.org> wrote:
>
> Hi All,
>
> On Thu, 4 Jun 2026 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > > On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> > > > On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > > > > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > > > > module") the system dma-buf heaps can be built as a module. The
> > > > > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > > > > but those functions are not exported on powerpc. This can result in a
> > > > > build error like:
> > > >
> > > > I'd much rather revert the above commit.  Yes, x86 has exported these
> > > > since 2017, but that's a really bad idea, and we should fix it instead
> > > > of spreading the export.
> > > >
> > > > Setting memory decrypted is a dangerous operations and should only
> > > > be available to core code.  We should have various allocators for
> > > > decrypted code, but not export the functionality to random code.
> > >
> > > At the very least an EXPORT_SYMBOL_NS.
> > >
> > > Looks like there are about 3 modules using it already..
> >
> > So, I'm not really sure how to fix this now. Should we revert the patch
> > making the system heap a module, or should we export the symbols for all
> > archs?
>
> Given that Christoph's objection is not really about the modules part,
> but that the set_memory_{encrypted,decrypted} should not be used here,
> one option is to revert 78b30c50a7ac until that issue is sorted out?
>
> Jiri, any thoughts from you?

Argh, I'm sorry I missed that some modules are already using it. I apologise!

Christoph, is there a way we could accept the symbols export for other
archs if the arch maintainers are ok? Heiko seemed ok for S390, so
this needs agreement for powerpc.
> >
> > Maxime
>
> Best,
> Sumit.

Best,
Sumit

