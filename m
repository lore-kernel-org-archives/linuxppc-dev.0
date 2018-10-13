Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2388BC71122
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 02:13:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7101B20895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 02:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N2gi5ZnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7101B20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X7Xg0Ms9zF3Sb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:13:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N2gi5ZnN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="N2gi5ZnN"; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42X7Tz0QWXzF3Sb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 13:11:02 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id 23-v6so6624124pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 19:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6XZWKP2pbysVG8F4WKX4YkunFpUXVJoneS2qWT0rIgM=;
 b=N2gi5ZnNq30pQxOnEBYq6zdh6G0ns+SI6AVZkhimNQGD9yQOm5UYR6JGFwS2BUFCIW
 FauhTl3Q+WSZVHehFg8SNEE/bWYFsI9CNtDr8BWvee6Gq8YU62TJwxNiZpLSShCoUVdR
 L56i07BfoCPIOURgBXyQvQokxNKgq+N+jyEKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6XZWKP2pbysVG8F4WKX4YkunFpUXVJoneS2qWT0rIgM=;
 b=k9csqj5KSND8ZGPGeKSDBYgMrz2HBGjUvDAUXoX4KrfttkBh+57KMgw9xLDuuzyNoQ
 V9QcIFmNgAn7RMOz1rMG7CMx/XAFPRgCpq2b2pLavoYBSSzWXlGvSu3LFLawU5uKBGAE
 /fSIJs/Qa8TIjIwjFvjtGCHdh7l7tO5WfHh8ZrzPvQ37wba6oBViU4k0umw8ZVwtUuGq
 uBcjueUhy+DL1Lk3iFSsOp5SBoh8YaP0F7BuwIwFTilpYWqklF8+p89usg9QzPbx25hA
 Mlm9I93HPyJRPH9RODfQWovyCA00c82m+9Qc2G9vg00wwrZBqhoLJrn/V6G6y/EHhAUt
 64Gw==
X-Gm-Message-State: ABuFfog0Ts5qyNwtR/udeU/DnGb20mUbhgrEGIAVa46K74Irh/5CmcZp
 1a+w4569gcvm2rJKwtANMEA3Ew==
X-Google-Smtp-Source: ACcGV63F+9SrXFCpEUHB+XptA5Iqqus34UkUro+5Ai/GVN+L0Yg6ILmrGMV/JAu7RXyjGdEg/oMq4Q==
X-Received: by 2002:a65:5147:: with SMTP id
 g7-v6mr7890713pgq.252.1539396659739; 
 Fri, 12 Oct 2018 19:10:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id b29-v6sm4669490pfj.183.2018.10.12.19.10.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Oct 2018 19:10:58 -0700 (PDT)
Date: Fri, 12 Oct 2018 19:10:57 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013021057.GA213522@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
 <20181013014429.GB207108@joelaf.mtv.corp.google.com>
 <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Fri, Oct 12, 2018 at 06:54:33PM -0700, Daniel Colascione wrote:
> I wonder whether it makes sense to expose to userspace somehow whether
> mremap is "fast" for a particular architecture. If a feature relies on
> fast mremap, it might be better for some userland component to disable
> that feature entirely rather than blindly use mremap and end up
> performing very poorly. If we're disabling fast mremap when THP is
> enabled, the userland component can't just rely on an architecture
> switch and some kind of runtime feature detection becomes even more
> important.

I hate to point out that its forbidden to top post on LKML :-)
https://kernelnewbies.org/mailinglistguidelines
So don't that Mr. Dan! :D

But anyway, I think this runtime detection thing is not needed. THP is
actually expected to be as fast as this anyway, so if that's available then
we should already be as fast. This is for non-THP where THP cannot be enabled
and there is still room for some improvement. Most/all architectures will be
just fine with this. This flag is more of a safety-net type of thing where in
the future if there is this one or two weird architectures that don't play
well, then they can turn it off at the architecture level by not selecting
the flag. See my latest patches for the per-architecture compile-time
controls. Ideally we'd like to blanket turn it on on all, but this is just
playing it extra safe as Kirill and me were discussing on other threads.

thanks!

- Joel

