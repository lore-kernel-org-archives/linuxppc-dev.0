Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F71C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:51:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB9420823
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddyaBuXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB9420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CcJn104qzDqHr
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 21:51:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com;
 envelope-from=jrdr.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ddyaBuXh"; 
 dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CcGx4l6ZzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 21:49:45 +1100 (AEDT)
Received: by mail-lj1-x244.google.com with SMTP id z20so3887562ljj.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Mar 2019 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sG432yYj+fXh4CV3/rA9GM8c4ecdVV/QZAXmBtg6vfA=;
 b=ddyaBuXhIyY+M+4buRavN1fdObCs2Ol04TtkHx3IZsJ5kmE/7GOnF0i4QuNwaxccCV
 0No2F07f9jGX8ErYMIaMHQwSrk27ygdHENT1+NHEBMG//xZvGrVHcw3xOGESMAok0YHW
 cl03foYBhZAluZADKwwcZltAQnyqjh7EAT8ziKWAkjlWwhW0XgAjFKyNihVMMwi3gscQ
 Cx5zvITkdjNgRUk6F5AGiwPAwZWgMn69Z+wa4UsRoulTkB2F5T4/g+MkxN8iyHS3uRtz
 j2Nifh3dfsTka9EXWnlFAseoVFXl45qjRUlRmPRBNcJprjab8Bh/TNNTgq4j6tZR/l6T
 IlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sG432yYj+fXh4CV3/rA9GM8c4ecdVV/QZAXmBtg6vfA=;
 b=rBLNvf8DD5gSzR4r5sKemWpIEpMEIjk5k1E1i9dXJWLlaZA55+C44RNs+TsuQFUhzx
 FCfhaY/LmCsgujlhnXh2HJf6Ols+E5Duq41DphvLoKHNO/Tm+PYTUPdMQXIvW++2Tk6j
 SXj05s7jAK/PvRJ0GSf1ntakm+np8fvM3sC/2TH2df/RL9BpCYv9CRUhcLQ40emr6v76
 57S3G4XZ7AdxTWsT2EOTxJ7U51aqfeNIyjdUKySkUqdXxyx5F+XFNLSj6lG83awnYsY6
 cqlUrXlobIuzNip+Gpb1GgKwNipd4YvjCszoPjKlscdMBc65BBKY7c1Bjez2iwMXdyby
 wZ7Q==
X-Gm-Message-State: APjAAAWAJkOltWoZrGEFzBK9Be7syKO/dohtlwCQ7sqHH/qQgXA9R4tx
 3o9fuLzMLBahlKT88Uc5DrHoNhvBs18AjF3y8qY=
X-Google-Smtp-Source: APXvYqxBRntn7UDJWJZcWZ53z9J/iW4X+tuUOMzU5b4HtgA59u0hIcapCXpdEhIOToQqUWMABL+xcmcRq3t072n+ayQ=
X-Received: by 2002:a2e:54f:: with SMTP id 76mr10386125ljf.20.1551696580783;
 Mon, 04 Mar 2019 02:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
 <87tvgr1fr4.fsf@concordia.ellerman.id.au>
 <CAFqt6zY0HV7E+_6_s5A3eG+jEj+4hgQnAgJQm-Pc1gyX4Vnbpg@mail.gmail.com>
In-Reply-To: <CAFqt6zY0HV7E+_6_s5A3eG+jEj+4hgQnAgJQm-Pc1gyX4Vnbpg@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 4 Mar 2019 16:19:29 +0530
Message-ID: <CAFqt6zYqa6aCAcs51AdePtBSL58hMa1BSA87ZMLbwUJA=rWNLA@mail.gmail.com>
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

On Tue, Feb 26, 2019 at 10:59 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 7:18 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Souptick Joarder <jrdr.linux@gmail.com> writes:
> > > Remove duplicate headers which are included twice.
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > ---
> > ...
> > >  tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
> >
> > I took this hunk via the powerpc tree.
>
> How about taking this entirely through a single tree ?
> or Shall I send these changes in different patches ?

If no comment, can we get this patch in queue for 5.1 ?

>
> >
> > > diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > index 167135b..af1b802 100644
> > > --- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > +++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
> > > @@ -11,7 +11,6 @@
> > >  #include <sys/wait.h>
> > >  #include <unistd.h>
> > >  #include <setjmp.h>
> > > -#include <signal.h>
> > >
> > >  #include "ebb.h"
> >
> >
> > cheers
