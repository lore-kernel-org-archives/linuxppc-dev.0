Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C20C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 17:53:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAAA206B2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 17:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gtX/3bFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAAA206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XXP12LQ7zF3J1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 04:53:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gtX/3bFK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="gtX/3bFK"; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XXLF484nzF3DT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 04:50:44 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id f18-v6so7282987pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GoWsMygASIRyu7PZgD3N2dBBnQZB9nQ/7GbuLV2HYnY=;
 b=gtX/3bFKdysbo0S38lPP9ATjDdsTysp7ptOg+SsEzBQmc5jRhOODzCYik6fd+BjPNr
 xu2Vp+XyGO4o3VTbAkLtyvZfSWRtUUHxernM8wIzLOXHfZUYx/YsB2m5iu16tCWuQG1m
 dx/4Vn6wKESA5zdAVp2ssOawvrRQIiujDiDAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GoWsMygASIRyu7PZgD3N2dBBnQZB9nQ/7GbuLV2HYnY=;
 b=DR3j63PowWebF0lmTpLP3WEOv6+BoMtoAO0SBN+bG2Pm8MhLJD4MSOzmRZKRVpCSO6
 P3SULCnzC8g5HsrKRDdz84rJwUQG9JyXqMNBZLogSzLWgw2Ulq/6d4Yb4brN0feM1FSx
 R3D7Nq3yYFFtcgWWv7QJA55bDyWPdttQYCOP9aBLlf6mJflTHW+8DNxr4WYBMhP5afhN
 Q1IgT/1P/r4EIHGOhVX9blgiSxhvgHkNYAAYn1VjyOg6/Hd4dnRUHefC7JD1PlQAyJSD
 i/NaO4HSdSFbA+mRnvst3HAXIWyL4F4Zp5IMcGfXgujj9c35ROb2wPdynffUo3noPLVh
 p2wg==
X-Gm-Message-State: ABuFfojTVAhxys/+8nbv8g5aMNauMoO9LLutDtXqTSFJUqlYq1uEip0r
 39JCI37ZoxE/sSxnfT1bDKqCig==
X-Google-Smtp-Source: ACcGV61mIIBnEva6K1s4pwIUv1udY8Qs2DvoHn+puuc+AYRgF7l/b6wUFQE1+gRiz97iAhmfFDPhRQ==
X-Received: by 2002:a63:f64f:: with SMTP id
 u15-v6mr10134944pgj.258.1539453041895; 
 Sat, 13 Oct 2018 10:50:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id t26-v6sm7479626pfa.158.2018.10.13.10.50.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 13 Oct 2018 10:50:40 -0700 (PDT)
Date: Sat, 13 Oct 2018 10:50:39 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: dancol@google.com
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013175039.GB213522@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
 <20181013014429.GB207108@joelaf.mtv.corp.google.com>
 <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
 <20181013021057.GA213522@joelaf.mtv.corp.google.com>
 <CAKOZueu2wdkeUFYLQ8qE48yJs1_uRz-9RVJRkp==CL=jp=Q8+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueu2wdkeUFYLQ8qE48yJs1_uRz-9RVJRkp==CL=jp=Q8+g@mail.gmail.com>
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

On Fri, Oct 12, 2018 at 07:25:08PM -0700, Daniel Colascione wrote:
[...] 
> > But anyway, I think this runtime detection thing is not needed. THP is
> > actually expected to be as fast as this anyway, so if that's available then
> > we should already be as fast.
> 
> Ah, I think the commit message is confusing. (Or else I'm misreading
> the patch now.) It's not quite that we're disabling the feature when
> THP is enabled anywhere, but rather that we use the move_huge_pmd path
> for huge PMDs and use the new code only for non-huge PMDs. (Right?) If
> that's the case, the commit message shouldn't say "Incase THP is
> enabled, the optimization is skipped". Even if THP is enabled on a
> system generally, we might use the new PMD-moving code for mapping
> types that don't support THP-ization, right?

That is true. Ok, I guess I can update the commit message to be more accurate
about that.

> > This is for non-THP where THP cannot be enabled
> > and there is still room for some improvement. Most/all architectures will be
> > just fine with this. This flag is more of a safety-net type of thing where in
> > the future if there is this one or two weird architectures that don't play
> > well, then they can turn it off at the architecture level by not selecting
> > the flag. See my latest patches for the per-architecture compile-time
> > controls. Ideally we'd like to blanket turn it on on all, but this is just
> > playing it extra safe as Kirill and me were discussing on other threads.
> 
> Sure. I'm just pointing out that the 500x performance different turns
> the operation into a qualitatively different feature, so if we expect
> to actually ship a mainstream architecture without support for this
> thing, we should make it explicit. If we're not, we shouldn't.

We can make it explicit by enabling it in such a mainstream architecture is
my point. Also if the optimization is not doing what its supposed to, then
userspace will also just know by measuring the time.

thanks,

 - Joel

