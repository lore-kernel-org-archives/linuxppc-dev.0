Return-Path: <ananth@in.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8E726140179
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 16:16:16 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 8 May 2014 00:16:14 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D1C776E801C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 02:16:02 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s486GAGc9306454
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 May 2014 06:16:10 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s486G7hD002636
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 May 2014 02:16:09 -0400
Date: Thu, 8 May 2014 11:46:58 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [RFT PATCH -next ] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
Message-ID: <20140508061658.GA2384@in.ibm.com>
References: <536A16A6.5040709@hitachi.com>
 <20140507115551.22259.70581.stgit@ltc230.yrl.intra.hitachi.co.jp>
 <20140508044753.GA13413@in.ibm.com> <536B18B0.9060209@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <536B18B0.9060209@hitachi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
 yrl.pp-manager.tt@hitachi.com, akataria@vmware.com,
 Tony Luck <tony.luck@intel.com>, Kevin Hao <haokexin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, rdunlap@infradead.org,
 Tony Luck <tony.luck@gmail.com>, dl9pf@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 08, 2014 at 02:40:00PM +0900, Masami Hiramatsu wrote:
> (2014/05/08 13:47), Ananth N Mavinakayanahalli wrote:
> > On Wed, May 07, 2014 at 08:55:51PM +0900, Masami Hiramatsu wrote:
> > 
> > ...
> > 
> >> +#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF == 1)
> >> +/*
> >> + * On PPC64 ABIv1 the function pointer actually points to the
> >> + * function's descriptor. The first entry in the descriptor is the
> >> + * address of the function text.
> >> + */
> >> +#define constant_function_entry(fn)	(((func_descr_t *)(fn))->entry)
> >> +#else
> >> +#define constant_function_entry(fn)	((unsigned long)(fn))
> >> +#endif
> >> +
> >>  #endif /* __ASSEMBLY__ */
> > 
> > Hi Masami,
> > 
> > You could just use ppc_function_entry() instead.
> 
> No, I think ppc_function_entry() has two problems (on the latest -next kernel)
> 
> At first, that is an inlined functions which is not applied in build time.
> Since the NOKPROBE_SYMBOL() is used outside of any functions as like as
> EXPORT_SYMBOL(), we can only use preprocessed macros.
> Next, on PPC64 ABI*v2*, ppc_function_entry() returns local function entry,
> which seems global function entry + 2 insns. I'm not sure about implementation
> of the kallsyms on PPC64 ABIv2, but I guess we need global function entry
> for kallsyms.

ABIv2 does away with function descriptors and Anton fixed up that
routine to handle the change (the +2 is an artefact of that).

> BTW, could you test this patch on the latest -next tree on PPC64 if possible?

I'll test it, but it may take a bit.

Ananth
