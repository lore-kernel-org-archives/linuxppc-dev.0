Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9B2C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:55:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17A82075D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q/q3QTdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17A82075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gpXk4hjXzF38K
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 00:55:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q/q3QTdA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="q/q3QTdA"; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gVzk3hv0zDqdx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 13:13:54 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id w3-v6so3230423pgs.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5CbWcmgaWhK69oh2DEOguVgA2uKl1YpKoqaGwtGwge8=;
 b=q/q3QTdACzUlPpDQMN1kjcezMfcsn0Yv6fXB6ODPHDCxjW91L/KWd7ad+HnYMhVDLK
 4w8FEyzAp+rB09Si8JZs7MJE9NTlxjm6PO3Hk2MpIdxGl6P2KagjiLkUB/ExO2oGujpm
 CSZTqm0K2zOVm+Foil/VJrYg2JhZozpJsR9l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5CbWcmgaWhK69oh2DEOguVgA2uKl1YpKoqaGwtGwge8=;
 b=g6jMvG59tM96/5ri1t+ryXBZ6nrJXNFewb1s7Oanr19bXaWdsGfH1YYnHz+R5KjHH2
 /SU4Gu9QBjftYu9q784Cp8xM82tjnsSCwSglt17AbzHynAnuitf0ZQ58fvmTJASHXp8A
 w2XA0grxqhHdYX8f1pyL7A7Zw51GwccM50oAAVmAVFTJHiEnaEeExmnmM2XJ1V4wvgEa
 yYZfQ62IU19pwkQoNoCrPqzWvnndts9n2E37u9dpghqIN6vAB1JfamlGRSvaQBSDqZ3d
 Yqjy/jipiApyWnoY7qRn02KKMog31VZmkwV/7LGBY/S0AEO+PCgvZ8+1XUj1xbGNMn1I
 /aYg==
X-Gm-Message-State: AGRZ1gKah8Lnkdd4OR3NtXUy98oT10FwvJIkkKtFfXH3wytzSKJrDHqs
 Qv8tmcnatN+AinkgFnUamK2fDQ==
X-Google-Smtp-Source: AJdET5dpMwn85VnY2OpxFWBdTBIZT6WEknqSNasg/mS3JU0dLY8ImJjZVFsNiBwxQlcm8wQ3lAxw+Q==
X-Received: by 2002:a63:441f:: with SMTP id
 r31-v6mr4853133pga.60.1540433632120; 
 Wed, 24 Oct 2018 19:13:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id 73-v6sm774464pft.178.2018.10.24.19.13.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Oct 2018 19:13:50 -0700 (PDT)
Date: Wed, 24 Oct 2018 19:13:50 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181025021350.GB13560@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024115733.GN8537@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Fri, 26 Oct 2018 00:50:26 +1100
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
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 kvmarm@lists.cs.columbia.edu, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-s390@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 nios2-dev@lists.rocketboards.org, "Kirill A. Shutemov" <kirill@shutemov.name>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org,
 pantin@google.com, Max Filippov <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
[...]
> > > +		pmd_t pmd;
> > > +
> > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> 
> 
> Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> the code applies, why not just reuse as much as possible? The same comments
> w.r.t mmap_sem helping protect against lock order issues applies as well.

I thought about this and when I looked into it, it seemed there are subtle
differences that make such sharing not worth it (or not possible).

 - Joel

