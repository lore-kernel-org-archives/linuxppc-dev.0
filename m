Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA63DC004D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 08:40:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D07206B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 08:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dN76Of2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D07206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g3cD5D7wzDrS3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 19:40:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="dN76Of2N";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="dN76Of2N"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g3Yg0bgKzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 19:38:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d2jfpjjB7oLmUkq3D7u7NPvUnHT/Qv4wl7bB9GP1+OQ=; b=dN76Of2NrI7shDByrYt1spoOs
 fBUYXsTsK9Kj4I1LXQDJPK2xbkMaXWpCmI4B0RLlP+9OXOkAtMmh68ZXCVO3S/pBN6dU0lgxD8gWX
 nB/Mk2BBYcQ3IlsOKSD/gdq8fN/Vp8fQ1SEFiYUfrNVfW57MgKQ9LrENYhjAozBIELFjQvTEPJNi5
 bz9uiXLHG17dG6EVwpehVjKZCtfq1bMHlqor9mgtNLP7WP2m2pWVDPspQzaKuMyTnFdPaDUhc/6kR
 mJe495zAtAHoUNeijZ1k8/AMfxQaYrE6a6RZnTBSeFiJ345Pm3weHdfiQbp0l9zYh1YwhM+nt6XPS
 SmRzIXzSw==;
Received: from [185.7.230.213] (helo=worktop)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFEfH-0004So-Sa; Wed, 24 Oct 2018 08:37:20 +0000
Received: by worktop (Postfix, from userid 1000)
 id EDB716E08AB; Wed, 24 Oct 2018 10:37:16 +0200 (CEST)
Date: Wed, 24 Oct 2018 10:37:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH 1/4] treewide: remove unused address argument from
 pte_alloc functions (v2)
Message-ID: <20181024083716.GN3109@worktop.c.hoisthospitality.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013013200.206928-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
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
 nios2-dev@lists.rocketboards.org, "Kirill A . Shutemov" <kirill@shutemov.name>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, pantin@google.com,
 linux-kernel@vger.kernel.org, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 06:31:57PM -0700, Joel Fernandes (Google) wrote:
> This series speeds up mremap(2) syscall by copying page tables at the
> PMD level even for non-THP systems. There is concern that the extra
> 'address' argument that mremap passes to pte_alloc may do something
> subtle architecture related in the future that may make the scheme not
> work.  Also we find that there is no point in passing the 'address' to
> pte_alloc since its unused. So this patch therefore removes this
> argument tree-wide resulting in a nice negative diff as well. Also
> ensuring along the way that the enabled architectures do not do anything
> funky with 'address' argument that goes unnoticed by the optimization.

Did you happen to look at the history of where that address argument
came from? -- just being curious here. ISTR something vague about
architectures having different paging structure for different memory
ranges.
