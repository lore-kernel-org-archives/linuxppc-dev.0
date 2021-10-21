Return-Path: <SRS0=ebkI=PJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39278C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 13:35:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E659611CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 13:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E659611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZpPh2KVWz3cM5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Oct 2021 00:35:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.233;
 helo=out03.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZpP66gzwz2xr0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Oct 2021 00:34:31 +1100 (AEDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:40512)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mdYD5-005DQ9-NZ; Thu, 21 Oct 2021 07:34:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:46380
 helo=email.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mdYD4-003epC-7e; Thu, 21 Oct 2021 07:34:19 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <87y26nmwkb.fsf@disp2133> <877de7jrev.fsf@disp2133>
 <CAMuHMdURxrdjsXq7+q-AWTwxVUdmddOj2vvNHv6M=WtsU5nRvg@mail.gmail.com>
Date: Thu, 21 Oct 2021 08:33:51 -0500
In-Reply-To: <CAMuHMdURxrdjsXq7+q-AWTwxVUdmddOj2vvNHv6M=WtsU5nRvg@mail.gmail.com>
 (Geert Uytterhoeven's message of "Thu, 21 Oct 2021 10:09:46 +0200")
Message-ID: <87tuhaijsw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdYD4-003epC-7e; ; ; mid=<87tuhaijsw.fsf@disp2133>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX1+Mpe2HbWR2YDGhZ3vVJNTbKaHiNpeOXoM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 21/20] signal: Replace force_sigsegv(SIGSEGV) with
 force_fatal_sig(SIGSEGV)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
Cc: Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Greentime Hu <green.hu@gmail.com>, H Peter Anvin <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 "open list:TENSILICA XTENSA PORT \(xtensa\)" <linux-xtensa@linux-xtensa.org>,
 Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Openrisc <openrisc@lists.librecores.org>,
 Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Chris Zankel <chris@zankel.net>,
 Jonas Bonn <jonas@southpole.se>, Nick Hu <nickhu@andestech.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, Maciej Rozycki <macro@orcam.me.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Eric,
>
> Patch 21/20?

In reviewing another part of the patchset Linus asked if force_sigsegv
could go away.  It can't completely but I can get this far.

Given that it is just a cleanup it makes most sense to me as an
additional patch on top of what is already here.


> On Wed, Oct 20, 2021 at 11:52 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Now that force_fatal_sig exists it is unnecessary and a bit confusing
>> to use force_sigsegv in cases where the simpler force_fatal_sig is
>> wanted.  So change every instance we can to make the code clearer.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
>>  arch/m68k/kernel/traps.c        | 2 +-
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you.

Eric
