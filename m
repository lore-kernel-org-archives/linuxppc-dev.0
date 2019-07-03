Return-Path: <SRS0=8MEZ=VA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EC5C5B57D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 01:56:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57DE2064A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 01:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBIP8ADu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57DE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45dkj81qNVzDqYn
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 11:55:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aBIP8ADu"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45dkg16ZtWzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2019 11:54:05 +1000 (AEST)
Received: by mail-io1-xd42.google.com with SMTP id u13so1072755iop.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jul 2019 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YWCrwQskLP6RChv1RaVNEBI2BeG77zwA1QgqRtTN23s=;
 b=aBIP8ADuc/6oC8jziky1yr08FAMyMuZ7yyFFj4XoaRVp8tWjPbVgPApgVzR4yYT2wt
 mrKleIC9B1100CEYzHt39tLCsA0Drsykyh0civ3HsiHigFZxP4sLal95HWMDqbkKhmsf
 DVkXPUnAMrZjATXncbCSMiShvD9NYLHjpd0RYwD58ulOLBRoTJsfSuswG0MINbg/LVQu
 AETuxo2ASD5uV9ngWN/d1iZII9PS5/gfz7pwFkgfJYvGZHybH+adT7ybw0IASFs47hiP
 jp0tXLEo95W1v4QR29qtJGDDcnlo9v6ROgHuI539mCuBMnwaNgO1+sDM8nO9kew8T2h9
 sSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YWCrwQskLP6RChv1RaVNEBI2BeG77zwA1QgqRtTN23s=;
 b=fIJ9NH6ylV0QLtSf/WaTIB4pNIgT3KJAkzR9qE0YbtVFXpDGkjrcPAyCl6su/96rlR
 th+k2oRS2MRHN7bQma22dn9FU01BgCPVmvLQC/1lsC6oySIV/wsOznzYiX2Q4JNOfyDK
 EAMmaIObzYyLYVONhh0dWhrnGxRIXi8fKskzAXzUwfy4uPEWvocYo8BT1tITfBA0cjEj
 9XzdxPwLcowJkCOvJ93YNJ49vwQ9wOmzOKzY8jFiw04pSSzPpqarsaal9+GPIzXV+0Pj
 m920VR8wGqGxvc+dzIhOlLihZxlLRrVrMttBQeRkXWXLzTXvExucFzhadmT9xrp0n3Bt
 j5tA==
X-Gm-Message-State: APjAAAWxZd37McRgsVLPYdJrLVOYnfhZmtdt84bTIKrS9TQrtH94BlvI
 ZH5ean12AlHvym2GEAg1Li1UVBuXSqGcxyP2HAQ=
X-Google-Smtp-Source: APXvYqxXCaoGnSrggcZ0XfGAo1zUZWN/ii/2LviSBEPaLcDUQeCzvmiRNgAOjeTCTC3jEOKjPvBrLva/1kFATjw6vUQ=
X-Received: by 2002:a02:a90a:: with SMTP id n10mr38280201jam.61.1562118842128; 
 Tue, 02 Jul 2019 18:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190701143338.16824-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190701143338.16824-1-aneesh.kumar@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 3 Jul 2019 11:53:50 +1000
Message-ID: <CAOSf1CGb7nDTekX5zJJBexuGh+HsicL_F6B6TRMLJRXogTomPw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/mm/nvdimm: Add an informative message if we
 fail to allocate altmap block
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 2, 2019 at 12:33 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Allocation from altmap area can fail based on vmemmap page size used. Add kernel
> info message to indicate the failure. That allows the user to identify whether they
> are really using persistent memory reserved space for per-page metadata.
>
> The message looks like:
> [  136.587212] altmap block allocation failed, falling back to system memory
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/mm/init_64.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index a4e17a979e45..f3b64f49082b 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -194,8 +194,12 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>                  * fail due to alignment issues when using 16MB hugepages, so
>                  * fall back to system memory if the altmap allocation fail.
>                  */
> -               if (altmap)
> +               if (altmap) {
>                         p = altmap_alloc_block_buf(page_size, altmap);
> +                       if (!p)
> +                               pr_debug("altmap block allocation failed, " \
> +                                       "falling back to system memory");
> +               }
>                 if (!p)
>                         p = vmemmap_alloc_block_buf(page_size, node);
>                 if (!p)
> --
> 2.21.0
>

I'll let mpe decide if he cares about the split line thing :)

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
