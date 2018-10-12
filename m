Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0569C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 12:02:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F832077C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 12:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sLllf+hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F832077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Wmfw15bQzDqq0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 23:02:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sLllf+hm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="sLllf+hm"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Wm5J5k9DzDrCm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 22:36:52 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id 23-v6so5728171pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RUBKeYPll4jMLSN3Gb+udTJXKfzopX9w+dug7aYTr/k=;
 b=sLllf+hmYeVdtEKLgpvUk4uo/R65gqQ2L7zDPqofo15O4TD2lqqZ48BnJii3zNLrzj
 NyrHzrmlo5M8BFAgDiAnDSzFkH/4pCMx41PDkn9KakXzyWFHzbatjJl7tG6M3QlRWbCb
 PxniswSJvBlL+/pLj7KZtuZCCp2I33/xGPiDrmpqGjXDRkvRlkWGmyBycB9Rzb7E6Zs2
 L7OGkByZKFBctGsWJmvbk2lLkFhYwnI954eYYA9mDD2xDlJKx5AIfd14wPbV5Zu/imuW
 2GvR+0yYrS49d3VwMQPPTufF89rOzatfQb3FsyMC/zTNqHmMQ6U+r5c6uWOkB0vCTRFN
 mXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RUBKeYPll4jMLSN3Gb+udTJXKfzopX9w+dug7aYTr/k=;
 b=cfZ0+NL3wAGpmz7uUkwjL8z8B7qLNZpWBgxX/kfkYGMcdBSjzem7XcVKceakuQSfe+
 nI09b9xSE4tqCVCG21cSrjMItX+G4IM625qc0RXNQ6HazhQbxg6Dy7TL2V9HqGRXFYXn
 PWUJV8BC30FLRwQ5uDp7kNUsX2HSE+8q5p69L4Im5hHOpRQ+zWp2LpCK86QFysb4VNji
 9cLQQj0xV0RCgY6KabQc5PBuvMePPLF1u+7yibH8z81nk9IyjBuQqJgyc9UBwAz6CWVj
 FfRZ0uBB0IMooXoZJGqj3MdQmZ9ueej9Cqe8aLwDMN9ZUgFJdcRGWc8QuPogewDu77jE
 tIPg==
X-Gm-Message-State: ABuFfoj463sVZ7KLuLfF6xcbtw5MIV5jspxD8jSR8g1C06BotTd8DkQ6
 me+6Q5ZFFdw6gv1fi0EnfizIzA==
X-Google-Smtp-Source: ACcGV60LchXUm+4bueEbZ+6bNEGISqX12eR/mS25M3eC4m93W+yAf1Gp0Al5g3J7F1KCwHaUiWlf2A==
X-Received: by 2002:a63:2a11:: with SMTP id
 q17-v6mr5201085pgq.374.1539344210379; 
 Fri, 12 Oct 2018 04:36:50 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
 by smtp.gmail.com with ESMTPSA id o2-v6sm3561853pgi.62.2018.10.12.04.36.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 04:36:49 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 60154300030; Fri, 12 Oct 2018 14:36:45 +0300 (+03)
Date: Fri, 12 Oct 2018 14:36:45 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181012113644.meqy5yb3xrxyh6lh@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
User-Agent: NeoMutt/20180716
X-Mailman-Approved-At: Fri, 12 Oct 2018 22:56:52 +1100
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
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, nios2-dev@lists.rocketboards.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, Richard Weinberger <richard@nod.at>,
 linux-parisc@vger.kernel.org, pantin@google.com,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
 minchan@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > @@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  			split_huge_pmd(vma, old_pmd, old_addr);
> >  			if (pmd_trans_unstable(old_pmd))
> >  				continue;
> > +		} else if (extent == PMD_SIZE) {
> 
> Hm. What guarantees that new_addr is PMD_SIZE-aligned?
> It's not obvious to me.

Ignore this :)

-- 
 Kirill A. Shutemov
