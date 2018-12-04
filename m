Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A57C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B222C20851
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B222C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438KGq4xJRzDqMW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:22:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.41; helo=mail-ot1-f41.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438KC16GZ0zDqbp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 22:19:41 +1100 (AEDT)
Received: by mail-ot1-f41.google.com with SMTP id n8so10933590otl.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 03:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qLUorFvCoSYCdKoeEnTaL4AUk5rpymHFh430D/XH7jc=;
 b=t0OVx1irEwGRomZUBEEv1voH5Xw1iuFyo9G8Ua0hxhr7dwS1QROFtxK6Qnvh2ukkxu
 IkOP71mRJy11/+EA5UxjfYLhfg63WtNjPhsoAlklt+qKCIJWqcFfvRXlGX8EuMnqmEMG
 hHR1LG41es3M4keuJX8krzIQAQ3FrvF/7H4GBkw0uRSS0cTtSsyzPLubiW/ulXh8cWIW
 llLnKi+v4ye4/QoMioC5VP+zEjoDjE6JGbeZ7n1w0DZB6EigUJfjjIkoYvdDUCK5UOhk
 6YK+jlJm35ja/g0UZ8WUaTouyfLX+Lw3diGJzvb1Kve7bLNSOag7ivDx8/Qe88Y6T5zg
 njJQ==
X-Gm-Message-State: AA+aEWYu8wqII803tHltTbIDMpeMHK4VVGa5fsMZjxbG2AFsfdKcsByK
 JUJYururzmwojyt7ybXA0gjyEEHwVujNHU/36XEuab3W
X-Google-Smtp-Source: AFSGD/WPXarniE/ogpWl9OGjtV3vTFA/JqN+85SzwFDotlZvL1b3QNg8rQxj30TUArIA0poY9gP8FhWy68UQPiUJJo0=
X-Received: by 2002:a9d:22a:: with SMTP id 39mr13109848otb.354.1543922379536; 
 Tue, 04 Dec 2018 03:19:39 -0800 (PST)
MIME-Version: 1.0
References: <e62a9e80561092fbb7c532203ebe1f3accdc3fa6.camel@kernel.crashing.org>
In-Reply-To: <e62a9e80561092fbb7c532203ebe1f3accdc3fa6.camel@kernel.crashing.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 4 Dec 2018 12:19:26 +0100
Message-ID: <CA+7wUsyAkxEtf6kaH7hLZA4MMfFPPFFzc9j4F7VbHR=S9Abnag@mail.gmail.com>
Subject: Re: ppc440gp "ebony" board manual/specs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 4, 2018 at 12:09 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Hi folks !
>
> Does anybody still has the manual or schematics (or both!) of the old
> "ebony" ppc440gp eval board around by any chance ?

A google search for:

IBM/AMCC "PPC440GP" Evaluation Board datasheet

leads to:

https://4donline.ihs.com/images/VipMasterIC/IC/AMCC/AMCCS00334/AMCCS00334-1.pdf?hkey=EF798316E3902B6ED9A73243A3159BB0
