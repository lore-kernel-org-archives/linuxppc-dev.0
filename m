Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 9A23067A67
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 01:57:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 3 Mar 2005 08:57:23 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592D7@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Marc Leeman" <marc.leeman@gmail.com>,
	"Joerg Dorchain" <joerg@dorchain.net>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: GCC4 fun.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have seen it since 2.6.11-rc2

It is not a fatal error, just more of a warning.
It complains because schedule() was called while scheduling is disabled
during initial setup

As far as I have been able to track it down, schedule gets called after
syscalls, and in this case (and in mine on a 8260)
It gets called when the proc filesystem is enabled.

These errors surfaced on PPC after Ingo Molnars patches to get rid of
the BKL (Big Kernel Lock)

> -----Original Message-----
> From: linuxppc-dev-bounces@ozlabs.org=20
> [mailto:linuxppc-dev-bounces@ozlabs.org] On Behalf Of Marc Leeman
> Sent: Thursday, March 03, 2005 07:14
> To: Joerg Dorchain
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: GCC4 fun.
>=20
> > scheduling while atomic: swapper/0x00000002/0
> > Call trace:
> >  [c0007620] dump_stack+0x18/0x28
> >  [c01de704] schedule+0x678/0x67c
> >  [c0004500] syscall_exit_work+0x108/0x10c
> >  [c02a97b4] proc_root_init+0x168/0x174
> >  [ff847288] 0xff847288
> >  [c02945e8] start_kernel+0x144/0x170
> >  [00003a30] 0x3a30
>=20
> We have something similar with PPC 8245, I was planning to have a look
> at it, but didn't get round to it. Since our system is=20
> crunching numbers
> since yesterday evening without fault, I guess it's not that=20
> serious...
>=20
> --=20
>   greetz, marc
> Aeryn died so you could live John. She would want you to keep=20
> fighting.
> 	D'Argo - Season of Death
> scorpius 2.6.11 #1 Wed Mar 2 16:38:38 CET 2005 GNU/Linux
>=20
