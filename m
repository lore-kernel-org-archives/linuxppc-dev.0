Message-ID: <39C7E54D.AFBD3412@mvista.com>
Date: Tue, 19 Sep 2000 15:14:37 -0700
From: Pete Popov <ppopov@mvista.com>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: rebooting with the FADS
References: <001701c01e61$958ed240$0a00010a@paoloweb>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo Scaffardi wrote:
>
> on my FADS, i see that it is not possible to reboot from software: you must
> press the reset buttons to do this.
>
> But, i sometimes have reboot problems. I see BCSRx registers have strange
> values and the bootrom seems to stop downloading the kernel randomly. This
> of because of erroneous values into memory configuration registers.
>
> how can i make a soft-reboot?
> how can i resolve this problem with strange register-values on reboot?

I've had soft reboot problems with the 850 on a custom board, where the
firmware would crash shortly after the reboot.  I had to modify the boot
code to not reinitialize the UPMs (I don't remember if I had to do
anything else) after a soft reboot.  You might have to modify your boot
code to get this to work correctly.  If you'll be developing a custom
board, I suggest you wait and fix the problem on your custom board,
instead of worrying about the FADS.

Keep in mind also that the FADS board is not the best hardware design
out there.  There's a number of signals left floating which shouldn't be
floating.  If you replace the cpu that comes with the board with a
different mask cpu, chances are the bdm port might not work at all
(unless you freeze it with some spray).

Pete

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
