Return-Path: <linuxppc-dev+bounces-21663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A02CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 19:44:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRH4d2LJ2z2yVv;
	Fri, 29 May 2026 05:44:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779997473;
	cv=pass; b=b9hVgB+Lon2hAvWj3xt5Dy+wCh6Qz5z1+phoovBi2GThOdKesZEFaJzIfaZOKJf/Bzuvf+v4N3PgtQHoRo6cwuTYnefbwbfuH9ZcOj44Y8uVM0IZM8ZQ09OEsrJxMcQzbMuGp6rywlXqG6l4qUjLxM+XFyivTcOuG1jChAaPxAGdIGhuY392ArRdN8CXEWTWbtYv0WlnmrWW4lnY72fxOHwFi+F8EZzAMxCZ90fgnAbywvCOI+WlRGL8B/M8hU+NQirYa79csWfTaB2VX76h/ubzfPyYOtqWo4s9D+DSQDX2nEE6NuWJle/cy9DmOSy+xpH2JFQTqTXrZohwTFEuPw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779997473; c=relaxed/relaxed;
	bh=8IynHu/DX5NF0G96SeXwK1qnUut5hZzt9g6fKpDU65E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOcBOT1oN7PyBkVbzj2E0SpKkh70j8wZ0PGkJqcpnl12H9i93gRmORNM8SOWOAG6U8HADCSpb01Ci51T6b4OBsi7fWdFhQIm9fn88SG+RgMfS0PUx3gwbVtoBliyZdCLGP+Zz0ZBSCv4jg857eYJz38Nvf2Cr7Hgkk8CtZKfM/hiGWUHRNfe80e5aB6keQ7tVBblCVODvbsrTNMNvK9A7iUPJG1GDNFaMT7ZWFiwOomAfyVq7s03NMMyLF09vqEVHsQvULXsttOC9Bbx5YoWNBymIXOGbEJlPTKy8/julnMk62rLtILWHemtHD3IMLzPNJidoN0q4rqJsi4xr5IQiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=k2lGiNhy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=k2lGiNhy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRH4b30b2z2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 05:44:31 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so625ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 12:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779997468; cv=none;
        d=google.com; s=arc-20240605;
        b=jaD7PbB1Pao5h3+QmudaqiZR5+4hS342B9G6BdKgQug+q+L8HD9DHozeyLUDRraXZ4
         SzGNnbWDoGqTOVBLr0MH1b49lEnuv1hem/ChBqBkA/KElMxjCzRTFReumPmgHcB4N3g9
         sDeYY6fHMny5W8pFJqiS+GE17ndyunRu+BJkwwb5ZVPURAngVEonvvVcrqUqNrHpkaA/
         d3WMgpTyRBqchYfKotubBg4xkOL6K0v2+ZKP3oqckG8N3nLufP+biEHnzgsz3Vm+Xkeh
         JlPSfjHIjkvc6toIKg1Xdw1Y30XNnyuiNd0Vg6K6UxP5vAp3SLrS88QZ5zTjpNsoX7HR
         A63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8IynHu/DX5NF0G96SeXwK1qnUut5hZzt9g6fKpDU65E=;
        fh=3NTPE4BvyHVTOi/WQlm5SIiAnxS2AOpFT78c+yJqwuU=;
        b=O+WCv14QL84HYUiA+0C0AnB4pvCR1L/UrAgUzGmbhVEEjAjTHyE7SSVG5LUR7dFYab
         /DhNAGB3K2BkDm58ekwK/SxJgWEwQNM3X6lzklkcTae7L4g2kMWmuhRdlFP1WaBlyr3E
         WPtxxwXMUznv0d39U6mzpI9qBBg9/SMookks56oM8/nvKIN0h14691ZLeM2x2gprNnwa
         IkWwKjfB+NtAG/RZmJFt+e09VDv2Z6Xh9dZmVH+JzpfqwyiNOojswrAmmrTYmc04ko2h
         SBQza6gksoTDdNkuwxHtd6cGN85eIxq1zDGAHTEfVDIAA1Dd4EACsbXRInagYTcbv35N
         8vxg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779997468; x=1780602268; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IynHu/DX5NF0G96SeXwK1qnUut5hZzt9g6fKpDU65E=;
        b=k2lGiNhyD1MFuCgAqsWT/t9ronXatp1x3TvOg2EUlbLRYpDPwkTDW6srCpIqpU83L4
         kogNiMcPGPty8ppBH8mq3dnrKymXaQvs6Od9fZCXdkND2myCbhv1fShQhSIG0W6RvOyC
         lU1TDUkt8wynlkO/Jhu8nuBU1p6ErIGrUlmRF0GoteGf7qnb/BbLdCscxIvKLCtQuJGp
         lHlxc+a3QQzn+QaBX1jzUrg7AAQpeucxipKqzZ2OIp3k2FIXIklbBnzLljQD2fETNauG
         KiJd9AJmzJkzdILhElsteJzBda81NL/mLpf0qp2DCMynZiO911bUymkmjoLSqVwRLf/r
         JKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779997468; x=1780602268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IynHu/DX5NF0G96SeXwK1qnUut5hZzt9g6fKpDU65E=;
        b=is049Dx+nPEHEAoWutwOv+FsMF5pl0cqO/CmwM78nIGdSJ2eJkf7kgBQmfwu8wlwFx
         m2uuwHOqq4O7Tj53hCmEoPVotSg7RBLgEMWjNT5hCb3qwWNn3qLBsw3HZxGNohrHdai0
         Y/TUR8jHnpn5uYh0stjcG7wxaoqIA6WLhEpq1BvgtWSKoo+hr4gr4v4BsNDFdIbR7Wq8
         hnqwstPVPqtjDrJTQuckM9xb2CzxyIF2+557i0jH8z4xJAB8cQphWpapjpvL2mISqJpc
         IHGobEwzdfWgySnwyYt8OQcOyAAbh6W+2LpsWQmnRoLQuexwZQHauvBxHM5ttsKTNpOV
         kNYA==
