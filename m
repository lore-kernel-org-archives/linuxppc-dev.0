Message-ID: <3B97F26C.C88B10B2@mvista.com>
Date: Thu, 06 Sep 2001 17:02:20 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@mvista.com>,
	John Tyner <jtyner@cs.ucr.edu>, linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: patch for mktree.c on cross compiles
References: <20010905120613.I14548@ecam.san.rr.com> <3B968E75.A63F26EA@mvista.com> <20010905212050.K18940@cpe-24-221-152-185.az.sprintbbd.net> <20010905223903.D621@sink.san.rr.com> <20010906075542.A21172@cpe-24-221-152-185.az.sprintbbd.net> <20010906130106.L14548@ecam.san.rr.com> <20010906140852.R21172@cpe-24-221-152-185.az.sprintbbd.net> <20010906135432.M14548@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
>
> > Yes, it's an imperfect solution at best.  What would be correct is for us
> > to copy all of the needed magic into our own header and toss it in
> > arch/ppc/boot/include.  With some proper magic for the !Linux case too.
>
> I am not sure why we would need to do this. mktree.c already includes
> libc headers and the htonl defination is pulled in with them.
>
> This does increase our build requirments to have a working libc env
> on the host.
>
> To be completely correct not only will you need to have the byte order
> magic in arch/ppc/boot/include, but also all the file access magic as
> well, since mktree reads in a file, adds a header and then writes out
> another file.

I have a concern that using any glibc (specific) stuff will break cross
compiling from say a solaris system to linux.  I thing Andrew is right,
the correct solution is probably to copy the bits into the boot/include
dir.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
