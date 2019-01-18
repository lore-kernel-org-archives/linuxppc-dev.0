Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD6C07EBF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:16:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D98C20850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D98C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h70050QRzDr8L
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 04:16:32 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h6y42pGMzDqnK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 04:14:52 +1100 (AEDT)
Received: by mail-qk1-f195.google.com with SMTP id y78so8428284qka.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 09:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cM6Ct6RNNXTziZEbUSSe56myHuH3NS1roB2yrpi3ejY=;
 b=ItnmNmz1tIljKRKGja6E9zbhd0xD4JsCLdNsOp8XYbbwVm5V09pt1igJrn2ks4Kbvt
 CjQNoZzVJfu7QQ+wpC9bsD1QfgpePVE56B4o+GCTGiJ0mqCdQDxIEzCG5nqRo9dnoBO8
 pxE5e6zcwSUOsRpChJgteWQxVvmXELv6NI6ZHTtHzqR+dSncZa+ohytqghPbKaSWp4+N
 XGXAIrNGMrgctYZOdRsKtTPdlLTZxf9ym8pVW0YrNxUkLe5lEcfgQSpoZmNNttswuSgu
 BZSomcBqFyOUNzx+u6fS9Ia9ZXFqkJIzm9opP9QfeHeSWlN6jX+7SaoyFgPBPUZqk7RA
 UwaQ==
X-Gm-Message-State: AJcUukdpeQPTvDBuMq/+VkoqtzOiXEnbT8pup0PwFlFcDBYqilgKnmhf
 Pet2PajAH+BbbXJE9L9KoL7dfoBjgKi9lTNGMRk=
X-Google-Smtp-Source: ALg8bN6YuxAZx88mWjLK6OJGww6yso8mTxW2uQ+U16+TTtpFWJaRgawaUEpqTv2Trum/q/Wu6cLlwpnMJ3TVNfmaobA=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr15079174qkf.107.1547831689678; 
 Fri, 18 Jan 2019 09:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
In-Reply-To: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 18:14:33 +0100
Message-ID: <CAK8P3a3xUpbk+Wpo5kdDtZ81jQuzEZH6jdmJJNeNM+acueg+Dw@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
To: Dennis Clarke <dclarke@blastwave.org>
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
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Networking <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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

On Fri, Jan 18, 2019 at 5:57 PM Dennis Clarke <dclarke@blastwave.org> wrote:
>
> On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> > This is a minor update of the patches I posted last week, I
> > would like to add this into linux-next now, but would still do
> > changes if there are concerns about the contents. The first
> > version did not see a lot of replies, which could mean that
> > either everyone is happy with it, or that it was largely ignored.
> >
> > See also the article at https://lwn.net/Articles/776435/.
>
> I would be happy to read "Approaching the kernel year-2038 end game"
> however it is behind a pay wall.  Perhaps it may be best to just
> host interesting articles about open source idea elsewhere.

It's a short summary of the current state. You can also find a
video and slides from my ELC presentation online for a little more
context.

Generally speaking, I'd recommend paying for the subscription to
lwn.net to anyone interested in the kernel, but it should become
visible to everyone with the next day (a week after the initial
publication). In the meantime, you can find the article at
https://lwn.net/SubscriberLink/776435/a59d93d01d1addfc/.

Finally, I've made a list of the remaining work that Deepa
and I are planning to still continue (this should be mostly
complete but may be missing a few things):

syscalls
 - merge big series for 5.1, to allow time64 syscalls
 - waitid/wait4/getrusage should get a replacement based on __kernel_timespec
 - getitimer/setitimer should probably follow getrusage
 - vdso, waiting for consolidation series from Vincenzo Frascino before
   adding time64 entry points

file systems
 - range checks on timestamps
 - xfs
 - NFS
 - hfs/hfsplus
 - coda
 - hostfs
 - relatime_need_update

drivers
 - media
 - alsa
 - sockets
 - af_packet
 - ppp ioctl
 - rtc ioctl
 - omap3isp

core kernel
 - fix ELF core files (elfcore.h)
 - syscall Audit code (kernel/audit.c, kernel/auditsc.c)
 - make all time32 code conditional
 - remove include/linux/timekeeping32.h
 - remove compat_time* from time32.h
 - remove timeval
 - remove timespec
 - remove time_t

     Arnd
