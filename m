From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23657@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel build: not recognizing 'tlbre' instruction
Date: Fri, 7 Feb 2003 11:03:09 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(1) Regarding tool chain defining -m405:

    I'm using Denx ELDK ppc_4xx, so by definition isn't my
    predefined compiler flag -mcpu=403. Shouldn't the out of
    the box ELDK (for ppc_4xx) take care of this? Or does it
    need to change from 403 --> 405?

(2) Regarding kernel tree without:

	ifdef CONFIG_4xx
	CFLAGS := $(CFLAGS) -Wa,-m405
	endif

    in arch/ppc/Makefile.

    The kernel trees that I have all have this set. Is the suggestion
    to comment this out, or find a kernel without it? If it's the latter,
    is there a nifty way to do this other than trial and error?

-- Brian

-----Original Message-----
From: Matt Porter [mailto:porter@cox.net]
Sent: Friday, February 07, 2003 12:33 PM
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel build: not recognizing 'tlbre' instruction

On Fri, Feb 07, 2003 at 08:23:43AM -0800, brian.auld@adic.com wrote:
> When I try to build this 'custom kernel', I get the following error:
>
> ...
> Unrecognized opcode: 'tlbre' in the file arch/ppc/kernel/misc.S

Your toolchain probably does not define -m405 and you must have a
kernel tree that does not have an arch/ppc/Makefile with the
following:

	ifdef CONFIG_4xx
	CFLAGS := $(CFLAGS) -Wa,-m405
	endif

> General question: Is there a way to get previous versions of
> linuxppc_2_4_devel kernels?

Do a "bk help" with the "clone" and "tag" args for an explanation on
how to clone a tree at a specific changeset or tag.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
