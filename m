Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD46C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:36:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4962321773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GUMia/Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4962321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q4DD1p1czDqX7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:36:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="GUMia/Jv"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q4B95Tp7zDq6K
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:34:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sqQ0QZ1qv0/cq0WsSzdCrhPHL6++zwMLBU3pK19WzZQ=; b=GUMia/JvBbB3zAQVnK3orn6C1j
 82JUj+d2DVCZLnWRQuk8r3JFWRh05Q5K0pNOo3seAOO3tsWm1//G0gBOb8WEgh1Xy/BgF4Txmw4Lf
 j4zOWVq9WGjAwYOrgT+eKNYUQL+OM+REyJk0uUJyMMByD/4HDigsOJYX6Dwk492azCivbCSYyyIWs
 p6cOqhwWC6MaDrFJh0/H4Ed2a99E/JMvOzAxZ8DLCMadovwmdlXnFFMg6aKnMGRoL3WKIMSuoaCPD
 5MBRbGKVmhYpf5JsYriwQwbj6ut2E5HcWzzcuHSbGc84agRYxtQsdDF/1evUgIy13eId83GOX3Wbk
 KbEkFIyQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJJup-0002ie-EU; Wed, 24 Apr 2019 15:34:31 +0000
Date: Wed, 24 Apr 2019 12:34:25 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 30/63] Documentation: PCI: convert acpi-info.txt to reST
Message-ID: <20190424123425.3e63f970@coco.lan>
In-Reply-To: <20190423162932.21428-31-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-31-changbin.du@gmail.com>
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

Em Wed, 24 Apr 2019 00:28:59 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/{acpi-info.txt =3D> acpi-info.rst} | 11 ++++++++---
>  Documentation/PCI/index.rst                        |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
>  rename Documentation/PCI/{acpi-info.txt =3D> acpi-info.rst} (97%)
>=20
> diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-inf=
o.rst
> similarity index 97%
> rename from Documentation/PCI/acpi-info.txt
> rename to Documentation/PCI/acpi-info.rst
> index 3ffa3b03970e..f7dabb7ca255 100644
> --- a/Documentation/PCI/acpi-info.txt
> +++ b/Documentation/PCI/acpi-info.rst
> @@ -1,4 +1,8 @@
> -		ACPI considerations for PCI host bridges
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ACPI considerations for PCI host bridges
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The general rule is that the ACPI namespace should describe everything t=
he
>  OS might use unless there's another way for the OS to find it [1, 2].
> @@ -135,8 +139,9 @@ address always corresponds to bus 0, even if the bus =
range below the bridge
> =20
>      Extended Address Space Descriptor (.4)
>      General Flags: Bit [0] Consumer/Producer:
> -	1=E2=80=93This device consumes this resource
> -	0=E2=80=93This device produces and consumes this resource
> +
> +        * 1 =E2=80=93 This device consumes this resource
> +        * 0 =E2=80=93 This device produces and consumes this resource

Hmm.. I think that you would need to add some extra blank lines before
the above, e. g., something like:

	[4] ACPI 6.2, sec 6.4.3.5.1, 2, 3, 4:
	    QWord/DWord/Word Address Space Descriptor (.1, .2, .3)
	      General Flags: Bit [0] Ignored
=09
	    Extended Address Space Descriptor (.4)
	      General Flags: Bit [0] Consumer/Producer:

		* 1 =E2=80=93 This device consumes this resource
		* 0 =E2=80=93 This device produces and consumes this resource

> =20
>  [5] ACPI 6.2, sec 19.6.43:
>      ResourceUsage specifies whether the Memory range is consumed by
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 1b25bcc1edca..c877a369481d 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -12,3 +12,4 @@ Linux PCI Bus Subsystem
>     PCIEBUS-HOWTO
>     pci-iov-howto
>     MSI-HOWTO
> +   acpi-info



Thanks,
Mauro
