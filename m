Return-Path: <SRS0=lNhQ=UZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D425EC4646B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Jun 2019 03:51:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2755C214DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Jun 2019 03:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+3Ub9ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2755C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45YTbP715yzDqYd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Jun 2019 13:51:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="b+3Ub9ic"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45YTWT1v63zDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2019 13:47:49 +1000 (AEST)
Received: by mail-io1-xd43.google.com with SMTP id u19so1875287ior.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2019 20:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fCoVRml/jv+g8lGjlexeAkszxKeEmBmE6BYcUGIfiXQ=;
 b=b+3Ub9ic8cC4HMJjnOjtbtO0H+dev+W63rqcTtt1DHFYOZ7SPMKhubWgpEPSqFYXVR
 P8e97yzSCF3hGGkKa48rZL996RuA8D9oBdmRtsktfWXqwrV/rjQvVqcmbGinM6b1fVoy
 s4izAEzbrCMwhGlkxTUPrYMQsjA6AeFrTzqdA7K7/E/AJDAfNKCypSqYdd1YIo2YiK2h
 87noU/Xhd41mi7zgT9GIbHNOyHGLUTrngLDlVkaknOR4uqAtEnpDTlL3URPdACyKRq1X
 /glWvsN2D/yZUaGjekSsg0fV9NOpJRr0Uy2r7M74wnkEqllPf5f0hcfhDx0wykngL/LS
 ad4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fCoVRml/jv+g8lGjlexeAkszxKeEmBmE6BYcUGIfiXQ=;
 b=C5bbirVpqckm3niX1ZnR1SlGaZLxUtusHAf2Jmf1+1FmJTRogpa0D3rofNQmrgGVAi
 xXuHKJTfLHpexJHk3eZ11IRMx6dthx1Yj0pEjF2uldailPPmUiU2Dp5V1Hf9y6kdDn4I
 pHBD7X0SjiiAvyvudPZEYhvELdBQov+i7IifdIKwzVkl5iT8p+AdZ9PVHHcHUjNdKpdV
 uQaLso3e2u28hUA5jmhdxKqd4AKL5k9PUj9gxzWiW1EjtShHpBTMl+SpqSCP1b2zpPbw
 GaW97GU3D4MDuBWdm3fyvf9rdMDukg4dRDHw/Y18M2ivNPYSy1l6BdxgCEgJUIW1GQfc
 XkXQ==
X-Gm-Message-State: APjAAAUjbU2RewLKh07bOalTx5nprU4Vey3dwAx/ozp824OQbHx/XyLU
 B4DpYgZ6F1UkqwUJx3HRhXidlPsz140vAnkM/1I=
X-Google-Smtp-Source: APXvYqygplaFPDhqCjB+kvDAe8dVXTv81perEQl/lDhSUg/RBDw0aC42uFsXOBpd7n77ySp6GH41hKk+eHK3CkTvtcI=
X-Received: by 2002:a6b:fb10:: with SMTP id h16mr2431001iog.195.1561520865927; 
 Tue, 25 Jun 2019 20:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190625122709.11846-1-vaibhav@linux.ibm.com>
 <20190625122709.11846-3-vaibhav@linux.ibm.com>
In-Reply-To: <20190625122709.11846-3-vaibhav@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 26 Jun 2019 13:47:34 +1000
Message-ID: <CAOSf1CGYP7NiaAJ=Pf+3UJzK35HRXRnO+woB2o6yHJikuERW0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc/papr_scm: Update drc_pmem_unbind() to use
 H_SCM_UNBIND_ALL
To: Vaibhav Jain <vaibhav@linux.ibm.com>
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
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 25, 2019 at 10:27 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> The new hcall named H_SCM_UNBIND_ALL has been introduce that can
> unbind all the memory drc memory-blocks assigned to an lpar.

This is a little muddy. For normal memory each block has a DRC so you
can add/remove individual blocks by configuring or deconfiguring the
DRC for that block. For storage class memory the DRC refers to the SCM
volume as a whole rather than an individual block so a "memory DRC"
isn't really what you're taking about here.

This is probably being a little pedantic, but I find the whole DRC
system confusing enough as-is so it's good to be clear about these
things.

> more efficient than using H_SCM_UNBIND_MEM as currently we don't
> support partial unbind of drc memory-blocks.
>
> Hence this patch proposes following changes to drc_pmem_unbind():
>
>     * Update drc_pmem_unbind() to replace hcall H_SCM_UNBIND_MEM to
>       H_SCM_UNBIND_ALL.
>
>     * Update drc_pmem_unbind() to handles cases when PHYP asks the guest
>       kernel to wait for specific amount of time before retrying the
>       hcall via the 'LONG_BUSY' return value.
>
> * Ensure appropriate error code is returned back from the function
>       in case of an error.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Change-log:
>
> v2:
> * Added a dev_dbg when unbind operation succeeds [Oliver]
> * Changed type of variable 'rc' to int64_t [Oliver]
> * Removed the code that was logging a warning in case bind operation
>   takes >1-seconds [Oliver]
> * Spinned off changes to hvcall.h as a separate patch. [Oliver]

Looks good otherwise, when you respin feel free to add:

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
