Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8C7C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 10:49:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025222082D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 10:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uRVyPXCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025222082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gkQd2zTmzF37D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 21:49:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uRVyPXCy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="uRVyPXCy"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gkMz1GJSzDrYb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 21:47:10 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id d23-v6so3641531pls.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1R3A0ycONFuPhko1Zvw9OxjeXH19x+s87tjU9oKwfSw=;
 b=uRVyPXCyFw/vFJ9ptle4zloJMrol+XisBixqDteIGc2z2oG/f4Q8NfKA0B2gilh+Rr
 i+HTajUVnTgL+59CrAsNpIQzGw2bYTsOBSPmi9WVqroK585WsKPK4zT2IIvv2C6f23dJ
 F9grKSKsJ1P0XFYJA4GEnLgn3qb5En9KpzOMyEtJi1cliFP4s9dMdLlWGK2lC/PN9h34
 PzeoJEkp3NKRxc1VVfXDgfbweJjDPzw7KTQ0g9tXmzEx6xT3/YOHh00cgteTAphadXLE
 270H2CcukCX0575S0EAUXv7rBR5pp/bl8ZyBNwBfTku8pgy4LLUWuBo4TdiLZcu1G2r6
 ZGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1R3A0ycONFuPhko1Zvw9OxjeXH19x+s87tjU9oKwfSw=;
 b=bO2e06AWmIDSq/tOJbkOwHPtpdkWBi/n9cLqVjQ1BLgBhFbzIOoFu4z6FcKwBhkgHt
 2OX8CRBPz7AsvLQgzj7AqYsNUd94di3do/+RIPR3rWVWK9wSEB/1m2SGD9c8IUR17ACh
 AmUHinkVlfLUSpcbmxQHvVVH6jujgoTVYMI5gYdKrV/fD6GFYrgIEi8Ksqojh8hBlZWE
 DULpbH7SezDFYkpELRlrkQKKIjdzTy6jDQT1b1RS2KenUdB1y0xKJIFzXi0uKczps44U
 /mz+fPC8O+Iqk8GihFgU7U6+iwmy9H7RTNdKBGA6UzKbRbocd96dlXaqQokf75LvpZEO
 9lnA==
X-Gm-Message-State: AGRZ1gInArd8BewV+dbyy3TAQoM6oYViVsRI3Hh5il0cJ+Tj6da8p5eJ
 3Tq49r4W/ptnfOx6ESPEamngKQ==
X-Google-Smtp-Source: AJdET5fRlG7zn7SaYzZpRZ5UT8n9qs5ABGZ7gGjpA2WzJPxYDI1NTaxmusE6kiTKMEVKRP5rq9c/Gw==
X-Received: by 2002:a17:902:8c86:: with SMTP id
 t6-v6mr1023260plo.55.1540464428285; 
 Thu, 25 Oct 2018 03:47:08 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
 by smtp.gmail.com with ESMTPSA id z22-v6sm8085935pgv.24.2018.10.25.03.47.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Oct 2018 03:47:07 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 722DF300225; Thu, 25 Oct 2018 13:47:03 +0300 (+03)
Date: Thu, 25 Oct 2018 13:47:03 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] treewide: remove unused address argument from
 pte_alloc functions (v2)
Message-ID: <20181025104703.esl6wxyg2ihe4zoc@kshutemo-mobl1>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
 <20181024083716.GN3109@worktop.c.hoisthospitality.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024083716.GN3109@worktop.c.hoisthospitality.com>
User-Agent: NeoMutt/20180716
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
 Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu,
 dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
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
 nios2-dev@lists.rocketboards.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, Richard Weinberger <richard@nod.at>,
 linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 pantin@google.com, linux-kernel@vger.kernel.org, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 24, 2018 at 10:37:16AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 12, 2018 at 06:31:57PM -0700, Joel Fernandes (Google) wrote:
> > This series speeds up mremap(2) syscall by copying page tables at the
> > PMD level even for non-THP systems. There is concern that the extra
> > 'address' argument that mremap passes to pte_alloc may do something
> > subtle architecture related in the future that may make the scheme not
> > work.  Also we find that there is no point in passing the 'address' to
> > pte_alloc since its unused. So this patch therefore removes this
> > argument tree-wide resulting in a nice negative diff as well. Also
> > ensuring along the way that the enabled architectures do not do anything
> > funky with 'address' argument that goes unnoticed by the optimization.
> 
> Did you happen to look at the history of where that address argument
> came from? -- just being curious here. ISTR something vague about
> architectures having different paging structure for different memory
> ranges.

I see some archicetures (i.e. sparc and, I believe power) used the address
for coloring. It's not needed anymore. Page allocator and SL?B are good
enough now.

See 3c936465249f ("[SPARC64]: Kill pgtable quicklists and use SLAB.")

-- 
 Kirill A. Shutemov
