Date: Tue, 2 Mar 1999 15:16:11 +0100 (MET)
From: "David.DeRidder" <s970707@uia.ua.ac.be>
Reply-To: loopback <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel boot arguments over network
In-Reply-To: <Pine.HPP.3.96.990302143829.3871e-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9903021502290.13750-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2 Mar 1999, Gabriel Paubert wrote:
> On Tue, 2 Mar 1999, David.DeRidder wrote:
> 
> >  Do you mean adding it to the NBO command ? When I boot the kernel with
> >  NBO, it loads over the network (BOOTP and TFTP work perfectly fine),
> >  but does not ask for any arguments. It does show the arguments it knows
> >  (because they are set in the kernel image), i.e. "console=ttyS0").
> 
> No, the console=ttyS0 is actually a prompt which asks you for possible
> additional parameters, you have to type the additional root=/dev/nfs. This

 Now I see. I wasn't aware the bootloader was waiting for input - I just
 thought it was doing something. There is a timeout to this prompt, 
 right ?

> is a trick in my current bootloader (which should disappear soon) that
> sets "console=ttyS0" as a default command line when it can't find a
> keyboard. You may append there additional kernel options. 

 Pretty neat that it can take input from a serial keyboard in that stage
 of the boot procedure. I thought it was just some kernel info, echoed
 due to CONF_SERIAL_ECHO. But instead, it is prepboot, right ?

> >  That part (done by PPC-Bug) works perfectly fine. nfsaddrs should be
> >  a kernel option, no ? Anyway, I also pass it on with some BOOTP
> >  parameter (root directory or so).
> 
> No, it is not a kernel option. AFAIR, you could build a kernel with
> default root set to NFS but network configuration parameters have to be
> set either by bootp or by the nfsaddrs (now ip) kernel options. 

 My mistake : I meant 'boot argument'. You are completely right.

> >  Well, I tried using the "Argument File Name" setting (NIOT in PPC-Bug),
> >  but it resulted in no improvement.
> 
> No, this won't work. I don't even remember if it is passed to the loaded
> program when you select the "Network PreP boot mode enable".

 It seems not. Does anybody out there know what this is for ? The PPC-Bug
 manual is very uninformative on this matter.

> >  I will download it and test it. No doubt I will get back with the
> >  results real soon.
> 
> Ok, waiting for you to test it.

 Tested it, and it still is stuck at 'Now booting...' Does the kernel
 look for its root filesystem before giving any output ? If so, it
 might be the case that the kernel doesn't find its root fs (but
 I'd expect at least a message reporting that is the case). If not,
 there must be another problem...

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"Every dog has its day, and today's mine."
 Terry Borer after winning the Masters finals at the New York M:TG Pro Tour 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
