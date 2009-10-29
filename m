Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23E361007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Oct 2009 20:07:49 +1100 (EST)
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330E22259@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>	<20091028112430.GO22408@zod.rchland.ibm.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D36A3D@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E22259@midas.usurf.usu.edu>
Subject: RE: Accessing flash directly from User Space [SOLVED]
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Message-ID: <OFE3AA516D.46A96178-ONC125765E.0030DA7C-C125765E.00317B8C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 29 Oct 2009 10:00:28 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Bill Gatliff <bgat@billgatliff.com>,
	Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> > > On Tue, Oct 27, 2009 at 04:24:53PM -0600, Jonathan Haws wrote:
> > > >> >>> How can I get that pointer?  Unfortunately I cannot simply
> > > use
> > > >> the
> > > >> >>>
> > > >> >> address of the flash.  Is there some magical function call
> > > that
> > > >> >> gives me access to that portion of the memory space?
> > > >> >>
> > > >> >> $ man 2 mmap
> > > >> >>
> > > >> >> You want MAP_SHARED and O_SYNC.
> > > >> >>
> > > >> >
> > > >> >
> > > >> > To use that I need to have a file descriptor to a device, do
> > I
> > > >> not?  However, I do not have a base flash driver to give me
> > that
> > > >> file descriptor.  Am I missing something with that call?
> > > >> >
> > > >>
> > > >> /dev/mem
> > > >>
> > > >Okay, I now have access to the flash memory, however when I write
> > > to it the writes do not take.  I have tried calling msync() on the
> > > mapping to no avail.  I have opened the fd with O_SYNC, but cannot
> > > get things to work right.
> > > >
> > > >Here are the calls:
> > > >
> > > >   int fd = open("/dev/mem", O_SYNC | O_RDWR);
> > > >   uint16_t * flash = (uint16_t *)mmap(NULL, NOR_FLASH_SIZE,
> > > >         (PROT_READ | PROT_WRITE), MAP_PRIVATE, fd,
> > > >         NOR_FLASH_BASE_ADRS);
> > >
> > > What board and CPU are you using?  Is your flash really at
> > > 0xFC800000, or is
> > > that the virtual address that VxWorks puts it at?
> >
> > I am using a custom board based on the AMCC Kilauea development
> > board.  It uses a 405EX CPU.  Yes, the flash is really at
> > 0xFC000000.
>
> I have found the problem.  It occurred to me in the shower (okay not really,
> but most good ideas happen there).
>
> What was happening is that I was in fact able to write to the correct
> registers.  However, I would try and write to them in a batch.  But the way
> mmap works (at least according to the man page) with MAP_SHARED is that the
> file may not be updated until msync() is called.  Now, I thought that O_SYNC
> would take care of that when I open /dev/mem, but that was not the case.
>
> Anyway, to make a long story short, I inserted an msync() after each
> assignment to the flash.  This resolved my problem and I can now program my flash.

Ouch, this was news to me too. Calling msync() after every write kills performance.
We use mmap(/dev/mem) to access HW and havn't seen any issues yet. Is this
perhaps a new behaviour for mmap(/dev/mem) and is there a way
to avoid calling msync()?

     Jocke
