Return-Path: <paul@mad-scientist.us>
Received: from smtp02.lnh.mail.rcn.net (smtp02.lnh.mail.rcn.net
	[207.172.157.102]) by ozlabs.org (Postfix) with ESMTP id ECDC2DDEDF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 23:08:03 +1000 (EST)
Received: from psmith by homebase.localnet with local (Exim 4.69)
	(envelope-from <paul@mad-scientist.us>) id 1KYhE1-0005Gb-12
	for linuxppc-embedded@ozlabs.org; Thu, 28 Aug 2008 09:07:45 -0400
Subject: 2.6.25: include/asm-ppc vs. include/asm-powerpc
From: Paul Smith <paul@mad-scientist.us>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 28 Aug 2008 09:07:44 -0400
Message-Id: <1219928864.16802.69.camel@homebase.localnet>
Mime-Version: 1.0
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

I know that arch/ppc is obsolete in 2.6.26 and deprecated for earlier
releases.  However, I have a port to a custom PPC-based board that was
originally done for 2.6.14 in arch/ppc, and I've ported it to our
current "standard" kernel of 26.25 and it works (anyway it boots etc.)
I absolutely do not have time now, and not for a few months, to convert
over to live in arch/powerpc (BTW, if anyone has any pointers to docs on
ways to make that transition I'm very interested).

My problem is this: I'm having trouble building some of our externel
kernel modules because they can't find various kernel header files.
Looking at the kernel's include directory I see that include/asm is
symlinked to include/asm-ppc which is what I would expect for ARCH=ppc,
and the same way it used to work in 2.6.14.

However, looking in the include/asm-ppc directory I see that many of the
files that used to be there are not there anymore... although they do
appear in include/asm-powerpc.  In particular I'm interested in
ppc_asm.h which used to exist in both asm-ppc64 AND in asm-ppc, but now
only exists in asm-powerpc.  What's the approved way to include this
header if asm points to asm-ppc?

In general it seems like lots of headers that used to be in both asm
directories now appear in only asm-powerpc; I don't really see how this
is supposed to work.  Any tips on this would be most welcome.


Thanks!
