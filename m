Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id B4AB7DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 03:30:43 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch] PS3: Fix hardware watchpoints
Date: Wed, 14 Mar 2007 17:30:14 +0100
References: <45F74D69.5070600@am.sony.com>
	<17911.24243.64287.434769@cargo.ozlabs.ibm.com>
In-Reply-To: <17911.24243.64287.434769@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703141730.15344.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 14 March 2007, Paul Mackerras wrote:
> Geoff Levand writes:
> 
> > Add PS3 support for the PowerPC processor's Data Address Breakpoint
> > Register (DABR).
> > 
> > Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> > 
> > ---
> > Paul, please consider for 2.6.21.
> 
> It's nice and small, but it isn't really a bugfix as far as I can
> see...  What's the downside of it not going into 2.6.21, apart from
> some inconvenience in debugging things?

It makes it possible for a regular user to hang the partition,
because the kernel falls back to access the actual SPR, which is
forbidden by the hypervisor.

My original changelog text was:

The lv1 hypervisor silently kills the partition if the kernel attempts
to access the dabr register directly. Instead, it needs to be set using
an hcall. Since both pseries and celleb have the same function, the guess
is that the implementation on ps3 is also the same.

How about making the actual changelog text something like this:

----
The lv1 hypervisor silently kills the partition if the kernel attempts
to access the dabr register directly, which can happen when gdb adds
a hardware breakpoint.
Instead, the kernel needs to be set using an hcall, the same way as
it does for pseries and celleb.
----

The real question however should be if there is a point in merging
any ps3 patches into 2.6.21 at this point. Geoff, my understanding
is that the current ps3 platform code in 2.6.21-rc still relies on
additional patches from you in order to even boot, right?

Maybe it's better to just queue them for 2.6.22 now, independent
of the severity of bugs fixed by a given patch.

	Arnd <><
