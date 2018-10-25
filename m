Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7E3C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 15:28:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E1D20834
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt1tDyrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E1D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42grcQ3f4GzF3BM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 02:28:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zt1tDyrG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zt1tDyrG"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42grYT5rmYzF38h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 02:25:49 +1100 (AEDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6A0E02084A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1540481147;
 bh=FCrF2YHz2MfojPFyTuAvP5QlpHDzWF57g5PQi4J27xI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Zt1tDyrGZjKA56LreYLZKs8xrCtDqTYqJMQlyv2l1UvwWLXOiy+ukFiCBdR6dATXh
 lr1NO4ZV5w6cux6N0BbNpUXtpur3onI5Y0vs19ULOlBrv3bb6ZrsRns4k1ijW+KvQP
 9iaBFiB8kOBCwu/sheD1Jpgq3GKh8B9+7/qI6E+k=
Received: by mail-ed1-f52.google.com with SMTP id z21-v6so8871996edb.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 08:25:47 -0700 (PDT)
X-Gm-Message-State: AGRZ1gI9XKAIE3gVZnccpvW2gzFI6EMOZzJUgyo4hu0MJm77MGJzlcsT
 uuePaZUqW/Kj6uYb2X7qo6Kz9o0p38EUpIquvDE=
X-Google-Smtp-Source: AJdET5cibd5l0pUpniCzpA9LucOOY+NTfspwxkKVa2Y7KnvB2fc28JppIApgOnWBR8SZ5Gpn+iXzvdSpTrG9iIFC3ZE=
X-Received: by 2002:a17:906:3cea:: with SMTP id
 d10-v6mr1406576ejh.168.1540481145897; 
 Thu, 25 Oct 2018 08:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
 <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
 <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 25 Oct 2018 10:25:08 -0500
X-Gmail-Original-Message-ID: <CANk1AXTm3G-xLz6nEeBh+JGLxF91Cn1-w=J+vKKM2qz1sqLXbA@mail.gmail.com>
Message-ID: <CANk1AXTm3G-xLz6nEeBh+JGLxF91Cn1-w=J+vKKM2qz1sqLXbA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
To: Rob Herring <robh+dt@kernel.org>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Frank Rowand <frowand.list@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 24, 2018 at 2:57 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Oct 22, 2018 at 4:25 PM Alan Tull <atull@kernel.org> wrote:
> >
> > On Thu, Oct 18, 2018 at 5:48 PM <frowand.list@gmail.com> wrote:
> > >
> > > From: Frank Rowand <frank.rowand@sony.com>
> > >
> > > Add checks to (1) overlay apply process and (2) memory freeing
> > > triggered by overlay release.  The checks are intended to detect
> > > possible memory leaks and invalid overlays.
> >
> > I've tested v5, nothing new to report.
>
> Does that mean everything broken or everything works great? In the
> latter case, care to give a Tested-by.
>
> Rob

Tested-by: Alan Tull <atull@kernel.org>

Alan
