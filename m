Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA7DC6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:34:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7399E2098A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Z8gYJNm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7399E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X2gp3F8jzF3HX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:34:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Z8gYJNm7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="Z8gYJNm7"; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WysM5h6FzDrCQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 06:42:14 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id l17-v6so6692221pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=7HZNZsB1jLEFaholpalHaVYnkWxxqdQS2UbsT4fFuJY=;
 b=Z8gYJNm7ONxx3qybdg27wFRSoVULBn2tUUBtRitXwUvZz3AhLFXo+FQIkGmVSgFidC
 qSw7CPJOp1WJWKXTflv0xxIw2LNh5s0xIfzOfYgIhSxjNXxUmUyqLzzwB0ATx3kCdzlg
 oxaGTQ7SptXZTjdi/GmovUe6gMn7aR4yslCfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=7HZNZsB1jLEFaholpalHaVYnkWxxqdQS2UbsT4fFuJY=;
 b=BQOMyv/4gpsa+j8aMBmij6fgBjZhqXD379H+/Zsp8WZ+NXIXBHnHCthRjBzgUbAbMJ
 LHr90mEZNeggQRBh35LXQXk4Lqg1dOM6epsycUlW9sm3MNWEKnRDdXU7917k3w9h85vT
 jMTyx4xVwlb9pQyVojFOAyTvDfF/lmVtpX6Dpt8OuGha3c2rw7jKc3pdjV9F72LI619b
 hcmjRWgtNWyzdLXfpfER/opH3V1DwqzY0LbSJHXkSMHH6TFkoONpsm30d0HDPa8CnlnO
 sHBDaSZcjg3KCSWA1rcmIgxQj8qRufUb7Xrd+bkPfETo24Uy0UTXPk7+95C0vdpquCXX
 wnTw==
X-Gm-Message-State: ABuFfogijRUpIjzWeA12dKuyKiVRVm5SsZQs+FTAU7uv878ItB9vvheJ
 mIsw0LUFRZWfkQ3nPB18BcjBfA==
X-Google-Smtp-Source: ACcGV62ghsr+2nsme8ztf1h/ejIwFwjRsZeeKiC6kJsMYRGK5dHID+ZMDEAPamf9Lz3JQcU3Yz/xdw==
X-Received: by 2002:a63:f922:: with SMTP id
 h34-v6mr6748971pgi.154.1539373332263; 
 Fri, 12 Oct 2018 12:42:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id k70-v6sm3054384pfc.76.2018.10.12.12.42.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Oct 2018 12:42:11 -0700 (PDT)
Date: Fri, 12 Oct 2018 12:42:10 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Message-ID: <20181012194210.GA27630@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Sat, 13 Oct 2018 08:58:21 +1100
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, kernel-janitors@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Lokesh Gidra <lokeshgidra@google.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Daniel Colascione <dancol@google.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Hugh Dickins <hughd@google.com>,
 "James E. J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, nios2-dev@lists.rocketboards.org,
 "Kirill A. Shutemov" <kirill@shutemov.name>, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org,
 pantin@google.com, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 08:51:45PM +0200, SF Markus Elfring wrote:
> > The changes were obtained by applying the following Coccinelle script.
> 
> A bit of clarification happened for its implementation details.
> https://systeme.lip6.fr/pipermail/cocci/2018-October/005374.html
> 
> I have taken also another look at the following SmPL code.
> 
> 
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> 
> I suggest to adjust the regular expression for this constraint
> and in subsequent SmPL rules.
> "^(?:pte_alloc(?:_one(?:_kernel)?)?|__pte_alloc(?:_kernel)?)$";

Sure it looks more clever, but why? Ugh that's harder to read and confusing.

> > (
> > - T3 fn(T1 E1, T2 E2);
> > + T3 fn(T1 E1);
> > |
> > - T3 fn(T1 E1, T2 E2, T4 E4);
> > + T3 fn(T1 E1, T2 E2);
> > )
> 
> I propose to take an other SmPL disjunction into account here.
> 
>  T3 fn(T1 E1,
> (
> -      T2 E2
> |      T2 E2,
> -      T4 E4
> )      );

Again this is confusing. It makes one think that maybe the second argument
can also be removed and requires careful observation that the ");" follows.

> > (
> > - #define fn(a, b, c)@p e
> > + #define fn(a, b) e
> > |
> > - #define fn(a, b)@p e
> > + #define fn(a) e
> > )
> 
> How do you think about to omit the metavariable “position p” here?

Right, I don't need it in this case. But the script works either way.

I like to take more of a problem solving approach that makes sense, than
aiming for perfection, after all this is a useful script that we do not
need to check in once we finish with it.

 - Joel

