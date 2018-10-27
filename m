Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11BEC46475
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 11:50:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5567B20856
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 11:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab1knh/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5567B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hzgw3s9wzDqBx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 22:50:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ab1knh/8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ab1knh/8"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hxj31tJFzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 21:21:10 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id 30-v6so1610399plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ytoc7E/E+CDN+36oMCq4ib7UWrIKwi1XigueqliThJE=;
 b=ab1knh/8i2Gpv4Vxfi+YDSBKbX/LgufE79cYPr5GJEdQUVQbI970thsDIy0ZjV1q0k
 ZSfcWvh4GTM9Brshk9p+y4tQ9MlVv9xCOgRN+Mkl3IacQhaurmJjOF4ISMav3UWSPWT0
 QDI4JUUMAIPA35q0/cXsitIc3ySa7+/5ANkq6TLz2UHPpSbIN1fzgNHsIaIbSC3XX++1
 mylMnA2ff0XDd2sL+yXZDHQHXijLBXi1MJNMHNoE52RFFgyL7H1Hr53le1mRs/9vRlLJ
 8fln4V5coK7PbseEtgyE6znLwjAsimR/DLzPXzQyaRXpcBZcO/1WMqn8CO3ILrNZhl0z
 +0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ytoc7E/E+CDN+36oMCq4ib7UWrIKwi1XigueqliThJE=;
 b=l+QdizRI8Mcj7MPYkrN+oDaVVtHZd8Se8XspXbrC0Dn7xCu5V+1RzNY8s5I7ZrtCnM
 ir5LemvVre44SRrG2/VmlsPFvC/7MdpWrcCTSxgoQUcXlCnmbR5+GylUr+nN0Bha9loV
 qZkDPlJoWUkHxeZwnXWdTVnbVsru78Ra2aWSi1Br7S4Y5Ixjq2G2Ja3OYAy0Pxhn3tZF
 wLoULiy2OR/vqrww9GF4QZCdsWCQe5GyFuRgqcDQJ0ZxvL8I9y949iSIxzBhKGKkP43a
 XHw9UMEx2oPR+rQsEVTri6YVBziTYmnqXxRygzpeaiCm2HiXpxPiBi7VnBUAUrYiIvwZ
 0JtQ==
X-Gm-Message-State: AGRZ1gIvnzz6BGUN0f/VtygmKspWI+uLikzbF331BjadkLoKqAPv2nrK
 4xBccCfjKApSRYiL1DM2XhQ=
X-Google-Smtp-Source: AJdET5dClbYQTLuFDbJ+0gDgS5/Hrs1bQO5PPuAbjI+vFXrDoU6PrAD4ZO8YmfARdAwQaa7m0KGriw==
X-Received: by 2002:a17:902:76c3:: with SMTP id
 j3-v6mr6882579plt.339.1540635667807; 
 Sat, 27 Oct 2018 03:21:07 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 z129-v6sm17506690pfb.40.2018.10.27.03.21.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 27 Oct 2018 03:21:06 -0700 (PDT)
Date: Sat, 27 Oct 2018 21:21:02 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181027102102.GO8537@350D>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181025021350.GB13560@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025021350.GB13560@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Sat, 27 Oct 2018 22:38:08 +1100
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

On Wed, Oct 24, 2018 at 07:13:50PM -0700, Joel Fernandes wrote:
> On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> [...]
> > > > +		pmd_t pmd;
> > > > +
> > > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > 
> > 
> > Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> > the code applies, why not just reuse as much as possible? The same comments
> > w.r.t mmap_sem helping protect against lock order issues applies as well.
> 
> I thought about this and when I looked into it, it seemed there are subtle
> differences that make such sharing not worth it (or not possible).
>

Could you elaborate on them?

Thanks,
Balbir Singh. 
