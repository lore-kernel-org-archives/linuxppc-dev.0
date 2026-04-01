Return-Path: <linuxppc-dev+bounces-19179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD45B1112240
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 23:57:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmMNk1HTRz2yZc;
	Thu, 02 Apr 2026 10:57:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::633" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775087846;
	cv=pass; b=kvIg4zAG5MmkBYlMiUYRNhNXuxazwDf2Zwv4fdacvc55VRk1BCaN6HNUeFGQEf7ZRABhiYbVMowg9sMomeMQT2tZm8MFFg+dUqZ+Z0p3ANBwCqwKciKh38k6OJceYJE1NUfkRdm5FtQYDbDWvZMlW+bKfNOCKA1ObmCocIVynUMQ3Hd8FSy4uUyz14ixDZyLI1ZFb+IAG42qV6HC9lx2cpugfgjEPojq8zoxLEGEYKirf0P9C1EJtv7P54Zvw4a+6Pnak9nWM88Qy7dCLzkDDcy70xQ4Ai6awnsEzHPloe5GgRya+Jfo2/L3tjZAgKrNxk1O4cQ9nXzsW+bzAns4LA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775087846; c=relaxed/relaxed;
	bh=+yiYxTXLxOfXQvOdvEUmkYdhZ5w3GP+y15pVsuODCvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ce/+oB8ifCLPrWeKaquapobW7vxny2APZzo6jpMERQitY3CaFtiLbw0sd0RUymNzaSTdexh9JCKJMk8oTepc4pzKyLUQ7bOAA+eqaO/z+IH9Qh02rmhKj1+2OkvP3Ix1zUBk1kMAg8x+fimiTKNnUOIhjvAq1v1sp/wiH7ZvuWNl9nT1SR5s/sLcHw2xirRhvNWfOzXqLku7g/dikqQrZSg1V3uKeQgsBG03v0Gmf2JJYAod/VxcmCJT47EcpQRR/iBVRBKHbC8S/pnDTuF3QEp5iq7dn3zhu9ovajFtpgIPwGybm0GIAgFE0pd6AfdKUz6lcJ2vdgfTyOCjExTkBQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NZ5zb4bB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NZ5zb4bB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmMNh4YYwz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 10:57:24 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2b0b260d309so18805ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 16:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775087841; cv=none;
        d=google.com; s=arc-20240605;
        b=bUqmcY91/nk/Uu/vj/5aQVdXITy3rrhNpt6HM5ecvSvK6JvyMlSQmxGnT5FaPusyHW
         DNSjUXDwOatd3oGcF7yXdyx9rKf9OvUoartTq4Bf75nsg7+BsRlEmTMWtv/MsmEP1zZ0
         OYLG3x/DfwT5jV8FPTyWsV7dR329JbyixgTIZs8iwf8sGZCqXA6su3EX7LwyMZn+6dkD
         9eBHB5vaXgpGYF3SCxM6t6KAPdUKoXVAek8rudW4kgkM2BML7QcNhE0DEJ5OcHvieJns
         fW9rmze/xyBMWoVIl9I236fVhj2gLCi1gUCnQA8Q9KfkRzKd64n9xMrwNJy13H8wBYKR
         /dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+yiYxTXLxOfXQvOdvEUmkYdhZ5w3GP+y15pVsuODCvM=;
        fh=RaLsX4PZktZMEajDOwjYz1TLPHjEkAq7NLitxIN1VR0=;
        b=gVCUxHTHluuO+VTvIY9CDjvgkdbA2F0wY8edGVzvdWrwWeyFMoDmmQefdc9JxvsCux
         lMtNMni83OAh391VK/3NUao7AjD0tYLWAdhIXav/l9FuARU4wjdYGek+prZB/9+scCEn
         E3+HcSlwmMwpaALNMWBfvzpdtthfCKhpHzvne+ZL77AvfutWrDoHQDWeMqJNeQG6G7qV
         /krTj2xmZaLArccp+0lX5x6MYU0g/ybFPDMBe9Wu382koII2vAoQxG+VtvSxQHOkhU6l
         mUrnTnTC1jLt/KcWvFYhhbL5lNz2mlJHjIRdEMPveP1fH+p8pIbFc9591FFOOyGjHtib
         3ldA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775087841; x=1775692641; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yiYxTXLxOfXQvOdvEUmkYdhZ5w3GP+y15pVsuODCvM=;
        b=NZ5zb4bBIOjNvWfUibJL5NBez0Wp7qor3nsea/lRm0zp9BN1rShgNL2Pigyl0EmKDj
         6vc33bmxJrwHjeclqA/Mmozr8EnSuKcOdlobTS7aVumXSh+w3+QB+3TbXUw4aPvRpvD0
         6GVxr7kMg7BEzVCQpDU50jgZHnEN0QyMgq15NoIZGggnWRmAQw97aPzJiSTzhugzQAkg
         mAj9OMujESif5J+VhV0F8IxgXoiuN/vvx/qz2WtF9kIaRv/HbzI26DF3202GT704z9g3
         3+QW/Q4vGDuqyoGGO78JXZ5M3Wc/PoUL9V/KCgJ5NZgT7YvzkxCniTZIp6TTyv/1MKZt
         UlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775087841; x=1775692641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yiYxTXLxOfXQvOdvEUmkYdhZ5w3GP+y15pVsuODCvM=;
        b=PMfqCA1b3Ki1Hx4kw5uFqRtmsJ6pvR1s1fgEj8Ggp8N1D7MN1/+MjOf+lZrYjPC1mY
         pfLmbmzLiusSo5G8Pcm3VrSDDNuVei+1xuXIMRooZbE/LfU4FuIWvATIfYCfZAEtmRcc
         GLYP4ZWv7FjLxgkaY8tPQO2ksP2aLpWDER7vCT+nu4NxwmRhJUaqG5RCA1ekM9MnoMGo
         wjSMf7AceyFezetlGiU/RzmMTPb6mUG6pXe/w1O/+fFazi/FUJlBU9GptdrWojpM9R0Q
         N2okclF2NEONJSp7luEUAUU+pXkdmVUobiksO2XbejWM5gO30KiddmwyOrovy+ld3Owt
         oM3w==
