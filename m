Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 96BC4DDF3A
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 20:58:17 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l2A9wCGF127782
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 09:58:12 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2A9wC4f2129946
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 10:58:12 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2A9wBNa008989
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 10:58:12 +0100
Subject: Re: [PATCH] Complain about missing system calls.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Andi Kleen <andi@firstfloor.org>
In-Reply-To: <20070309190051.GA20521@one.firstfloor.org>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<p737itqbdnl.fsf@bingen.suse.de> <20070309163805.GV18564@lug-owl.de>
	<20070309190051.GA20521@one.firstfloor.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 10 Mar 2007 10:58:13 +0100
Message-Id: <1173520693.7128.17.camel@localhost>
Mime-Version: 1.0
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, sam@ravnborg.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>, rmk@arm.linux.org.uk
Reply-To: schwidefsky@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-09 at 20:00 +0100, Andi Kleen wrote:
> > Not everybody has a simple indexed list of pointers :)  For example,
> > for vax-linux, we use a struct per syscall with the expected number of
> > on-stack longwords for the call.
> > 
> > So if something "new" is coming up, please keep in mind that it should
> > be flexible enough to represent that. :)
> 
> Are there plans to merge vax any time soon to mainline? 
> 
> Normally we don't care very much about out of tree code, especially
> if it adds complexity like this.
> 
> But I suspect s390 would need number of arguments anyways.

I can't quite follow that line of thought. Why does s390 need the number
of arguments? The wrapper of a compat system call implicitly knows how
many arguments a system calls to do the conversion. For a normal system
call we just call the function. Random example sys_read: the user space
loads the arguments to register %r2, %r3, %r4 and calls the system. The
register are not touched until sys_read is reached. Only sys_read cares
about the number of arguments in this case.

-- 
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Geschäftsführung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: Böblingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
