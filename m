Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04327C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Sep 2021 23:37:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5A76115A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Sep 2021 23:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED5A76115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H5FmC1Yn4z2ywK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 09:37:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=/11f=n7=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H5Flh1k9hz2yJq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Sep 2021 09:37:04 +1000 (AEST)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2AF536108D;
 Thu,  9 Sep 2021 23:36:57 +0000 (UTC)
Date: Thu, 9 Sep 2021 19:36:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Subject: Re: [PATCH v4] ftrace: Cleanup ftrace_dyn_arch_init()
Message-ID: <20210909193655.7bc715af@gandalf.local.home>
In-Reply-To: <20210909090216.1955240-1-o451686892@gmail.com>
References: <20210909090216.1955240-1-o451686892@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
 linux-sh@vger.kernel.org, linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Nick Hu <nickhu@andestech.com>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu,  9 Sep 2021 17:02:16 +0800
Weizhao Ouyang <o451686892@gmail.com> wrote:

> Most of ARCHs use empty ftrace_dyn_arch_init(), introduce a weak common
> ftrace_dyn_arch_init() to cleanup them.

FYI,

I'm not ignoring this patch. I just wont be able to look at it until the
merge window is over.

-- Steve


> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com> (s390)
> Acked-by: Helge Deller <deller@gmx.de> (parisc)
> 
> ---
> Changes in v4:
> -- revert the generic declaration
> 
> Changes in v3:
> -- fix unrecognized opcode on PowerPC
> 
> Changes in v2:
> -- correct CONFIG_DYNAMIC_FTRACE on PowerPC
> -- add Acked-by tag
> 
> ---
>  arch/arm/kernel/ftrace.c        | 5 -----
>  arch/arm64/kernel/ftrace.c      | 5 -----
>  arch/csky/kernel/ftrace.c       | 5 -----
>  arch/ia64/kernel/ftrace.c       | 6 ------
>  arch/microblaze/kernel/ftrace.c | 5 -----
>  arch/nds32/kernel/ftrace.c      | 5 -----
>  arch/parisc/kernel/ftrace.c     | 5 -----
>  arch/riscv/kernel/ftrace.c      | 5 -----
>  arch/s390/kernel/ftrace.c       | 5 -----
>  arch/sh/kernel/ftrace.c         | 5 -----
>  arch/sparc/kernel/ftrace.c      | 5 -----
>  arch/x86/kernel/ftrace.c        | 5 -----
>  kernel/trace/ftrace.c           | 5 +++++
>  13 files changed, 5 insertions(+), 61 deletions(-)
> 
>
