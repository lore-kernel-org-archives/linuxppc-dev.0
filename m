Return-Path: <linuxppc-dev+bounces-23043-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8378C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2026 17:49:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gng6926Hmz2y71;
	Sun, 28 Jun 2026 03:49:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e2f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782582577;
	cv=none; b=CsbRLIqwvMI7lb3a91qljMVKYLm4Ep9zVphsVWVLnBg0epxusglgKij1dNuq5o1Wj0DKISouJsbtwsAMLjhI9mPOGaFwMgx0kULgdWw6imBqCqOrJnBfSOaygLsUClBfuvDv2A7G5SnWAojbvLXiSn7WHGg2fuMaW7l27euHdMJda4mt5oScaT6IcWSkrohL46UUqVW/E0WpzZjuNG6VmWS/uRyXHvSnPFcIOZoNRQp6sygnY9C5ulhGBfnuglUmzy5xuhNEYtJZVvuOFV9reICSbfL9cNYSqNM4e0NoinJx7YRz9ZhZBZLti8aR3bpbMALsWLXlN2CzESwE+MzTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782582577; c=relaxed/relaxed;
	bh=+uflCN5dEoFADXWjqBtV9JZXNhAeBkbLG/4dD0z7b4I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0OPak6QaoeWUSDOOOEO6+EiNMw2XYZPPkZ9aaXJsTXO1RAJrnTh4EzqgivrfNdt4p5u5GzKJKaZNtRrdvb0izAiobu8YvSRs7hyAeY8tdZJ2Kq9cv19HeSZPfEAZqL/XuGd0Os/bw5P82jEl5+ARioztBIFe3ZqjdyTku9EapAM3cVpIVOFGXyX8uCO5Ws5HothTyzg2c3HEj8DVKSvTfVZci23t3gw6TIQWM6t6uF6qHHMKNs4CD9KIfq9NdwVewA7bPGt1Zur4UkVR9hz9jZus5ZBayD4XMnR24EKw66/mwdI7ze6U2yBmdcYe+fYA7HP8lJnWGbRs/QVaF5GbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r93BpLw/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r93BpLw/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gng6651nzz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2026 03:49:33 +1000 (AEST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-73720e58dafso243866137.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782582569; x=1783187369; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+uflCN5dEoFADXWjqBtV9JZXNhAeBkbLG/4dD0z7b4I=;
        b=r93BpLw/bgL/uA8v3TWGknyxsUg4DAqq5A6ZzZuGbUNenVPiHxDZ4fPSKGDWlT/+pB
         MUDNEWjpktHD7BJQ16h4HiHmpfg8TLnmzG93JOugXmlL/emXbhY3Cn5Z6Ah9aGkHkGKM
         W+3O0C38GUGqeI8xeynU9BvXK3o44rmMIFqK0MBemQmhhglcQz7FDn0rZ3Htpn8IgYHW
         Lha5UEq6z1j+2xlIG0g40c+FO0wuH41jL9eBlfCuJFomCWnKmKPBCFjP0NtoESML9KNY
         ylRZbvgZpJjXeohyK3e1BeVJA9h8nRm56gi31yUodyR1+1/QcMh+X1HE74HqA/V/p9hi
         TE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782582569; x=1783187369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uflCN5dEoFADXWjqBtV9JZXNhAeBkbLG/4dD0z7b4I=;
        b=NVwP1mcYod59vJXXdvqGQU8P0umnFRZmRQ/nzEOJjG8oh4vSj6EPqm63B90qHo3uGI
         OjrJ65xMXCuCRx2akgJe1jpUEUtxLgI1ZKoYFo/kRy/0Wrg2/kDrCVDVVUfU3/31jDkg
         z7yny98IHYcOlSFGQqrmS3bKp9ZjmVmiZIi78acbaRPYK6BxS6tvE7XWRhmU07Oa7Hh3
         9NTdOUWshOATvdOWticqpdSos3VL+r8Hzd7L5Ojc/BOw/GqdgoMjnyv814RKEknfK2Fg
         0jsEdwD83Bbz2z9tJThaOInuAJ/ePYVkgBx7Aj1MCbOTBpD+BTzLjnEJQkHsRnFhDr+D
         qrjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKEOCJ7rkY6OyB52xTNuVtE5OUpnjvV/VvGdognReIXAXDoBUvQ52DCiWAAdCmhWeMqWi0JRGci1keDwY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyH7ioQLLkN1NBsX/JND8H0Feih+Df+bUT0kT7XO/D2bclOQpLb
	EQ+xb4ZnTdlGDu48KMwhEQQA0kyi2aH8M+gJSgLwXLcfo5mUV/vd2+gm
X-Gm-Gg: AfdE7cljumT0Miv6Vc28WSetbkz49YHAUUjVAwgO9kykXN8sgYgOGUH3U0gR4a4WImk
	On+voJ7jPILRyKcZK+8tyxtHbyh3xvCh3VXY457ftoAaPXeg+rvayW7lGPjz21gzrbZ1Joen7V2
	UbAuiP7XW9QFW69Z0UYfGBQ9SrAEJG6Febd8rKyTWw5QvT4cLI2pvPu+JHsFE0iVZL51vHRyxCj
	zo9ZQi7tucWotMzPrA1lDQDevHjVIlOq9pyfXV+TXOVacp1hT4zxP5HVoUP7F8Ilpl8AcgTklmE
	afh3OpPQBDCqN01dxGnvkDB17RzpFTAVPU+6lySbxPWgVpnAL0xlId3eLE4yxkMQIg21KVLN2L9
	4l2X6i8r4HTCNPXOPK8DtSJbXB4CuWvC8STRIhE7hCx0Wri4f415T3cVTDaxYgP7i/WWCkCnnkb
	iPsPFTyjrsg/myniRlMTyut85cfRwUnDqvv6wGyLNWO2kc
X-Received: by 2002:a05:6102:440f:b0:730:db02:1d08 with SMTP id ada2fe7eead31-73434452fd5mr5471882137.10.1782582569056;
        Sat, 27 Jun 2026 10:49:29 -0700 (PDT)
Received: from localhost (d-24-145-72-22.fl.cpe.atlanticbb.net. [24.145.72.22])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96916e5b10dsm2811280241.4.2026.06.27.10.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:49:28 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sat, 27 Jun 2026 13:49:27 -0400
To: David Laight <david.laight.linux@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Linu Cherian <lcherian@marvell.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 13/16] perf: Use sysfs_emit() for cpumask show callbacks
Message-ID: <akANJ-AT7nHpRMq-@yury>
References: <20260528183625.870813-1-ynorov@nvidia.com>
 <20260528183625.870813-14-ynorov@nvidia.com>
 <7e980b99-1e4e-408b-8ebd-4d28116e7ad5@arm.com>
 <20260529130619.12f24264@pumpkin>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529130619.12f24264@pumpkin>

