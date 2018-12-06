Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A32C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 23:36:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C4520878
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 23:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8R+GUK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439sRj5ZdFzDrTQ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 10:36:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z8R+GUK8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z8R+GUK8"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439sNm1gHnzDrSK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 10:33:28 +1100 (AEDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 083BD214DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544139206;
 bh=gZxZKWzS/CFBRJ5cx9gU4j7NTuSbfpHO6a+5reMvM/I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Z8R+GUK8HmCWPi80PyCnBiS2XVMwSALm+ygpr1Sb4NJTdT+RF6UcKTs2v8neW/MRT
 GVKK0yHT+VR4xT+Jnj9WY5GIJiNonv+56yeq2kJU6+i3PzYey5XM21Dg97lqWG/sfS
 vcqs/Q1VjdEmcMUYKwSYmLNeoqjLcLvuAey0TbrA=
Received: by mail-qk1-f169.google.com with SMTP id a132so1467449qkg.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 15:33:25 -0800 (PST)
X-Gm-Message-State: AA+aEWZ5c3xu3tt8U5TgRgRb8y63aGLQmW1D5mrZqLvZ2QqfF+P6KG4o
 mn6EpaWCGEKxWZMu0h/FXma1Jy3lsG3S0nIFHg==
X-Google-Smtp-Source: AFSGD/VAAUM4UeHiln1FkoZdLxs4GVSy23jQgIG4UQhXKT7qgvB21vJxN+mpR+mykRFVaL2JgzlKp+pHBoQKxo1/gxg=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr28723113qkg.147.1544139205175; 
 Thu, 06 Dec 2018 15:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
In-Reply-To: <20181206023140.GZ3987@dragon>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 17:33:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
Message-ID: <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc bindings
 to json-schema
To: Shawn Guo <shawnguo@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 5, 2018 at 8:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> > Convert Freescale SoC bindings to DT schema format using json-schema.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/armadeus.txt      |   6 -
> >  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
> >  .../bindings/arm/compulab-boards.txt          |  25 --
> >  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
> >  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
>
> Rob,
>
> I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
> tree, so please send it via your tree.

What about:

c386f362957b dt-bindings: Add compatible string for LS1028A-QDS
3671cd57de06 dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding

>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
