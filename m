Message-Id: <4.3.2.20000920073056.00b6dee0@falcon.si.com>
Date: Wed, 20 Sep 2000 07:37:30 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: rebooting with the FADS
In-Reply-To: <39C7E54D.AFBD3412@mvista.com>
References: <001701c01e61$958ed240$0a00010a@paoloweb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There currently is no formal convention for restarts (i.e. it isn't
defined in the EABI :-), but PPC implementations that I've been
associated with use the convention of 0xFFF00104 being the restart
location.  The first instruction executed is at 0xFFF00100 and is set
to be a jump to the cold start location.  The next instruction is then
a jump to the restart location.  Many (all?) PPCs and/or their
associated hardware require different handling based on whether they
have been initialized before or not.

I strongly advocate adopting this convention.  It is much cleaner than
the alternative of trying to leave flags laying around in RAM.

gvb


At 03:14 PM 9/19/00 -0700, Pete Popov wrote:

>Paolo Scaffardi wrote:
> >
> > on my FADS, i see that it is not possible to reboot from software:
> you must
> > press the reset buttons to do this.
> >
> > But, i sometimes have reboot problems. I see BCSRx registers have
> strange
> > values and the bootrom seems to stop downloading the kernel
> randomly. This
> > of because of erroneous values into memory configuration registers.
> >
> > how can i make a soft-reboot?
> > how can i resolve this problem with strange register-values on reboot?
>
>I've had soft reboot problems with the 850 on a custom board, where the
>firmware would crash shortly after the reboot.  I had to modify the boot
>code to not reinitialize the UPMs (I don't remember if I had to do
>anything else) after a soft reboot.  You might have to modify your boot
>code to get this to work correctly.  If you'll be developing a custom
>board, I suggest you wait and fix the problem on your custom board,
>instead of worrying about the FADS.
>
>Keep in mind also that the FADS board is not the best hardware design
>out there.  There's a number of signals left floating which shouldn't be
>floating.  If you replace the cpu that comes with the board with a
>different mask cpu, chances are the bdm port might not work at all
>(unless you freeze it with some spray).
>
>Pete
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
