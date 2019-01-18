Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46284C07EBF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D77C20657
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D77C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hB1R6tLdzDrCF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 06:32:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.194; helo=mail-qt1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h9zS2NRFzDrB4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 06:31:15 +1100 (AEDT)
Received: by mail-qt1-f194.google.com with SMTP id e5so16424539qtr.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 11:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0AqmTALoASBra3sCdglfdVs8uL/QVnAKemn1xthUo0g=;
 b=NsVlPg5S4uFDwnbkAVHG+srwpvpV91wEcRnWKS6CvhcDa6FQNj1RT3CZ+kMfNug0ko
 iy/YxPPUYfkVKfrgx7uWcFTvmkDVWGQgqF6f4zgrtREIJmpGjE1z/9IJZnI62vix032m
 QT75yujD1+mdmuG0AlhmxfkmFUmjkWlFLubavnMDFy65X5kYXzBfz0HZXtIyHoZbxq80
 gjxUvQW2U5CloAiSO7nfWbD0Yo3iJRCCCGGuVfqlHqXpSqVJTy+CGu/Th7NHG5vSTLNV
 1jACtgcFSAvpc0mHH6XHCqTSqactvS2vUdWXv7Cg2F97jyikbI8rql81ZM6rtiaCSywC
 Fi+A==
X-Gm-Message-State: AJcUukeCtGJIBVGCVxXZcAPRPpu6t0L+F/wxCJLyRgk7QLTVThACEze5
 xkA3gvreJrsEAScRQYHpnTY7KdUCp5w1Hpoejis=
X-Google-Smtp-Source: ALg8bN6j9yHcnKi+481JiICcfzmXamZ1jIWHSB1ab1h/DB+ThocBrv+KhcCDCSjIJzxiV13/exH4DDVlgzHxeSHApHc=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr16397093qvl.180.1547839873593; 
 Fri, 18 Jan 2019 11:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-14-arnd@arndb.de>
 <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
In-Reply-To: <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 20:30:57 +0100
Message-ID: <CAK8P3a1R8BfAnNGvBa-hoQBL3uJQ5bJ0_YO91YLv8pp3-nAe3Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/29] arch: add split IPC system calls where needed
To: Gabriel Paubert <paubert@iram.es>
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
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Networking <netdev@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 18, 2019 at 6:20 PM Gabriel Paubert <paubert@iram.es> wrote:
>
> On Fri, Jan 18, 2019 at 05:18:19PM +0100, Arnd Bergmann wrote:
> > The IPC system call handling is highly inconsistent across architectures,
> > some use sys_ipc, some use separate calls, and some use both.  We also
> > have some architectures that require passing IPC_64 in the flags, and
> > others that set it implicitly.
> >
> > For the additon of a y2083 safe semtimedop() system call, I chose to only
>
> It's not critical, but there are two typos in that line:
> additon -> addition
> 2083 -> 2038

Fixed both, thanks!

     Arnd
