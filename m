Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3DC28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 08:13:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F7120661
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 08:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4PmmSPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F7120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49K0MH49n7zDrBY
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 18:13:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::12e;
 helo=mail-il1-x12e.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Y4PmmSPd; dkim-atps=neutral
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49K0KQ60pYzDqjb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2020 18:11:52 +1000 (AEST)
Received: by mail-il1-x12e.google.com with SMTP id c18so3655963ile.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2020 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=trcL6JL/P6z4vCS3d8TLuc4KmkB3M51YoritqIkziPk=;
 b=Y4PmmSPdrqGZ9O/9z6M1BAClnjDC+wdjebUzwpC5fqMXzZYsNdW+jA1kUHbxbimLGc
 /mmI2EA72uT5ihkSTK2kuTqHj2x1+e1v/a4TpW12wq022tFZEyVJOJOn+45xFoyZvGwB
 YxJG4EZ5l7m5NEQyA6gu8GjgtWPhpi6dUm0V8JIuLM4mfs8vHdoqVr27OTCiinlxu2kC
 HIZXznUP4vbfD1HXnVh4/XkWFHjrO1UFdc0yBC7U2UEIIx8yk+99ve4PhVtDG2qRyX41
 ZZqSJzBY37qlaSMcLkKy1g2xS1xSIjqErA0/BU92BelEHTjchkhQwastD5fZK5bhcYmz
 n5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=trcL6JL/P6z4vCS3d8TLuc4KmkB3M51YoritqIkziPk=;
 b=eBFl3J0V9k3af6Cw5sQYj2JF/o0M5rzvRtCcnrEO1epRe53dpWRHRni13CJv0l5TOz
 XzGGlb2uZ40/7LDndOwFBSHh4modVgSFEa1wUIyDRlGhoYPaoG6133U4i+jSNr6GQ0qp
 fp4IP+8VPrC7Li/5pIYNn3q6QW11H+Ym+kGrQlTC7GA6dwwDH+jZommbrpSwGjApoDbC
 qgTB0OMYLwC+vtySxqV7ILoE9dUaQsRLlRnYv8AHSi9Bd8jfgl2qKn0PXT0bGVMampLn
 nGYT61Mnk4dlDrgC8NahC3c9zAsIu9JyxHFlNtTzqH/jx/I82rwkjBYiFv+E2lV2MPEp
 n/qQ==
X-Gm-Message-State: AGi0PuaNWyb/PeyWlJJn8KG0MBzyLn04frq8nJQiUPdCjnpkvlveuETj
 vmJp8KlMeh7BfKBbs2ioKl/PxsdAEjckj4fV5ys=
X-Google-Smtp-Source: APiQypJEGGvidYhz7vaJLXabTC/HGWu94b/4ibiIxw1/gsZvZ2NKsP9SXVH45+MFpy+V6NB4mvbM7/gSZjyNNEJO5mQ=
X-Received: by 2002:a92:7c01:: with SMTP id x1mr6540061ilc.122.1589011908683; 
 Sat, 09 May 2020 01:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <B183CDAA-DA88-4760-9C1B-F73A8F7840E7@lca.pw>
In-Reply-To: <B183CDAA-DA88-4760-9C1B-F73A8F7840E7@lca.pw>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Sat, 9 May 2020 18:11:37 +1000
Message-ID: <CAOSf1CFNp6+k_y_87r7p2e8cKfX0rK-9wBxeR+K0e0y8R0_TNg@mail.gmail.com>
Subject: Re: ioremap() called early from pnv_pci_init_ioda_phb()
To: Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 9, 2020 at 12:41 AM Qian Cai <cai@lca.pw> wrote:
>
>  Booting POWER9 PowerNV has this message,
>
> "ioremap() called early from pnv_pci_init_ioda_phb+0x420/0xdfc. Use early=
_ioremap() instead=E2=80=9D
>
> but use the patch below will result in leaks because it will never call e=
arly_iounmap() anywhere. However, it looks me it was by design that phb->re=
gs mapping would be there forever where it would be used in pnv_ioda_get_in=
val_reg(), so is just that check_early_ioremap_leak() initcall too strong?

The warning there is junk. The PHBs are setup at boot and never torn
down so we're not "leaking" the mapping. It's supposed to be there for
the lifetime of the kernel.

That said, we could probably move the PCI setup to a point later in
boot where the normal ioremap can be be used. We would have to check
for initcalls which depend on the PHBs being setup and delay those too
though.

Oliver
