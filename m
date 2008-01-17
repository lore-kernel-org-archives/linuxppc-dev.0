Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 214C3DDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 23:47:16 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0HClC3O008594
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 07:47:12 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0HClCKj106452
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 05:47:12 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0HClBuF008523
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 05:47:12 -0700
Date: Thu, 17 Jan 2008 06:45:27 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
Message-ID: <20080117064527.397cdfd6@zod.rchland.ibm.com>
In-Reply-To: <15983.1200548209@neuling.org>
References: <1200545142.37022.89292279731.qpush@coopers>
	<20080117044542.2F6CD70006@localhost.localdomain>
	<20080117053857.GA29035@lixom.net> <15983.1200548209@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008 16:36:49 +1100
Michael Neuling <mikey@neuling.org> wrote:

> 
> 
> In message <20080117053857.GA29035@lixom.net> you wrote:
> > Hi,
> > 
> > On Thu, Jan 17, 2008 at 03:45:42PM +1100, Michael Neuling wrote:
> > 
> > > Index: linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
> > > ===================================================================
> > > --- /dev/null
> > > +++ linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
> > > @@ -0,0 +1,18 @@
> > > +/*
> > > + * Copyright (C) 2007 Michael Neuling
>                      ^^^^^^
> 
> > > + *
> > > + *      This program is free software; you can redistribute it and/or
> > > + *      modify it under the terms of the GNU General Public License
> > > + *      as published by the Free Software Foundation; either version
> > > + *      2 of the License, or (at your option) any later version.
> > > + *
> > > + */
> > > +#ifndef _ASM_POWERPC_SETJMP_H
> > > +#define _ASM_POWERPC_SETJMP_H
> > > +
> > > +#define JMP_BUF_LEN    23
> > > +
> > > +extern long setjmp(long *);
> > > +extern void longjmp(long *, long);
> > > +
> > > +#endif /* _ASM_POWERPC_SETJMP_H */
> > 
> > Should the above be inside #ifdef __KERNEL__?
> 
> Yep... _and_ it's 2008 now!
> 
> I'll update.

While you're off updating it, remove the (C).  It's bogus and shouldn't
be there.

josh
