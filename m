Return-Path: <sjmunroe@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3ECCC67C2F
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 09:18:09 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA1MI3j0023726
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 17:18:03 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA1MHaIl140702
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 17:17:39 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA1MHaxD004820
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 17:17:36 -0500
In-Reply-To: <1162172825.25682.139.camel@localhost.localdomain>
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF160F7BCC.ADD0D85F-ON86257219.00795AB5-86257219.007A72E6@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Wed, 1 Nov 2006 16:17:28 -0600
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Jeff Bailey <jbailey@ubuntu.com>,
	Fabio Massimo Di Nitto <fabbione@ubuntu.com>,
	Paul Mackerras <paulus@samba.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Benjamin Herrenschmidt <benh@kernel=2Ecrashing=2Eorg> wrote on 10/29/20=
06
07:47:05 PM:

> On Fri, 2006-10-27 at 12:22 -0400, Jeff Bailey wrote:
> > Le vendredi 27 octobre 2006 =E0 07:56 +0200, Fabio Massimo Di Nitto=
 a
> > =E9crit :
> > > Hi everybody,
> > >
> > > i am in the process of bootstrapping the new toolchain for ubuntu=
 and
I am
> > > hitting a problem building glibc-2=2E5 on ppc=2E
> > >
> > > This behaviour has been reproduced on 2=2E6=2E15/2=2E6=2E17 and 2=
=2E6=2E19-
> rc2 (where the
> > > machine crashes) and with ppc32 and ppc64 kernels=2E
> > > A hard reboot of the machine is required to get rid of the Zl
> processes hanging
> > > around that keep spinning the CPU at 100%=2E
> > >
> > > I did place sources here: http://people=2Eubuntu=2Ecom/~fabbione/=
benh/
> > >
> > > but i start to believe it is a kernel bug we are exploiting only =
now=2E
> > >
> > > Any hint or help for what to look for would be extremely apprecia=
ted=2E
> >
> > Heya Fabio, just an update, it looks like the tests that are zombie=
'ing
> > are the nptl tst-robust[1-8] tests=2E  According to /proc/##/wchan,=
 the
> > tasks are cheerfully spinning in do_exit=2E
>
> So I've built that glibc with debian 2=2E6=2E16 kernel headers (since=
 Fabio
> says the problem doesn't happen with glibc built with 2=2E6=2E19 head=
ers)
> and have ran that with 2=2E6=2E19-rc3-git-du-jour=2E
>
> The machine didn't crash, nor did I see any zombie with those
> tst-robust[1-8], however, I did get as SIGBUS with tst-robustpi1=2E I=
've
> tracked it down to being an alignment exception=2E It looks like glib=
c is
> doing a lwarx on a non-aligned value, though I can't say precisely
> what's up here=2E I don't know how I can get a backtrace when running=

> those test-cases=2E=2E=2E the test harness seems to catch signals, I =
suppose
> it could be modified to spit one out=2E
>
> At this point, it would be useful to have somebody who knows glibc to=

> tell us:
>
>  - what are those tst-robust all about ? (what do they do "special" t=
hat
> might trigger bad reactions with older kernels)
>  - how can glibc ever do atomic operations on a non-aligned value ?
>
> Ben=2E
>
The tst-robustpi# test are exercising the new PTHREAD_MUXTEX_ROBUST api=
,
with PTHREAD_PRIO_INHERIT attribute=2E

The fuxtex word seems to include the waiters TID, I don't know if the
kernel cares about this or not=2E


Steven J=2E Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center=
