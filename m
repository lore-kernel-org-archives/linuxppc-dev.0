Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17C4C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 21:35:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3571320672
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 21:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3571320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438Zsc1KWXzDqXT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 08:35:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438ZqJ4mJszDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 08:33:32 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id z16so19939284qtq.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 13:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+W0EbAePeEpyft8AGAWdGBucIWf6cgDCPKGR33Rc8cM=;
 b=DxazqrC8iTDOX06vDo0IRCgv/u1C0L/3jdQvBimJg6iQtOJNadagwPOBQd/CNsJ47J
 2KHJE2l8wSMDiZqnC/WiLUKNeOYqHPn3yQXTgsArHC+v/G7ytnyqcr8aRkxQhcVlW8dn
 jXLJC7lB0MBzS7EMm4Lg6q8iwELRtLJLiT7pFxaU88uR1LGMz9a1867L7CnGLH1qFtzL
 qa8PG9tpMHpnrz+lKqcXQrEr7y5zIYkMOAvIfICc0bS/UJGARzArKJkU5r+MlieqNZg0
 hXb2umByvTBtbMctBZEezpGwrN8TdFrs3rz3QK1p6ZZrwcEJt6ltSI77K4eV8Hmcs+QJ
 JwmQ==
X-Gm-Message-State: AA+aEWbupRjFaXyQJIaREaRw+Q7ZY7iR/LdqXcEWsq8gZU1QNU1C+t/4
 6oBTdx2GVJ5srCN5WDFnywsJBLMy0hBn0nVcXTI=
X-Google-Smtp-Source: AFSGD/VqVajLxF0jVSFmrd5TieXjqarj5TshDi/jn5dRL2G7+HehZB6lV+/HJAqd4cglA3ZUvZ6VPFVLPidTxj5qqgk=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr20936968qte.212.1543959210210; 
 Tue, 04 Dec 2018 13:33:30 -0800 (PST)
MIME-Version: 1.0
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
 <1543465611-17122-5-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
In-Reply-To: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 4 Dec 2018 22:33:13 +0100
Message-ID: <CAK8P3a0DX6Eh0OwUh975RL2Pq_ux_AQeBPSakPFxZf+t62EJ=w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] powerpc: generate uapi header and system call
 table files
To: Firoz Khan <firoz.khan@linaro.org>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 linux-arch <linux-arch@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Boqun Feng <boqun.feng@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, linuxram@us.ibm.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, leitao@debian.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 4, 2018 at 10:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
> > index 9ff1913..d756348 100644
> > --- a/arch/powerpc/kernel/systbl.S
> > +++ b/arch/powerpc/kernel/systbl.S
>
> >  #ifdef CONFIG_PPC64
> > @@ -47,5 +25,17 @@
> >  .globl sys_call_table
> >  sys_call_table:
> >
> > +#if defined CONFIG_PPC64 && defined(CONFIG_COMPAT)
> > +#define __SYSCALL(nr, entry, nargs) .8byte entry
> >  #define compat_sys_sigsuspend  sys_sigsuspend
> > -#include <asm/systbl.h>
> > +#include <asm/syscall_table_c32.h>
> > +#undef __SYSCALL
> > +#elif defined CONFIG_PPC64 && !defined(CONFIG_COMPAT)
> > +#define __SYSCALL(nr, entry, nargs) .8byte entry
> > +#include <asm/syscall_table_64.h>
> > +#undef __SYSCALL
>
> This part looks wrong: where the old sys_call_table contained
> both the native and compat calls side by side, the new table
> contains only the compat versions (note that CONFIG_COMPAT is
> always set on PPC64). I think you copy-pasted this incorrectly from
> one of the other architectures that uses a different layout for the
> compat calls.
>
> The way I think this could work best is if you add a preparation
> patch that splits out the 64-bit table into two separate ones
> (and make sure that works). After that, you can add your
> existing patch, rebased to use the two generated tables
> instead of the old-style tables. I'll follow up with an untested
> patch for illustration.

One more thing I noticed while writing up that patch: you also need
to use the DOTSYM() macro in __SYSCALL() to generate the correct
symbol name for the old ELF ABI (when PPC64_ELF_ABI_v2 is
not set).

       Arnd
