Return-Path: <SRS0=xLud=DG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A805C2D0A8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 00:57:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EA4207C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 00:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqfX70p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EA4207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C0gvj101fzDqSQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 10:57:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d42;
 helo=mail-io1-xd42.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fqfX70p6; dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0gsr0q1SzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2020 10:55:26 +1000 (AEST)
Received: by mail-io1-xd42.google.com with SMTP id u6so3098741iow.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2020 17:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QGTY5JlYWG9z0D7/RuLNr1T5K1KEPAuumqJ9jOnxLyw=;
 b=fqfX70p6n23/qMu34NxN9mlOSgogomSvdKf6fhh0zrS/y3WgqeKSOW7/unUCQhgsRK
 5vUjqKJeV/P70GeLH0wEXCqLyJH4PhJAT9kL83lGffQsKp/+EsSi1OMcAfmKByUKyVAb
 DTZ9ClinCQeMew1q726Fo7S8MIqdGXCiL9mtVqy/w05ENkImu6DgaOrYDNpXCHtWixFK
 NeU8xTwygywPahfeHfFiwRTWeWQmPUBi/FBEPtYruIjq3kXd7dXmvbNp+y2juxqp85K9
 KjxdaZIEfJW2g6fAg3Byrr2TdLFTxjD08vKI7rKPFSKeKDPKr/fH3edzBaEbrRdi4Jx2
 Eybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QGTY5JlYWG9z0D7/RuLNr1T5K1KEPAuumqJ9jOnxLyw=;
 b=kXg5sILZRWBNq4nRRiH/92fQXc96Nb1XlLx3iAtOQzuEzfHazsmJvXAr7OxLTZhQyK
 tTdmC9PWgIhtyt4lB6E5z6eUTFb7UYIVUFDYhfENLyyFjw0bLyCGL1uMH8U8YA4CDKVW
 /DuXL/Z4zoc3XznmR7ynTPD6CZhhguTle7sYFv63kc1rs9JxlL9LocCNV5Z0ia60IwMq
 qT0qK/Gy4X073oWWZqmDEOBx/qFOMZcBsleLfffrn3tT89NowPjXvSzIjq8uKGn8podJ
 +l+snzjakDNnmeyIsxU7P790YRVcJDfI1bx3tbXBikuIZ0NFv0ZJswYUQi0nwm5BrJCz
 xyMA==
X-Gm-Message-State: AOAM532oKsdgyBdWVjdFnhEGfDrYB/A6K27UbYhpLeGQRb43zAZLdflJ
 9EdBEi7c743GsJN6Hagvp1IWlib4qAfuK52csFk=
X-Google-Smtp-Source: ABdhPJzksqe6Wln9YBjx1ZvlFsWD4eV85ZoBEjjk7OOVTIcOb7Mo4sErIAc3CG+izUMAzwtHugSF7aZoX1oy2aKg89E=
X-Received: by 2002:a02:6623:: with SMTP id k35mr1004403jac.105.1601340922396; 
 Mon, 28 Sep 2020 17:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200924051343.16052.9571.stgit@localhost.localdomain>
 <CAOSf1CEv3v940FR_we70qCBME0qFXPizPT8EFbf3XyK2-fPDrw@mail.gmail.com>
 <ff6a8c97-4a6a-c82b-bd35-e09fa44f8e20@linux.ibm.com>
In-Reply-To: <ff6a8c97-4a6a-c82b-bd35-e09fa44f8e20@linux.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 29 Sep 2020 10:55:11 +1000
Message-ID: <CAOSf1CHdOk1guuST8T5t1A9O=xkbeFiJ9uZXgHeBBjeLKZ5O4g@mail.gmail.com>
Subject: Re: [PATCH] rpadlpar_io:Add MODULE_DESCRIPTION entries to kernel
 modules
To: Tyrel Datwyler <tyreld@linux.ibm.com>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 29, 2020 at 6:50 AM Tyrel Datwyler <tyreld@linux.ibm.com> wrote:
>
> On 9/23/20 11:41 PM, Oliver O'Halloran wrote:
> > On Thu, Sep 24, 2020 at 3:15 PM Mamatha Inamdar
> > <mamatha4@linux.vnet.ibm.com> wrote:
> >>
> >> This patch adds a brief MODULE_DESCRIPTION to rpadlpar_io kernel modules
> >> (descriptions taken from Kconfig file)
> >>
> >> Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> >> ---
> >>  drivers/pci/hotplug/rpadlpar_core.c |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> >> index f979b70..bac65ed 100644
> >> --- a/drivers/pci/hotplug/rpadlpar_core.c
> >> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> >> @@ -478,3 +478,4 @@ static void __exit rpadlpar_io_exit(void)
> >>  module_init(rpadlpar_io_init);
> >>  module_exit(rpadlpar_io_exit);
> >>  MODULE_LICENSE("GPL");
> >> +MODULE_DESCRIPTION("RPA Dynamic Logical Partitioning driver for I/O slots");
> >
> > RPA as a spec was superseded by PAPR in the early 2000s. Can we rename
> > this already?
>
> I seem to recall Michael and I discussed the naming briefly when I added the
> maintainer entries for the drivers and that the PAPR acronym is almost as
> meaningless to most as the original RPA. While, IBM no longer uses the term
> pseries for Power hardware marketing it is the defacto platform identifier in
> the Linux kernel tree for what we would call PAPR compliant. All in all I have
> no problem with renaming, but maybe we should consider pseries_dlpar or even
> simpler ibmdlpar.

I'm not too bothered by what we call it so long as it's consistent
with *something* else in the tree. Using pseries rather than ibm as a
prefix would probably be better since the legacy ibmphp driver is in
the same directory.
