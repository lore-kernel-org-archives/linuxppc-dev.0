Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23C461A02A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 17:56:21 +1000 (EST)
Message-ID: <1403078179.32307.7.camel@concordia>
Subject: Re: [RFT PATCH -next v3] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
From: Michael Ellerman <michael@ellerman.id.au>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date: Wed, 18 Jun 2014 17:56:19 +1000
In-Reply-To: <539161D6.7020508@hitachi.com>
References: <5387F150.5000307@hitachi.com>
 <20140530031838.17427.75896.stgit@ltc230.yrl.intra.hitachi.co.jp>
 <539161D6.7020508@hitachi.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>,
 Chris Wright <chrisw@sous-sol.org>, yrl.pp-manager.tt@hitachi.com,
 akataria@vmware.com, Tony Luck <tony.luck@intel.com>,
 Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 rdunlap@infradead.org, Tony Luck <tony.luck@gmail.com>, dl9pf@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, "David
 S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-06-06 at 15:38 +0900, Masami Hiramatsu wrote:
> Ping?
> 
> I guess this should go to 3.16 branch, shouldn't it?

> > diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
> > index bfb6ded..8b89d65 100644
> > --- a/arch/powerpc/include/asm/types.h
> > +++ b/arch/powerpc/include/asm/types.h
> > @@ -25,6 +25,17 @@ typedef struct {
> >  	unsigned long env;
> >  } func_descr_t;
> >  
> > +#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF == 1)
> > +/*
> > + * On PPC64 ABIv1 the function pointer actually points to the
> > + * function's descriptor. The first entry in the descriptor is the
> > + * address of the function text.
> > + */
> > +#define function_entry(fn)	(((func_descr_t *)(fn))->entry)
> > +#else
> > +#define function_entry(fn)	((unsigned long)(fn))
> > +#endif

We already have ppc_function_entry(), can't you use that?

cheers
