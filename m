Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C094C282F6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 09:04:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26CA2084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 09:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26CA2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jlwk0qWrzDqYq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 20:04:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.68; helo=mail-vs1-f68.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
 [209.85.217.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jllQ5vRqzDqVV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 19:56:18 +1100 (AEDT)
Received: by mail-vs1-f68.google.com with SMTP id u11so12137370vsp.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 00:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E/6v0ZVPaXQi5FWJ19dLuHcLgd/E9ZECv5IjLmf6PoI=;
 b=Rw8nNvIDenjKLZWCa9d+N/AYm/sxYoRYbD+6Hf4UVR9p9UMx0ezLcTrYXjxXIPh6Uz
 WARjQ4r89Tiwo8/USFPqNuxyES/Y486GEElyKn7anijEBUXeFxGIBqodHT2Bbxg7syey
 pGk5EGKRJnttQUZut/mOwgT1uHAqBN2Wt3jTxbDVqN/KRalbOGeLNoVSMoTwIMpHdqiD
 5pQonVtW89vDWFsgKfnOCDFoWq+Dmd8xHYSgbjOEtwGyz9+fQOPhEk4T5r45Y0zmT8A0
 Fei1pUdlMBlyH2t0N5GiGLdxeQdVMQc2rcJInx8BB9FTkem1QY0wD6P0ZwlMb06Vusdq
 f9qg==
X-Gm-Message-State: AJcUukeGbme/4lpgpWwBYlvgt8RGurnYTfKD3+mRjSCUYP3HlMiAaARS
 4n6rFHgaq665mVHV6QrDOByT82I2SK5O8zWwMkM=
X-Google-Smtp-Source: ALg8bN6mqPPGjY0mRgSzvQIVAiUYVEkzmmA1fTVJs4P5AJXGDwVjqnqovDI8HCxNMByb80ziNpDqZXxAv1iGgV8yZxk=
X-Received: by 2002:a67:3885:: with SMTP id n5mr10358537vsi.96.1548060976721; 
 Mon, 21 Jan 2019 00:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-27-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-27-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:56:02 +0100
Message-ID: <CAMuHMdWiHTjDT9-tnjgJy9qCWRr+qUgsJa6LjpRDJQzhoJqnzw@mail.gmail.com>
Subject: Re: [PATCH v2 26/29] y2038: use time32 syscall names on 32-bit
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
> This is the big flip, where all 32-bit architectures set COMPAT_32BIT_TIME
> abd use the _time32 system calls from the former compat layer instead
> of the system calls that take __kernel_timespec and similar arguments.
>
> The temporary redirects for __kernel_timespec, __kernel_itimerspec
> and __kernel_timex can get removed with this.
>
> It would be easy to split this commit by architecture, but with the new
> generated system call tables, it's easy enough to do it all at once,
> which makes it a little easier to check that the changes are the same
> in each table.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 42 +++++------

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
