Return-Path: <RA8135@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6EBBA2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 02:13:32 +1100 (EST)
Date: Fri, 25 Oct 2013 10:13:09 -0500
From: James Yang <James.Yang@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500
 cores
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B73B1@saturn3.aculab.com>
Message-ID: <alpine.LRH.2.00.1310250946000.31001@ra8135-ec1.am.freescale.net>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
 <1382607919.9395.56.camel@pasglop>
 <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
 <alpine.LRH.2.00.1310241556390.31001@ra8135-ec1.am.freescale.net>,
 <26976A96-8DF8-44EB-8B9B-E23200738F4E@kernel.crashing.org>
 <CE506A05CAAF2A42B6F5840E6093C92D08895AC8@039-SN1MPN1-005.039d.mgd.msft.net>
 <AE90C24D6B3A694183C094C60CF0A2F6026B73B1@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 25 Oct 2013, David Laight wrote:

> > This is not a distro issue. It's a libstdc++ portability issue. libstdc++
> > hardcodes lwsync unless __NO_LWSYNC__ is explicitly defined,
> > which you only get with -mcpu=8540/-mcpu=8548.  When compiled
> > for any powerpc target other than -mcpu=8540/-mcpu=8548, including
> > the default -mcpu=common,  libstdc++ will end up containing lwsync.
> > There is no way to explicitly request libstdc++ to be built without lwsync
> > with an -mcpu target other than 8540/8548.
> > 
> > The issue is easily demonstrated by running a program that throws a
> > C++ exception: __cxa_throw() is called, which has an lwsync.  This
> > results in an illegal instruction exception when run on an e500v1/e500v2.
> 
> Perhaps libstc++ should be working out at run time whether lwsync is 
> valid?

lwsync has been in libstdc++ for over 8 years so there's a substantial 
amount of legacy binary code that exists such that changing libstdc++ 
now won't solve the problem.

This isn't a performance issue, it's a functional issue -- libstdc++ 
for -mcpu=common targets doesn't work on e500v1/e500v2. (QorIQ P4080 
that have e500mc and newer cores support lwsync so this is no longer 
an issue.)

If one /really/ cared about losing performance while running common 
target binaries, emulating lwsync is an inconsequential performance 
loss compared to the kernel doing floating point emulation.

Recompiling libstdc++ (and all your other userland) with -mcpu=8548 is 
what you'd have to do to avoid classic FP and use Embedded FP or SPE, 
and if you are doing that you'll get sync instead of lwsync in 
libstdc++.
