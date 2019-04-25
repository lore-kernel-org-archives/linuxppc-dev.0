Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B406C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:22:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A201120675
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 15:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9nSvzUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A201120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qgsm0dVvzDqcj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 01:22:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="h9nSvzUU"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qgqj0g5pzDqSv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:20:48 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id z8so1590201pln.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yoGmyiBWeZnSsqkaBcEqMFAHcCmUDlyEJTGPecR9P2k=;
 b=h9nSvzUU1D22znVNFQ1LSGhY/0zTExAwrch/8IAqB2qOf32x85XkppW9Qkg8apnTLx
 U31SxfBskuD4jasmcIot/IIyg9VB9JzfcVi/0Ek8ofJ2n0RE/RGVrcRMdRu+1hLUMcry
 BSwLTfgRv9LZcYh2Ptpzeg5Eq7Y91dIZxyWOgWOSPs4a175JAS+jYOyYie3BZqWehcGQ
 Cjowx9sJzpwok5JaMrlbTeb0mEY34SZ4cuEC0NnSSc4naB8eFtosl07D1xt6hhH17Ls5
 jAqBNuY9EwsRHZy5pfApE03f1201K1ED/uINpnqrp0Bi4IRO+XqDAjsKqIO/4yuw7gGF
 K6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yoGmyiBWeZnSsqkaBcEqMFAHcCmUDlyEJTGPecR9P2k=;
 b=cqfHW1ZMYN9p94h3yZTtsBKY1U7Qlxuknas2IuxpIg7iywhvM7iNDam2juDxzobyuC
 CT+4gkblolHwvapCmRyHolHWpX6DsbBXvVL35w8dlnaGzYkspFWVmZcG4O1wuqRCYuI9
 kreYYZa6xvU/ZeSN2N4LaSDdYauECWnfX1cPvWjQMr2auOlsTwUNdGV2v383st88OPix
 7I0jSMQlf7Xer+ytOXH4MV1bb5TRkGqCXzSFcvLGpNEDwA9qutD1mXoyZ57assx+9TUR
 c0aJBDEemVO9NvHpUNEh4aB0sa6tOuexgsJaoYF4T5S5boOtqPl5yAAQ2SwXrfr5OuIU
 1itw==
X-Gm-Message-State: APjAAAWVouKwqhDCyp6iYk4uQ2kcVrnwO+alR4axIe2ZfXCemN5DBsTX
 carCHVc1c9MCv3aIJ4JhFlQ=
X-Google-Smtp-Source: APXvYqwiI2NpjrX77r+6N7Cj/eYgSoQZlyoYY9SaicaEwRGqAwKcL+aCStyywLLg2owA0vEn3apKfQ==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr40074978ple.62.1556205645128; 
 Thu, 25 Apr 2019 08:20:45 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v15sm30955894pff.105.2019.04.25.08.20.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 Apr 2019 08:20:44 -0700 (PDT)
Date: Thu, 25 Apr 2019 23:20:35 +0800
From: Changbin Du <changbin.du@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 00/23] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190425152034.u4q6wjhm3yfhbnzp@mail.google.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
 <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
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
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 25, 2019 at 10:44:14AM +0200, Rafael J. Wysocki wrote:
> .On Wed, Apr 24, 2019 at 7:54 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Hi All,
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> > reST format in this serias.
> >
> > The hieararchy of ACPI docs are based on Corbet's suggestion:
> > https://lkml.org/lkml/2019/4/3/1047
> > I did some adjustment according to the content and finally they are placed as:
> > Documentation/firmware-guide/acpi/
> 
> I'd like to queue up this series, but it is missing a patch to create
> Documentation/firmware-guide/acpi/index.rst.
> 
> Care to provide one?
oops, the first patch is missed. Let me add it next.

-- 
Cheers,
Changbin Du
