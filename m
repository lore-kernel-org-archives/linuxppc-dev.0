Message-ID: <3C830487.3388FD5F@taikebj.com.cn>
Date: Mon, 04 Mar 2002 13:22:15 +0800
From: caokai <tk19@taikebj.com.cn>
MIME-Version: 1.0
To: Jeremy Rosen <Jeremy.Rosen@au.thalesgroup.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing BCSR's
References: <sc835dac.097@gw_tms_syd2.pty.tms.thomson-csf.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,Jeremy Rosen:
   I have met the same problem with u.The kernel will crash if I access the
BCSR when mmu is on.
I add the following line in function MMU_init (arch/ppc/mm/init.c).it is OK
now.
#ifdef CONFIG_XXXXXX
        /*I defined the BCSR_ADDR,BCSR_SIZE in my include/asm/xxxx.h*/
        ioremap(BCSR_ADDR, BCSR_SIZE);
#endif
Wish it helps u.
caokai
Jeremy Rosen wrote:

> I have investigated a little further, and in arch/ppc/mm/init.c, it
> calls ppc_md.setup_io_mapping(), which remaps 1:1 the BCSRs
> (in arch/ppc/kernel/m8xx_map_io), so (if I understand your explanation
> and the code properly) the BCSR should be at the same address in PPCBOOT
> and in the kernel space... so accessing offset ff010000 in /dev/mem or
> /dev/kmem should give me access to it... is that it ? Because if it is,
> I can't make it work...
>
> I'll try to access some of the internal maps in the IMMR to see if they
> work...
>
> thx anyway
> Jeremy
>
> >>> Magnus Damm <damm@opensource.se> 03/04/02 10:57am >>>
> Hi,
>
> If you have memory-mapped io (The (F)ADS8xx BCSR registers is a
> good example) which is mapped to a certain physical address, it
> is very simple to access it if the MMU is turned off.
>
> The Linux kernel runs with the MMU on, and it needs a
> virtual-to-physical
> address mapping to be able to access memory-mapped io.
>
> So, my 2.2-kernel has a file called arch/ppc/mm/init.c.
>
> Inside that file there's a function called "ioremap()" - that is what
> you are looking for.
>
> Make sure that your Linux kernel has a virtual page for your io-area,
> and access the virtual address that is returned by "ioremap()".
>
> If you use "ioremap()" before a certain moment when the Linux kernel
> starts up, you will get a 1:1 mapping between virtual and physical
> addresses.
> (This is true for 2.2 anyhow)
>
> Look how the internal io block is ioremap():ped for a good example how
> it is done.
>
> Cheers /
>
> magnus
>
> Jeremy Rosen wrote:
> >
> > Hello everybody,
> >
> > I have 860T FADS board, and I am trying to access the (board
> specific)
> > registers BCSRs.
> >
> > I have no problem accessing them in PPCBOOT, since they are accessed
> > through CS1, at address FF01xxxx, but I can't access them in linux
> for
> > the moment.
> > My first attempt was by using the /dev/mem device, but it doesn't
> seem
> > to work, the result read are not correct.
> > so I have to question
> > 1) why doesn't it work, I probably don't understand how /dev/mem
> works
> > : does it map only memory and not the address space ? do I have to
> > register the address range or the BCSR in the kernel ?
> > 2) what is the proper way of doing this ? writing a driver ? or
> using
> > /dev/mem properly ?
> >
> > thx for your help...
> >
> > Jeremy
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
