Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4612EA16.7070102@am.sony.com>
Date: Tue, 03 Apr 2007 16:58:14 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<1175636904.10567.8.camel@shinybook.infradead.org>
	<4612D8FE.1070400@am.sony.com> <200704040055.36173.arnd@arndb.de>
In-Reply-To: <200704040055.36173.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	David Woodhouse <dwmw2@infradead.org>, cbe-oss-dev@ozlabs.org,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 04 April 2007, Geoff Levand wrote:
>> So there are really two answers, one is that having the boot memory in=
 the
>> DT hasn't changed, I just haven't finished that part yet. =EF=BF=BDThe=
 other is that
>> we get the amount of memory at runtime because it is a dynamic resourc=
e, and
>> cannot be known at DT compile time.
>=20
> But the device tree can easily be modified before entering the new kern=
el,
> when the kboot kernel allocates all the memory it can get, it just need=
s
> to list it in the device tree in some preallocated device node.

Yes, but boot mem is not allocated by the guest, it is allocated by the p=
olicy
module.  The guest can only query how much boot mem has been allocated fo=
r
it.  This can be done by the bootloader, or the kernel itself, if done ea=
rly
enough.  That info needs to be added to the DT before the kernel sets up =
its
boot mem structures.  My current plan is to do it in the bootloader, sinc=
e
there is not a platform hook in the current powerpc arch code that is ear=
ly
enough.

But you seem to say we can do something in the first stage kernel and pas=
s
some info to the second stage kernel?  The trouble with that is that when
the kernel is used as a first stage, where does the info come from?  I wa=
nt
to have a single kernel that can be either programmed into flash or loade=
d
by kexec.  For that to work the DT setup must be done in the wrapper, or
the kernel itself.

-Geoff
