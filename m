Message-ID: <3AD16EB0.738E278E@iiic.ethz.ch>
Date: Mon, 09 Apr 2001 10:11:28 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Guillaume Laures <guillaume.laures@noos.fr>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: XFree86-4.0.99.2
References: <15056.36750.453557.759357@ipa.ne.mediaone.net>
		<3AD0AABE.1020605@vacuumgenesis.com>
		<15056.55761.845494.317224@ipa.ne.mediaone.net> <986767730.17213.0.camel@pmg4.gom.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Guillaume Laures wrote:

> #0  0xfe0bea8 in kill () at soinit.c:64
> #1  0xfe0bd24 in raise () at ../sysdeps/posix/raise.c:27
> #2  0xfe0d3d4 in abort () at ../sysdeps/generic/abort.c:139
> #3  0x10025bbc in ddxGiveUp ()
> #4  0x10025cb0 in AbortDDX ()
> #5  0x100a9ae0 in GiveUp ()
> #6  0x100ab5d8 in FatalError ()
> #7  0x1003c6ec in xf86SigHandler ()
> #8  <signal handler called>
> #9  0x1030aa04 in ?? ()
> #10 0x0 in ?? ()

[...]

> I tried looking for soinit.c in the i128 files but this didn't give any
> result, and I cannot find it trhough the whole source; any idea on where
> to head on ???

I suppose #0-#2 are from glibc and not interesting.

The interesting parts are #9 and #10, which are probably in loadable modules
so gdb can't handle them correctly. You could build a static server (#define
DoLoadableServer NO in xc/config/cf/host.def) and try with that.


PS: Has anyone tried porting the module aware gdb?

--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
