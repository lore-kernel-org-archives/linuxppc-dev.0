Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C825C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 13:04:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6300420862
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 13:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjhFS2IS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6300420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Rvn2V3mzDqXm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 00:04:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjhFS2IS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=tiny.windzz@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjhFS2IS"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433RqM400dzDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 00:00:47 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id m8so6987525itk.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 05:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aurTFiuGcAp0aZRcwPqJiCDfSL5ycdScu5LfdN6gKNk=;
 b=kjhFS2ISx1RFdEAsDcTf73+6wKk4QpAaMdKKui3PbyIRZn3cNhRgz0HV9iO+DB7IRv
 zEKuJp3WnJYEpv0h8fbBH7hyO3uu4XCACgOYaEt+eZev6C7KfSFW0rU+o+FDYZ4eKVn8
 pACee20caNHKYkD0CTd7CXrmCCr9lNAGkJ5mAzi3o+v3eZ67dg+GvdnFkpKbsRUprX4c
 jNUv67LbySBuhXmWfCEo7FUzan5Mue3KM65zxwu0jFm+5+Ur92egw5Bzz52/tgP7pFra
 rVnAcZkfTtzP/2D2MF2GsgBBzWGM7IqTsrxB0NBMRKUkQ+cGfzv8UD9+BFHPu1O1YsiM
 7YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aurTFiuGcAp0aZRcwPqJiCDfSL5ycdScu5LfdN6gKNk=;
 b=FuFhZK2aitSdAZompLNOouN+jMAOMxaIfbheDLSvDgR3Q6LCSNEomPXOtxUFrAWmU8
 S4QlnOutjZFGS+lMg2DLDwiNGG3WFAOo2ruYTYZed6gaWBrYTwZ/fq2V3Z/die/B3u72
 eAkCWmIKmjDuEvRbJL5lR0//BD1ntC80e80wTdFntwUKxDqxqBLVhDmyXCFtlsX62j6a
 oQZESmAD9ybJKAVjzJNc8wxQ3scEjBZwvPc0BPCC2pcVXGaH5Z8SmAmEH4BV8Y8j1o6B
 9JDg0HvBMlumrtwPkJv7axbc2vdjW8viVDvMczIW3jlApJkU5KBOCYyTlw3pWTDQBCNz
 b8kw==
X-Gm-Message-State: AA+aEWYaTrwKY24izF56Tgcv3fY5xbNFWbpTKyLxACFzFSYdo2MGlKGQ
 /w0E/u45P6iBCdpCwq6rhZ0A0ydkzV5w5DzIGNI=
X-Google-Smtp-Source: AFSGD/U71LBiXCAc+cjpmoz2Lh67bPnr/Ou4RlcyM+deVTbsfUwSyQBFNDnsoyvlbjngRPh6dlZKnal5k8vaSmvqC5g=
X-Received: by 2002:a02:5184:: with SMTP id s126mr18601064jaa.12.1543237245405; 
 Mon, 26 Nov 2018 05:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20181120160530.21015-1-tiny.windzz@gmail.com>
 <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
In-Reply-To: <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Mon, 26 Nov 2018 21:00:23 +0800
Message-ID: <CAEExFWu7rt8oOHFtrvy0h=gwhMaNFXHuaaOxTnLcQfZDXsy9yw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: powernv: add of_node_put()
To: ego@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 21, 2018 at 12:02 PM Viresh Kumar <viresh.kumar@linaro.org> wro=
te:
>
> On 20-11-18, 11:05, Yangtao Li wrote:
> > The of_find_node_by_path() returns a node pointer with refcount
> > incremented,but there is the lack of use of the of_node_put() when
> > done.Add the missing of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v2
> > -update changelog
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --
> viresh
Hi Gautham=EF=BC=9A

Can you add your Reviewed-by here?

Thanks=EF=BC=8C
Yangtao
