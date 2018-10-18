Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FCEC67863
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 19:41:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83432205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 19:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBFmOkyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83432205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bfZC5XpHzF3HP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 06:41:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBFmOkyT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=radu.rendec@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBFmOkyT"; 
 dkim-atps=neutral
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bfR31CSbzF3HS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 06:35:42 +1100 (AEDT)
Received: by mail-oi1-x236.google.com with SMTP id p125-v6so24988659oic.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=7wRg+/HszAmijc4G8vIxHpyjs/hhpcWcWwV3Maja0X8=;
 b=UBFmOkyTGTjWO9vr10Rdfr7t6+g0YbaRmNN+k+7D/D92P4Ftx7xIaXjpzP53GRRu7/
 zHnDy7td4SS+0/hSeKVSLOif8Cz62aGh4mMQWnyWXdqzHHhgh/T3eewXW+ugN/O9n6UV
 GcYHb0iqVlIdTPPAF+//okgKyvRVCOM9egw9hOBGdDq8aCyGPMs96CJl930JMKm4DASO
 F2TreWBV1kfYR9LB4W7/orV9IFchue48nkbN3WlgM9HQhbMECcLTVILPikRwdTDAGF12
 IX6w1b6wF3Rv2vbJd4YCIOSmact9XRNB4beb2/X3+jSdEJYNZ4Jp/DSiyIXaQG15+MJC
 RKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=7wRg+/HszAmijc4G8vIxHpyjs/hhpcWcWwV3Maja0X8=;
 b=KA8wOAvYBJiehTc36bPUHfWEAFJSLuqt8gYMscJqi7RdzMfB25OdxGjyoCeJTG5QFi
 yJ8g1w7lSY2jPksBTnZBD7hfbfJTzC3R8tKocGXYGN1p0e+Ewbjwu3fu5ywWHKicBLut
 csl/DGO5ZjdeaFIPGh7ir5ANnoksZtoNeGd3xE81NTUuL9sIENsVy30l3e6NjecCpk+J
 beVGHdKYm5W+ZK+Yl//I2vXrph2yMiCIYsfSqXaaT2dAI/o0b53LG1rUU+UtkcbETUZ3
 Zdz55cnWnS2zPOsY58eQTPN+dKX+9Wpiu4pmLc9a1zep9HDEzExErueaUM/rQoSf+aSf
 dUWw==
X-Gm-Message-State: ABuFfoh1Y/nJ37eXpzfpUj39nApjBLGcercJYvhv4oyj7HZbMKQ/aYxj
 qMeVnu6BNJT1trxBEJVOcn2WQoR1Om3cDFPZzpxEw1O72Z4=
X-Google-Smtp-Source: ACcGV61PaEj+AiJ9PrbgI/AJzHig9h6IyI0UtJMGGxGrnyL2W+KS4RHBIQo4Oqo0uiB/IbJRmPN6bBrk8yv+DSQBwBA=
X-Received: by 2002:aca:dc46:: with SMTP id
 t67-v6mr17840481oig.65.1539891340066; 
 Thu, 18 Oct 2018 12:35:40 -0700 (PDT)
MIME-Version: 1.0
From: Radu Rendec <radu.rendec@gmail.com>
Date: Thu, 18 Oct 2018 15:35:28 -0400
Message-ID: <CAD5jUk8eh+AMpSsrOZ9xLqY0yb06YpJduCA9NWMiJhe0ojogXQ@mail.gmail.com>
Subject: Regression: compile error on mpc83xx
To: linuxppc-dev@lists.ozlabs.org
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
Cc: Scott Wood <scottwood@freescale.com>, Li Yang <leoli@freescale.com>,
 Jia Hongtao <hongtao.jia@freescale.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi everyone,

I'm getting the following compile error for mpc83xx in v4.9.115:

arch/powerpc/sysdev/built-in.o: In function `fsl_of_msi_probe':
fsl_msi.c:(.text+0x1548): undefined reference to `fsl_mpic_primary_get_version'

This seems to have been fixed in v3.12-rc1 by commit df1024ad8728. Then,
somewhere between v4.0 and v4.1 the following two commits changed the
arch/powerpc/include/asm/mpic.h file and that function again:
5e86bfde9cd9
807d38b73b63

After those two commits, it seems we're back to square one. I haven't
tested, but it looks like there haven't been any other changes to that
file up to the latest master in Linus' tree, so I believe the problem is
still there in the latest kernel.

Should commit df1024ad8728 be reapplied?

Thanks,
Radu Rendec
