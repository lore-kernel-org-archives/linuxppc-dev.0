Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE92EC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 20:46:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1106B218A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 20:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY0H+uSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1106B218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yyVs12q3zDqZk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 07:46:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="LY0H+uSx"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yySr300SzDqW2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 07:44:28 +1100 (AEDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2802F218D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549917866;
 bh=WVMUwg3hSj8n/u7OrGTWZ8xMtpXengl1pgo9JOSsn5A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LY0H+uSxdj4ZbpQE4WxH4EEPojp1B6v6bpwu82wbFoquu9B+d3VxXDpKReHFGx5pH
 ilfXaHxuuh6EHtBlrZ0ZhmpeSQIB99Cm7mGFEKq5toRt02cegqpjpn+NiWMAt9882h
 ZCdg82Q96E0YsRZ21sEsyTJbWJJAKlK+1jzpO+t0=
Received: by mail-ed1-f51.google.com with SMTP id f9so220248eds.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 12:44:26 -0800 (PST)
X-Gm-Message-State: AHQUAubPKUkOxg8SZdLE6xIdwSN62G3tMBZlg8JJBz01IeTEjgQn26XY
 B4vBGdusPnHMXxUgp39huc/yshtfsQefqbKdP6w=
X-Google-Smtp-Source: AHgI3Ia9P83OXsSDFym2Stnz/ppQJiKozaKElyWO5Xkipqc0SRJDBy/EFsLjoH7ffvBWsSDul8qIX24DxVlRgki1P1A=
X-Received: by 2002:a50:b964:: with SMTP id m91mr86196ede.184.1549917864610;
 Mon, 11 Feb 2019 12:44:24 -0800 (PST)
MIME-Version: 1.0
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
 <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
 <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
 <20190211191341.GA13134@kroah.com>
In-Reply-To: <20190211191341.GA13134@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 11 Feb 2019 14:43:48 -0600
X-Gmail-Original-Message-ID: <CANk1AXRnX+=v+7g-_rM3TwNmM3aVcOqRknv9BR+hBOeCtT24Fg@mail.gmail.com>
Message-ID: <CANk1AXRnX+=v+7g-_rM3TwNmM3aVcOqRknv9BR+hBOeCtT24Fg@mail.gmail.com>
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for
 v20 -- correction: v4.20
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-fpga@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Moritz Fischer <mdf@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 1:13 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 11, 2019 at 12:41:40PM -0600, Alan Tull wrote:
> > On Fri, Nov 9, 2018 at 12:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > What LTSI's are these patches likely to end up in?  Just to be clear,
> > I'm not pushing for any specific answer, I just want to know what to
> > expect.
>
> I have no idea what you are asking here.
>
> What patches?

I probably should have asked my question *below* the pertinent context
of the the 17 patches listed in the pull request, which was:

>       of: overlay: add tests to validate kfrees from overlay removal
>       of: overlay: add missing of_node_put() after add new node to changeset
>       of: overlay: add missing of_node_get() in __of_attach_node_sysfs
>       powerpc/pseries: add of_node_put() in dlpar_detach_node()
>       of: overlay: use prop add changeset entry for property in new nodes
>       of: overlay: do not duplicate properties from overlay for new nodes
>       of: overlay: reorder fields in struct fragment
>       of: overlay: validate overlay properties #address-cells and #size-cells
>       of: overlay: make all pr_debug() and pr_err() messages unique
>       of: overlay: test case of two fragments adding same node
>       of: overlay: check prevents multiple fragments add or delete same node
>       of: overlay: check prevents multiple fragments touching same property
>       of: unittest: remove unused of_unittest_apply_overlay() argument
>       of: overlay: set node fields from properties when add new overlay node
>       of: unittest: allow base devicetree to have symbol metadata
>       of: unittest: find overlays[] entry by name instead of index
>       of: unittest: initialize args before calling of_*parse_*()

> What is "LTSI's"?

I have recently seen some of devicetree patches being picked up for
the 4.20 stable-queue.  That seemed to suggest that some, but not all
of these will end up in the next LTS release.  Also I was wondering if
any of this is likely to get backported to LTSI-4.14.

>
> confused,

Yes, and now I'm confused about the confusion.  Sorry for spreading confusion.

Alan

>
> greg k-h
