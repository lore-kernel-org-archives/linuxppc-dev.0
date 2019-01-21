Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81996C282F6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 09:05:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F75214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 09:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F75214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jlyM3QS5zDqYV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 20:05:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.67; helo=mail-vs1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jllT1WrlzDqX0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 19:56:21 +1100 (AEDT)
Received: by mail-vs1-f67.google.com with SMTP id e7so12171851vsc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 00:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uun2AU3eJW+aX9fhOUjPPIC4XfawfY9i9oS9NgvU6Z4=;
 b=VjnAXF2FCXPOlhhOx/k7mCIwWDFF1hjf68bfUm6lvhYe+mEK7Zzlyx8ePskgjdKUTw
 m12EUGOeX3KctrZWQavPMkCMbaO0fWZBkIXy3AJqMg32AbUJumi9GQTe8iSsctiVy63H
 hZXaq2HF5MrIIrEMU8Mw4gcomPUB5/p/Mek8njocfNj84oB6AdMefkNH9dpaiTrpkm+T
 kbWvKVBNMFJvNz7AcQA3vnkclzwvu495BGD8UbFdqhipvUgXrl9WbSsGsny4RaIYlJ04
 b4XJm+cAie4NjZRdF5tlGQGMkNYK1gK9gnfWT9mEnxcor3NUS9L4CFm7sm54TyJpHfb1
 1cFA==
X-Gm-Message-State: AJcUukc6xrTfMI2BQ3ermNojNR3+jC1Q3BlvJONz1sFdQcv8D+yNUSuu
 r+SKNDJtnsUzx8Q9B8DzRCCbqGpgye+W3XdQTrE=
X-Google-Smtp-Source: ALg8bN5Zv5T9HgEze01gQpDUuzyqM6YeldP0GcLXE8vieJqOlkOh/z7Dnz2dgUAbu8nwMIPAviPimX4i+NMBPPzq9wY=
X-Received: by 2002:a67:f43:: with SMTP id 64mr11966034vsp.166.1548060979206; 
 Mon, 21 Jan 2019 00:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-29-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-29-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:56:06 +0100
Message-ID: <CAMuHMdVxSVpP0KcBpCSVh0iKBCh3WtGqExtZGPH86hn2TOpTXg@mail.gmail.com>
Subject: Re: [PATCH v2 28/29] y2038: rename old time and utime syscalls
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, netdev <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Firoz Khan <firoz.khan@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 18, 2019 at 5:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> The time, stime, utime, utimes, and futimesat system calls are only
> used on older architectures, and we do not provide y2038 safe variants
> of them, as they are replaced by clock_gettime64, clock_settime64,
> and utimensat_time64.
>
> However, for consistency it seems better to have the 32-bit architectures
> that still use them call the "time32" entry points (leaving the
> traditional handlers for the 64-bit architectures), like we do for system
> calls that now require two versions.
>
> Note: We used to always define __ARCH_WANT_SYS_TIME and
> __ARCH_WANT_SYS_UTIME and only set __ARCH_WANT_COMPAT_SYS_TIME and
> __ARCH_WANT_SYS_UTIME32 for compat mode on 64-bit kernels. Now this is
> reversed: only 64-bit architectures set __ARCH_WANT_SYS_TIME/UTIME, while
> we need __ARCH_WANT_SYS_TIME32/UTIME32 for 32-bit architectures and compat
> mode. The resulting asm/unistd.h changes look a bit counterintuitive.
>
> This is only a cleanup patch and it should not change any behavior.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/include/asm/unistd.h              |  4 ++--
>  arch/m68k/kernel/syscalls/syscall.tbl       | 10 +++++-----

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
