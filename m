Date: Tue, 11 Mar 2003 23:38:19 -0900
From: Ethan Benson <erbenson@alaska.net>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Serial Console on XServe and yaboot???
Message-ID: <20030312083819.GD20925@plato.local.lan>
References: <20030311223353.00f9a059.billfink@mindspring.com>
Mime-Version: 1.0
In-Reply-To: <20030311223353.00f9a059.billfink@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 11, 2003 at 10:33:53PM -0500, Bill Fink wrote:
>
> I'd like to use the serial port on the XServe as a serial console.
> I enabled CONFIG_SERIAL_CONSOLE in a 2.4.20-0.7b (YDL 2.3) kernel,
> set the OF input-device and output-device parameters to ttya, and
> booted with the kernel argument "console=ttyS0,38400".
>
> This actually works once the system starts booting.  My problem
> is that I never get a chance to interact with yaboot and thus for

you will need to use a different first stage (magicboot) or none at
all (if OF will boot that way, some models refuse to autoboot
binaries without the CHRP bootinfos).  the default ofboot script
installed with yaboot forces the output to screen to work around
stupid hacks in apple OF to prevent `archaic peecee text' from
appearing on the screen.

> example can't select a different Linux kernel to boot.  Is there
> any way to accomplish this, for example by some suitable modification
> to the ofboot.b file in the boot partition?  Or is this just not

never modify the bootstrap partition, edit the magicboot= line in
/etc/yaboot.conf to point to an alternate script.  you can make a copy
of the /usr/lib/yaboot/ofboot file, then find and change the line:

" screen" output

to

" ttya" output

later im going to fix this so it won't have this problem.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
