Date: Mon, 18 Jan 1999 10:21:46 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Dan Malek <dmalek@jlc.net>, Johnnie Peters <jpeters@phx.mcd.mot.com>,
        Michael Meissner <meissner@cygnus.com>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linuxppc-dev@lists.linuxppc.org, gdt@cygnus.com
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
In-Reply-To: <Pine.LNX.3.96.990117115308.15296A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.990118100740.3058A-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sun, 17 Jan 1999, Cort Dougan wrote:

> 
> The prep/mbx boot code is a mess right now and I'm hesitant to touch it
> at the moment because we're at 2.2 and it works for most machines right
> now.  I know from the past that touching it breaks at least some machine 
> somewhere.
> 
> What I would like to do is keep arch/ppc/boot/ for MBX and prep since
> they're so similar but setup a different relocation strategy.  Right now
> it's mostly a result of me trying out things and stopping when everything
> I could get ahold of worked and patching it as bug reports came in.
> 
> The new one should be linked at a safe address (for PReP this could be
> 10-16M).  After load we relocate ourselves there, use the 10-12M range for
> free space and decompress the kernel.  This requires 16M but I'm not sure
> there are many machines out there with <16M.
> 
> This would take care of every prep I know of.  They all load at a
> different address (sometimes depending on how you boot) but that region
> should be safe.  Does anyone see problems with that?


Why don't you compile with the -m relocatable option for PreP, which
allows executing at any addres. Have a look at how I've done it in the
prep loader I've written. Some assembly glue at the beginning performs the
relocation and calls a C routine which essentially decides where to
relocate and set the stack and other things. Then it relocates again at
the highest possible address (everything as a single block like boot).

You may have problem with preploader for other reasons (multiplying the 
number of boot methods) but this part is quite clean and does not rely
on any fixed address.

Nevertheless, since the MBX firmware understands ELF AFAIK, they should be
handled somewhat differently than PreP. However, this is only a matter
of linker scripts and compiler option depending on CONFIG_MBX. 
(There is so much condiftional code on CONFIG_MBX in the source that 
adding a couple of them should not matter, -mrelocatable increases
somewhat the code size so it should be PreP specific since the machines
are much less memory constrained, and I've been careful to write the
code in a way which minimizes this kind of bloat). 

I'm in the process of improving preploader to handle the no residual data
case of preploader (I've finally some hints on how to do it). I could not
do it during the week-end due to serious problems with the computer system
here requiring major reconfiguration. 

	Gabriel


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
