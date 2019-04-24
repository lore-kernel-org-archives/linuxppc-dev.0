Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4E6C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:09:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9018C2084F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K7z4gYOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9018C2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q3cw2WgwzDqFS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:09:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="K7z4gYOL"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q3BL6JHMzDqQC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 00:49:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nKCwBmfBp7mcLbr5EtlGrsX2M4qchKLnLez+nRU0bpI=; b=K7z4gYOLG9Il8dGxDROWgW3h/o
 MYvPnBQP80XVXEXulkopPsVc5wm+6NlqWcd/h2GHY3dzlCsYNfMZwRIspSRtPn50ov6mWI7dYevoz
 Op4iC7kUpyf+8Iaupsix7o+x8aQHFYHq6klmdRM9vB7ejyII0LotHwKOuiRIbr4IxvHjKgxLH9tBq
 ITroLpqZ7ZXbSNCR5tVqWibzTT+tOR/rcWV2m2ClwNBKBCpAQWPtNRnKUTiyoUrq2s/DSJ382XW8A
 iK9KoevgVOZ/uGvzAp7Yfr6zpGJ+HoxP0Vd4eTDbv6uUKRktdGwvoa20r8TVjoTVh0Rxg6nMqUKQ1
 EPhv6+3g==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJJDM-0000dE-Qa; Wed, 24 Apr 2019 14:49:37 +0000
Date: Wed, 24 Apr 2019 11:49:30 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 22/63] Documentation: ACPI: move lpit.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190424114930.09df0827@coco.lan>
In-Reply-To: <20190423162932.21428-23-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-23-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: fenghua.yu@intel.com, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 00:28:51 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/firmware-guide/acpi/index.rst    |  1 +
>  .../lpit.txt =3D> firmware-guide/acpi/lpit.rst}  | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>  rename Documentation/{acpi/lpit.txt =3D> firmware-guide/acpi/lpit.rst} (=
68%)
>=20
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/=
firmware-guide/acpi/index.rst
> index fca854f017d8..0e60f4b7129a 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -22,3 +22,4 @@ ACPI Support
>     gpio-properties
>     i2c-muxes
>     acpi-lid
> +   lpit
> diff --git a/Documentation/acpi/lpit.txt b/Documentation/firmware-guide/a=
cpi/lpit.rst
> similarity index 68%
> rename from Documentation/acpi/lpit.txt
> rename to Documentation/firmware-guide/acpi/lpit.rst
> index b426398d2e97..aca928fab027 100644
> --- a/Documentation/acpi/lpit.txt
> +++ b/Documentation/firmware-guide/acpi/lpit.rst
> @@ -1,3 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Low Power Idle Table (LPIT)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
>  To enumerate platform Low Power Idle states, Intel platforms are using
>  =E2=80=9CLow Power Idle Table=E2=80=9D (LPIT). More details about this t=
able can be
>  downloaded from:
> @@ -8,13 +14,15 @@ Residencies for each low power state can be read via F=
FH
> =20
>  On platforms supporting S0ix sleep states, there can be two types of
>  residencies:
> -- CPU PKG C10 (Read via FFH interface)
> -- Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
> +
> +  - CPU PKG C10 (Read via FFH interface)
> +  - Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interfa=
ce)
> =20
>  The following attributes are added dynamically to the cpuidle
> -sysfs attribute group:
> -	/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> -	/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> +sysfs attribute group::
> +
> +  /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> +  /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> =20
>  The "low_power_idle_cpu_residency_us" attribute shows time spent
>  by the CPU package in PKG C10



Thanks,
Mauro
