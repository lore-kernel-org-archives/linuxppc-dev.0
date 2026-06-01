Return-Path: <linuxppc-dev+bounces-21819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C097CCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 17:45:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gThFF0nH8z2ysb;
	Tue, 02 Jun 2026 03:45:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780335921;
	cv=none; b=dkukZdawNdTfDyp/ZxdUkUnIZh1lQSQ89YQRdt5SBt++YCyVWkCWwQyxQQVJSILQsl7JD9+4BApbjE2WNWjnpO/eGY7WNRzOLAc3RW5WYL5xGYJ+V6a0TuLxxcF09vL49mVMqfTQu3O0lxmQsMFEF70lb7Me5Leh0txxpC/eOt76DZzNuzKK13ffKC9CXv09DeMKQjT+RP3p9tGPaH2+lKTAoEysUv+lvZG27ZPHqM+iseuGw/74ZWTv0yoBxbJbjOuKxeL9x1XM5jmitPlYuTxS6QnsslRfkg0GXLYvqWvdZ9bVWcAe2plfW8mZQSPe4y+azDupAZjQOjUEw31XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780335921; c=relaxed/relaxed;
	bh=NQXET+HIwUHzkASejrWXITD/EhCJ1l5nthigBOUX5B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkfrYPqkNqu97voPRwBM4YTRjqf8jeXJmtQDYtmvruFHHzmqQmaMZxhtz3vLSf+2dfSTSy6+VebU4VM3iazl9bI9oZ/VvXxoP72INViOXaRTZXgoopTQYlNph2JrxhF348b8/9EEHYUnwiJplRx2ZeRSutm3gCv6PT4juk/opLN3ugsgUG/26B7ZGUmT0UFCsGOL2a9Rj4me+ok9wIrWW9MQCa7BH1sfHaE0qfatcqd58GV7CpS0Bso65rEZUJVAhDny0tlcgK91eVgw6wtgV2CjMvSUVhQnkwenBUK93flDSnVAg0aVNJhnIcqSElWgl14zfIlSNJlPNN6n9xTzNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjGRHh/A; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjGRHh/A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gThFC4zV9z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 03:45:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F96944621
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2026 17:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567021F00A11
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2026 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335916;
	bh=NQXET+HIwUHzkASejrWXITD/EhCJ1l5nthigBOUX5B4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gjGRHh/AejulXxkNQAjfjV93VMiqgdq6wRmZ7BNSN1UHb97WguW4+/ZA+WuQC6Kll
	 yhn3UxrX6XHEvJlmkImSQf3opqad40WQNxo0e446ikygz1JQuNxXlxEupqUOOMotfi
	 QZ7zNwyi6Ev4WkeVDBku7OIdn6/NnCxDJfGGNtSBSMm42l8FYQ3sk4gJGLxT/hbqCe
	 K0vFWgCVQinuD4UcX6ltdXhdbZf0cM4k6OQ10FtXjpLK4tNUvA3GQZ7EyhXiE2tkMT
	 OVYBnp+ntfYpsvWr85EAbNEvk2fl/CVRUiYB0mkIo2usdhpYSJ7vIUPsX5pwj59Gzk
	 lW6qoYjQk8e7g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa6792e7b8so1524169e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 10:45:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8H/oZtc25IVCwG6GndIt3N40v7l4lHa2ELmHzr/tC1XAxiZmZ/xZWoCCwjbaQdB5wN9as4QbobYkT8jEA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxH+pEz4V/gevolh2Y8Ivoxx+y0GdSnfxHZDQrMoc743QQKwMDM
	hQK/vLLV5QoC2aTVWWDWWouZ60IQweU0C8x7xk/wgaxXNDVGwCAXsWx7J+dI4FOV9NxEQsyowwW
	XK/lxzgmYXohYCLl6HIU+2WLS33iFsuw=
X-Received: by 2002:a05:6512:3b97:b0:5aa:6e86:55c8 with SMTP id
 2adb3069b0e04-5aa6e8657c0mr1302970e87.12.1780335912894; Mon, 01 Jun 2026
 10:45:12 -0700 (PDT)
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
References: <20260528183625.870813-1-ynorov@nvidia.com> <20260528183625.870813-6-ynorov@nvidia.com>
In-Reply-To: <20260528183625.870813-6-ynorov@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:45:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPZL7Cmi7Sm5pVN01AG7rb8NiwWkUJ9X6gwim67EUZPQ@mail.gmail.com>
X-Gm-Features: AVHnY4L1KYHIevdOf61kuP7a6ocAZfa6dkfv0T6IORvr_Om4IsQ3giCPU7iBHEE
Message-ID: <CAJZ5v0gPZL7Cmi7Sm5pVN01AG7rb8NiwWkUJ9X6gwim67EUZPQ@mail.gmail.com>
Subject: Re: [PATCH 05/16] ACPI: pad: Use sysfs_emit() for idlecpus show
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
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
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
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:36=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wrot=
e:
>
> idlecpus_show() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
>
> This prepares for removing cpumap_print_to_pagebuf().
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/acpi/acpi_pad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index ec94b09bb747..04d61a6cc95f 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -334,8 +334,8 @@ static ssize_t idlecpus_store(struct device *dev,
>  static ssize_t idlecpus_show(struct device *dev,
>         struct device_attribute *attr, char *buf)
>  {
> -       return cpumap_print_to_pagebuf(false, buf,
> -                                      to_cpumask(pad_busy_cpus_bits));
> +       return sysfs_emit(buf, "%*pb\n",
> +                         cpumask_pr_args(to_cpumask(pad_busy_cpus_bits))=
);
>  }
>
>  static DEVICE_ATTR_RW(idlecpus);
> --

Applied (with a tweaked subject) as 7.2 material, thanks!

