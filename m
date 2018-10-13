Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292ECC6787C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 03:03:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611BD20895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 03:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uV2twWkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611BD20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X8fC13jWzF3TH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 14:03:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="uV2twWkm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dancol@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="uV2twWkm"; 
 dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42X7pK28mnzF3Sf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 13:25:12 +1100 (AEDT)
Received: by mail-ot1-x344.google.com with SMTP id o14so14139314oth.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 19:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AVT8yt4SB5J9DoLXgmc7fyXmf+sZ/QolyovgztLAQ10=;
 b=uV2twWkmECSPrusRnN/vXPmvBFYTjOqR8hUGj7uFIqFnja6HWyEE59/EX6URRSK7ei
 bsLQO8pq96Yj7M5G0CjsRbi5afMpRO5p6LGi6gqkF1Fsb96X2cpi7a6HzEjPHM5S5b/+
 frAsPOqLD9LWEf7OVOqxvcQcS5euFpCDZTZ4mQNwNIu+I5BIdazSX176UsMrE2WE7yqy
 vEzD1H9jpf2yN7Z39bZVobe1cuQmeBj/6yYghOi4Eg5BRvkIX/X2/Np9eIx+7MbesZ3i
 M/WKTCz0rPGomijvt/NLvxi250WzkhscHNYFINjgKIa6h6fyG7Vk/yjb5v+LZqg963lC
 Fyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AVT8yt4SB5J9DoLXgmc7fyXmf+sZ/QolyovgztLAQ10=;
 b=hfaQovHnfqSGai1wjtBOUKIDgCnvp+p0afujDpu+QmaneAYb1iUWfcBTelSm/HMBI0
 rw2wbb092sRaZKXyU83w1BAmawjGWdA9IsZ+bmIsD8ZEO9KWCg7M2PQHjISoRew2Edmp
 5FbGud7PJ82LMk/MDxxSKMgemfJt1RkZLh8kFG6NiwIlQ46fmCg5kIgqIfUOo9ZCPy0k
 AKS+uMgelFUMfJJQLNcc2aVDE4LhTpHZ3HAgZJRAc/vnICiaLd+6HjSsTY45G7sQXnCC
 FCYafFZHeUelrly6C7a516mk1TBXj4Zl55StKyocxQ/SRKwjBWs4CEYcnjQkMqCU2eWc
 W9xw==
X-Gm-Message-State: ABuFfogc7XgxlN5DwoJhMB1BHhVsqJMTI9lO7raMAw6FagFhZvIpIxOZ
 QHF8TCEibA2Lbc/bpbwlybzdePF1L93WIlDFB/stwg==
X-Google-Smtp-Source: ACcGV626tmOS/hq+IOOBvcyLVHGavVFHf8rpMv7Ej7UrZuwws9AFWJei17jzLnNTEoqbyX0OG7eWDPlqeQQBpHBj980=
X-Received: by 2002:a9d:62cb:: with SMTP id z11mr5748873otk.342.1539397509267; 
 Fri, 12 Oct 2018 19:25:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:56d8:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 19:25:08
 -0700 (PDT)
In-Reply-To: <20181013021057.GA213522@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
 <20181013014429.GB207108@joelaf.mtv.corp.google.com>
 <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
 <20181013021057.GA213522@joelaf.mtv.corp.google.com>
From: Daniel Colascione <dancol@google.com>
Date: Fri, 12 Oct 2018 19:25:08 -0700
Message-ID: <CAKOZueu2wdkeUFYLQ8qE48yJs1_uRz-9RVJRkp==CL=jp=Q8+g@mail.gmail.com>
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
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, deller@gmx.de, Hugh Dickins <hughd@google.com>,
 jejb@parisc-linux.org, kasan-dev@googlegroups.com,
 kvmarm@lists.cs.columbia.edu, mingo@redhat.com, geert@linux-m68k.org,
 aryabinin@virtuozzo.com, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, fenghua.yu@intel.com, jdike@addtoit.com,
 linux-um@lists.infradead.org, Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-m68k@lists.linux-m68k.org, bp@alien8.de, luto@kernel.org,
 nios2-dev@lists.rocketboards.org, kirill@shutemov.name, gxt@pku.edu.cn,
 Chris Zankel <chris@zankel.net>, richard@nod.at, linux-parisc@vger.kernel.org,
 Ramon Pantin <pantin@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>,
 linux-alpha@vger.kernel.org, lftan@altera.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 7:10 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 06:54:33PM -0700, Daniel Colascione wrote:
>> I wonder whether it makes sense to expose to userspace somehow whether
>> mremap is "fast" for a particular architecture. If a feature relies on
>> fast mremap, it might be better for some userland component to disable
>> that feature entirely rather than blindly use mremap and end up
>> performing very poorly. If we're disabling fast mremap when THP is
>> enabled, the userland component can't just rely on an architecture
>> switch and some kind of runtime feature detection becomes even more
>> important.
>
> I hate to point out that its forbidden to top post on LKML :-)
> https://kernelnewbies.org/mailinglistguidelines
> So don't that Mr. Dan! :D

Guilty as charged. I really should switch back to Gnus. :-)

> But anyway, I think this runtime detection thing is not needed. THP is
> actually expected to be as fast as this anyway, so if that's available then
> we should already be as fast.

Ah, I think the commit message is confusing. (Or else I'm misreading
the patch now.) It's not quite that we're disabling the feature when
THP is enabled anywhere, but rather that we use the move_huge_pmd path
for huge PMDs and use the new code only for non-huge PMDs. (Right?) If
that's the case, the commit message shouldn't say "Incase THP is
enabled, the optimization is skipped". Even if THP is enabled on a
system generally, we might use the new PMD-moving code for mapping
types that don't support THP-ization, right?

> This is for non-THP where THP cannot be enabled
> and there is still room for some improvement. Most/all architectures will be
> just fine with this. This flag is more of a safety-net type of thing where in
> the future if there is this one or two weird architectures that don't play
> well, then they can turn it off at the architecture level by not selecting
> the flag. See my latest patches for the per-architecture compile-time
> controls. Ideally we'd like to blanket turn it on on all, but this is just
> playing it extra safe as Kirill and me were discussing on other threads.

Sure. I'm just pointing out that the 500x performance different turns
the operation into a qualitatively different feature, so if we expect
to actually ship a mainstream architecture without support for this
thing, we should make it explicit. If we're not, we shouldn't.