X-Forwarded-Encrypted: i=1; AFNElJ92T8tIY24oRlMlO5IbUWyVIXq6UXN6t9v1Rh2v/LjczJ0kpmkk9l4bqfxrS8x8qcNc07LGOYTgqaN2me0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxSMGUZRAN0EQVqa5C8oovldgALrvpQHCQrKLgIcuvENIT15sqh
	l4QggrO6+aOWz42LhagxjqmG0rFeEMjLlo0QFy/Icc/Oe36YZO8IzfSEzy6WMbzb4VZGhDJ2VC/
	kx3LA7RQmqAepnct+Rbdt1DwuqnMDTkTUU24/J36p
X-Gm-Gg: Acq92OFG3FpWo85yQYZGQ+iSOFCuUanLgh92Xb3aaGeV66VcQ5N24fRRd/mjtJYNGM1
	2D00n2iW4pfcuZzkXzBhirzGGTJfZbKTUX7+nW1uGox/8GV5aLYtYf/0BM6OFPMz0jnwVWvGdcw
	kRv0456U6/T+ZIvzWHwc1Xd7e3M+9k7Dw7zq44Ev8Gykf7rCUz0ZGCQcFvNqKoy03Lo3PjzSbkE
	J3lpkGHA8a9+U/ymrqyLAoNUqvXxL583oLuo27mQERMYBoM1+9Z+3h7qu1yZdlYADuMNjsgDppl
	28QiGB4FzkNwAKGKj+w=
X-Received: by 2002:a17:902:f64b:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2bf1fb9d40amr92235ad.2.1779997467341; Thu, 28 May 2026 12:44:27
 -0700 (PDT)
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
References: <20260528183625.870813-1-ynorov@nvidia.com> <20260528121806.2b54606ba6e42f7f371d95c3@linux-foundation.org>
 <ahiW5LKLiPMC6il_@yury> <20260528122903.cf74cf905418ab2d144607c3@linux-foundation.org>
 <ahiYUr0dO_dhOHTU@yury>
