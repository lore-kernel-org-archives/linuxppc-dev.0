Return-Path: <pacman@kosh.dhis.org>
Received: from kosh.dhis.org (c-67-162-90-113.hsd1.in.comcast.net
	[67.162.90.113]) by ozlabs.org (Postfix) with SMTP id 37AFAB6FC4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 09:09:15 +1000 (EST)
Message-ID: <20110404230233.28641.qmail@kosh.dhis.org>
From: pacman@kosh.dhis.org
Subject: Re: Pegasos i8042 broken again
To: paubert@iram.es (Gabriel Paubert)
Date: Mon, 4 Apr 2011 18:02:33 -0500 (GMT+5)
In-Reply-To: <20110404222637.GA4633@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gabriel Paubert writes:
> 
> Ok, I got fed up about it. The patch referred above is obviously wrong since
> it leaves interrupts at 0 when a device_type or name of 8042 is found,
> so what about the following? 

Looks like the workaround I was using for a while.

In the original report I said I wasn't sending my kernel workaround patch
because of the previous disagreements about whether the kernel should work
around this type of bug. (In fact the current difficulty is the result of
changes being made without considering the special case that was created by
my first workaround... what a mess.) I also said I wasn't comfortable hacking
the Forth-based part of the boot sequence because I didn't know the language.

As it turned out, learning Forth was much easier than getting any guidance
from the kernel people on how to proceed with a workaround, so I wrote this:

=== CUT HERE ===
" /isa/8042" find-device
: open true ;
: close ;
: decode-unit ( addr len -- phys )
  1 <> if
    abort" invalid unit address"
  then
  c@
  dup ascii 0 = if
    drop
    0 exit
  then
  ascii 1 = if
    1 exit
  then
  abort" invalid unit address"
;
: encode-unit ( phys -- addr len )
  dup 0 = if
    " 0" exit
  then
  1 = if
    " 1" exit
  then
  abort" invalid unit address"
;

1 encode-int
3 encode-int encode+
d# 12 encode-int encode+
3 encode-int encode+
" interrupts" property

0 0 " 0" " /isa/8042" begin-package
 " keyboard" device-name
 " keyboard" device-type
 " pnpPNP,303" encode-string " compatible" property
 0 encode-int " reg" property
end-package

0 0 " 1" " /isa/8042" begin-package
 " mouse" device-name
 " mouse" device-type
 " pnpPNP,f03" encode-string " compatible" property
 1 encode-int " reg" property
end-package
=== CUT HERE ===

Along with the previous device tree patch (pegasos-dts-20071018), this should
present the kernel with a properly filled-out 8042 device-tree node,
preventing the need for any more patching the next time the kernel changes
its mind about how to initialize the keyboard driver.

-- 
Alan Curry
