Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0126.hostedemail.com
 [216.40.44.126])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cbJm6jjfzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 03:18:16 +1000 (AEST)
Message-ID: <26f07092cdde378ebb42c1034badde1b56521c36.camel@perches.com>
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
From: Joe Perches <joe@perches.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>, Murilo Opsfelder Araujo
 <muriloo@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Simon Guo
 <wei.guo.simon@gmail.com>, Paul Mackerras <paulus@samba.org>,  Nicholas
 Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>, Michael
 Ellerman <mpe@ellerman.id.au>,  "Eric W . Biederman"
 <ebiederm@xmission.com>, Cyril Bur <cyrilbur@gmail.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Balbir Singh
 <bsingharora@gmail.com>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>,  linux-kernel@vger.kernel.org
Date: Fri, 27 Jul 2018 10:18:08 -0700
In-Reply-To: <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
 <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-07-27 at 18:40 +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
> 
> > Simplify the message format by using REG_FMT as the register format.  This
> > avoids having two different formats and avoids checking for MSR_64BIT.
> 
> Are you sure it is what we want ?
> 
> Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?

[]

> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
[]
> > @@ -311,17 +311,13 @@ static bool show_unhandled_signals_ratelimited(void)
> >  static void show_signal_msg(int signr, struct pt_regs *regs, int code,
> >  			    unsigned long addr)
> >  {
> > -	const char fmt32[] = KERN_INFO "%s[%d]: unhandled signal %d " \
> > -		"at %08lx nip %08lx lr %08lx code %x\n";
> > -	const char fmt64[] = KERN_INFO "%s[%d]: unhandled signal %d " \
> > -		"at %016lx nip %016lx lr %016lx code %x\n";
> > -
> >  	if (!unhandled_signal(current, signr))
> >  		return;
> > 
> > -	printk(regs->msr & MSR_64BIT ? fmt64 : fmt32,
> > -	       current->comm, current->pid, signr,
> > -	       addr, regs->nip, regs->link, code);
> > +	pr_info("%s[%d]: unhandled signal %d at "REG_FMT \

I think it better to use a space after the close "
and also the line continuation is unnecessary.

> > +		" nip "REG_FMT" lr "REG_FMT" code %x\n",

And spaces before the open quotes too.

I'd also prefer the format on a single line:

	pr_info("%s[%d]: unhandled signal %d at " REG_FMT " nip " REG_FMT " lr " REG_FMT " code %x\n",

> > +		current->comm, current->pid, signr, addr,
> > +		regs->nip, regs->link, code);

Seeing as these are all unsigned long, a better way to do
this is to use %p and cast to pointer.

This might be better anyway as this output exposes pointer
addresses and instead would now use pointer hashed output.

	pr_info("%s[%d]: unhandled signal %d at %p nip %p lr %p code %x\n",
		current->comm, current->pid, signr,
		(void *)addr, (void *)regs->nip, (void *)regs->link, code);

Use %px if you _really_ need to emit unhashed addresses.

see: Documentation/core-api/printk-formats.rst
