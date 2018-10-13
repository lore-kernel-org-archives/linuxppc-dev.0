Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF89C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:20:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7875120652
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SwGcOdxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7875120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XVKm4jryzF3DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 03:20:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SwGcOdxS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="SwGcOdxS"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XVHD5cYDzF390
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 03:17:58 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id y81-v6so12117260oia.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rU/ecJ/iu4SmEP30zyvvt9fLdigY6NlYfk37drGWnas=;
 b=SwGcOdxSr49TqgeH7Ue49bueoNPDCgqqKH0yTSavySC7dOjiM2uxnPtIcZrup+ZWlq
 hq9K7XpNxJPFCFFUfuZ4AIa/6ynpnJx9jvPifwaYhtL/7qUPYruMPer3i326ZNQsvdOG
 pk7cBT/zJyyH/7/1EysacMRgmvmY7qEhvKICoUJ9oHIKWj6QKxn+mRjssEFzjie4Yr1L
 NmEdva+zF4K9nXn1tI4LHELjgNB/Lf+NPyedUmfCOwj36UEmU6aRMWWCE4E2q2sHJDKB
 A9UM9iBkwPGzIbNkkYyyP2h9zm4KXnHm5gpUx+BOKfx4hi8wJFDbcdFiygUMC9/LHDak
 Qt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rU/ecJ/iu4SmEP30zyvvt9fLdigY6NlYfk37drGWnas=;
 b=CPZkMQdZz0K3nc7R4wi2fnKubbAfbYCT29PaSlENxs+O9jyTjEhIe98z1KOkojseVh
 ceIyiUQeygqXxn9uVFvIR2SKp8Ewk4B/rHgbk1oojwWWqOkB9b7gER3UqMPNyJECeJgV
 UaRJhXoKvH7ng+VUx9XGx/EPG8tSE8yGkpAdj5URb+kuwoiqnSGwPvXCOBgLaSwk+3cG
 fUlVnc303Rt9jApTYcgfwS4GFGokGa/ne2EjDeFt+Sw8LAfR/IV7MSfx+c8EEXpmZCKL
 WQ+QeZAY44SecP6parjHLXc2iwbAmZmOiWZnUjj2RxLtvwr1Q02AwJ8sJ3jdqBbuS7r+
 Vr5A==
X-Gm-Message-State: ABuFfohJNEBQs4q3sEbJF4wwO3BKDjHcyJZEkPj0d82F53wH+OUzTkt8
 azurLw/Ym87vE3/bmwytlRh/uOKuvfGRDbKRaiFs0w==
X-Google-Smtp-Source: ACcGV63xgR1P8hR5dXtLnCjlW87He7YCZ3USive18s+RksAOKiTFGOIXVvZ3b7U+1rSJrMFSlDwqyMecM96nPtvlWc8=
X-Received: by 2002:aca:3ad4:: with SMTP id
 h203-v6mr5329613oia.235.1539447475968; 
 Sat, 13 Oct 2018 09:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181010060812.20068-1-oohall@gmail.com>
 <20181010060812.20068-3-oohall@gmail.com>
 <CAPcyv4jhs9f2DdOk30KU9___mWMtowQi0LP-OD1E+_5xFbxWgA@mail.gmail.com>
 <87h8hq122t.fsf@concordia.ellerman.id.au>
In-Reply-To: <87h8hq122t.fsf@concordia.ellerman.id.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 13 Oct 2018 09:17:44 -0700
Message-ID: <CAPcyv4h0b9jmrizygCEOU8GGMj-5yxz+vgEyVmVq+KNAozs+rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/pseries: Add driver for PAPR SCM regions
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 13, 2018 at 5:08 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > On Tue, Oct 9, 2018 at 11:21 PM Oliver O'Halloran <oohall@gmail.com> wrote:
> >>
> >> Adds a driver that implements support for enabling and accessing PAPR
> >> SCM regions. Unfortunately due to how the PAPR interface works we can't
> >> use the existing of_pmem driver (yet) because:
> >>
> ...
> >> +
> >> +static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
> >> +{
> >> +       struct device *dev = &p->pdev->dev;
> >> +       struct nd_mapping_desc mapping;
> >> +       struct nd_region_desc ndr_desc;
> >> +       unsigned long dimm_flags;
> >> +
> >> +       p->bus_desc.ndctl = papr_scm_ndctl;
> >> +       p->bus_desc.module = THIS_MODULE;
> >> +       p->bus_desc.of_node = p->pdev->dev.of_node;
> >> +       p->bus_desc.attr_groups = bus_attr_groups;
> >> +       p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
> >> +
> >> +       if (!p->bus_desc.provider_name)
> >> +               return -ENOMEM;
> >> +
> >> +       p->bus = nvdimm_bus_register(NULL, &p->bus_desc);
> >> +       if (!p->bus) {
> >> +               dev_err(dev, "Error creating nvdimm bus %pOF\n", p->dn);
> >> +               return -ENXIO;
> >> +       }
> >> +
> >> +       dimm_flags = 0;
> >> +       set_bit(NDD_ALIASING, &dimm_flags);
> >> +
> >> +       p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_groups,
> >> +                               dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
> >
> > Looks good, although I'm just about to push out commits that change
> > this function signature to take a 'security_ops' pointer. If you need
> > a stable branch to base this on, let me know.
> ...
> >
> > Other than that looks ok to me:
> >
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> >
> > ...just the matter of what to do about function signature change.
>
> Yeah that's a bit of a bother.
>
> The ideal for me would be that you put the commit that changes the
> signature by itself in a branch based on 4.19-rc3 (or earlier), and then
> we could both just merge that.
>
> But not sure if that will work with whatever else you're trying to sync
> up with.

How about this, I'll move the new signature to an 'advanced':

    __nvdimm_create()

...and make the existing:

   nvdimm_create()

...a simple wrapper around the new functionality. That way no matter
what merge order we should be ok.
