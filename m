Date: Tue, 2 Mar 1999 10:45:44 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: loopback <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel boot arguments over network
In-Reply-To: <Pine.SO4.4.05.9903011559500.22676-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990302103807.3871Y-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 1 Mar 1999, David.DeRidder wrote:

> Hi,
> 
> in my continueing efforts to get our MVME2306 board running, I ran
> across another problem. All Linux (mini-)HOWTOs talk about passing
> boot arguments (like 'root=/dev/nfs') to the kernel. Some also
> mention the case where one is booting a diskless station (such as
> an MVME230x board). However, no document describes *how* to pass these
> arguments over the network to the kernel.

You don't have to (and can't AFAICT). For now on my MVME2302, I have to
sit at the serial console and add root=/dev/nfs to the LinuxPPC boot
prompt. If you don't have a bootp server correctly settup, you also have
to add other parameters like internet addresses in the ip or nfsaddrs
parameter as explained in Documentation/nfsroot.txt.

When I have time, I'll merge code to take default parameters from the
NVRAM in prepboot. The code exists, but I'm too busy on the VME driver
right now.

> I'm starting to doubt whether this is possible. I want the BOOTP/TFTP
> server to have the initial boot arguments for each of its clients, and
> pass them when a client (i.c. an MVME2306 board) boots over the
> network. Other than the file name, BOOTP doesn't seem capable to me
> to passing anything as long as a command line - but I may be wrong.

The right solution is to use the NVRAM I think, at least for very early
setup since you'll end up with a chicken and egg problem (you have to
tell the kernel root=/dev/nfs so that it attempts to use bootp to
configure its network interface).

BTW: the latest version on my ftp server is a tested version which I have
actually booted.

	Gabriel. 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
