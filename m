Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 78F98679F9
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 00:42:47 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Wire up *at syscalls
References: <jeu08ippb9.fsf@sykes.suse.de>
	<1145924011.16166.465.camel@shinybook.infradead.org>
	<17489.50396.320494.589703@cargo.ozlabs.ibm.com>
	<1146219867.10561.39.camel@shinybook.infradead.org>
Date: Fri, 28 Apr 2006 16:42:32 +0200
In-Reply-To: <1146219867.10561.39.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Fri, 28 Apr 2006 11:24:26 +0100")
Message-ID: <jehd4d7odj.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse <dwmw2@infradead.org> writes:

> On Fri, 2006-04-28 at 17:31 +1000, Paul Mackerras wrote:
>> Nice idea, but you didn't change the syscall entry path to multiply
>> the syscall number by 24 instead of 16. 
>
> Indeed. Neither did I wire up the spu callbacks. It wasn't meant to be
> applied as-is.
>
>>  It would be nice to have a way to do something like that but generate
>> two separate tables instead of a single table with 3 entries per
>> syscall. 
>
> Arnd apparently tried that once and it was icky.

void *spu_syscall_table[] = {
#define SYSCALL(func)		sys_ni_syscall
#define SYSCALL_SPU(func)       sys_##func
#define COMPAT_SYS(func)	sys_ni_syscall
#define COMPAT_SYS_SPU(func)	sys_##func
#define PPC_SYS(func)		sys_ni_syscall
#define PPC_SYS_SPU(func)	ppc_##func
#define OLDSYS(func)		sys_ni_syscall
#define SYS32ONLY(func)		sys_ni_syscall
#define SYSX(f, f3264, f32)	f
#include <asm/systbl.h>
}

where <asm/systbl.h> contains the bopy of arch/powerpc/kernel/systbl.S
after _GLOBAL(sys_call_table), and the latter is changed to include the
former.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
