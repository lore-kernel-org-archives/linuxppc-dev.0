Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D47FDDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 20:51:39 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l2A9pZW4169254
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 09:51:35 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2A9pZEJ1876144
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 09:51:35 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2A9pYRe009905
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 09:51:35 GMT
Subject: Re: [PATCH] Complain about missing system calls.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Andi Kleen <ak@suse.de>
In-Reply-To: <200703091954.13982.ak@suse.de>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<p737itqbdnl.fsf@bingen.suse.de>
	<1173458854.24454.27.camel@localhost.localdomain>
	<200703091954.13982.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 10 Mar 2007 10:51:36 +0100
Message-Id: <1173520296.7128.9.camel@localhost>
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

On Fri, 2007-03-09 at 19:54 +0100, Andi Kleen wrote:
> > We need additional gunk for syscalls that can be called from SPEs on
> > cell
> 
> Can that gunk not be auto generated?
> 
> I know s390 does in some cases, but it looks quite auto generatable to me.

The system call tables and the compat wrapper are all manually created.
If we manage to get the prototypes for the system calls in a parseable
format at least the compat wrappers could be auto-generated. I see two
pitfalls: 1) some compat system calls are directly wired to the system
call table while others need the compat_wrapper detour, 2) override of
system calls with "meta" system calls like sys_socket or sys_ipc.

-- 
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Geschäftsführung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: Böblingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
