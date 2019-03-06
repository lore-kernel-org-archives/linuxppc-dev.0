Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4181C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 18:04:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1168420652
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 18:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAshJijk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1168420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44F1q26fTBzDqGM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 05:03:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com;
 envelope-from=jrdr.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HAshJijk"; 
 dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44F1nJ5zV1zDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 05:02:27 +1100 (AEDT)
Received: by mail-lf1-x142.google.com with SMTP id p1so9610975lfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9NlTnV1RuRzxavxPyEzKIvYJ+VeCVW6++rTPCnXKsCM=;
 b=HAshJijk36tRtXm9Ks//VLNIk4cZ58Xyu44Tm5mtYSIBKnp3XuHPmADtVTi+4RG7Lz
 xGf3IR/MilgzzDGOrNX47XZPqTEySRmSPXLBnuYUruL1wxI5I3MW9G6vftLoYpjTK7zL
 0qxSG315vCeacS0c2PMRDGuZSNGxO6jmsA7BCxaePYLMpUNYqUW9gFXOFa61b5+zDmTo
 rTJ2Z/n/O+r5Rc3OJhaV5qOXywZ+jBdvH4pmvPmPPnPAwunH/FY+EEaObkv95H3bigBB
 iYMJ5Ein2UO6Jl53VFdw6QKXJp2Onb2LzFGG6U0b3doDvPDPD2eZHu9o+fN/MEsGQH/m
 yP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9NlTnV1RuRzxavxPyEzKIvYJ+VeCVW6++rTPCnXKsCM=;
 b=PsieNvC4/61soz/SYTSWeynieUCSuV7togcapdCrOTYQwsOFAP7V3p6KEc7zp9r0ZP
 J9gbz4vNG1vYf/XtF7DHTd3MCgo26sOZsKi5Hfp9X21kSh8s6aFCKslRgtcvRpQFQe2S
 QCflwLx+6zHPkvf7gt43NlNDWQ0Exz5zZfLtnlyopPrUXrA91ZNxpfS3UJjyZPgs74/i
 fq08/tooYzCUjZXLsUCsyGgRH0o1NgsZd/9fKF0E4bDv1XH37ELqT2B8mNLql9yuiApI
 y9Z1yCgdDb8rFDTsxPHrra2m38CSCzTxTtP3qQsRw/8Vyg9tT6HxvM2DrNW81ZPHE6nD
 n34Q==
X-Gm-Message-State: APjAAAUz9yC4/7Di/9GkoR/ieP0Efdb/d08cjByIaM38fHpQpa5GD7Yx
 QQPgk1G3ikUrwMtKWDDejZKk4A7ibbj6ynbQv9A=
X-Google-Smtp-Source: APXvYqyES9Mlgsy3geuwbdoVhE5fLT2b9NOat0SfHRhOEn8gfrTNRFwrNYBWJ0BtwzSo1L8lrjQhc3hEhcNyxmQwAWU=
X-Received: by 2002:a19:a417:: with SMTP id q23mr4872719lfc.27.1551895338862; 
 Wed, 06 Mar 2019 10:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
 <87tvgr1fr4.fsf@concordia.ellerman.id.au>
 <CAFqt6zY0HV7E+_6_s5A3eG+jEj+4hgQnAgJQm-Pc1gyX4Vnbpg@mail.gmail.com>
 <CAFqt6zYqa6aCAcs51AdePtBSL58hMa1BSA87ZMLbwUJA=rWNLA@mail.gmail.com>
In-Reply-To: <CAFqt6zYqa6aCAcs51AdePtBSL58hMa1BSA87ZMLbwUJA=rWNLA@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 6 Mar 2019 23:36:38 +0530
Message-ID: <CAFqt6zZcoe1fZF__h=zdKaWC7MHt4nVELCV07RspWjntHA94hg@mail.gmail.com>
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
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, sboyd@kernel.org,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Bamvor Zhang <bamv2005@gmail.com>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, netdev@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.ibm.com>, shuah <shuah@kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 4, 2019 at 4:19 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 10:59 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Tue, Feb 26, 2019 at 7:18 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >
> > > Souptick Joarder <jrdr.linux@gmail.com> writes:
> > > > Remove duplicate headers which are included twice.
> > > >
> > > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > ---
> > > ...
> > > >  tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
> > >
> > > I took this hunk via the powerpc tree.
> >
> > How about taking this entirely through a single tree ?
> > or Shall I send these changes in different patches ?
>
> If no comment, can we get this patch in queue for 5.1 ?

I will drop this patch as we have submitted these changes in
different patches. ( Except the one picked by Michael).

>
> >
> > >
> > > > diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > > index 167135b..af1b802 100644
> > > > --- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > > +++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > > @@ -11,7 +11,6 @@
> > > >  #include <sys/wait.h>
> > > >  #include <unistd.h>
> > > >  #include <setjmp.h>
> > > > -#include <signal.h>
> > > >
> > > >  #include "ebb.h"
> > >
> > >
> > > cheers