On Fri, May 29, 2026 at 01:06:19PM +0100, David Laight wrote:
> On Fri, 29 May 2026 12:05:08 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
> > On 2026-05-28 7:36 pm, Yury Norov wrote:
> > > These callbacks are sysfs show paths.
> > > 
> > > Use sysfs_emit() and cpumask_pr_args() to emit the masks.
> > > 
> > > This prepares for removing cpumap_print_to_pagebuf().  
> > 
> > TBH, looking at this diff I think it only shows the value of having a 
> > helper to abstract the boilerplate...
> > 
> > I'm not sure I agree with the argument of removing something entirely 
> > just because it may occasionally be misused, but could we at least have 
> > something like:
> > 
> > #define sysfs_emit_cpumask(buf, mask) \
> > 	sysfs_emit((buf), "%*pbl\n", cpumask_pr_args(mask))
> >
> > to save the mess in all the many places where the current 
> > cpumap_print_to_pagebuf() usage _is_ entirely appropriate?

This way you have to add 2 wrappers:

 #define sysfs_emit_cpulist(buf, mask) \
 	sysfs_emit((buf), "%*pbl\n", cpumask_pr_args(mask))

 and

 #define sysfs_emit_cpumask(buf, mask) \
 	sysfs_emit((buf), "%*pb\n", cpumask_pr_args(mask))

There are people who complain even about DIV_ROUND_UP(), how hard it is
to keep all that helpers in memory, and all that things.

https://lore.kernel.org/all/20260304124805.GB2277644@noisy.programming.kicks-ass.net/

Disagree about DIV_ROUND_UP() (because yeah, I'm bad in math), but
this sysfs_emit_cpumask() is a complete syntax redundancy.

Once we have it, people will do this type of things:

        tmp = kmalloc(PAGE_SIZE);
        sysfs_emit_cpumask(tmp, mask);
        sysfs_emit(buf, "my prefix: %s\n", tmp);
        kfree(tmp);

Patch #1 in this series is one example. My series that removes
bitmap_print_to_pagebuf() will give you more:

https://lore.kernel.org/all/20260303200842.124996-2-ynorov@nvidia.com/

It doesn't mean that *you* will misuse the API. It means that *I* will
have to inspect the codebase for that type of bugs periodically.

So, the overall state is simple: we've got well-established
printf()-like functions that people know and understand, and we also
have exotic APIs here and there with a non-standard interface and a
clear potential to misuse. In this case, they have historical roots,
but now we don't need them.

> That has the advantage of letting you change how it is done (again)
> without having to find all the callers.

You mean things like silencing the prints or adding a prefix?

If you believe that perf subsystem would benefit from it - that's
OK. Just please keep it local. The kernel globally doesn't need to
'change how it is done' beyond the lib/vsprintf.  The kernel really
needs people to use something that the other people are familiar with.

Thanks,
Yury

