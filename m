Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F65C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:08:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6859220659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8ncztNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6859220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YJg70qHDzF08G
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 11:08:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n8ncztNW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="n8ncztNW"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YJcV0Wp1zDr43
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 11:05:45 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id m15so1947561itl.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=llom8yP2SF5/SWEOYHQz4+sVibYdJxvrwXLO0N2NZZo=;
 b=n8ncztNW1xtg/PnEawK+/F67BDBSZsklfkqWyd12js2paPL669R5JS3jRZCFwT4BKX
 LXZW/VsbicKL180VflyDTNdtQyCysHPsDhhwMRS9ZddMRYgEBKjy7ru37Wwxn3oj2UOT
 wXXRwTONaM8Cw9bOqa4MtnKpzRgGNHWmTCNHt1Bf0vt5crLaj4GiWdCwEgN0q+cU7Z7l
 ENdo5F5/KwDhCG0KYhAfc/XJBoDdBd+cjsJv9NCbSoxYGx6NxlWUwkp+7rEnXISpK0Pe
 I7b4fqtMZDd7f9jf36Szd8ge7X+UoTGTnOUlVVr9+yNeJeT3MM1SwoUgmsDQ9SwJbWR0
 Y7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=llom8yP2SF5/SWEOYHQz4+sVibYdJxvrwXLO0N2NZZo=;
 b=SjyJM4Y2lX277fYc6Jpd9GZW48OapgxmOQXRZinpYk0e5RV/NJps4soqa8JGBkkQxp
 2z07bOyFwI4E47gu/G9ZHefvwXfmH95ZtROtlrALkEJOvxOmJ1gGUjzD0FtSmcM85++E
 2XKxIa6ty7mroy+dMtTOws48aAyVs30N4OnWvPP6I399tyEs/YhMlY/d3MP6vZRsjhn2
 Ap+UjCjzyUxgeQndGR0NV/QcvqYsKK4QLHHaq9kNym+Hw/2RlPrVssyFPvhtavf3bjNc
 ku+uI4Kg+jlNgyz6xoox3A+OzK+t5SiWsk0NgxmAv3Hok6Dj7BIrlnwCvrNXwadd2kLq
 FEQw==
X-Gm-Message-State: ABuFfog60DjwOofjlk9KtnQhiDiTp4k56hv6RURszhXmq/GrqpGvIEMG
 G7BY35mNz+eBgb2h6INWpD55jFhG0FlGD4WN7fw=
X-Google-Smtp-Source: ACcGV61WCaYLUcTe4/TSAQ2J+VMfkgn/sVxZoYQJ2thE9gqp8hpS5pN5Z2Tq4IMrIfC2pBvu2xa1GG0Vk3BmSONZYaw=
X-Received: by 2002:a24:1dd8:: with SMTP id
 207-v6mr11218258itj.126.1539561941669; 
 Sun, 14 Oct 2018 17:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181014231828.17139-1-oohall@gmail.com>
 <20181014231828.17139-2-oohall@gmail.com>
 <CAPcyv4jr4Y66wt7KtE7ke9OGX6kqNDQkO6yqAP8iaa2BzgdW2w@mail.gmail.com>
In-Reply-To: <CAPcyv4jr4Y66wt7KtE7ke9OGX6kqNDQkO6yqAP8iaa2BzgdW2w@mail.gmail.com>
From: Oliver <oohall@gmail.com>
Date: Mon, 15 Oct 2018 11:05:30 +1100
Message-ID: <CAOSf1CERAKnD=biAhAyBUqR4ZtULaVV=A1ZuA2iHaLU6mhVg6Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries: Add driver for PAPR SCM regions
To: Dan Williams <dan.j.williams@intel.com>
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 10:44 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sun, Oct 14, 2018 at 4:19 PM Oliver O'Halloran <oohall@gmail.com> wrote:
> >
> > Adds a driver that implements support for enabling and accessing PAPR
> > SCM regions. Unfortunately due to how the PAPR interface works we can't
> > use the existing of_pmem driver (yet) because:
> >
> >  a) The guest is required to use the H_SCM_BIND_MEM h-call to add
> >     add the SCM region to it's physical address space, and
> >  b) There is currently no mechanism for relating a bare of_pmem region
> >     to the backing DIMM (or not-a-DIMM for our case).
> >
> > Both of these are easily handled by rolling the functionality into a
> > seperate driver so here we are...
> >
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> > ---
> > The alternative implementation here is that we have the pseries code
> > do the h-calls and craft a pmem-region@<addr> node based on that.
> > However, that doesn't solve b) and mpe has expressed his dislike of
> > adding new stuff to the DT at runtime so i'd say that's a non-starter.
> > ---
> > v2: no change
> > v3: Corrected the mapping to use a DPA start address of zero
> >     Added cond_resched() calls in the bind/unbind loops
>
> Looks good, could I trouble you for an ack on the build / merge fix?
>
> https://patchwork.kernel.org/patch/10640385/

Sure thing. I checked that it built when rebased on top of your
pending branch before posting.
