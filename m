Date: Sat, 1 Dec 2001 15:41:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: frowand@mvista.com, paulus@samba.org,
	Ralph Blach <rcblach@us.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
Message-ID: <20011201154153.F7819@cpe-24-221-152-185.az.sprintbbd.net>
References: <OF04BCE99E.8AF57CF2-ON85256B14.00425D94@raleigh.ibm.com <15368.891.368917.13579@argo.ozlabs.ibm.com> <3C0814AC.455D6FEA@mvista.com> <3C084F22.3030505@embeddededge.com> <3C091F3C.7176C145@mvista.com> <3C095837.6090302@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C095837.6090302@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Dec 01, 2001 at 05:22:47PM -0500, Dan Malek wrote:
>
> Frank Rowand wrote:
>
>
>
> >If I understand correctly, you are talking only about the configuration
> >structure, not the header file structure -- so a different topic than
> >what this thread has been.
>
> I'm talking about both.  Yes, I know the configuration has been mostly
> changed, but today the ibm4xx.h file includes ibm405gp.h which then
> includes walnut.h.  This is totally backward.

It used to be like that.  It's now ibm4xx.h -> board.h -> proc.h

> The ibm4xx.h file (and the mpc8xx.h file) should be replaced by an
> appropriate platform.h file which would remove all of the ifdefs we
> currently have in the include lists of the C files and some of the
> problems with multiple definitions these ifdefs are in place to solve.

Maybe we can do this in 2.5.  We've already got the bits around for
making symlinks from CONFIG_FOO -> foo.h, and an empty foo.h if it
doesn't exist.  So we could do CONFIG_8xx -> symlink
include/asm-ppc/platform to mpc-8xx, and so on..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
