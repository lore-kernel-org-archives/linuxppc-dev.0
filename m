Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF626ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 20:00:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4561520832
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 20:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+ieZtxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4561520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gLjC0PxrzDrPc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 07:00:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B+ieZtxx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="B+ieZtxx"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gLdj0P0PzDrPq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 06:57:44 +1100 (AEDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DDE0620847
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1540411063;
 bh=FwSMMBXy4dTKeHHTSnecuMQFteZbKG+ZULO94V/G9pE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=B+ieZtxxPkpl7s2uaCNCOQHb8m9Myj+Gcu5doULu5NVKrbelztJ+ImjQpuIoULgKm
 mT3tDOHOMvq+BdcXD5131P5BzLGYh699QThFT7hKSGu/Sylo90x7PwwPDkk32FJYv4
 iJaoDkIPA0Q8tniciTMu8zlX0fExjuW/mWzdpBAU=
Received: by mail-qt1-f171.google.com with SMTP id l9-v6so7071040qtj.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 12:57:42 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKckVrsak0teCRAaDSaLqeqXOG/RvrAAQIIT7SxcHVsWzDgri2d
 pbbK6XjXm7vCQxUQ3PbGRRrx6KS/9NKe0IljWA==
X-Google-Smtp-Source: AJdET5dz2pAxrLhL1s78L9G/BjFv/eV20ClHTl+pz2d+Vc1RRTtvEwx8YK8gPVn10dkAVdEWTBKPxZyRtiiBa2FaSoM=
X-Received: by 2002:a0c:8c86:: with SMTP id
 p6-v6mr3772591qvb.246.1540411062071; 
 Wed, 24 Oct 2018 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
 <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
In-Reply-To: <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 24 Oct 2018 14:57:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
Message-ID: <CAL_JsqJ1=5ABi5N50HLTSu2xFGJJSf-6EpuvhkG-rxSbv3MZdw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
To: Alan Tull <atull@kernel.org>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Frank Rowand <frowand.list@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 22, 2018 at 4:25 PM Alan Tull <atull@kernel.org> wrote:
>
> On Thu, Oct 18, 2018 at 5:48 PM <frowand.list@gmail.com> wrote:
> >
> > From: Frank Rowand <frank.rowand@sony.com>
> >
> > Add checks to (1) overlay apply process and (2) memory freeing
> > triggered by overlay release.  The checks are intended to detect
> > possible memory leaks and invalid overlays.
>
> I've tested v5, nothing new to report.

Does that mean everything broken or everything works great? In the
latter case, care to give a Tested-by.

Rob