In-Reply-To: <ahiYUr0dO_dhOHTU@yury>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 May 2026 12:44:15 -0700
X-Gm-Features: AVHnY4KU3_bl6PIogc_loULa1uZ5IugP9iETmiYVnKICvK-frgUxDB4nRARXI20
Message-ID: <CAP-5=fXXg+PqH7EZ8X599CKYFWCwQgyH2H-4-+5M3_b9w_dTNw@mail.gmail.com>
Subject: Re: [PATCH 00/16] lib/cpumask: get rid of cpumap_print_to_pagebuf()
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
	Jiucheng Xu <jiucheng.xu@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Linu Cherian <lcherian@marvell.com>, Gowthami Thiagarajan <gthiagarajan@marvell.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Khuong Dinh <khuong@os.amperecomputing.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Ma Ke <make24@iscas.ac.cn>, Chengwen Feng <fengchengwen@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:32=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wro=
te:
>
> On Thu, May 28, 2026 at 12:29:03PM -0700, Andrew Morton wrote:
> > On Thu, 28 May 2026 15:26:28 -0400 Yury Norov <ynorov@nvidia.com> wrote=
:
> >
> > > On Thu, May 28, 2026 at 12:18:06PM -0700, Andrew Morton wrote:
> > > > On Thu, 28 May 2026 14:36:07 -0400 Yury Norov <ynorov@nvidia.com> w=
rote:
> > > >
> > > > > cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" not=
ation
> > > > > in printk-like functions. In some cases, it makes people to creat=
e
> > > > > temporary buffers for the printed cpumasks, where it can be avoid=
ed.
> > > > >
> > > > > Get rid of it in a favor of more standard printing API.
> > > > >
> > > > > Each patch, except for the last one, is independent and may be mo=
ved with
> > > > > the corresponding subsystem. Or I can take it in bitmap-for-next,=
 at
> > > > > maintainers' discretion.
> > > > >
> > > > > On top of bitmap-for-next.
> > > >
> > > > Sashiko doesn't attempt bitmap-for-next, so it couldn't apply this =
series.
> > > >   https://sashiko.dev/#/patchset/20260528183625.870813-1-ynorov@nvi=
dia.com
> > >
> > > OK... What should I do about that?
> >
> > Rebase onto something which Sashiko *does* attempt.  Mainline, a few
> > mm.git branches.  Maybe linux-next.
>
> Is Sashiko a new mandatory requirement now? Documentation doesn't even
> mention the bot.
>
> > Roman, is there a list of trees/branches which Sashiko tries to apply
> > series to?
>
> Hi Roman,
>
> Can you add bitmap-for-next in the list?

Fwiw, you can see the list of branches attempted and the SHA they are
at in the Baseline drop down:

Baseline Status Log
tip/x86/core (0f61b1860cc3f52aef9036d7235ed1f017632193) Failed View Log
powerpc/HEAD (6916d5703ddf9a38f1f6c2cc793381a24ee914c6) Failed View Log
chanwoo/HEAD (7fd2df204f342fc17d1a0bfcd474b24232fb0f32) Failed View Log
linux-arm/HEAD (dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b) Failed View Log
linux-pm/HEAD (e7ae89a0c97ce2b68b0983cd01eda67cf373517d) Failed View Log
linux-fpga/HEAD Failed View Log
pci/HEAD (254f49634ee16a731174d2ae34bc50bd5f45e731) Failed View Log
linux-pm/thermal (21c315342b81526874acfa311f11b3f72bed4e14) Failed View Log
rdma/HEAD (67464f388d52ec172be62c99fc43697437ffa384) Failed View Log
linux-next/HEAD (f7af91adc230aa99e23330ecf85bc9badd9780ad) Failed View Log
HEAD (917719c412c48687d4a176965d1fa35320ec457c) Failed View Log

Thanks,
Ian

