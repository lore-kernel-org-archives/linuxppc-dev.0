Message-ID: <3A4256BE.C0834A97@mvista.com>
Date: Thu, 21 Dec 2000 14:15:10 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Matthew Locke <mlocke@onemain.com>
CC: govindan@tejasnetworks.com, linuxppc-dev@lists.linuxppc.org,
        damm@kierayapc01.p.y.ki.era.ericsson.se, dhinds@pcmcia.sourceforge.org,
        gopi@tejasnetworks.com
Subject: Re: Problem with PCMCIA and RPXCLASSIC
References: <384433732.977423922543.JavaMail.root@web625-wrb.mail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matthew Locke wrote:

> >Then we gave _IO_BASE = 0x80000000
> >This still did not work and the kernel panics.  We had to >comment out
> >a line in ll_rw_blk.c( where and outb_p is called)..
> >After this the kernel comes up.
>
> So, IO_BASE = 0x80000000 does work, ll_rw_blk.c is an unrelated bug.

What are you guys using for a kernel?  This outb_p "bug" was fixed
in ancient times (or you didn't properly configure the kernel).


> It may be a little confusing, but since it works for me I doubt there is a
> goof up. The confusing part is that there is code in there to bypass card
> services for ATA cards.

Yes, this works.  It sounds like you are mixing the internal ATA hack
with card services.  You can't use both........

> >I HAVE READ IN THE MAILING LIST from Dan dated TUE 02, may 2000
> >that he has successfully used IBM Micro drive with MPC860 PCMCIA.
> >has anybody got the detail information ?
>
> I don't think Dan uses card services.  He has code in the kernel that
> connects the ide driver directly to the 8xx pcmcia controller.

That's right, no card services when I wrote that message.  I just
used the PCMCIA interface as a dedicated ATA interface.  The purpose
was simply to verify the hardware would work correctly, and to provide
a method for embedded systems to use this interface directly without
card services.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
