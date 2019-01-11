Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16978C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 17:35:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966CF20870
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 17:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966CF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bqkl4bCdzDr3j
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 04:35:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.196; helo=mail-qt1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bqhh1yXPzDqwJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 04:33:24 +1100 (AEDT)
Received: by mail-qt1-f196.google.com with SMTP id p17so19672019qtl.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 09:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PlXu3O61pUFPLleZ5AMTVxcoWeFNM1mKAK5t7dNAM0o=;
 b=WGHZRnOgFJD7ojCj3L96CxLKmYD1AoQlZX7UEJ0uWvxpz7BVFVCI+3AkxgkM3AgP8S
 gip1gICvpK7+sdiAMKjslb1CvWMi+q/EicvBF1wv1JtMGrwkeUkXCLvE07yjVWzOM/dK
 9bc5jKiE+Jsq2KZRJNX6yq9eqUR5u6AGIkdscHZWSNqasHgScLb5cs+0MffvadLVIZB5
 9XffSHbeHcY9gRWce+i6L+Ro2BEDCdEQBA3xG1pGtbTzgAj7CfdHpNEXG30yOgJNZqAx
 mM3cCM7HXsYRuELZlnI+QRsTDrYfsyD18DXjlG27J2UIDYmZs5xtDr4aztaJBuqoTuMn
 LpjA==
X-Gm-Message-State: AJcUuke+zPqiH2RodZGN0miw+gmdBVUaaafjBXcWD3j+BtbZEKAMOPYN
 4dkgt7z7aLUsxw757rv2wdK8GBJ5Z75piv1bLag=
X-Google-Smtp-Source: ALg8bN69vX9vcq63IXhYC33aOwWxtfAvEwzhoWorTBpfa9Zlf+nERekjdxP7iJFo0Zjh4Gu5ospxdXcZfV6z9FLdQY4=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr14381544qtl.343.1547228002113; 
 Fri, 11 Jan 2019 09:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <20190110203253.GA3676@osiris>
In-Reply-To: <20190110203253.GA3676@osiris>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 11 Jan 2019 18:33:05 +0100
Message-ID: <CAK8P3a0PahP8Bbc7OfiqrRcoxMReDuoyn8Hw=aSFtPjNeyrjcA@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
To: Heiko Carstens <heiko.carstens@de.ibm.com>
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
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

On Thu, Jan 10, 2019 at 9:33 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Jan 10, 2019 at 05:24:34PM +0100, Arnd Bergmann wrote:

> > diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> > index 022fc099b628..428cf512a757 100644
> > --- a/arch/s390/kernel/syscalls/syscall.tbl
> > +++ b/arch/s390/kernel/syscalls/syscall.tbl
> > @@ -391,3 +391,15 @@
> >  381  common  kexec_file_load         sys_kexec_file_load             compat_sys_kexec_file_load
> >  382  common  io_pgetevents           sys_io_pgetevents               compat_sys_io_pgetevents
> >  383  common  rseq                    sys_rseq                        compat_sys_rseq
> > +# room for arch specific syscalls
> > +392  64      semtimedop              sys_semtimedop                  -
> > +393  common  semget                  sys_semget                      sys_semget
> ...
> > +395  common  shmget                  sys_shmget                      sys_shmget
> ...
> > +398  common  shmdt                   sys_shmdt                       sys_shmdt
> > +399  common  msgget                  sys_msgget                      sys_msgget
>
> These four need compat system call wrappers, unfortunately... (well,
> actually only shmget and shmdt require them, but let's add them for
> all four). See arch/s390/kernel/compat_wrapper.c
>
> I'm afraid this compat special handling will be even more annoying in
> the future, since s390 will be the only architecture which requires
> this special handling.
>
> _Maybe_ it would make sense to automatically generate a weak compat
> system call wrapper for s390 with the SYSCALL_DEFINE macros, but that
> probably won't work in all cases.

For some reason I was under the impression that s390 already did that.
However, it seems that x86 does, so I'll try to convert the x86 version
for s390, and see if I can get rid of all the wrappers that way.

It would certainly be safer to have the wrappers always present,
especially if we expect future system calls to be added to the
s390 table by whoever implements the syscall itself.

      Arnd
