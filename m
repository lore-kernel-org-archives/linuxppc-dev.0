Date: Tue, 16 Jan 2001 07:01:16 +0000
Subject: [PATCH] Merge of dmasound back-port and BK 2.4.1p4 dmasound driver
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org,
        linux-audio-dev@ginette.musique.umontreal.ca,
        linux-m68k@lists.linux-m68k.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010116070326.C2A88DBA44@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

For anyone who wants it, there's a merge of the changes I made doing the
back-port code and the latest BK 2.4.x Linux PPC kernel. (2.4.1pre4 tested).

I'm not working on the back-port any more... just 2.4.x.

-----

For some reason...  this seems a lot more stable than the 'stock' version.
IMHO this is probably a Bad Thing (tm) because it likely means there is some
subtle bug floating around in there still :-(  ... I didn't touch the dbdma
or IRQ code... so I shouldn't have made any improvement...

-----

Linked from the usual place ;-)
http://www.drfruitcake.com/linux/linuxppc.html

-----

It's not an amazingly big deal... but... some people may find it useful (it
makes some of the user-land apps less fragile by being more forthcoming
about the hardware capabilities).

I would be particularly interested to hear if the Pismo has decided that
byte-swapping is a Good Thing under 2.4.1 ;-)

------

 + fixes SND_DSP_GETFMTS to OSS spec.
 + fixes SND_DSP_GETCAPS to return actual info for the machine
 + fixes a crash if translations were called which were not present
 + tries to be more flexible about determining the AWACS/Screamer sample
rates
 + amp enable is conditional upon perch now rather than CUDA
 + requests the true AWACS regs size on ioremap (won't make a difference
methinks - but).

 + cosmetic changes to the output (/dev/sndstat is more informative about
the capabilities of the hardware now).

 + changes to the build mechanism to allow the way forward for more PMac
models (and I sincerely hope without breaking other arch support).

=======  Arch-specific things...

The translation tables are now built separately and the latest makefile
should support the "one-size-fits-all" concept as well as "this is my arch
module only".

I've added a CONFIG_DMASOUND_RECORD so that people who don't want to build
in record code (for machines that don't have it) can leave it out...

... but, if you leave it in, then you only need to make one version of
dmaosund_core.o to support each arch (i.e. ppc/m68k).

=========

as always...

.... tested on PPC (PMac) [g3/beige, Lombard, 9600/233]

.... not even built for other archs...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
