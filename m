Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61681C169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 02:39:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB4C20870
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 02:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBuIzOQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB4C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43q6yt62xlzDqRc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 13:39:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBuIzOQv"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43q6wS0WVHzDqRn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 13:37:43 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id y1so10330951plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 18:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jF2YUk3CGXcsn7FfNEazANOC+yJqAca70TIA7Bif9jM=;
 b=QBuIzOQvBwrZBknSNZjXbekuNSuZOAZ7t8q4btJ4O7mGu5mU8svc37BE3n4cm4Nlfn
 7YEJ0byaoEwJv4U1Xrg5lg2gli+7hRqwkZMznVT/dEvNUp2QCYEzfnlivei0UAP1djfN
 Z+/fOgL7GAvAGt/PajU2d5AmI8kFg+ruboXzEzZGJSA1JhImBjVK7/0N65sJTm7TG/XM
 zGvjyHXn/bEkcycsrVogxtS0Sz55KqFw/kvNvxeWIHjFC9GFjGj+LiKNh8DCETYC7AT9
 UtHSbYZ6apHJQH12FpvI/U+u6MWYGkCBbiFq8Akr3/dVvQzgE5ac942jHdCjiDaA8as0
 VaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jF2YUk3CGXcsn7FfNEazANOC+yJqAca70TIA7Bif9jM=;
 b=bXLm4nPwMfu9NPY9YyML1X8cTgHLtYgvDrWq6Y3ZNSUk7oB1jQGQc3vwzp4nnBEZhC
 r9x/5J1vWpa+h4RMb5xBbeMczvAAL7aDO9Fj2Sw8AV9ymWf9JdJlbfjtbviqCK7dzCjV
 SVvh0YAU9VO3GT4Fg5K8VTyPb3d8q5WF8m5V+YUn+8qvhITVjl1VreyEALyv6y/6LKYt
 fdh9GQifguwdzlrF1LHIXFvrV+N4Q0IQ4Yo2E1WwKWP9urXhxPl4avsPJMSo5E2iNkAy
 IzLy1JPhrKCxx33UjrNNVK+iB50KdQPnTkhJ2O2u3t2lYamJGk5Kt0pRrUEvSD6GGEvW
 mK4Q==
X-Gm-Message-State: AJcUukeuB+djkUP5pHF/z8atgGqXmBfijbGmN4Wsfen5thZ+Fk7GdyTj
 xYe5yWA8sPuSQsqhwTNDlfnJY8ivNuIeBP4LD4M=
X-Google-Smtp-Source: ALg8bN4//XpMjLYU59grLqgxc75m7Qmb3h+PEaqFtcjMuA7ypQI7c2egmEDsQxXcNI50oFcN7oWtu4XRNClNMMsfFs8=
X-Received: by 2002:a17:902:8bc6:: with SMTP id
 r6mr28432418plo.67.1548815862063; 
 Tue, 29 Jan 2019 18:37:42 -0800 (PST)
MIME-Version: 1.0
References: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com>
 <CAFqt6zbyZnk3vAnRHV0JsXpVF=HxoC-WA9x434R+k36b0vtKzA@mail.gmail.com>
In-Reply-To: <CAFqt6zbyZnk3vAnRHV0JsXpVF=HxoC-WA9x434R+k36b0vtKzA@mail.gmail.com>
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Wed, 30 Jan 2019 08:07:30 +0530
Message-ID: <CAJr6mf0XT1rqdtT3muEuD+-+WsbSOeFZr_dawMFzsWT=VniQQQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Remove duplicate header
To: Souptick Joarder <jrdr.linux@gmail.com>
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
Cc: Brajeswar Ghosh <brajeswar.linux@gmail.com>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, paulus@samba.org, Oliver <oohall@gmail.com>,
 msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 18, 2019 at 3:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Jan 17, 2019 at 9:40 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Remove linux/printk.h which is included more than once.
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
>
If no further comment, can we get this patch in queue for 5.1 ?
> > ---
> >  arch/powerpc/platforms/powernv/opal.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> > index beed86f..802de0d 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -26,7 +26,6 @@
> >  #include <linux/memblock.h>
> >  #include <linux/kthread.h>
> >  #include <linux/freezer.h>
> > -#include <linux/printk.h>
> >  #include <linux/kmsg_dump.h>
> >  #include <linux/console.h>
> >  #include <linux/sched/debug.h>
> > --
> > 2.7.4
> >
