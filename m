Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F2C6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:07:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EAB2087D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KQEzQQFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EAB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X24v21nhzF3Qq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:07:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KQEzQQFk";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="KQEzQQFk"; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Wtyx5qnjzF3T8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 03:46:49 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id r9-v6so6103617pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Umti8berIQqjm65Zoyf/w3JloUMrJhwZUXe+Y2BsWdc=;
 b=KQEzQQFkI6jyKow9cNxsGELIJZyLx1I8uGjB/QnyLtJkOtbntdWVJwS8u0cqFmWoK2
 Zbax90aSm2shdb707DdFjVreJBouZPwsGgrwGCldaGV6mLKNDvduyzCfqgYYC5kplbyd
 Z9GrlBVjP7KcXBEbZpZjy43C4pR8q7gp8Lu8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Umti8berIQqjm65Zoyf/w3JloUMrJhwZUXe+Y2BsWdc=;
 b=MjFw5b1clBNiPOHniFi4xs8U9aCK08FOHe6lsbFThOvgSRuGA6+6+EwZgJ8Vnt7SNH
 ENSbyiMgOMlFIFlX5wRGdTlLzcDMcY5Tly3jXKNqJxiBPcHO1lPEiCXLK+nnKaNl4VF0
 Ak0EZ2U2RgDeNlE29I4uKccZKtnl0heuzCWTJhwbkLJF/AlvSvXTAVmcKWWEa3SCktfF
 0bEcft4McX9nKDayyT6vHUclw004cPle5ugo5fVRXGPkfpKVcdcww450iNMCEtipk5Ys
 CNurPV0vR+TCbEZQ4t9rfdpkfbzEIO/m393+YipS1cV8mr9WqaK+c5DKnBefzMCAfhf+
 m8/g==
X-Gm-Message-State: ABuFfoh0NY3JktzAniVltaymDpCMAsprn87oRghvTiDDuB7al06NqzRP
 y+Pm8aFQCiv5G4dgOEDbx0LjpQ==
X-Google-Smtp-Source: ACcGV609gsys33zC1Yow1z87yTnxpouPc78UFZGuqi9n2/9mNvSopecla0EDsZWt+bvQnXlM2xKVdQ==
X-Received: by 2002:a63:991a:: with SMTP id
 d26-v6mr6276510pge.434.1539362807192; 
 Fri, 12 Oct 2018 09:46:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id g62-v6sm3310692pgc.22.2018.10.12.09.46.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Oct 2018 09:46:45 -0700 (PDT)
Date: Fri, 12 Oct 2018 09:46:44 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Message-ID: <20181012164644.GC223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk>
 <20181012163433.GA223066@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.20.1810121838180.4366@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1810121838180.4366@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Sat, 13 Oct 2018 08:58:20 +1100
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
 Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
 Ingo Molnar <mingo@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 linux-xtensa@linux-xtensa.org, Jeff Dike <jdike@addtoit.com>,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 kirill@shutemov.name, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, pantin@google.com, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Richard Weinberger <richard@nod.at>,
 nios2-dev@lists.rocketboards.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Ley Foon Tan <lftan@altera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 06:38:57PM +0200, Julia Lawall wrote:
> > I wrote something like this as below but it failed to compile, Julia any
> > suggestions on how to express this?
> >
> > @pte_alloc_func_proto depends on patch exists@
> > type T1, T2, T3, T4;
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> > @@
> >
> > (
> > - T3 fn(T1, T2);
> > + T3 fn(T1);
> > |
> > - T3 fn(T1, T2, T4);
> > + T3 fn(T1, T2);
> > )
> 
> What goes wrong?  It seems fine to me.

Weird it seems working now. I could swear 5 minutes ago it wasn't and I did
give a unique rule name. Don't know what I missed.

Anyway, thank you for all the quick responses and the help!

- Joel

