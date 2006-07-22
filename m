Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5B8567BD1
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jul 2006 13:10:17 +1000 (EST)
In-Reply-To: <002b01c6acf0$a7417050$99dfdfdf@bakuhatsu.net>
References: <002b01c6acf0$a7417050$99dfdfdf@bakuhatsu.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bb0f53dbee5c7240daf6855454eca028@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: AltiVec in the kernel
Date: Fri, 21 Jul 2006 23:09:57 -0400
To: matt@genesi-usa.com
Cc: 'Olof Johansson' <olof@lixom.net>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Freevec was being developed as a "perfect opportunity". glibc-ports
> came to life and was something that code could be contributed to.
> Since it was such a hassle dealing with the glibc guys, it ended up
> being a seperate library for now.

Do you have a pointer to an archive of that email thread?  I can't
remember it.

You could give Freevec a whole lot more exposure, to people who
might be more interested in it than the average glibc user, by
putting it into uClibc first.  Additional advantage is that you
don't have to care about forward/backward compatibility issues,
or even whether the platform a binary ends up running on actually
has AltiVec or not (uClibc gets tailored to the exact system it
runs on at compile time).  So you can focus on the routines you
want to speed up instead of on all the infrastructure stuff
required for glibc.

You'll have to update uClibc's PowerPC port first though (mostly
just copying stuff from recent glibc) -- it seems the libc AltiVec
support (for handling setjmp() etc.) isn't in there yet.

>> This task could be as hard as writing the code in the first place.

Not as hard.  Way, way harder instead.  Part of that is that the
code probably really isn't good enough yet, sorry.  And then there's
all the compatibility stuff, and symbol versioning, etc.  And the
communication issue, of course.


Segher
