Date: Tue, 2 Mar 1999 14:34:51 +0100 (MET)
From: "David.DeRidder" <s970707@uia.ua.ac.be>
Reply-To: loopback <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: loopback <david.de.ridder@bitsmart.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel boot arguments over network
In-Reply-To: <Pine.HPP.3.96.990302103807.3871Y-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9903021429260.12290-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2 Mar 1999, Gabriel Paubert wrote:

> > an MVME230x board). However, no document describes *how* to pass these
> > arguments over the network to the kernel.
> 
> You don't have to (and can't AFAICT). For now on my MVME2302, I have to
> sit at the serial console and add root=/dev/nfs to the LinuxPPC boot

 Do you mean adding it to the NBO command ? When I boot the kernel with
 NBO, it loads over the network (BOOTP and TFTP work perfectly fine),
 but does not ask for any arguments. It does show the arguments it knows
 (because they are set in the kernel image), i.e. "console=ttyS0").

> prompt. If you don't have a bootp server correctly settup, you also have
> to add other parameters like internet addresses in the ip or nfsaddrs
> parameter as explained in Documentation/nfsroot.txt.

 That part (done by PPC-Bug) works perfectly fine. nfsaddrs should be
 a kernel option, no ? Anyway, I also pass it on with some BOOTP
 parameter (root directory or so).

> When I have time, I'll merge code to take default parameters from the
> NVRAM in prepboot. The code exists, but I'm too busy on the VME driver
> right now.

 What is prepboot ?

> The right solution is to use the NVRAM I think, at least for very early
> setup since you'll end up with a chicken and egg problem (you have to
> tell the kernel root=/dev/nfs so that it attempts to use bootp to
> configure its network interface).

 Well, I tried using the "Argument File Name" setting (NIOT in PPC-Bug),
 but it resulted in no improvement.

> BTW: the latest version on my ftp server is a tested version which I have
> actually booted.

 I will download it and test it. No doubt I will get back with the
 results real soon.

 Thanks,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"When a lord goes hunting, it is easier to release his hounds
 than to catch them again."
 - Murashige 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