X-Forwarded-Encrypted: i=1; AJvYcCVvKy4miB+I9hVhVQdjxRt2K/UGrbcZrWEVRDJD/gHDZmmcOjwoNK9PREkqe5OFiXO4IVFuLHJaMKTlZCI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6iedGev85gZP2LrUDBngaFRlSnLkwcm2ATraR3rkpehbow1R8
	6kx0aalILr/LboUyxR0ZTaP7J+bko4+kwUCP/EuIGNS42xYu8SBOc+FFfGVKSm2n3HqzbcH2EIF
	Ab1L9JYUJaBIJcG6wkl8h0FOaNuVNM4s/6kKk9XeE
X-Gm-Gg: ATEYQzyhu5ecNkqB+uvwFtG816pxiK/RMdVR0fLUsi62wdgcevZ7EO977hzeZknqFnT
	DVtKN1my0LxXqXsFAJv8pULmeGRzkKl0ThBHrXM+S0pRhCaZt6PJpYVJEH/HOiFJd+E/reug/ce
	rrp2vFf5s7CmG0+WJYKwqNn9lAL9S/4NvZE68aX25hPyoCwkwCM1WC0brSGx5SfzkASTZugU63S
	wm90HVh6dfW6+NI4umxnLRK7iYNSj6z2/LBa7CXgdtAnG9z8MiBl5JZ3DCJCQhGUxl9b5ON4kCC
	wdk8+vId70/sKUu0N0SqChvuyxUeoKLBYj1C
X-Received: by 2002:a17:903:340e:b0:2ae:44db:570c with SMTP id
 d9443c01a7336-2b2785597bfmr131825ad.12.1775087840393; Wed, 01 Apr 2026
 16:57:20 -0700 (PDT)
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
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com> <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ac2uvTXI1iknXwyV@google.com>
In-Reply-To: <ac2uvTXI1iknXwyV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 16:57:09 -0700
X-Gm-Features: AQROBzCmxblpzbVITcBH36ZAhv5JVLQm9qzytuKcyUK3dFPRFQllBd2wdk3wWeg
Message-ID: <CAP-5=fX6993MzAEgB7JeVEU5GcVk3PxhkEjMX3G4EZgxPBaBqg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Venkat <venkat88@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com, 
	tmricht@linux.ibm.com, maddy@linux.ibm.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Apr 01, 2026 at 01:40:47PM -0700, Ian Rogers wrote:
> > This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?
>
> Are you ok with the change itself then?
>
> I'm not sure what's the expectation when the test runs with a regular
> user.  I assume the intention of this change is running as root..

So the test is failing as root on Intel, and the log output is
extensive. I'd prefer not to have the log output, so we may need to
work past some known broken items. Otherwise, the change looks okay,
but there are inconsistencies: `grep -q "<not supported>"` is used in
the existing code, while `grep -q "not supported"` is used here.

Thanks,
Ian

> Thanks,
> Namhyung
>

