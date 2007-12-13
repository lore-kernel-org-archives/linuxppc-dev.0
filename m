Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2] kdump shutdown hook support 
In-reply-to: <20071212070150.GC786@lixom.net> 
References: <20071212054512.A02B062C153@localhost.localdomain>
	<20071212070150.GC786@lixom.net>
Date: Thu, 13 Dec 2007 11:53:55 +1100
Message-ID: <5018.1197507235@neuling.org>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> > +		if (setjmp(crash_shutdown_buf) == 0) {
> > +			asm volatile("sync; isync");
> > +			crash_shutdown_handles[i]();
> > +			asm volatile("sync; isync");
> > +			__delay(200);
> 
> This looks a bit random. Why the handcoded barriers, and why the delay?
> I don't see a need for the barriers at all here?

I was following the bouncing ball here from the xmon code.  We don't
want the hardware executing any of potentially dangerous hooks before
we've setup the setjmp save buffer.  Similar, any code past the
dangerous hooks shouldn't be executed before we take a machine check.

It's definitely not a fast path so.... :-)

> At least comment why the delay is needed (and why just 200 is
> sufficient). 

xmon.c says: 
   /* wait a little while to see if we get a machine check */

I'll update the "200" with a #define SETJMP_MACHINE_CHECK_DELAY and push
the same change into the xmon code.  This delay in the machine check is
apparently required on 601 machines.

All you other comments I agree with.

Mikey
