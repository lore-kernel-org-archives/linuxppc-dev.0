Return-Path: <SRS0=MUiv=6C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DCAC352BE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 19:22:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACF3221E9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 19:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACF3221E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 494NBw5KpYzDsGm
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Apr 2020 05:22:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.131; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494My85HVyzDrj5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2020 05:11:28 +1000 (AEST)
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N7zJj-1jBwrI2DNz-0155RT for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr
 2020 21:11:23 +0200
Received: by mail-qt1-f172.google.com with SMTP id w24so5061194qts.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2020 12:11:23 -0700 (PDT)
X-Gm-Message-State: AGi0PubXWVbu9xyfpxr1eHTK8t6DSQNf+BoOjDaHfCjewsWqVr0AROkB
 /Uh6PVCYoazVAr3Oez/9YQoJP4WLZJlq0p9t3jQ=
X-Google-Smtp-Source: APiQypI5XWv+0v5CUPd6xcl5C/iLVZmU2I5uN+IAnHyrQzOErNeb/Vq46nsA5qUEtPCx2jH3AALWiUq8REeGQkl/9Vg=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr2801144qtv.142.1587237082474; 
 Sat, 18 Apr 2020 12:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200418162157.50428-1-wenhu.wang@vivo.com>
 <20200418162157.50428-5-wenhu.wang@vivo.com>
In-Reply-To: <20200418162157.50428-5-wenhu.wang@vivo.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 18 Apr 2020 21:11:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-7mLhGb=LCAQSTL4kNoGVcBcQOca=-tJkZAj1w2Bxsg@mail.gmail.com>
Message-ID: <CAK8P3a0-7mLhGb=LCAQSTL4kNoGVcBcQOca=-tJkZAj1w2Bxsg@mail.gmail.com>
Subject: Re: [PATCH v6, 4/4] drivers: misc: new driver sram_uapi for user level
 SRAM access
To: Wang Wenhu <wenhu.wang@vivo.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zItT9gr0eylhpWGs7/EVvRJe+RisiXf8DtGdsYDJtCXWs1icD2F
 3EaKAg6KXihEy0af0+1FoYO8BvEZUn/PEeQUOODI25BhVb3v99WHZUlJx1ebH/HH/EPy8OH
 U9KonU0A0CXVOGgmfCYnOAOOHBGW6Ytny9J0LdWrpGgUSuwsW5/awZoAS2nKUcCtRnwljMZ
 cpWyppvLCR6qkUnKieYOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wpOTqRJVBIc=:316x6rIVYJYt6IUBWhNmQG
 pw9RoXkyuNvysWFGglXajqJejqQGvodQu5JXFp01ZDq7e1jSYNmFhXN92Z0taQ0e9/6gTgqZx
 IbJ8bdjUx2ARde45QPt9oZ+/drmkHgqQVR1K2VRejKjwS+X5Cp03/a6/CESQfBmeyarCYnRok
 BXtkKLjCpSZ8yZ8A4RxbO23qg6dvR7zIHa7v6XTKDLJRpRPtZxfxcdOYfCbeC3RepsfWzSA2a
 7yj0M/1MEnCA9V+XswYuHNfL4JxXVDUefqguPNLWpi22c70qECADxwnTaXSy3YtnWjlNP3uU5
 ITpfncK6mmvbETP6cwGN5T48msU2liLRKfe5TpUzaq54FUMHBI9eNU8RJncW8ZW6lcTi4KWhf
 2CDKh4f61tIzWLeFMUmUft0cbk4SrYHxJ8WaVpydrsdYcBzrRfwaH2DhqDrHV5FS90pB7zHqu
 R0yE6KjaYCrk1zwiTxWZ/rzKxV51MM7wwf6I7OlMjMQgCG2mFKib3zUx9uFLCmIrfyIUeGM0I
 0r2UO9TFNVeDS10wBakTUhk6/usbrlEuTvJkgyiGDfq+ZcWOawLAVg2/XUKGsFRjKob0S0nMO
 P8suz7K6x30pUoafbqIkDoLdhXesEF4ln3RTOPetGQ7PQGs0ma5qMDvQCsn90XbG2HoIYHvCQ
 UL6mPittdX3cToNUbjgQgeO/CZ1nhEvjEDE8vuGKz1lC7ur9Iawjsn74y+swLUyHn+lvlZu4r
 qkC6eKAoHYrsvA7QXH1JlnEqRyf9D5Gxd8sLZCWWXbpsiq+TWCIUErkf+N1LXBYfu0tPybggV
 x1jGsv4CEnQDavH7VA9NkAdAe4i/3pKwfv8QD++xjpM0QSBXSE=
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
Cc: gregkh <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Scott Wood <oss@buserror.net>, kernel@vivo.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Apr 18, 2020 at 6:22 PM Wang Wenhu <wenhu.wang@vivo.com> wrote:
> +#define DRIVER_NAME    "sram_uapi"
> +
> +#define SRAM_UAPI_IOCTL_SET_SRAM_TYPE  0
> +#define SRAM_UAPI_IOCTL_ALLOC          1
> +#define SRAM_UAPI_IOCTL_FREE           2
> +
> +struct res_info {
> +       u32 offset;
> +       u32 size;
> +};

This is of course not a proper ioctl interface at all, please see
Documentation/driver-api/ioctl.rst for how to define the numbers
in a uapi header file.

The offset/size arguments should probably be 64 bit wide.

       Arnd
