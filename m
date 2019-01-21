Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C5EC2F441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 16:32:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520F421019
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 16:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520F421019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jxt83RX8zDqVL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 03:32:48 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jxrS6z6jzDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 03:31:20 +1100 (AEDT)
Received: by mail-qt1-f196.google.com with SMTP id t13so24185711qtn.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 08:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ugnN37Htp2pcGbvXPo+DEz/r4541Rca2swp85kVj/dg=;
 b=hu4w5V9H0PDRlo0B8uVRCFndPoo1ZajDCQL/KGfStv9gqUPx/oXbd1ue7DXcsJAHYl
 DRgx3MeT39b+9tWNn0/xUEC4GXfyxQm4F174jEluE0stb5PUw5G6JPyQst4vE2YuOXXw
 Voq+BhOcOSLO5ajPj6HWxHDAd8CGB9AGW1zqx7O3s1VjzQJl5Kw63BFCR4rHxz1VN7e8
 M3Eo6yWfJ9ZPIyjNNlbHv+yJ5fdy/iGHDlqJWX0GcAnaXJJF9t+9RUOd1Y7KjqqTuUes
 GaaUKr4QCpHIXwsBd6F2wpPKSxbaAN918J47kb+nOPUCFkL+D/TFtO0oRjQC835c6A4G
 skCw==
X-Gm-Message-State: AJcUukfBLYbKZAhuPXZPv7iyAXqigfityjh4Uyyis5zHM22FTn03cGyf
 VctML5NZ8Vp1S2nWJWWJID4r89P83OLKNWJ3azQ=
X-Google-Smtp-Source: ALg8bN4IjC8153m9pB3iBWOATh3R/RnsAQ6wVGb5LY7XqftLLWs9CXLGl7GxR+zlIVcd8dP96h71Ls+Fr/txo5y0uPg=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr27326381qte.212.1548088278474; 
 Mon, 21 Jan 2019 08:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-30-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 17:31:01 +0100
Message-ID: <CAK8P3a2grsgvLeBHFoLnnpJti7qkZFfBPTrXf+CoihtOJKySzw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>
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
 Heiko Carstens <heiko.carstens@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, linux-mips@vger.kernel.org,
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

On Fri, Jan 18, 2019 at 5:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This adds 21 new system calls on each ABI that has 32-bit time_t
> today. All of these have the exact same semantics as their existing
> counterparts, and the new ones all have macro names that end in 'time64'
> for clarification.
>
> This gets us to the point of being able to safely use a C library
> that has 64-bit time_t in user space. There are still a couple of
> loose ends to tie up in various areas of the code, but this is the
> big one, and should be entirely uncontroversial at this point.

I've successfully tested this with musl and LTP now, using an
i386 kernel. The musl port I used is at
https://git.linaro.org/people/arnd.bergmann/musl-y2038.git/
This is just an updated version of what I used for testing last
year, using the current syscall assignment, and going back
to the time32 versions of getitimer/setitimer and
wait4/waitid/getusage.

It's certainly not intended for merging like this, but a proper
musl port is under discussion now, and this should be
sufficient if anyone else wants to try out the new syscall
ABI before we merge it.

The LTP I have is heavily hacked, and has a number of
failures resulting from differences between musl and glibc,
or from the way we convert between the kernel types and
the user space types.

The testing found one minor bug in all the kernel syscall tables:

> +418    common  mq_timedsend_time64             sys_mq_timedsend
> +419    common  mq_timedreceiv_time64           sys_mq_timedreceive

While this would have fit in with umount(), creat() and mknod(),
it was unintentional, and I've changed it back to
mq_timedreceive_time64 (with an added 'e').

       Arnd
