Date: Sun, 17 Jan 1999 11:58:20 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Dan Malek <dmalek@jlc.net>
cc: Johnnie Peters <jpeters@phx.mcd.mot.com>,
        Michael Meissner <meissner@cygnus.com>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        gdt@cygnus.com
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
In-Reply-To: <36A0E079.F90619F5@jlc.net>
Message-ID: <Pine.LNX.3.96.990117115308.15296A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The prep/mbx boot code is a mess right now and I'm hesitant to touch it
at the moment because we're at 2.2 and it works for most machines right
now.  I know from the past that touching it breaks at least some machine 
somewhere.

What I would like to do is keep arch/ppc/boot/ for MBX and prep since
they're so similar but setup a different relocation strategy.  Right now
it's mostly a result of me trying out things and stopping when everything
I could get ahold of worked and patching it as bug reports came in.

The new one should be linked at a safe address (for PReP this could be
10-16M).  After load we relocate ourselves there, use the 10-12M range for
free space and decompress the kernel.  This requires 16M but I'm not sure
there are many machines out there with <16M.

This would take care of every prep I know of.  They all load at a
different address (sometimes depending on how you boot) but that region
should be safe.  Does anyone see problems with that?


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
