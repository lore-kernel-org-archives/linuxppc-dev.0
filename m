Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED8ECDE45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 16:13:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5DD21479
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w9gHLqVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5DD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c9tl4SJ7zDrbW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 03:13:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="w9gHLqVu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="w9gHLqVu"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c9qt1gsCzF3Zq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2018 03:10:34 +1100 (AEDT)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D608D2083E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539965432;
 bh=XxhNLthymnIFPnHMwqFaCxA9IGCUpdnIUE4qhaivIQ4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=w9gHLqVuqNPsctDlQ7tHtR6+vC16XXFbnwa3C/88PX6VU6kx7a3wOxSFriZvWNMvt
 d1RhducvH+/F81OdvtQ9YSTqH6XlJy9ZoQMgxn+APlZlCX5tSC2IDw5Oa7lgvM8roP
 qPzsTkU9VkeMFaZYCffuqorh3fOsjJMvJYYWfD5M=
Received: by mail-qk1-f178.google.com with SMTP id v68-v6so21307139qka.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 09:10:31 -0700 (PDT)
X-Gm-Message-State: ABuFfohjYRbj0DrPr3esKKfpUMes3X5UK28kUK6OLlTgg0TBP9yUhsmg
 Qzs1I7rqCs3iB0JkUMZS6X+ihKWPlRsT0MGJTQ==
X-Google-Smtp-Source: ACcGV61NyC1iT4WkxZa+hGw+8Yzd3BndnZqnyVQXo1Vcv93kCbCrqb6NwE05BgZz5YSW+7+HZwkBCdrpzIBcFM0I7jI=
X-Received: by 2002:a37:9201:: with SMTP id
 u1-v6mr31342061qkd.29.1539965430939; 
 Fri, 19 Oct 2018 09:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
 <20181018170931.GC15557@bogus>
 <780fb659-29e8-1ef4-4f62-97dacf36f6c8@gmail.com>
In-Reply-To: <780fb659-29e8-1ef4-4f62-97dacf36f6c8@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 19 Oct 2018 11:10:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+WW2kMHzExMrQvUCAODvOrDW3gTrJzvSUd_3n55oCwA@mail.gmail.com>
Message-ID: <CAL_JsqJ+WW2kMHzExMrQvUCAODvOrDW3gTrJzvSUd_3n55oCwA@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
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
Cc: devicetree@vger.kernel.org, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 18, 2018 at 2:09 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/18/18 10:09, Rob Herring wrote:
> > On Mon, Oct 15, 2018 at 07:37:24PM -0700, frowand.list@gmail.com wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> >> added a missing of_node_get() to __of_attach_node_sysfs().  This
> >> results in a refcount imbalance for nodes attached with
> >> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
> >> to __of_attach_node_sysfs() is:
> >>
> >>    dlpar_attach_node()
> >>       of_attach_node()
> >>          __of_attach_node_sysfs()
> >
> > IIRC, there's a long standing item in the todo (Grant's) to convert the
> > open coded dlpar code. Maybe you want to do that first?
>
> I'd like to avoid extra delays to getting the current (with necesary
> fixes) series accepted because the series is rather intrusive and
> could have conflicts with other patches.
>
> I'm also worried that I don't have access to any of the systems that
> use the dynamic overlay code, and I don't have any way to test the
> changes.

Mainly I was thinking you are asking them to test changes now, so I
was thinking better to do that once than twice.

Either way is fine though.

> Can we encourage the users of this code to convert the open coded
> dlpar code?

That would be ideal...

Rob
