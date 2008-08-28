Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 057D9DE2A5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 00:42:38 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org,
 paul@mad-scientist.us
Subject: Re: 2.6.25: include/asm-ppc vs. include/asm-powerpc
Date: Thu, 28 Aug 2008 16:42:26 +0200
References: <1219928864.16802.69.camel@homebase.localnet>
	<200808281553.18167.arnd@arndb.de>
	<1219933848.16802.96.camel@homebase.localnet>
In-Reply-To: <1219933848.16802.96.camel@homebase.localnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281642.26647.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 28 August 2008, Paul Smith wrote:
> On Thu, 2008-08-28 at 15:53 +0200, Arnd Bergmann wrote:
> > The easiest solution should be to just include all your modules in
> > the kernel source as patches, rather than building them externally.
> > 
> > That will give you access to all the headers you need.
> 
> It doesn't matter whether I build my code in the kernel as patches, or
> not.  The problem is not that I don't have the headers handy, it's that
> they simply don't exist in asm-ppc anymore, not even in the linux source
> tree.

The trick that arch/ppc uses is to create a symlink arch/ppc/include/asm
pointing to include/asm-powerpc and then passing "-Iinclude
 -Iarch/ppc/include" to the compiler. This will make gcc look for
headers in asm-ppc first, and then in asm-powerpc.

It should also work with external modules if you build them in the
recommended way (see http://lwn.net/Articles/80250/), but as I said,
the easiest way is to just build all modules as part of the regular
kernel build. It should be evident that building kernel code actually
works and gets the right header files for all existing modules, so
it should work just like that for any drivers you add to the kernel.

	Arnd <><
