Return-Path: <bdc@carlstrom.com>
Received: from electricrain.com (electricrain.com [207.7.145.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39DCD67BAB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 04:53:48 +1000 (EST)
Date: Thu, 20 Jul 2006 11:47:04 -0700
Message-ID: <le8xmoktav.wl%bdc@carlstrom.com>
From: "Brian D. Carlstrom" <bdc@carlstrom.com>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: AltiVec in the kernel
In-Reply-To: <20060720174255.GP5905@austin.ibm.com>
References: <20060719181047.GL5905@austin.ibm.com>
	<001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
	<20060720174255.GP5905@austin.ibm.com>
Cc: 'Paul Mackerras' <paulus@samba.org>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
Reply-To: "Brian D. Carlstrom" <bdc@carlstrom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At Thu, 20 Jul 2006 12:42:55 -0500,
Linas Vepstas wrote:
> > We found glibc sucked for that.
> 
> Only because someone was asleep at the wheel, or there was a bug. 
> 
> When glibc gets ported to a new architecture, one of the earliest 
> tasks is to create optimized versions of memcpy and the like. 
> Presumably, on powerpc, this would have been done more than a 
> decade ago; its hard for me to imagine that there'd be a problem 
> there.  Now, I haven't looked at the code, but I just can't imagine 
> how this would not have been found and fixed by now. Is there
> really a problem wiht glibc performance on powerpc? I mean,
> this is a pretty serious accusation, and something that should 
> be fixed asap.

In the course of my work, I use powerpc architecture simulators. When
working on Mac OS X with a G5, I had to implement some of the basic
AltiVec specifically for use by their libc memcpy implementation. A
quick grep memcpy in the recent glibc sources on my linux/ppc box seems
to show no where near that level of optimization, but I admit that I
could have missed something. However, I would not be surprised that
glibc avoided AltiVec specific optimizations since it would add to the
complexity of supporting various architectures with one binary. On Mac
OS X, libc actually delegated a small number of libc calls such as
memcpy via a kernel managed page at the end of the address space that
setup which routines to use based on currently running architecture.

-bri
