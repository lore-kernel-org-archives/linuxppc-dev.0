Message-ID: <40F43AA9.6010009@loowit.net>
Date: Tue, 13 Jul 2004 12:40:25 -0700
From: James Perkins <james@loowit.net>
MIME-Version: 1.0
To: Arun Prasad Velu <arun@ossi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compiling for VxWorks/PowerPC Target from a Linux/x86 Machine
References: <NIBBKGBHPKFDFAOHCGBLAECMCAAA.arun@ossi.co.in>
In-Reply-To: <NIBBKGBHPKFDFAOHCGBLAECMCAAA.arun@ossi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Arun Prasad Velu wrote:

>I'd like to know how feasible is it to cross compile for a VxWorks/PowerPC
>Target from a Linux/x86 Machine?
>If there was any attempt earlier, I'd like to know about it (basically to
>get the source compiled for VxWorks/PowerPC from Linux/x86 machine).
>Any pointer on how to go about it would also be appreciated.
>
You can get the gcc toolchain that WR is using, it is GPL and Wind River
will provide it free to people they've distributed the binaries to --
which should be everyone who's also bought a valid VxWorks library
license. If you want to use your off-the-shelf gcc it may be somewhat
tricky to configure your gcc just like it is in Tornado, but on an
existing Tornado installation (even on Windows) you can probably get gcc
to cough up most of the details of how it was configured if you want to
build your own cross-toolchain.

VxWorks AE has supported Linux cross-development hosts for quite some time.

VxWorks 6.0 (soon in beta) supports Linux development hosts (official
support for Red Hat Enterprise Linux 3 although it probably will work
with some tweaking on other distributions). Details at
http://www.windriver.com/announces/02232004b.html. It also is integrated
with Wind River Workbench, which uses Eclipse as an IDE framework for
the cross-toolchain, debugger, code browsing -- although it's still easy
to use the cross-toolchain from a command line build (that's what many
VxWorks architecture engineers do - we edit target/config/bsp/config.h
and fire off make). You also have your choice of two toolchains, gcc or
Wind Power Compiler.

I haven't tried mixing objects from another gcc toolchain, say DENX,
with objects from WR, but I don't see why (in principle) they wouldn't
work, although I'd expect caveats with specific assembler opcodes, link
operations, and especially C++ interoperation (the gcc and wpc
toolchains do not intermix C++ objects).

Cheers,
James
(disclaimer: WR employs me but I am not an official spokesperson)

--
James Perkins         james@loowit.net         http://loowit.net/~james
-=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=- -=*=-
    I have no fear of death.... It's how you live that really counts.
		    -- Katharine Hepburn, 1907-2003


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
