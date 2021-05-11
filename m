Return-Path: <SRS0=9biP=KG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C80CC433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 May 2021 01:24:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E1661628
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 May 2021 01:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E1661628
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FfKw84G7Dz309M
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 May 2021 11:24:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=wnnDBP50;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20150623.gappssmtp.com
 header.i=@paul-moore-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=wnnDBP50; dkim-atps=neutral
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FfKvf1pL4z2yQw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 May 2021 11:24:11 +1000 (AEST)
Received: by mail-ej1-x630.google.com with SMTP id j10so222150ejb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2021 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=syt/rTNKKQ17UGCB3Uu0pF3Y4fSaa3SrmtO2mz6CWnE=;
 b=wnnDBP50YuTDmWGzNOFnPcs4wQToxwsCwGRBEFgx7dTWtco22s8x+zEZSiwuwWfbpM
 cWdw31wnr1boOC7AEos2jrrH4bGAuhpsYL+GtY+HbrHfNNFIkCQ2XoXiTKi6ysk/a0LM
 KwLh5IIRlLP0O+kiTEPwwX6SP6ff2YJqRmgF9axUO6GoHRWhDwBuHrmuAHL/1AQB00za
 Z5ya4HUeA76Q7yyS/rcQO9PZfeIpKFiUmrvL2D2pFYuw1ACepDvAm2QaZ/4I+ELpE5vp
 C6rfPiox76AXXt/Rb/GJows7NCWjIsCS6N3qaxUYY1LJERzpfb4IjwoLyxWMlP5agPFI
 AE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=syt/rTNKKQ17UGCB3Uu0pF3Y4fSaa3SrmtO2mz6CWnE=;
 b=qhXtb2EkB/8/AaUwlbUQD9Fg2Da+UN+8cyNCHnTOAMPhcG4p8hhYpla3upc4PGMAe6
 GVfo4LXLTs6u+UBV2uAc/iLWIi+EvnFl8z0Dh4C0h05D/4mCMsj++kfVo4jE9fHipywb
 09Sk17wbkIG6/lfDBTzXrWMMOPJF5MvrAoFhIxmMxZnEa0jrtBF+K/tFAK1QV0nqYkKe
 JO5LurBhYijLYW6bVIO7l+uazmJtUT1CP82+oxWN6Rv9WGxtxHoFzmPUWExItlEjQ+X8
 N1IhDfAP7W08k45b4Cnh/n4RealC3qq0vC8cBRMdU5i1ICI1CJcLDKyDT1cqKwua57Uk
 gRaA==
X-Gm-Message-State: AOAM532BsLrm2+hO5KABn7q0Q4RngFwSRMPNxThOkByoGeP03FuPknFZ
 DRfQ3WT/aFQDCK70WhhPPOzQy82/qOoxnN/k6oqt
X-Google-Smtp-Source: ABdhPJyW4MiZ3N1+ZHg7+YNdb0vgiQkf7+SPMSk21X8mfUycEAtJWf5nTYhrqBDtALuDjNQQeKXN/Vj76oxO0MuWUxs=
X-Received: by 2002:a17:907:10d8:: with SMTP id
 rv24mr28569992ejb.542.1620696245333; 
 Mon, 10 May 2021 18:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619811762.git.rgb@redhat.com>
 <bda073f2a8b11000ef40cf8b965305409ee88f44.1619811762.git.rgb@redhat.com>
In-Reply-To: <bda073f2a8b11000ef40cf8b965305409ee88f44.1619811762.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 May 2021 21:23:54 -0400
Message-ID: <CAHC9VhShi4u26h5OsahveQDNxO_uZ+KgzGOYEp5W7w6foA-uKg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] audit: replace magic audit syscall class numbers
 with macros
To: Richard Guy Briggs <rgb@redhat.com>
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
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
 sparclinux@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
 Linux-Audit Mailing List <linux-audit@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
 Steve Grubb <sgrubb@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 30, 2021 at 4:36 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Replace audit syscall class magic numbers with macros.
>
> This required putting the macros into new header file
> include/linux/auditscm.h since the syscall macros were included for both 64
> bit and 32 bit in any compat code, causing redefinition warnings.

The ifndef/define didn't protect against redeclaration?  Huh.  Maybe
I'm not thinking about this correctly, or the arch specific code is
doing something wonky ...

Regardless, assuming that it is necessary, I would prefer if we called
it auditsc.h instead of auditscm.h; the latter makes me think of
sockets and not syscalls.

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  MAINTAINERS                        |  1 +
>  arch/alpha/kernel/audit.c          |  8 ++++----
>  arch/ia64/kernel/audit.c           |  8 ++++----
>  arch/parisc/kernel/audit.c         |  8 ++++----
>  arch/parisc/kernel/compat_audit.c  |  9 +++++----
>  arch/powerpc/kernel/audit.c        | 10 +++++-----
>  arch/powerpc/kernel/compat_audit.c | 11 ++++++-----
>  arch/s390/kernel/audit.c           | 10 +++++-----
>  arch/s390/kernel/compat_audit.c    | 11 ++++++-----
>  arch/sparc/kernel/audit.c          | 10 +++++-----
>  arch/sparc/kernel/compat_audit.c   | 11 ++++++-----
>  arch/x86/ia32/audit.c              | 11 ++++++-----
>  arch/x86/kernel/audit_64.c         |  8 ++++----
>  include/linux/audit.h              |  1 +
>  include/linux/auditscm.h           | 23 +++++++++++++++++++++++
>  kernel/auditsc.c                   | 12 ++++++------
>  lib/audit.c                        | 10 +++++-----
>  lib/compat_audit.c                 | 11 ++++++-----
>  18 files changed, 102 insertions(+), 71 deletions(-)
>  create mode 100644 include/linux/auditscm.h

...

> diff --git a/include/linux/auditscm.h b/include/linux/auditscm.h
> new file mode 100644
> index 000000000000..1c4f0ead5931
> --- /dev/null
> +++ b/include/linux/auditscm.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* auditscm.h -- Auditing support syscall macros
> + *
> + * Copyright 2021 Red Hat Inc., Durham, North Carolina.
> + * All Rights Reserved.
> + *
> + * Author: Richard Guy Briggs <rgb@redhat.com>
> + */
> +#ifndef _LINUX_AUDITSCM_H_
> +#define _LINUX_AUDITSCM_H_
> +
> +enum auditsc_class_t {
> +       AUDITSC_NATIVE = 0,
> +       AUDITSC_COMPAT,
> +       AUDITSC_OPEN,
> +       AUDITSC_OPENAT,
> +       AUDITSC_SOCKETCALL,
> +       AUDITSC_EXECVE,
> +
> +       AUDITSC_NVALS /* count */
> +};
> +
> +#endif

-- 
paul moore
www.paul-moore.com
