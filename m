Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01900C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 14:49:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E91920657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 14:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E91920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fCsB1gCLzDqcb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 01:49:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.195; helo=mail-qk1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fCqT4smGzDqQ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 01:47:33 +1100 (AEDT)
Received: by mail-qk1-f195.google.com with SMTP id g125so1676196qke.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 06:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CJSgcbSLHBpkQA1mStr0T4cc3D19F0djyMHOoCBmTQM=;
 b=eq4OV9iR1nySxwhRPn1T2/XrHmb78S2KMFCQIDsGcFWV0M1DxwG0aflzKpjLvyCoWx
 M43r6dubl+aXrDxaH+vyr6/aQdhi7CmqB0OERZ/ASstLR2Dsj4MDhvt1SWnqd6bL4TlV
 zP4OLRTCdbQSZ7WLS+Q5JfPKV1iw4OZmAvXWf/RWuwe/rV5myNbgBzGjeQzWyz1O6Xbe
 TmD6R4tWTkhkHPpeX5tMK/jBzrrxoEAj7c3A1jzrZbBS1Y8q8Qpag+HOxtax5HObqlKk
 AidEdnnNo6mO1EuS8OBL+tGCUTWwJHGEpfoCaV9lA07141M5cHwYCrPE34pcuAXm64m2
 LeJA==
X-Gm-Message-State: AJcUukdP1GcPb0prtDFQnTofV4u233HmPCWfzOZRXJ+9L5v4i62b8za8
 kkQenTrgQ+Her3iKFJtEPBzQl0bDlSFIccTQd50=
X-Google-Smtp-Source: ALg8bN7NyBBLgCUds8tYMS0JcD3kjA3gSFqxzkmVv/3Wlh5Gl2kGahA1WPnfsZKIUU3QSibwFh0em/FK52DjAc3L5UI=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2838414qkf.107.1547563651094; 
 Tue, 15 Jan 2019 06:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-16-arnd@arndb.de>
 <20190115115229.mcrmmpwdmjxf2cra@e5254000004ec.dyn.armlinux.org.uk>
In-Reply-To: <20190115115229.mcrmmpwdmjxf2cra@e5254000004ec.dyn.armlinux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 15:47:14 +0100
Message-ID: <CAK8P3a1Xb4z-mbhBTPZ0Cpy0Hy_s2wwT-8UG9yO6AGbUTjdkyw@mail.gmail.com>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 12:52 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:
> > Most architectures define system call numbers for the rseq and pkey system
> > calls, even when they don't support the features, and perhaps never will.
> >
> > Only a few architectures are missing these, so just define them anyway
> > for consistency. If we decide to add them later to one of these, the
> > system call numbers won't get out of sync then.
>
> I was lambasted for adding the pkey syscalls for 32-bit ARM in 2016,
> which will probably never support it.  Why has the attitude towards
> this kind of thing now apparently become acceptable?

I was (and still am) a bit unsure about this one. A number of architectures
added the numbers that won't ever support them, but I wasn't sure if
any of those that didn't add them might need it later.

I tried to just go by the rule that anything that we list in
asm-generic/unistd.h
is probably important enough that we want to list it everywhere, even if
that includes a couple that we end up being rather architecture specific.

I'm happy to drop this patch if you or others feel that we're better off
without it though.

      Arnd
