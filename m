Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6870C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 21:21:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87772147C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 21:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d+n2M3g2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87772147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440CBv68SgzDqW2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:21:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20150623.gappssmtp.com
 header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d+n2M3g2"; 
 dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440C904lW1zDqTf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 08:20:00 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id f5so2881516lfc.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 13:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7qaVEjCmoRfosICdejMJpPumW2wAFBZnk9qdCZVNez4=;
 b=d+n2M3g2Ddc4KAgqfKPHGpRWbp2/O5V4O7E4MU+tm+LYnqPeoZZGF46GLJZ6a2Z6pC
 PtQ0Rd8vK6M7ZaMB/Gv1sExbbyKXGtDfyZRvpHSY4m87ld2maDYtv7hTM5BGnvNmotje
 8coXPH9O18jU8OvuJVywIzRtoU+H3envB/p8jmOBnbwVWzAOQLQv6yVLz78irv2Apae5
 kfO3RThs9kPoEg6dc6SmKqilhhUOaMIn4xcUFkLffpzayYEdY7bqHd7YiRXjTze0TGo1
 +HXMbzxk+XmVC+d8XKL9z7nPJsyRZvH9jvpwO73esv8HIPx81vO7rw8bOo4MgF9AxPXl
 BI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7qaVEjCmoRfosICdejMJpPumW2wAFBZnk9qdCZVNez4=;
 b=l/+CUT/YDXRZWsAtwZm0LglxPPemcDW4MesO9HHfzT9r8m06fEDCy3lJVQXmBLCNxm
 DWWtCD/+35FwxLtMilpyfekF1QqwmnulRqnCBv80gHE5hdQw/izbj7qXObRy9aaczxvy
 QktZLd+AOZpQyqN7VVsQSOPPf6bcSlew1PEvwmW8nvV33LoOpg0/kmEfJbolXyQ51OrX
 OZYsyFuw6o6hyiITLL/BBHFwcwt9IohHiw7/mnBzjQQUb/2pzTi7kkoCZhuMSr1Xg0uF
 kIHEHMStEm3TdLwWJB5/T+kdfjbVHqAd9WUkPP65DZtheJ1Mz4mYJk3I9eNxvT81AV4t
 4B8g==
X-Gm-Message-State: AHQUAub9qhWMQ6kGFbZTekcltRYdUqYiK44Hxc9jSVo/a3V/kh3moiWU
 e2sch/v4SLlfktMyqA5xs5gp9Yk5EeYpVP7snazK
X-Google-Smtp-Source: AHgI3Ibv18osK6j86M7eWFAowOkAWT4CL+2fsH0v8fKrN30duK12IfSLVbV5RVEAovVsKUXxh1o84aGkBuqb3kp+SnI=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr128421lfb.72.1550092797379;
 Wed, 13 Feb 2019 13:19:57 -0800 (PST)
MIME-Version: 1.0
References: <df04c747-58c1-4757-b0ef-1ccea745defb@oracle.com>
 <89f699ca-e307-0714-2fdb-37b5307e1195@oracle.com>
In-Reply-To: <89f699ca-e307-0714-2fdb-37b5307e1195@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Feb 2019 16:19:46 -0500
Message-ID: <CAHC9VhSAj6nKzO+y9r9NDVdez8G157rpYxRqBUCcTBypbOj1YA@mail.gmail.com>
Subject: Re: [QUESTION] powerpc, libseccomp, and spu
To: Tom Hromatka <tom.hromatka@oracle.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Dhaval Giani <dhaval.giani@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 12, 2019 at 9:50 AM Tom Hromatka <tom.hromatka@oracle.com> wrote:
> On 2/11/19 11:54 AM, Tom Hromatka wrote:
> > PowerPC experts,
> >
> > Paul Moore and I are working on the v2.4 release of libseccomp,
> > and as part of this work I need to update the syscall table for
> > each architecture.
> >
> > I have incorporated the new ppc syscall.tbl into libseccomp, but
> > I am not familiar with the value of "spu" in the ABI column.  For
> > example:
> >
> > 22    32    umount                sys_oldumount
> > 22    64    umount                sys_ni_syscall
> > 22    spu    umount                sys_ni_syscall
> >
> > In libseccomp, we maintain a 32-bit ppc syscall table and a 64-bit
> > ppc syscall table.  Do we also need to add a "spu" ppc syscall
> > table?  Some clarification on the syscalls marked "spu" and "nospu"
> > would be greatly appreciated.
>
> Thanks for the awesome responses, Ben and Michael.  I'll definitely
> get Paul's input as well, but it sounds reasonable to exclude SPUs
> from the newest libseccomp release.

Based on this thread, I don't think we need to worry about "spu" at
this point in time.  Thanks everyone.

> Michael's recommendation to replace "nospu" with common" and ignore
> "spu" entirely has allowed ppc and ppc64 to pass all of our internal
> checks.
>
> Thanks again!
>
> Tom

-- 
paul moore
www.paul-moore.com
