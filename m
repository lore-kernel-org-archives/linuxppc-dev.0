Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FFCC10F03
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 08:46:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7007217FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 08:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7007217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qW4Y4SWNzDqbm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 18:46:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qW2Q4zfXzDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 18:44:29 +1000 (AEST)
Received: by mail-oi1-f193.google.com with SMTP id w139so16503348oie.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bjt9UbhvtnUU4JF1Ugmh32U0petY5Yn4OCBHxmRAjRk=;
 b=Dwj0Hkose8YTg0cNprc9CCtYQkY8aSEL60qCEL7C4gjBe3Aw0T7ovXDll1oboi0/qq
 4y6YwSk46vQSUfhOMEl3FVUu1U3W1OKyEPsamMvkDKm3JiotmcQEjj48DER2HqDTJRvh
 9E9TV7w+7O+ei1ZE/+7fN3jbIEN7VE7kibW1kKuFNGz+tmb1BdWbXncnmmHybOLy9gUW
 YfYQpdcUfrMqzVVcGNCjzQ+E3q/gxTrkE49oobwNH2mSrgRVSOJMFDO+YD7NeWhPwjDk
 /LtfNji6CBcj7YtdjTkXOSO0H2DI8bImKcXDf//1AHD1VO2uvZogY8ZACcmB42Wl9nfv
 vNIQ==
X-Gm-Message-State: APjAAAWBJmN8Xkz5TATMqBF6x/w2bNgQzDh9zX28FRxRkjPXCxPSsL5B
 WmLZkIOR718hA/Qdd1Sy3zYNtzTl9ex473lrFeA=
X-Google-Smtp-Source: APXvYqzanEsCHYgN6ChHqJF1LmTkEoNSTo+9Gyq2P+euIofGGYu9abx/xIveUmPQLvCRXgC5r9O3U8qgxIthy2setfg=
X-Received: by 2002:aca:f511:: with SMTP id t17mr2363558oih.115.1556181866282; 
 Thu, 25 Apr 2019 01:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190424175306.25880-1-changbin.du@gmail.com>
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Apr 2019 10:44:14 +0200
Message-ID: <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] Include linux ACPI docs into Sphinx TOC tree
To: Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 linux-gpio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

.On Wed, Apr 24, 2019 at 7:54 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi All,
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> reST format in this serias.
>
> The hieararchy of ACPI docs are based on Corbet's suggestion:
> https://lkml.org/lkml/2019/4/3/1047
> I did some adjustment according to the content and finally they are placed as:
> Documentation/firmware-guide/acpi/

I'd like to queue up this series, but it is missing a patch to create
Documentation/firmware-guide/acpi/index.rst.

Care to provide one?
