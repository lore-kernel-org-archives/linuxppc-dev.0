Content-Type: text/plain;
  charset="iso-8859-1"
From: Leonardo Pereira Santos <lsantos@pd3.com.br>
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Subject: Re: PCMCIA on TQM8xxL
Date: Thu, 23 Jan 2003 11:55:20 -0200
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Wolfgang Denk <wd@denx.de>
References: <3E2FBB5E.E16D577E@imc-berlin.de> <3E2FBF48.6040200@bluewin.ch> <3E2FC0F1.41C65F18@imc-berlin.de>
In-Reply-To: <3E2FC0F1.41C65F18@imc-berlin.de>
MIME-Version: 1.0
Message-Id: <200301231155.20895.lsantos@pd3.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



1) Define _IO_BASE and _IO_BASE_SIZE in arch/ppc/platforms/tqm8xxl.h
2) just copy and paste the line of code for the RPX to TQM8xxL section in
arch/ppc/kernel/m8xx_setup.c m8xx_map_io(), as you pointed. If there's no
#ifdef CONFIG_TQM8XXL (or something like that), just create one near the ones
already defined for FADS, RPX, MBX. For example, for my FADS board, its
section looks like this:

#ifdef CONFIG_FADS
	io_block_mapping(BCSR_ADDR, BCSR_ADDR, BCSR_SIZE, _PAGE_IO);
	io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
#endif

the first call to io_block_mapping() maps the EPLD's registers, the second the
PCMCIA address space. And that's it.

On Thursday 23 January 2003 08:16, Steven Scholz wrote:
> Wolfgang Grandegger wrote:
> > On 01/23/2003 10:52 AM Steven Scholz wrote:
> > > Hi there,
> > >
> > > this is about PCMCIA on TQM8xxL using DENX ELDK 2.0 with DENX
> > > linuxppc_2_4_devel CVS tree:
> > >
> > > I am confused:
> > >
> > > In order to get pcmcia working on mpc8xx one have to define a proper
> > > _IO_BASE and then ioremap it early enough so the physical address
> > > equals the virtual adress.
> > >
> > > That fair enough, but I just can't find the place where _IO_BASE is
> > > remapped for TQM8xxL.
> > >
> > > It should be done in arch/ppc/kernel/m8xx_setup.c:m8xx_map_io(), but
> > > there's no "#ifdef TQM8xxL" or something !?
> > >
> > > Any ideas, why it should work at all?
> >
> > Check "arch/ppc/platforms/tqm8xx.h", which is somehow include by
> > "include/asm-ppc/io.h".
>
> Thanks for your reply.
>
> I know _IO_BASE is defined in arch/ppc/platforms/tqm8xx.h.
> But IMHO it's never ioremapped like it is done for  RPC Boards in
> arch/ppc/kernel/m8xx_setup.c:m8xx_map_io():
>
> #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
>         io_block_mapping(RPX_CSR_ADDR, RPX_CSR_ADDR, RPX_CSR_SIZE,
> _PAGE_IO); #if !defined(CONFIG_PCI)
>         io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
> #endif
> #endif
>
> That's what I don't understand!
>
> My HW is similar to TQM8xx and I have to add something like
> #if defined(CONFIG_MYBOARD)
>         io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
> #endif
> to get PCMCIA working...
>
> Steven
>

- --
This is Linux country.
On a quiet night, you can hear Windows reboot.

Leonardo Pereira Santos
Engenheiro de Projetos
PD3 Tecnologia
av. Pará 330/202
(51) 3337 1237

Today Fortune tells us:
Of ______course it's the murder weapon.  Who would frame someone with a
fake?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
