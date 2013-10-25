Return-Path: <RA8135@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50F542C0119
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 15:49:17 +1100 (EST)
From: Yang James-RA8135 <RA8135@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] [RFC] Emulate "lwsync" to run standard user land on
 e500 cores
Date: Fri, 25 Oct 2013 04:49:06 +0000
Message-ID: <CE506A05CAAF2A42B6F5840E6093C92D08895AC8@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
 <1382607919.9395.56.camel@pasglop>
 <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
 <alpine.LRH.2.00.1310241556390.31001@ra8135-ec1.am.freescale.net>,
 <26976A96-8DF8-44EB-8B9B-E23200738F4E@kernel.crashing.org>
In-Reply-To: <26976A96-8DF8-44EB-8B9B-E23200738F4E@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry for the formatting.  I'm not at my usual mailer.=0A=
=0A=
From: Kumar Gala:=0A=
>On Oct 24, 2013, at 4:05 PM, James Yang wrote:=0A=
>> On Thu, 24 Oct 2013, Kumar Gala wrote:=0A=
>>> Than, I'd ask this be under a Kconfig option that is disabled by=0A=
>>> default.  Users should have to explicitly enable this so they know=0A=
>>> what they are doing.=0A=
>>=0A=
>>=0A=
>> I think it should be enabled by default, rather than disabled, so that=
=0A=
>> users would actually see a warning rather than get a sig 4.  Or, let=0A=
>> it not be Kconfig-able so that this doesn't become a problem any more.=
=0A=
>> (It's been 4 years since I sent to you an earlier version of this=0A=
>> patch.)=0A=
>=0A=
>And clearly most users don't seem terrible annoyed enough about =0A=
>this issue to have concerns.  I don't see why making it a Kconfig =0A=
>option impacts the small handful of people that happen to try =0A=
> and run a more generic distro on e500 cores.=0A=
=0A=
=0A=
I would have to dispute that qualification of "most".  =0A=
=0A=
This is not a distro issue. It's a libstdc++ portability issue. libstdc++ =
=0A=
hardcodes lwsync unless __NO_LWSYNC__ is explicitly defined, =0A=
which you only get with -mcpu=3D8540/-mcpu=3D8548.  When compiled =0A=
for any powerpc target other than -mcpu=3D8540/-mcpu=3D8548, including=0A=
the default -mcpu=3Dcommon,  libstdc++ will end up containing lwsync.  =0A=
There is no way to explicitly request libstdc++ to be built without lwsync=
=0A=
with an -mcpu target other than 8540/8548.=0A=
=0A=
The issue is easily demonstrated by running a program that throws a =0A=
C++ exception: __cxa_throw() is called, which has an lwsync.  This=0A=
results in an illegal instruction exception when run on an e500v1/e500v2.=
=0A=
=0A=
Those users who insist on using a generic target for their compiler=0A=
will hit this problem, in particular, those who need to generate =0A=
binary code that targets a wide range of powerpc targets, such as=0A=
generic distro.  It's unreasonable to require a user to recompile =0A=
libstdc++ just to get functionality for a C++ program, since they would=0A=
have to provide two libstdc++.so along with some dynamic-linking hacks to=
=0A=
determine at runtime which one should be used.  Emulating lwsync =0A=
does not prevent an e500v1/e500v2-targeted libstdc++ from providing=0A=
the optimal performance.=0A=
=0A=
=0A=
citation:=0A=
=0A=
> > lwsync is embedded into the library unless __NO_LWSYNC__ is defined:=0A=
> > http://gcc.gnu.org/viewcvs/gcc/trunk/libstdc%2B%2B-v3/config/cpu/powerp=
c/atomic_word.h?revision=3D195701&view=3Dmarkup#l30=0A=
> > -----------------------------------------------=0A=
> > #define _GLIBCXX_READ_MEM_BARRIER __asm __volatile=0A=
> > ("isync":::"memory")=0A=
> > #ifdef __NO_LWSYNC__=0A=
> > #define _GLIBCXX_WRITE_MEM_BARRIER __asm __volatile=0A=
> > ("sync":::"memory")=0A=
> > #else=0A=
> > #define _GLIBCXX_WRITE_MEM_BARRIER __asm __volatile=0A=
> > ("lwsync":::"memory")=0A=
> > #endif=0A=
> > -----------------------------------------------=0A=
> > =0A=
> > =0A=
=0A=
