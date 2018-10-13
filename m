Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EC0C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 03:00:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5945D20895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 03:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oO7CQBJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5945D20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X8bX2kbVzF3TN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 14:00:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="oO7CQBJ0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dancol@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="oO7CQBJ0"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42X7722ZPZzF3SH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 12:54:37 +1100 (AEDT)
Received: by mail-ot1-x342.google.com with SMTP id l1so14072345otj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ruDqHADLGhUq/OqjXNRFevT5jDn0habRcwA3l0QGuG8=;
 b=oO7CQBJ0o3h4W+oksCLNlcAMMdo7sg4Jtv1VCUZcuw6SrUuKQoC7/yRbVEByqVegR5
 2XakAmI6gLBq49bXmjVYz4+acBeAcuwKtUHPjj2sGXy+jzOkdhqdTL0YPcZPqB+LKt6o
 bhRful9oO7cRR8nbmHw1A7uqI9ttcB1fV31XpSXw7a9IcC+joMzcgVc8TxQKKcRQt8Re
 zoNMfZUWu+1do2+6RW0MSWVyN/9DUjKrGt5dJpbjxpWiCS22HxYleuy9uZIoJeze7/q0
 zCoyyhRBLvqgZ71FAynWB3xe4pRvB3ibgZGe60xwaYIUrVPx8bwkXyzud+F7R7U1MaXx
 /VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ruDqHADLGhUq/OqjXNRFevT5jDn0habRcwA3l0QGuG8=;
 b=E8pNbuRqgSIhLLmg2+/9L6N8XyYn5a+mIfdH20mrS7YnzOLnvhBqx1BY9sYCyj/U0J
 o0VRW6p5cKr4hyEOde6ktvYYdKFGRNEkYEZ2OnDSQ1CURr4I9gnX+PlBMWl0x7zlqXpx
 pn9/YslLJ6JuhDtSGlHa3SWrQvtDkaRA1USfWqMwGCCSwEq8C86ZZV7K+7rpK+2/Z6sg
 t8BRaSmFTh4G9S8j1UTrc7tAarZkux067iqkeuiEw9OO55QYVhWCG/WfV9OWPSTn+QiQ
 smr82H1JLLMedtgjqsS6nB8SR4BsS4a5IDbOaIEc+qzE/O9R5CD0mFEgpFnSlbuwhywr
 oTsA==
X-Gm-Message-State: ABuFfoiRwFidVJWxD68beI7TtFtzFubnEmdnVE4eDjKU4UXrbpMItSbu
 ncH8glkSCLlFBU1Gf/mmEuOS0lVHGaetL7GLvZKlTQ==
X-Google-Smtp-Source: ACcGV61wTHJT8KA0FRbB4T8HJavFhx8DCnBEFcv7It/8YmRplkdtkLJbpEFBtddWCai0iE4efhP92rfUMrMKw3tumlM=
X-Received: by 2002:a9d:3a21:: with SMTP id j30mr2325823otc.237.1539395674440; 
 Fri, 12 Oct 2018 18:54:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:56d8:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 18:54:33
 -0700 (PDT)
In-Reply-To: <20181013014429.GB207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
 <20181013014429.GB207108@joelaf.mtv.corp.google.com>
From: Daniel Colascione <dancol@google.com>
Date: Fri, 12 Oct 2018 18:54:33 -0700
Message-ID: <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To: Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 13 Oct 2018 13:44:51 +1100
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Lokesh Gidra <lokeshgidra@google.com>, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, jonas@southpole.se, linux-s390@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, deller@gmx.de,
 hughd@google.com, jejb@parisc-linux.org, kasan-dev@googlegroups.com,
 kvmarm@lists.cs.columbia.edu, mingo@redhat.com, geert@linux-m68k.org,
 aryabinin@virtuozzo.com, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, fenghua.yu@intel.com, jdike@addtoit.com,
 linux-um@lists.infradead.org, Julia.Lawall@lip6.fr,
 linux-m68k@lists.linux-m68k.org, bp@alien8.de, luto@kernel.org,
 nios2-dev@lists.rocketboards.org, kirill@shutemov.name, gxt@pku.edu.cn,
 chris@zankel.net, richard@nod.at, linux-parisc@vger.kernel.org,
 Ramon Pantin <pantin@google.com>, jcmvbkbc@gmail.com,
 linux-kernel <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>,
 linux-alpha@vger.kernel.org, lftan@altera.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I wonder whether it makes sense to expose to userspace somehow whether
mremap is "fast" for a particular architecture. If a feature relies on
fast mremap, it might be better for some userland component to disable
that feature entirely rather than blindly use mremap and end up
performing very poorly. If we're disabling fast mremap when THP is
enabled, the userland component can't just rely on an architecture
switch and some kind of runtime feature detection becomes even more
important.

On Fri, Oct 12, 2018 at 6:44 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 06:39:45PM -0700, Daniel Colascione wrote:
>> Not 32-bit ARM?
>
> Well, I didn't want to enable every possible architecture we could in a
> single go. Certainly arm32 can be a follow on enablement as can be other
> architectures. The point of this series is to upstream this feature and
> enable a hand-picked few architectures as a first step.
>
> thanks,
>
>  - Joel
>
