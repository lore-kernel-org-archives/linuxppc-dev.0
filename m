Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F206C32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 05:52:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824262081D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 05:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vFP1Hs1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824262081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pzG22T2NzF35p
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 16:52:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vFP1Hs1w";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="vFP1Hs1w"; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pxZH2WxYzDrDJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 15:36:04 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id f8-v6so5242083pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 20:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2ZO7f7AbR0Q/Tv9r9GFR6EhQOtVlvtqVzi+kHQIwd6Q=;
 b=vFP1Hs1wYQcIlWGzK/RquQm7mPiYOK37zkYc9g7HM5f1UakBrd0LproiSxWxB+J+cw
 LwUgBiOgB/Mof2uCb5M7ypmLMYM7sa/OYV8c2R4EJZNkyEzkll/fFaiA1VN/bVpLQDnv
 N2x7os/SUx/84UCqqI0dyLJ344I+8ENkn6mEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2ZO7f7AbR0Q/Tv9r9GFR6EhQOtVlvtqVzi+kHQIwd6Q=;
 b=jSUkrwNUjZdkWACvG77PVK1A1H2jD3KGG899cGuPDScTV/Abc7YVESn9zY5W2e8JXV
 q2DIcivf3XGUmjre7rA7UaLNfDTmnyuPUbyXSzlm7QApFp4u519y3h3NoeaEyY7BWzfv
 QqdlklT1PU6Y+jmbEUI1/0Q9/j7MwZ69eTsTkjrHwp+tXP4hJlgeyoIkI+k6Q3N0KOAO
 aZxlgRwZkLIyTJ8YFOBWI5bmexe3KRJI6g0JDbNUuefcgXmc2+mPaBcpX+watz4LNj3+
 LOtXTpHM72sIQ3xYuFPPe0wmpDEToCmQGAaz4r5PVynWomq9MDh9RXJG34VbJkDwfvKq
 cvOQ==
X-Gm-Message-State: AGRZ1gJilufr5XgoNWiCyBZco0PsUTWa7h/HLl3A+ifaaH8T40OSu4R4
 kg01xRZETR4fSkTrjOreEuUKSw==
X-Google-Smtp-Source: AJdET5ecnHmWHapBSfgQDaRa+d8XuLQo3dJlBpesDCXVYTiF4QhB2rt8xq4tK8y9MBGhfwYqJFpEjQ==
X-Received: by 2002:a63:5ec6:: with SMTP id
 s189mr21579640pgb.357.1541478962566; 
 Mon, 05 Nov 2018 20:36:02 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id c87-v6sm43985294pfe.93.2018.11.05.20.36.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Nov 2018 20:36:01 -0800 (PST)
Date: Mon, 5 Nov 2018 20:36:00 -0800
From: Joel Fernandes <joel@joelfernandes.org>
To: William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
Message-ID: <20181106043600.GB139199@google.com>
References: <20181103040041.7085-1-joelaf@google.com>
 <6886607.O3ZT5bM3Cy@blindfold>
 <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
 <20181103183208.GA56850@google.com>
 <D6FB3C15-A8C1-4694-A434-A7489F590E05@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6FB3C15-A8C1-4694-A434-A7489F590E05@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 06 Nov 2018 16:49:54 +1100
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
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
 Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu,
 dancol@google.com, linux-ia64@vge.kvack.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org,
 Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>,
 r.kernel.org@lithops.sigma-star.at, hughd@google.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com,
 Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-s390@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, nios2-dev@lists.rocketboards.org,
 "Kirill A. Shutemov" <kirill@shutemov.name>, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, pantin@google.com,
 LKML <linux-kernel@vger.kernel.org>, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 04, 2018 at 12:56:48AM -0600, William Kucharski wrote:
> 
> 
> > On Nov 3, 2018, at 12:32 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > Looks like more architectures don't define set_pmd_at. I am thinking the
> > easiest way forward is to just do the following, instead of defining
> > set_pmd_at for every architecture that doesn't care about it. Thoughts?
> > 
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 7cf6b0943090..31ad64dcdae6 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -281,7 +281,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> > 			split_huge_pmd(vma, old_pmd, old_addr);
> > 			if (pmd_trans_unstable(old_pmd))
> > 				continue;
> > -		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
> > +		} else if (extent == PMD_SIZE) {
> > +#ifdef CONFIG_HAVE_MOVE_PMD
> > 			/*
> > 			 * If the extent is PMD-sized, try to speed the move by
> > 			 * moving at the PMD level if possible.
> > @@ -296,6 +297,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> > 				drop_rmap_locks(vma);
> > 			if (moved)
> > 				continue;
> > +#endif
> > 		}
> > 
> > 		if (pte_alloc(new_vma->vm_mm, new_pmd))
> > 
> 
> That seems reasonable as there are going to be a lot of architectures that never have
> mappings at the PMD level.

Ok, I will do it like this and resend.

> Have you thought about what might be needed to extend this paradigm to be able to
> perform remaps at the PUD level, given many architectures already support PUD-mapped
> pages?
> 

I have thought about this. I believe it is doable in the future. Off the top
I don't see an issue doing it, and it will also reduce the number of flushes.

thanks,

- Joel

