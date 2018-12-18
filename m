Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B0C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 21:02:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E4A217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 21:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW/sJx6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E4A217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K9Sb0bSyzDqQ6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 08:02:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mW/sJx6Y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="mW/sJx6Y"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K9PB51D4zDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 07:59:10 +1100 (AEDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 58853218AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545166748;
 bh=x01E9j0ZrqizTWvDpK3jIyW8Cu6j5PqPF5gaj0FOdH0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mW/sJx6YtPHiGVruuORM3iS+yFXxp/Qa83B4f5fc6k5SlITLWZKI7GaAU7YNjl4QH
 Bmq2vOoqa2ac8/r0u4wLCcKEUflZlxP2iRuMGtEnCbows0eHDpekG+m9hBzZvOwg5H
 KGHtSgOXVbvpqm1kB1F4QIxLt34VRYSzha/jyQjc=
Received: by mail-qt1-f169.google.com with SMTP id n32so19801287qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 12:59:08 -0800 (PST)
X-Gm-Message-State: AA+aEWasxb/lzDpIFb3IHP5O3J5+tRiejQG8ip90rieS046pGNt0yWTp
 uOwnPD+MeD7XlEQccztRGHPz/gNsiODZ52nC/A==
X-Google-Smtp-Source: AFSGD/VqQoSHQlXjok4m9+ajmGvZS+ks2R1rqAB/j2czSalH2alxL0vaciEKWW8uYe2TEbLAgFKyQ5MNf1KGktHx1Ec=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr19382016qtf.26.1545166747526; 
 Tue, 18 Dec 2018 12:59:07 -0800 (PST)
MIME-Version: 1.0
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
 <871s6gv30z.fsf@concordia.ellerman.id.au>
 <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
 <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
 <893d9327-4353-066d-2efa-414a3db4c282@gmail.com>
 <6b6a3d11-e60a-f55c-04fa-deafdd58ccec@gmail.com>
In-Reply-To: <6b6a3d11-e60a-f55c-04fa-deafdd58ccec@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 18 Dec 2018 14:58:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLjhc4LSVKLVm7d+T+74xLK5kYNN0NLZySv1zV0tg5ibQ@mail.gmail.com>
Message-ID: <CAL_JsqLjhc4LSVKLVm7d+T+74xLK5kYNN0NLZySv1zV0tg5ibQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle
 cache
To: Frank Rowand <frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 18, 2018 at 2:33 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 12/18/18 12:09 PM, Frank Rowand wrote:
> > On 12/18/18 12:01 PM, Rob Herring wrote:
> >> On Tue, Dec 18, 2018 at 12:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>
> >>> On 12/17/18 2:52 AM, Michael Ellerman wrote:
> >>>> Hi Frank,
> >>>>
> >>>> frowand.list@gmail.com writes:
> >>>>> From: Frank Rowand <frank.rowand@sony.com>
> >>>>>
> >>>>> Non-overlay dynamic devicetree node removal may leave the node in
> >>>>> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> >>>>> will incorrectly find the stale entry.  Remove the node from the
> >>>>> cache.
> >>>>>
> >>>>> Add paranoia checks in of_find_node_by_phandle() as a second level
> >>>>> of defense (do not return cached node if detached, do not add node
> >>>>> to cache if detached).
> >>>>>
> >>>>> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> >>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >>>>> ---
> >>>>
> >>>> Similarly here can we add:
> >>>>
> >>>> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
> >>>
> >>> Yes, thanks.
> >>>
> >>>
> >>>> Cc: stable@vger.kernel.org # v4.17+
> >>>
> >>> Nope, 0b3ce78e90fc does not belong in stable (it is a feature, not a bug
> >>> fix).  So the bug will not be in stable.
> >>
> >> 0b3ce78e90fc landed in v4.17, so Michael's line above is correct.
> >> Annotating it with 4.17 only saves Greg from trying and then emailing
> >> us to backport this patch as it wouldn't apply.
> >
> > Thanks for the correction.  I was both under-thinking and over-thinking,
> > ending up with an incorrect answer.
> >
> > Can you add the Cc: to version 3 patch comments (both 1/2 and 2/2) or do
> > you want me to re-spin?
>
> Now that my thinking has been straightened out, a little bit more checking
> for the other pre-requisite patches show:
>
>   v4.18: commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
>   v4.19: commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")
>
> These can be addressed by changing the "Cc:" to ... # v4.19+
> because stable v4.17.* and v4.18.* are end of life.

EOL shouldn't factor into it. There's always the possibility someone
else picks any kernel version.

> Or the pre-requisites can be listed:
>
>    # v4.17: b9952b5218ad of: overlay: update phandle cache
>    # v4.17: e54192b48da7 of: fix phandle cache creation
>    # v4.17
>
>    # v4.18: e54192b48da7 of: fix phandle cache creation
>    # v4.18
>
>    # v4.19+
>
> Do you have a preference?

I think we just list v4.17 and be done with it.

Rob
