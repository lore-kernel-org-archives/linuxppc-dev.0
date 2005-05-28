Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.198])
	by ozlabs.org (Postfix) with ESMTP id 4B896679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 10:50:07 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1773079wri
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 17:50:06 -0700 (PDT)
Message-ID: <528646bc0505271750470f2bf1@mail.gmail.com>
Date: Fri, 27 May 2005 18:50:06 -0600
From: Grant Likely <glikely@gmail.com>
To: Theo Gjaltema <gjalt007@chello.nl>
In-Reply-To: <42970B74.1060602@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <429639D5.20609@chello.nl>
	<E6CEFEB5-1F03-45DA-8BA3-C1F1511950EA@aimsys.nl>
	<42970B74.1060602@chello.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Dynamic libraries do not work
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/27/05, Theo Gjaltema <gjalt007@chello.nl> wrote:
>=20
>=20
> Toolchain used:   ELDK 2.0
> target processor: mpc862
> RAM:                64 Mbyte
> Kernel:               2.4.20, extended with ATM/UTOPIA
> init:                  /sbin/init -> /bin/busybox
>=20
>=20
> (using a static linked busybox: activating a sh (=3Dbusybox)
> ::sysinit:/bin/sh)
> sh: /lib/ld.so.1          (note: /lib/ld.so.1 is a link to
> /lib/ld.so.2.5.5, part of the ELDK 2.0 )
> < help page of ld.so.1>
> sh: /lib/ld.so.1 --verify /bin/xxx (or just any dynamic linked executable=
)
> <here the system has crahed>
>=20
> or
> sh: /bin/xxx
> <here the system has crashed>
>=20
> I have tried to step through the dynamic linking, but did not succeed
> til after the creation of a thread.
> With a dynamic linked busybox the system stops after a message such as
> "freeing xxx kbytes" (I don't know the actual number by head)
> When init is then called, which is a part of the busybox which is dyn.
> liked, it crashes.
>=20
It's really hard to give any advice with the limited data.
Do you get a kernel panic?  Has the kernel crashed or has it become
unresponsive.  Making a large number of assumptions, it sounds like
you've got a kernel problem, not a dynamic linking problem.  Dynamic
linking is handled 100% in user space.  If init crashes (or is killed)
you should get a kernel panic message.  The fact that you get nothing
says to me that dynamic linking is simply exposing a kernel bug.

A good place to start is to make sure all of memory is working.  Try a
simple test; allocate memory in an infinite loop and see where it
breaks.

Cheers,
g.
