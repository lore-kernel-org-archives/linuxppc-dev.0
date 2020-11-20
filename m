Return-Path: <SRS0=wfc/=E2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A7C63777
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 13:36:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6CC22272
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 13:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKEUq0NE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6CC22272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CcyJB6zTLzDr0C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2020 00:36:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::142;
 helo=mail-lf1-x142.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=JKEUq0NE; dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CcyB92tDdzDqxs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2020 00:31:28 +1100 (AEDT)
Received: by mail-lf1-x142.google.com with SMTP id j205so13432988lfj.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 05:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kLH0OGgbTBQgr1BhqOOxL+SRFwucXklLFSza60U5gmw=;
 b=JKEUq0NEzlifFWaBA0D5lpOCB04lQlGFemaSKS3XzHa6RVCpvPxPOYXGJ7003oIDTI
 dMmWk6pBpkgepW/ySiTZemD8gvfPu4w6wimX0PYxJ20vLsk3gl41t2vYIqYJ56rTHzkK
 d8JZRqwCu6nxm4e/30FpGxqx+wiAOCDO1E9Qt22yKm9Shm9O3u3VdlJpBTT7HE5O/SK8
 yTrFPuK9h+rL1z5/UR80zns/AJcIB8M8HLavZRzmpJaEqBO5HrH8hKEPVRLVFM9dlZfu
 HnAH9MOd2N/ZjqcndFEklFUVo1V0haiHnnQ8xv3+54jY4sGe7j084GdI8DSRlLCTd+Fd
 4BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kLH0OGgbTBQgr1BhqOOxL+SRFwucXklLFSza60U5gmw=;
 b=VqY87JRRjtuOcMG69J9qDr5ejOFbSVqTHh8UqlqomnHFM5q1WhCP4B2hIRnX1VfRTG
 hu1k+4d/toD0xBCUozGpAEsabX8fVYMtSYdPY7UiVQDJ3P1GYOMs3zeKSS62FQUpW1G3
 Gs/dUXlxdydykqW6J4rCBmOMMsinLhhAaicPA2OmYSLH7SBTNGfGZ1OyQZXMRPPQgah1
 /X+g82onMhYDxK+9EQ/VIeuYZ7h4nn0/g9iglVZklMcLAY7TStuQVSxyP1mzA3OFzzTm
 Geaay9yQ2mphC2qJgwJJfBF/B3dAdRQHt1UcohCb1VaW8OTb+Xjb2rvguyVbZpZ1h18p
 fHTA==
X-Gm-Message-State: AOAM532PN7MqB3vUdHNiKjU+zuN0sO01S2dcVZFGtl1dvw4/TEw5l9ss
 4loLxRR2ITVjair9BjYJ1QOY5OCHfWoz7eMZK9U=
X-Google-Smtp-Source: ABdhPJy+LkcPERZsa7lbfU5qX6+D00AemKwTfYvzLQ8Krd9kR0rfrY7Qk4AvsVLPh5AlaJe2YaADA055SMDxj7jipqU=
X-Received: by 2002:a19:207:: with SMTP id 7mr8578863lfc.251.1605879083895;
 Fri, 20 Nov 2020 05:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20201120001509.15155-1-festevam@gmail.com>
 <87ima01r52.fsf@mpe.ellerman.id.au>
In-Reply-To: <87ima01r52.fsf@mpe.ellerman.id.au>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Nov 2020 10:31:11 -0300
Message-ID: <CAOMZO5CrtC627GJ=fM6Wruf765pfxAGboPJhfDrhYG5a2OjpRA@mail.gmail.com>
Subject: Re: [PATCH] media: fsl-viu: Use proper check for presence of {out,
 in}_be32()
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Geert Uytterhoeven <geert@linux-m68k.org>, paulus@samba.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-media <linux-media@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

On Fri, Nov 20, 2020 at 3:25 AM Michael Ellerman <mpe@ellerman.id.au> wrote:

> I'd rather not have to carry this in arch code just for one driver.

Fair enough.

> Can't the driver just use ioread/write32be() on all platforms?

Yes, this is a better approach. I have just a patch doing that.

Thanks
