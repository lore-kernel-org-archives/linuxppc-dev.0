To: Matt Porter <mmporter@home.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QUERY: Embedded PowerPC Linux? 
In-Reply-To: Message from Matt Porter <mmporter@home.com>
   of "Wed, 07 Jun 2000 22:56:17 MST." <20000607225617.A11485@cx258813-a.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 08 Jun 2000 16:18:02 +1000
Message-ID: <25991.960445082@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 7 Jun 2000 22:56:17 -0700, Matt Porter <mmporter@home.com> writes:
>I'm basically looking at reorganizing directories plus the necessary
>Makefile changes to reduce the klutter in arch/ppc/kernel/
>
>It would now have something like:
>
>arch/ppc/kernel/
>		chrp
>		gemini
>		pmac
>		prep
>		<port a>
>		<port b>
>
>The generic stuff would either stay in kernel/ or move to kernel/common/

How about this:

	arch/ppc/
		boot/
		io/
		kernel/
		mm/

		4xx/
			boot/
			io/
			kernel/
			mm/
		8xx/
			boot/
			io/
			kernel/
			mm/
		8260/
			boot/
			io/
			kernel/
			mm/
		chrp/
			boot/
			io/
			kernel/
			mm/
		gemini/
			boot/
			io/
			kernel/
			mm/
		pmac/
			boot/
			io/
			kernel/
			mm/
		prep/
			boot/
			io/
			kernel/
			mm/

Not all the directories would exist in all the platform directories, of
course. Some platforms might use another's directory - or bits therein
(e.g. if I had a cogent directory, I'd have a boot/ and io/ directory,
but no kernel/ or mm/ directory - for these I'd use 8xx/kernel/ and 8xx/mm/
with a few #ifdefs in there (if I had the 8xx cpu module, if I had the
cogent CMA282 8260 cpu module, I would use 8260/kernel/ and 8260/mm/). The
cogent/boot/ directory would only have a tty.c driver, the rest would come
from 8xx/boot/ - and the tty driver might not be used if you were to use the
devices on the cpu module, not on the motherboard. I might use both 8xx/io/
and cogent/io/ directories for generic 8xx commproc devices, and cogent
motherboard devices. For cpu module specific cogent devices - i.e. devices
on the cpu module, not the motherboard, I might have cogent/io/8xx/ and
cogent/io/8260/ etc.).

Each <port>/kernel/ directory might have some or all of: head.S, nvram.c,
pci.c, pic.c, prom.c, setup.c, time.c. The <port>/mm directory might have
fault.c, init.c, tlb.c (actually, there might not be any <port>/mm/
directories, there doesn't appear to be enough differences to warrant it -
but the option is there).

I'm not sure I like this - just throwing it into the air. Others that have
been hacking this stuff longer might have a better feel for how difficult
such a structure would be to maintain, and whether the advantages (if any)
are worth it. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
