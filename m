Message-ID: <3BEAD844.380F227A@mvista.com>
Date: Thu, 08 Nov 2001 12:08:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: The Plan
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
		<3BE9D4B8.6A2E8603@mvista.com> <15337.62287.965562.545296@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Mark A. Greer writes:
>
> > I would move harrier.c and pplus_common.c to the "kernel" dir since they
> > are both bridge related files (kinda like the mpc10x_common.c file).
>
> I wondered about pplus_common.c, actually.  Are pplus_common.c and
> harrier.c likely to be used by more than one or two platforms in the
> future?

Depends what  you mean by "platform".

Basically, most of the older MCG boards will use pplus_common.c (supports
falcon/raven and hawk); most of the newer ones will use the harrier.  It
depends on whether the MCG boards are supported by one or two "board ports"
or if each board has its own "board port".  Lately, we've been separating
them out because there have been more significant differences between the
various boards and having things like residual data are not assured anymore
(or residual data that's close to correct).

Any comments Matt?

> If we leave them in kernel then we need to move the
> corresponding header files to include/asm-ppc.

> BTW, I would love to find a way to move all the platform-specific
> files (mvme5100.h, for instance) from include/asm-ppc to
> arch/ppc/platforms too.  The obstacle at the moment is the serial
> stuff.

Sounds like the right place to me too.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
