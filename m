Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07344C5ACC6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:11:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7627F20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 20:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V9PgMDNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7627F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZRJj4tKYzF3BN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 07:11:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V9PgMDNF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="V9PgMDNF"; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZQhl5XvDzF3Vr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 06:43:18 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id p25-v6so11483628pli.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4E6/TYIJnb1hpwFXfznXrU9WRJfBcYMDYHXRqDEZgOg=;
 b=V9PgMDNF7CBl5+Nzjvr0iSOtDiDCQgsN/s5ihAy9noZqWII6hYc6Ts6C5GhDKx8GXO
 m7lTUaprGsEeUyTBUKqmHo3irjZ1l34Zh9xqtEP2vVvNhHYNULvRTyjfiwn/iz3OaXl0
 6o0VR9etFqC0VPLMHRowVmTVSwuMOe0dtplzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4E6/TYIJnb1hpwFXfznXrU9WRJfBcYMDYHXRqDEZgOg=;
 b=cFhKC16s5beubv8YWLxYBObo+uvT+gVG73Tj/ujVRUoe7m4Qo6LdWS8naKkCEh+j6j
 vWcqmsmFPk+1rIIvXT3Yqbqgcjq1DIFqxHYy9BtidWKkNrxCv4EDvnpzkc/2UmBjsWp0
 Manfs2wKwwnpXmjzydFPRBaIut8R66IKzVYVFrxBGDiRwMVfeGlLkzvi/g7Yn/llEezf
 8j8ROftGSmDcFvaYc6x+Uwd/0UX//xwvgmDHXEOP+0vMF7W1TXhQizNdcOYFl3msKkNC
 0CqaDywibC+V+9daXhqJavRTKWV0DMgAI12rkFtQqcJbo45iLj3rH3bS6kqUA0mZSLXT
 HZbw==
X-Gm-Message-State: ABuFfoh2QtMOowLRCBOpPpDZ5vC4Rf8dvIFqsJr9lVt36QBVO+L47MlL
 x4mpRsi08L8Wq84+QoRxrAcPlg==
X-Google-Smtp-Source: ACcGV62AdBcFxDIb9TDt/mmUnedT1xOttrv1cSqMsBN5bCJGRH95gVqQWD3vO6sNA2FVCR0J+aMC2w==
X-Received: by 2002:a17:902:15a8:: with SMTP id
 m37-v6mr22725955pla.132.1539718996443; 
 Tue, 16 Oct 2018 12:43:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id s2-v6sm15420002pgo.90.2018.10.16.12.43.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Oct 2018 12:43:14 -0700 (PDT)
Date: Tue, 16 Oct 2018 12:43:13 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181016194313.GA247930@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181015094209.GA31999@infradead.org>
 <20181015223303.GA164293@joelaf.mtv.corp.google.com>
 <35b9c85a-b366-9ca3-5647-c2568c811961@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b9c85a-b366-9ca3-5647-c2568c811961@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Wed, 17 Oct 2018 07:06:33 +1100
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
 kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, elfring@users.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 linux-xtensa@linux-xtensa.org, Jeff Dike <jdike@addtoit.com>,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Ley Foon Tan <lftan@altera.com>, kirill@shutemov.name,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, pantin@google.com, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Richard Weinberger <richard@nod.at>,
 anton.ivanov@kot-begemot.co.uk, nios2-dev@lists.rocketboards.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 16, 2018 at 01:29:52PM +0200, Vlastimil Babka wrote:
> On 10/16/18 12:33 AM, Joel Fernandes wrote:
> > On Mon, Oct 15, 2018 at 02:42:09AM -0700, Christoph Hellwig wrote:
> >> On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> >>> Android needs to mremap large regions of memory during memory management
> >>> related operations.
> >>
> >> Just curious: why?
> > 
> > In Android we have a requirement of moving a large (up to a GB now, but may
> > grow bigger in future) memory range from one location to another.
> 
> I think Christoph's "why?" was about the requirement, not why it hurts
> applications. I admit I'm now also curious :)

This issue was discovered when we wanted to be able to move the physical
pages of a memory range to another location quickly so that, after the
application threads are resumed, UFFDIO_REGISTER_MODE_MISSING userfaultfd
faults can be received on the original memory range. The actual operations
performed on the memory range are beyond the scope of this discussion. The
user threads continue to refer to the old address which will now fault. The
reason we want retain the old memory range and receives faults there is to
avoid the need to fix the addresses all over the address space of the threads
after we finish with performing operations on them in the fault handlers, so
we mremap it and receive faults at the old addresses.

Does that answer your question?

thanks,

- Joel

