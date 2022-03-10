Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96563C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Mar 2022 05:00:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDcMj0R1Bz30RK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Mar 2022 16:00:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3EvzZ+84;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::42e;
 helo=mail-pf1-x42e.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=3EvzZ+84; dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDcLz719Bz2xsq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2022 16:00:11 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id u17so1951750pfk.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Mar 2022 21:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DmlaOnkXV7gYyLatHTSFHCOo07Z7E4KBwil1Hrfv+RU=;
 b=3EvzZ+84RIgKTLctT8/y9GJHmgVsI6b4yA09fCZK8D8rSU7jje0P3SaX7vJ5E6odJr
 LypsvJNqpS7Q9j7Et9R7THMRpBEZNkm6HdnWVdhQcDhOg/EWYxuHvg0yMvrSAJ3oNgX9
 1AAXNJzrcQRuPmBGUWaWTlmiCdmUx7620ZO/WC4V8L1k0omnYrTu+cxMc75J8FGBHo8E
 687a4KVAbdp0l+v8VfxpynWaW3387DvK1O+lryZHb2flExlJYVcOlhZbPfcZi6n3q84w
 YKp0ocBTueQ8x7IHZJ9XRirP1Z+iJhlTg7C46Y4ki4zeX2f4QXz0YWHC2r2C5V/nunJK
 nMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DmlaOnkXV7gYyLatHTSFHCOo07Z7E4KBwil1Hrfv+RU=;
 b=FRNWzskVrFGTaBsltS2Y5VRFlsW2BgikC/CyHikTAelclXPYV+3Ceo9vujHuQsGmu5
 SaiGjBwwMU0Rlv0XgpM5M2vsSE7PUKfJU3Cl+bpQflf6VSq8RONNXNXKxl/HG/R2BFXR
 JXedg/YsJFbZ94T+fl53uNDP+m6dMr7RfDRsP6w8NRhk3qUSjReQZOh5Qc+SpYAw/NKp
 5/jnT5ErxEJwhNzpg8HTxGxHsFlbf68WDyRfyGsTo99l7K9rjy/ypOxbFo0wdhJiyMc6
 aYLtdZYtg3XyLUtEipc9OKJCozaHXSmz6HheL8U4IED4EMqwQ7gMm9GXpAlFmzdEQ8oW
 fV8A==
X-Gm-Message-State: AOAM531+fpS35Tp+TQnYg9I6JQkHeI585xgoAQQoVP8p5dh4eqyjt1Ah
 zR+hNWDSG1K53/jtGHF6vnaCOmNV3UZTJ0sbNvvAUA==
X-Google-Smtp-Source: ABdhPJxJ3M1uMJPPOfvSe4qNin9BErn7l9aDnJzi2AxsDSjcSEqvSkUiqDcMjN3WNNEuA4WH+wsk5FV8ARDID94jxD8=
X-Received: by 2002:a63:2a43:0:b0:376:4b9:f7e0 with SMTP id
 q64-20020a632a43000000b0037604b9f7e0mr2556716pgq.437.1646888408526; Wed, 09
 Mar 2022 21:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20220225143024.47947-1-kjain@linux.ibm.com>
 <38ab9d45-e756-80b2-1b56-287c43c84ca2@linux.ibm.com>
In-Reply-To: <38ab9d45-e756-80b2-1b56-287c43c84ca2@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 9 Mar 2022 20:59:57 -0800
Message-ID: <CAPcyv4ih7Ur_L_=Zce0h5CUSCr1MfqzNdo3-azygT_e9qgDB2g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Add perf interface to expose nvdimm
To: kajoljain <kjain@linux.ibm.com>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Santosh Sivaraj <santosh@fossix.org>,
 maddy@linux.ibm.com, "Weiny, Ira" <ira.weiny@intel.com>,
 rnsastry@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 atrajeev@linux.vnet.ibm.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 7, 2022 at 9:27 PM kajoljain <kjain@linux.ibm.com> wrote:
>
> Hi Dan,
>     Can you take this patch-set if it looks fine to you.
>

Pushed out to my libnvdimm-pending branch for a 0day confirmation
before heading over to linux-next.
