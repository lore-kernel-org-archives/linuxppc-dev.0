Date: Thu, 13 Mar 2003 22:29:01 -0500
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: erbenson@alaska.net, Bill Fink <billfink@mindspring.com>
Subject: Re: Serial Console on XServe and yaboot???
Message-Id: <20030313222901.79512cfc.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ethan,

On Tue, 11 Mar 2003, Ethan Benson wrote:

> On Tue, Mar 11, 2003 at 10:33:53PM -0500, Bill Fink wrote:
> >
> > I'd like to use the serial port on the XServe as a serial console.
> > I enabled CONFIG_SERIAL_CONSOLE in a 2.4.20-0.7b (YDL 2.3) kernel,
> > set the OF input-device and output-device parameters to ttya, and
> > booted with the kernel argument "console=ttyS0,38400".
> >
> > This actually works once the system starts booting. My problem
> > is that I never get a chance to interact with yaboot and thus for
>
> you will need to use a different first stage (magicboot) or none at
> all (if OF will boot that way, some models refuse to autoboot
> binaries without the CHRP bootinfos). the default ofboot script
> installed with yaboot forces the output to screen to work around
> stupid hacks in apple OF to prevent `archaic peecee text' from
> appearing on the screen.
>
> > example can't select a different Linux kernel to boot. Is there
> > any way to accomplish this, for example by some suitable modification
> > to the ofboot.b file in the boot partition? Or is this just not
>
> never modify the bootstrap partition, edit the magicboot= line in
> /etc/yaboot.conf to point to an alternate script. you can make a copy
> of the /usr/lib/yaboot/ofboot file, then find and change the line:
>
> " screen" output
>
> to
>
> " ttya" output
>
> later im going to fix this so it won't have this problem.

Thanks a bunch for the info!  Using this method, with scca instead
of ttya, and a baud rate of 57600 (using a laptop), I was able to
verify this basically works.  The initial menu that asks you what
you want to boot (Linux, MacOS 9, MacOS X, etc) still goes to the
screen (at least it does if you have a screen attached) but the
yaboot menu where you select the Linux kernel to boot does show
up on the serial port of the XServe, and this is what I'm most
interested in.  Now if I can just figure out how to set the baud
rate of the serial console for OF to 38400 or less to make my
console server happy, I'd be in business.  If nothing else I can
use the laptop approach which is at least a lot easier than toting
a big monitor around.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
