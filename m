Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC247C46475
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 00:25:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AD920848
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 00:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QPtsyBSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AD920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42jJRh2fKQzF1BS
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 11:25:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QPtsyBSU";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="QPtsyBSU"; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42jB565j9WzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Oct 2018 06:39:22 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id bb7-v6so1956017plb.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AHWCz3fu9TpC7J2ei9HeEkNKgFxDHuGGuLqn4Rh+JHE=;
 b=QPtsyBSUj6AojIo85azY8oUVJwGhm0RIqVohzSIMkkWGL/CZwEBPHYTna50E7Om4WA
 F5z18wGfy8lz5xFwg1vCwZ9ySWUf9QkWrrkAXwGsE1TwsrZ1HoqAWixpXJ3DliywdJzW
 CxbFyNe852Wb89cMxFXqW5ZHR3ew/TXqEJ1ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AHWCz3fu9TpC7J2ei9HeEkNKgFxDHuGGuLqn4Rh+JHE=;
 b=PNi0fQSAXhUjHPgPr12B5FisBY+JbroIRieUKi75A5YhTot9ey2WHkGsQvefE9/IZR
 AEPdz4pMGsnU8rYoulrmRzzaTx2RbtDy3x4lydrr0RdWNBgwcQaLQrmgNUhlUiA+dEF3
 I34KbOTt/NfR7R4Fqvo/5npBhCjGlKttkkVHnnu97j9Nt0V6syurDu6iPLaPxTFkocQf
 +qkH+Yrg4WhbEfIk8lQkZ+zxFUy42qtiYmdDE7rS9sRZYIAwCs5TJlqLQSpu4+VBhkqs
 pDiUtr7vYa0PHLjhYY8zNlJiHlQArthTuvGsvYN0HjmURoMftio/ZnuQoDUlHwrp4yDJ
 KM5g==
X-Gm-Message-State: AGRZ1gKYRsTC5HfhHsUm0OVYTe2zZMFvtcYBxMfskWj8UqGWT4FdhWSY
 ajtJfCc+k3yhVDtwRTY63AVRzw==
X-Google-Smtp-Source: AJdET5f21mfpbfgLffX+k0qGngh7x8A4g9m9LTX1FSqvBjQFfP0xKIMF/O60+aOyl9qi4XLET8IsYQ==
X-Received: by 2002:a17:902:3381:: with SMTP id
 b1-v6mr8190467plc.323.1540669159792; 
 Sat, 27 Oct 2018 12:39:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id 11-v6sm23945581pfs.108.2018.10.27.12.39.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 27 Oct 2018 12:39:18 -0700 (PDT)
Date: Sat, 27 Oct 2018 12:39:17 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181027193917.GA51131@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181025021350.GB13560@joelaf.mtv.corp.google.com>
 <20181027102102.GO8537@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027102102.GO8537@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Sun, 28 Oct 2018 11:23:44 +1100
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

Hi Balbir,

On Sat, Oct 27, 2018 at 09:21:02PM +1100, Balbir Singh wrote:
> On Wed, Oct 24, 2018 at 07:13:50PM -0700, Joel Fernandes wrote:
> > On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> > [...]
> > > > > +		pmd_t pmd;
> > > > > +
> > > > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > > 
> > > 
> > > Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> > > the code applies, why not just reuse as much as possible? The same comments
> > > w.r.t mmap_sem helping protect against lock order issues applies as well.
> > 
> > I thought about this and when I looked into it, it seemed there are subtle
> > differences that make such sharing not worth it (or not possible).
> >
> 
> Could you elaborate on them?

The move_huge_page function is defined only for CONFIG_TRANSPARENT_HUGEPAGE
so we cannot reuse it to begin with, since we have it disabled on our
systems. I am not sure if it is a good idea to split that out and refactor it
for reuse especially since our case is quite simple compared to huge pages.

There are also a couple of subtle differences between the move_normal_pmd and
the move_huge_pmd. Atleast 2 of them are:

1. We don't concern ourself with the PMD dirty bit, since the pages being
moved are normal pages and at the soft-dirty bit accounting is at the PTE
level, since we are not moving PTEs, we don't need to do that.

2. The locking is simpler as Kirill pointed, pmd_lock cannot fail however
__pmd_trans_huge_lock can.

I feel it is not super useful to refactor move_huge_pmd to support our case
especially since move_normal_pmd is quite small, so IMHO the benefit of code
reuse isn't there very much.

Do let me know your thoughts and thanks for your interest in this.

thanks,

 - Joel

