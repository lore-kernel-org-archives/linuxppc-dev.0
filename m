Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04786C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:31:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD762173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AguuasYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD762173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447nVt0FZwzDqGb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 16:31:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com;
 envelope-from=jrdr.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AguuasYi"; 
 dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447nSz59lqzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 16:30:09 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id w6so9606063ljd.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 21:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=csKfCHjnEHfQKSvUWfDicmJococPYAbcvFqpRHGDb7Y=;
 b=AguuasYiFeYtJYECTzwIPOdq6j9TmEWl1sKahzXSMCeft9qzoyxO+rmGf6m367mM50
 m/7rEVgZ/RMvnPf9b1JDyfQaNvleG9H9Hj6K0WpSh5UoSaAT/23KiGK2YoDfG09FTsmX
 MKCB08eGmOnzsrGi3FKxb2vckkgUvfIRHjIsx+vB6aFXNPnY71SD7uhYzcARJ+A5dS6g
 RP3E0wR0cysGi6lhLfF2Q8BkrD40SHVqfMQ/oJuwyFFEp7QDCSqXSnQpVi1V350hdKM4
 DZ84svT747MQLINW9aea/5GnLDSHAgtTHU6XrxwbQOw8kbSg/EtyazB42c178R/yn5VB
 iVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=csKfCHjnEHfQKSvUWfDicmJococPYAbcvFqpRHGDb7Y=;
 b=UPBA9Ir2NrprB/ixzmJVdAdkUJ9H9mqw5tk+UileSaBkttIhnIqBL630h759nEyNU5
 AMnJ6bwR+yiz2wpOKnFaNSMMxH2I8ow8dZ8OD79pWKsXasx7jb7X159TlCThBmzREq3M
 btYmFkPqcgW9z6N5FDiZNcnwnzEgqN89Yb9gOrjrjCgCgWpbUqSmv3S8q0EZmQudMu9c
 hI/eXqdqisb4ba/zDzYVZeBMbdkKdhvxsSflp+nnNg+2NVbP9vgadRy2zonyLlxHdDlq
 xodN0Mtq4yYDrDshf5QwZ/ZWwqTkKNDu1sHxQ2xO9VvBc8cSfY7Szd1qTEJpQI89pk4T
 dOZw==
X-Gm-Message-State: AHQUAuZhBYPjcYPlFVpBR8pTYkAhtAvEfi057YIzFdS21GsWLjN0XcDf
 5SMYos91jj/RMbrmHjUo+kzUN1PJ505nlmSQlm0=
X-Google-Smtp-Source: AHgI3IYTN7Dh8m3sCpj9WjJlVi8OvgZQVFH4I+nJIkBte3teo+mXjGjOffqVQYANHWQqCIs0QflzVZzOV0CKpzlo+RI=
X-Received: by 2002:a2e:54f:: with SMTP id 76mr12377984ljf.20.1551159002632;
 Mon, 25 Feb 2019 21:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
 <87tvgr1fr4.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvgr1fr4.fsf@concordia.ellerman.id.au>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 26 Feb 2019 10:59:50 +0530
Message-ID: <CAFqt6zY0HV7E+_6_s5A3eG+jEj+4hgQnAgJQm-Pc1gyX4Vnbpg@mail.gmail.com>
Subject: Re: [PATCH] tools: testing: selftests: Remove duplicate headers
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
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-gpio@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, sboyd@kernel.org,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Bamvor Zhang <bamv2005@gmail.com>, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.ibm.com>, shuah@kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 26, 2019 at 7:18 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Souptick Joarder <jrdr.linux@gmail.com> writes:
> > Remove duplicate headers which are included twice.
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> ...
> >  tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
>
> I took this hunk via the powerpc tree.

How about taking this entirely through a single tree ?
or Shall I send these changes in different patches ?

>
> > diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > index 167135b..af1b802 100644
> > --- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > +++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > @@ -11,7 +11,6 @@
> >  #include <sys/wait.h>
> >  #include <unistd.h>
> >  #include <setjmp.h>
> > -#include <signal.h>
> >
> >  #include "ebb.h"
>
>
> cheers
