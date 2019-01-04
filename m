Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5F2C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 17:48:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A1021872
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 17:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zah8HQFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A1021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WXML06QJzDqNn
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 04:48:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zah8HQFA"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WXKf6j2xzDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 04:47:02 +1100 (AEDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA11821872
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546624019;
 bh=DX9SVpw1a/H0h5G9P6YYsGTnS5rJGiARNv3EjPDdPy0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Zah8HQFAQuxJ+V/LrIcbB6iPEj+pAV7fwibz8LJM1xgptNPjZpxX242qQrPL/SDqp
 kRtRy/nMKdiZVV7DKimMh9CfVuEyiemF7apb27P7W4PQ/pDl6piGLcWO7IbkzFtUtl
 zaUrNjO6Ruk9S2nhZuY3MWHRTOMr0LM6jRe3g0qQ=
Received: by mail-qk1-f182.google.com with SMTP id y16so21928748qki.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 09:46:59 -0800 (PST)
X-Gm-Message-State: AJcUukcJ5IhGzDEd0R2TeutUWQFae5aj5flBQWmiCG7tbsofTys+WwJM
 IIx+6MQX+rd/rcWXjDjyr2z8PnKxrA7YHrjBWw==
X-Google-Smtp-Source: ALg8bN6lbN6IYt8HBU4h2chHQ+lI9e7YOem3Rwtx1bNujcBM644c/lYcoTmHl4NvCY8PPpoJsYEun8V1xQgJ1QzJyn8=
X-Received: by 2002:a37:b646:: with SMTP id g67mr48718816qkf.326.1546624018937; 
 Fri, 04 Jan 2019 09:46:58 -0800 (PST)
MIME-Version: 1.0
References: <1546595897-33291-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1546595897-33291-1-git-send-email-clabbe@baylibre.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 4 Jan 2019 11:46:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Wo7kWTHg6f+HkTfq1=JN8r4iBrwSz9JRdJ0rhjyKSpg@mail.gmail.com>
Message-ID: <CAL_Jsq+Wo7kWTHg6f+HkTfq1=JN8r4iBrwSz9JRdJ0rhjyKSpg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: build dtb even without COMPILE_TEST
To: Corentin Labbe <clabbe@baylibre.com>
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 4, 2019 at 3:58 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> I wanted to test the virtex440-ml507 qemu machine and found that the dtb
> for it was not builded.

Just do:

make virtex440-ml507.dtb

> All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
> COMPILE_TEST.
> But building DTB is not related to a "compile build test".

But it is. We normally only build the dtbs for enabled platforms just
like we only build platform/driver code for enabled platforms. It's
hidden behind COMPILE_TEST so it only gets enabled for
allmodconfig/allyesconfig builds.

> So this patch made building of DTB independent of COMPILE_TEST (by
> depending only on the PPC arch)
> A better selection of which DTB to build could be done in the future
> like that do the ARM arch.

No reason you can't start that now for the platform you care about.
You don't have to convert everyone.

Rob
