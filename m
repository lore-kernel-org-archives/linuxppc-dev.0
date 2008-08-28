Return-Path: <paul@mad-scientist.us>
Received: from smtp02.lnh.mail.rcn.net (smtp02.lnh.mail.rcn.net
	[207.172.157.102]) by ozlabs.org (Postfix) with ESMTP id 060BBDE298
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 00:30:59 +1000 (EST)
Subject: Re: 2.6.25: include/asm-ppc vs. include/asm-powerpc
From: Paul Smith <paul@mad-scientist.us>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200808281553.18167.arnd@arndb.de>
References: <1219928864.16802.69.camel@homebase.localnet>
	<200808281553.18167.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 28 Aug 2008 10:30:48 -0400
Message-Id: <1219933848.16802.96.camel@homebase.localnet>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: paul@mad-scientist.us
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-28 at 15:53 +0200, Arnd Bergmann wrote:
> The easiest solution should be to just include all your modules in
> the kernel source as patches, rather than building them externally.
> 
> That will give you access to all the headers you need.

It doesn't matter whether I build my code in the kernel as patches, or
not.  The problem is not that I don't have the headers handy, it's that
they simply don't exist in asm-ppc anymore, not even in the linux source
tree.

There is no asm-ppc/ppc_asm.h in the kernel anymore.  In my code that
includes it, where ARCH=ppc and include/asm is linked to asm-ppc, how do
I get ahold of that file?  I can't use #include <asm/ppc_asm.h> like I
used to.  Do I have to use #include <asm-powerpc/ppc_asm.h> explicitly?
At least this will work... but read on:

Even more troublesome are headers like <linux/posix_types.h>, which
includes <asm/posix_types.h>, but there IS NO asm-ppc/posix_types.h file
in the kernel tree!  There is only an asm-powerpc/posix_types.h... but
if asm is a link to asm-ppc, this fails and I have no way to fix it!

On the other hand, if I cheat and set the asm symlink pointing to
asm-powerpc instead, then when I include files like <linux/interrupt.h>.
which includes <linux/hardirq.h>, which includes <asm/hardirq.h>, which
(because I have CONFIG_40X defined) includes <asm/ibm44x.h>, I get the
opposite problem: there is no asm-powerpc/ibm4xx.h; that header exists
only in the asm-ppc directory.  So now THAT include fails.



I seem to be out of luck here.
