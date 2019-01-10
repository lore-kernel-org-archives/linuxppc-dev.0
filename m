Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31CDC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 23:06:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12020208E3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 23:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12020208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bM716fFTzDqwh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 10:06:05 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bM59079NzDqwH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 10:04:28 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id i7so15945047qtj.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 15:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HtXhbi3vHt8M/OEnatDKUvPiA7NAMQnuGXU1lkYVUOA=;
 b=heGkLCK6WQQMLgl0P6CRkFAO1uRQw4FoW7b6qw2MJfYkJz70OUKbu1+rxQ+HEKy9WZ
 vBHtfKpJUYMGj+7l4zOyOcscYHQ5EGHRuUJp0KQGHoMgCoywvKdzVrKKtRIF/bsRW3cW
 pUC81j6oIHrSSz3HnQJ6BQY36w+WmcKrzSrOq8TRfewe1DPNEZy7Df5wttHFjyySTyqg
 urZoMx3OkK4ZCyrBO+FBh1PZgEsKxIgQRz1zyBFvSyNpcdBmJlnHeZnRNutGTVW/UA7/
 9SVnrAc0Y2YiELhVdccbzKtJ/jOVdWeplTC9w6cG3vNWTvluDWPCWw8ByroDhV5ByhUk
 kEOw==
X-Gm-Message-State: AJcUukel3t89GZ2Y45GJfSrWQGX2xCwtERv4qXDp+qY1HulEhzOpyRJQ
 0n/MC5Z+1pHBQtaS5I4SabQUN04gXDOAuEn08PY=
X-Google-Smtp-Source: ALg8bN4ZeEWRkM9hWnrPPHyShJGIJaQ4v14vU6tq5tVSdcQOtnDoc1B1ZFUD1N8Tb+aXoK9KYlt7H6bjgwfKKkPpLQI=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr11357943qvl.180.1547161466728; 
 Thu, 10 Jan 2019 15:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-12-arnd@arndb.de>
 <20190110193949.5wsysvchhhh2gfmu@pburton-laptop>
In-Reply-To: <20190110193949.5wsysvchhhh2gfmu@pburton-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 11 Jan 2019 00:04:09 +0100
Message-ID: <CAK8P3a1-QvHrPOupHx3sc+c6zAS9E-u8hYbt4keWzpiPgNOD-Q@mail.gmail.com>
Subject: Re: [PATCH 11/15] mips: fix n32 compat_ipc_parse_version
To: Paul Burton <paul.burton@mips.com>
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
Cc: "dalias@libc.org" <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
 "deller@gmx.de" <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "firoz.khan@linaro.org" <firoz.khan@linaro.org>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ebiederm@xmission.com" <ebiederm@xmission.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 8:40 PM Paul Burton <paul.burton@mips.com> wrote:
> On Thu, Jan 10, 2019 at 05:24:31PM +0100, Arnd Bergmann wrote:
> > While reading through the sysvipc implementation, I noticed that the n32
> > semctl/shmctl/msgctl system calls behave differently based on whether
> > o32 support is enabled or not: Without o32, the IPC_64 flag passed by
> > user space is rejected but calls without that flag get IPC_64 behavior.
> >
> > As far as I can tell, this was inadvertently changed by a cleanup patch
> > but never noticed by anyone, possibly nobody has tried using sysvipc
> > on n32 after linux-3.19.
> >
> > Change it back to the old behavior now.
> >
> > Fixes: 78aaf956ba3a ("MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT but no compat ABI.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > As stated above, this was only found by inspection, the patch is not
> > tested. Please review accordingly.
>
> Nice catch! Would you prefer to merge this yourself, or that I take it
> through the mips tree?

Up to you: if you want to merge it for 5.0, I'll just drop it from my tree.

> If the former then:
>
>   Acked-by: Paul Burton <paul.burton@mips.com>

Thanks!

> I suspect kernels configured with n32 support but no o32 support are
> probably not very common - for internal testing we currently always
> enable both.

Do you know of anyone actually still using n32 in production systems
with 4.x kernels? I wonder if it just fell out of popularity as the 64-bit
machines that used it either became large enough to want 64-bit
user space, or got replaced by arm64 or mips32 hardware.

      Arnd
