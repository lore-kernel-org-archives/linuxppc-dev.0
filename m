Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCD5C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 11:59:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133C42077C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 11:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="g54sfYi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133C42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Wmbb0JSyzF3TN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:59:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="g54sfYi+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="g54sfYi+"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Wlyc27PKzF3S4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 22:31:04 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id c25-v6so6060869pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 04:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=l7AhKnmfvmp8KBJvG0N/KXKa/mMdyWfz5lA4HnS7BL8=;
 b=g54sfYi+w0crnYiSByxg5Nkl3eGqhJ6PN3wZFl+ctMzP2ovV+r5fma35R0NtLVm7f4
 n5dBPdHh/h+S00ymRa9yXbYyWCDNbz5qTo9fbzEBNajxgbVXHatOXKhWE2ymaeXn4b5+
 3y3wh4nrJJVcwBsKyp1ZdwGny9fgiF2ZGJoiLdnlO2hbOpRXU/jsB85IrZoJ+NpUk4uq
 jaOW+U4M0qLfRnRGAkxWtj5pjU2u4VJgE+Mmaw1D6h2dqW+o9dFjgqSLLoVlGTHQkemb
 O2qFRHSU7x5ebQd3d+IhwBYfRwpZqwIx0EmzYxOFIjiVnHWgdZ7DEtkH2GtuE3Iit1L9
 iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=l7AhKnmfvmp8KBJvG0N/KXKa/mMdyWfz5lA4HnS7BL8=;
 b=DQKZBK8xP5vXsA9dhsmaJI940EdeitQ/kFqyC3AxQGQ0eVrNbsInYQWAuYQAfWbosK
 zTqQ4LOUapJso8Mm0Lr0wMKbwP4dMLEZixoQXQgK7SbhVzfq64g38BI5enwLRJ2/SqlN
 HmhSzTOEAtAl7MbnuCAkerRDaGp/HVQbhln62LlANCEZRIk6IGdUXxMsUmJTj8Fc3awP
 oZ4j+hBcRzPW1iszHdcNLlp76YjwTxOveH4AunpoCj1+ZVy16yayzfdz6E8b4hzfBCfu
 Qi2mgpS99GUhdfhjRovBs89kbll1JgmB4gHHC1Ce/Fa1L861A9BLZEvwg+IXChPcpPvZ
 /k3g==
X-Gm-Message-State: ABuFfojg7L2MRmb8ch97AqFJuePqwcCjITw4xzg/Glk5ZzdQuZUJ71v5
 pyue7XrV16vEn3tm36yh41w/lA==
X-Google-Smtp-Source: ACcGV62lBfke4Nd6rzFvvGEYe+NYu7uJH2YfYRGmsZVhWDnzIbZPXUe0wUiVZh6jfZwYAfZZwYDRWA==
X-Received: by 2002:a63:194a:: with SMTP id
 10-v6mr5233013pgz.192.1539343861937; 
 Fri, 12 Oct 2018 04:31:01 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
 by smtp.gmail.com with ESMTPSA id o12-v6sm1985263pfh.20.2018.10.12.04.30.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Oct 2018 04:31:00 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 6FFFA300030; Fri, 12 Oct 2018 14:30:56 +0300 (+03)
Date: Fri, 12 Oct 2018 14:30:56 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012013756.11285-2-joel@joelfernandes.org>
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

On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> Android needs to mremap large regions of memory during memory management
> related operations. The mremap system call can be really slow if THP is
> not enabled. The bottleneck is move_page_tables, which is copying each
> pte at a time, and can be really slow across a large map. Turning on THP
> may not be a viable option, and is not for us. This patch speeds up the
> performance for non-THP system by copying at the PMD level when possible.
> 
> The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> completion times drops from 160-250 millesconds to 380-400 microseconds.
> 
> Before:
> Total mremap time for 1GB data: 242321014 nanoseconds.
> Total mremap time for 1GB data: 196842467 nanoseconds.
> Total mremap time for 1GB data: 167051162 nanoseconds.
> 
> After:
> Total mremap time for 1GB data: 385781 nanoseconds.
> Total mremap time for 1GB data: 388959 nanoseconds.
> Total mremap time for 1GB data: 402813 nanoseconds.
> 
> Incase THP is enabled, the optimization is skipped. I also flush the
> tlb every time we do this optimization since I couldn't find a way to
> determine if the low-level PTEs are dirty. It is seen that the cost of
> doing so is not much compared the improvement, on both x86-64 and arm64.

I looked into the code more and noticed move_pte() helper called from
move_ptes(). It changes PTE entry to suite new address.

It is only defined in non-trivial way on Sparc. I don't know much about
Sparc and it's hard for me to say if the optimization will break anything
there.

I think it worth to disable the optimization if __HAVE_ARCH_MOVE_PTE is
defined. Or make architectures state explicitely that the optimization is
safe.

> @@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  			split_huge_pmd(vma, old_pmd, old_addr);
>  			if (pmd_trans_unstable(old_pmd))
>  				continue;
> +		} else if (extent == PMD_SIZE) {

Hm. What guarantees that new_addr is PMD_SIZE-aligned?
It's not obvious to me.

-- 
 Kirill A. Shutemov
