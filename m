Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EABC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 21:46:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863DE20827
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 21:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW/G7GZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863DE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42sDJ93cn6zF3hW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 08:46:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nW/G7GZt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nW/G7GZt"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42sDFb0nv5zF3dl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 08:44:34 +1100 (AEDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6616320989
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 21:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541799872;
 bh=i6Yl9ehwxuvkZu0JHzcxfI9DUXZQnWkI23kex8Us1Bs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nW/G7GZtJh8KeVKTLuPSWx6/AlXMAcLXIn+dt+3J/7aI2hbtn7LYrUZhqtOucMs3b
 3Uk8Bm3gLkshwDu528zndXxVcdR6AIEvgr+CP9qy2/dQqVHCY9XvJBGQCvuRNlOwLh
 P/qy0Ynl91pvaApZLTv/Wz9YBpcknmn5hj1odtK4=
Received: by mail-qk1-f182.google.com with SMTP id q1so4274720qkf.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Nov 2018 13:44:32 -0800 (PST)
X-Gm-Message-State: AGRZ1gKH8X9sox05CGNz/YjvLEZhKn7KOg+7/qXpK7y2elevDXmrTRPE
 ANdxmoLH1s3g0/65vogvKjPG+3bonAVRu5K+xg==
X-Google-Smtp-Source: AJdET5dll8YPqA7IlzBzkbVWwEDv5QadKxyJyTfFt+I3HmTsLE52xce2gx/7BPTnub1DCIncQbipkWjwOKu40SAOw7s=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr10393361qve.246.1541799871583; 
 Fri, 09 Nov 2018 13:44:31 -0800 (PST)
MIME-Version: 1.0
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
In-Reply-To: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 9 Nov 2018 15:44:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJHNAYAtL791UsPE=J9L97cOGvRVkqP+3VuuT5qVmRHw@mail.gmail.com>
Message-ID: <CAL_JsqJJHNAYAtL791UsPE=J9L97cOGvRVkqP+3VuuT5qVmRHw@mail.gmail.com>
Subject: Re: [GIT PULL] of: overlay: validation checks,
 subsequent fixes for v20
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

On Fri, Nov 9, 2018 at 12:56 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Rob,
>
> Please pull the changes to add the overlay validation checks.
>
> This is the v7 version of the patch series.

Pulled for 4.21. Thanks.

Rob
