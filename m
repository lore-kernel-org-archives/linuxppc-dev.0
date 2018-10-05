Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DACC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:55:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CDC2087D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl+jE4rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CDC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RXr00T7kzF3TM
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 00:55:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tl+jE4rM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tl+jE4rM"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RXnH3zNVzF3Rq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 00:53:23 +1000 (AEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37FF021473
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538751201;
 bh=00zcc7T9LOqqvcw8lccqOwJaFe1MY6VWDH4ECJFlkn0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Tl+jE4rMsSuXm7vxnCkApF5zbU5S1iCkUWnHjuOXM7ME4r5SF+OThrHYbQoomG/3+
 jNL3AGZ9XjeG95ghbh6wob3L/FurmTViXDIP8suDsFLOXIEGASFxk4u77iRB0ENTK6
 Xtgvi/FBv3Gaq9ZBEtx8xBIcP/izrBjKwdvGwYF4=
Received: by mail-qt1-f174.google.com with SMTP id l41-v6so1489441qtl.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 07:53:21 -0700 (PDT)
X-Gm-Message-State: ABuFfog+xNiccWRcZwTsoT2k3JPAjbitpMRsRbT+QShCpkcHNNeUv1Ff
 ZDZB5FHYjBJEJtZjH+1zbv56FH0byjOVQ1Tz6w==
X-Google-Smtp-Source: ACcGV61UtYTBgqWR4Mbl1nxSdTwcm9wKf7n/oxaa9XcPPvcWE+aikjffBw8WLByXacL/CLAsjyI6fN7yi6RSp/gnCnI=
X-Received: by 2002:ac8:2ac9:: with SMTP id
 c9-v6mr9642544qta.188.1538751200204; 
 Fri, 05 Oct 2018 07:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 5 Oct 2018 09:53:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
Message-ID: <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling
 of_irq_parse_one()
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Callers of of_irq_parse_one() blindly use the pointer args.np
> without checking whether of_irq_parse_one() had an error and
> thus did not set the value of args.np.  Initialize args to
> zero so that using the format "%pOF" to show the value of
> args.np will show "(null)" when of_irq_parse_one() has an
> error and does not set args.np instead of trying to
> dereference a random value.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Does this need to be part of this series?

Rob
