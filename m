Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id E835EDDFC9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 16:54:09 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so7545ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 23:54:08 -0700 (PDT)
Message-ID: <528646bc0704302354w88454ddqfe01f35afa9fb204@mail.gmail.com>
Date: Tue, 1 May 2007 00:54:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [PATCH 2/5] [PPC] Merge common virtex header files
In-Reply-To: <4636C1D7.9090309@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<87d51sac8l.fsf@sleipner.barco.com>
	<528646bc0704271149w211bd5cbscb467123ab962703@mail.gmail.com>
	<87slai5vz3.fsf@sleipner.barco.com> <4636C1D7.9090309@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/30/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> Peter Korsgaard wrote:
> > GL> Alternate suggestion: Can we change virtex support to use the
> > GL> structure defined in ppcboot.h instead?  (I've actually got that
> > GL> change in my tree and was planning on posting it for review today
> > GL> or tomorrow).  bd_t is a stinking ugly mess, but things would be
> > GL> better if we standardize all virtex platforms on the stinking ugly
> > GL> mess shared by almost all the other ppc embedded board ports.
> >
> > That's where the ugly mess pops up - RedBoot uses another
> > (incompatible) bd_t definition than U-boot, E.G:
> >
> > typedef struct bd_info {
> >       unsigned int   bi_tag;        /* Should be 0x42444944 "BDID" */
> >
> snip
> >
> >       int            bi_flashwidth; /* Width (8,16,32,64) */
> >       unsigned char *bi_cmdline;    /* Pointer to command line */
> > } bd_t;
> >
> > I should probably migrate to U-boot anyway, but still ..
> >
>
>     Can we please not standardize on some specific implimentation of
> bd_info ?
>
>     We have our own bootloader - actually a monitor. It does alot of
> things besides boot Linux.
>     and it does so in less than 16K.
>     our bd_info struct is used to pass info to OS's besides Linux.
>     It does not have all the crap the u-boot bd_info has in it that has
> no meaning for us.
>     But it does have some things that are very specific to our
> hardware/firmware.

I understand your concerns.  Here are my thoughts when I put together
this patch:

- Only the ML300 and ML403 board ports are in mainline.  There has
been no serious push to get other Virtex platforms supported from
mainline; so patches need to be applied *regardless* for any boards
other than the ml300 and ml403 ref designs.  Patching to a different
bd_t is trivial.
- Even ml300 and ml403 ports in mainline don't work for anything other
than zImage.  The custom bd_t doesn't buy us anything.
- bd_t is a truly awful solution to the problem of passing information
from bootloader to kernel.  In arch/ppc, we cannot get away from it,
so I want to minimize it's stinkyness as much as possible.  By moving
from the custom virtex bd_t to the one in ppcboot.h at least makes it
work with one of the boot loaders (u-boot).
3. Unfortunately, even in moving to arch/powerpc we're still stuck
with bd_t as long as we continue to support older boot loaders (via
the boot wrapper).  As such, I'm actively discouraging the practice of
board specific bd_t.  Between now and the move to arch/powerpc there
will be plenty of people starting new virtex board ports, and I want
to make it clear that custom bd_t's are strongly discouraged.
However, if you already have a board port w/ a different bd_t, then
it's still no problem.  It is trivial to conditionally omit
#include<ppcboot.h> in favor of a different bd_t.

>     Besides, I am not current on the powerpc tree but isn't this kind of
> thing what device trees are
>     supposed to be about and don't we have to do that anyway to migrate
> to the powerpc tree ?

Yes, the ideal is that a single kernel image will be bootable on any
Virtex FPGA design if it is passed the correct device tree by a
compliant boot loader, but we're not there yet and I don't want to
make the situation any worse between now and then.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
