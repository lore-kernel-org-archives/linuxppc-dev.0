Date: Thu, 14 Feb 2002 11:25:11 +0100
From: Marius Groeger <mag@sysgo.de>
Message-Id: <200202141025.g1EAPBo10610@dagobert.svc.sysgo.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: serial ports on 8245
In-Reply-To: <a05101400b889d8db8da9@[10.8.16.89]>
References: <E16ZEqZ-0005kG-00@usw-sf-list1.sourceforge.net> <a05101400b889d8db8da9@[10.8.16.89]>
Reply-To: mag@sysgo.de
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In linux.ppc.embedded, Greg Allen wrote:
>
> >     arch/ppc/mm/init.c:
> >     #ifdef CONFIG_HIGHMEM
> >	    ioremap_base = PKMAP_BASE;
> >     #else
> >	    ioremap_base = 0xfc000000UL;    /* for now, could be 0xfffff000 */
> >     #endif /* CONFIG_HIGHMEM */
>
> It's even worse than that, because:
>      arch/ppc/mm/pgtable.c
>          io_block_mapping(virt, ....) {
>              if (...)
>                  ioremap_bot = ioremap_base = virt;
>
> IOW, calling io_block_mapping (which is typically done in
> ($PLATFORM)_map_io) moves the EUMB around, too.

True, io_block_mapping() may move ioremap_base, but mpc10x_bridge_init() is
always called before $(PLATFORM)_map_io(), so this should not be a problem.
Or am I missing something?

--
Regards,
Marius.

--
Marius Groeger        SYSGO Real-Time Solutions GmbH    www.sysgo.de
Software Engineering  Embedded and Real-Time Software   www.osek.de
mgroeger @ sysgo de   Germany                           www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
