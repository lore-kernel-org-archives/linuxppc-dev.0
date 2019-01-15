Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D05C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:03:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9841D20656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9841D20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fD9t5ZQlzDqWW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 02:03:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fD7q5fJDzDqWF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 02:01:43 +1100 (AEDT)
Received: by mail-qk1-f196.google.com with SMTP id y16so1687068qki.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 07:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/j2xo8vyz06xg1gQlvQEYwJpD6WHXsDfeyUW+0147bI=;
 b=MfB/XzfA0PLAM1V8EjG6mXfgxMBc1vlbZEbrniwF22MxOIh0QuM2NGtvVk0T9cggDK
 c+gZDkEcnYa337gn0+6Nb/idxjVK/6ARFfBGERccVqleTKn/WbfvfYhtlDOxY5igoY7e
 q7DYmGQPYdgH43QeC9b3Sn3NK9jn7Rxw2T6n4yO1YSPDqTTB3bqe0+GNEDM9Byc+W5UG
 TAfdEpxh+NtTc3fbVbYOca6l74lkTYaduULM+v3m0wYV5aV5zpFGSZ2Mk+TWus57Ep7X
 wzIdNyTMeTTdzzYPGcwyzYYhk3Ht7d7FS3299l6OD+XuOZlqIdTtBYbID/oPlO6mssLH
 uG2A==
X-Gm-Message-State: AJcUukea8UISNuPyyYMVeI0/3QprjjgtEu2ExFX/wN3veN3g4uOGfWUu
 5Hd1EOLK5CiEr7d5PlmWFaF/VAclx4qh3dPVO0s=
X-Google-Smtp-Source: ALg8bN66ERQQcRHL6kpituOugRhaYl47wq+bMeU6L9UD0bbjiIXTK390uY37r+V2oE8uztNtYSgBmDdqY7/ckMkByIg=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2882793qkf.107.1547564501193; 
 Tue, 15 Jan 2019 07:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pnsz28k2.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 16:01:24 +0100
Message-ID: <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
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

On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
> >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
> >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
>
> I have some changes I'd like to make to our syscall table that will
> clash with this.
>
> I'll try and send them today.

Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
nice for me to have a branch based on 5.0-rc1 that I can put
the other patches on top of.

> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> > index db3bbb8744af..1bffab54ff35 100644
> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> > @@ -425,3 +425,15 @@
> >  386  nospu   pkey_mprotect                   sys_pkey_mprotect
> >  387  nospu   rseq                            sys_rseq
> >  388  nospu   io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > +# room for arch specific syscalls
> > +392  64      semtimedop                      sys_semtimedop
> > +393  common  semget                          sys_semget
> > +394  common  semctl                          sys_semctl                      compat_sys_semctl
> > +395  common  shmget                          sys_shmget
> > +396  common  shmctl                          sys_shmctl                      compat_sys_shmctl
> > +397  common  shmat                           sys_shmat                       compat_sys_shmat
> > +398  common  shmdt                           sys_shmdt
> > +399  common  msgget                          sys_msgget
> > +400  common  msgsnd                          sys_msgsnd                      compat_sys_msgsnd
> > +401  common  msgrcv                          sys_msgrcv                      compat_sys_msgrcv
> > +402  common  msgctl                          sys_msgctl                      compat_sys_msgctl
>
> We already have a gap at 366-377 from when we tried to add the split IPC
> calls a few years back.
>
> I guess I don't mind leaving that gap and using the common numbers as
> you've done here.
>
> But it would be good to add a comment pointing out that we have room
> at 366 for more arch specific syscalls as well.

Ah, I missed that. I've added this to my patch now:

index 5c0936d862fc..2ddfba536d5f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -460,6 +460,7 @@
 363    spu     switch_endian                   sys_ni_syscall
 364    common  userfaultfd                     sys_userfaultfd
 365    common  membarrier                      sys_membarrier
+# 366-377 originally left for IPC, now unused
 378    nospu   mlock2                          sys_mlock2
 379    nospu   copy_file_range                 sys_copy_file_range
 380    common  preadv2                         sys_preadv2
         compat_sys_preadv2

       Arnd
