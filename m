Message-ID: <3BF67854.C4D8EA7D@midrivers.com>
Date: Sat, 17 Nov 2001 07:46:44 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Organisation of 4xx initialization code
References: <20011116164625.K673@zax>
			<20011116045737.A24130@cx258813-a.chnd1.az.home.com>
			<20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net>
			<20011116094210.B3473@beef.az.mvista.com>
			<20011116101323.B9242@cpe-24-221-152-185.az.sprintbbd.net>
			<3BF5A01D.4040502@embeddededge.com>
			<20011117114330.G12763@zax>
			<20011116191832.D9923@cpe-24-221-152-185.az.sprintbbd.net> <15350.18199.593968.834376@cargo.ozlabs.ibm.com> <3BF65B8B.EB015B30@intrex.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
> Just a note that might influence you.  The sprs of each 405 will be the same,
> but there is NO gurantee that the DCR, any of them look anything like any
> other DCR in any other DCR.
>
> I suggest core, chip, and then platform specfic.
>
> Chip
>

some differences between 405gp and 405pm:
- DCRs and memory mapped peripherals have moved, (m4xx_map_io(): makes
  more sense to map small blocks for each peripheral than one large
  map for 0x80000000 on up),

- the -PM supports floating point (yet more ifdefs for head_4xx.S)
- the ethernet MAL interrupts have been mux'd from 5 to 1 in the UIC
  (and moved too in the UIC -- more ifdefs for drivers/net/ppc4xx_enet.c)

IBM appears to create their processors by combining asic cores, i.e.
one core for the basic 405, one for ethernet, FPU, ... in doing so
they can move things around.  depending upon how many 4xx processors
they create, that's going to make for a lot of ifdefs if we stick to
one set of files.

is there a 'ppc-generic' set of interfaces that all code must conform
to in the kernel? too many layers?

an alternative might be (e.g.) all the ppc4xx ethernet stuff in
one file, but ifdef'd in (large separate) sections w/ common code
calling that which is processor specific.  (as opposed to ifdeffing
each individual func for each case.)

yow.

Mark
--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
