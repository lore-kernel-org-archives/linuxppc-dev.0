Message-ID: <B25E2E5A003CD311B61E00902778AF2A0148B711@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'Dan Malek'" <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: How does one get physical address for iorempped window?
Date: Thu, 15 Feb 2001 09:58:59 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I know the physical address I should be writing to.

For debugging I was trying to print exact physical address where
write is happening .When I used virt_to_phys() on the addresse
ioremap() I was not getting back the original physical address.
Hence the question.

Basically code I have looks like this.

unsigned long physaddr;

physmap_map.map_priv_1 = (unsigned
long)ioremap_nocache(WINDOW_ADDR,WINDOW_SIZE);
printk("Physical window (0x%08X size)starting at 0x%08X is mapped to address
0x%08X \n",
            WINDOW_SIZE,WINDOW_ADDR, physmap_map.map_priv_1);
physaddr = virt_to_phys((void *)physmap_map.map_priv_1);
printk("virtual address 0x%08X maps to physical 0x%08X \n",
                        physmap_map.map_priv_1 ,physaddr);

The output I was getting is this.

Physical window (0x00400000 size) starting at 0x28000000 is mapped to
address 0xC5012000
virtual address 0xC5012000 maps to physical 0x05012000


/Subodh Nijsure


> -----Original Message-----
> From: Dan Malek [mailto:dan@mvista.com]
> Sent: Thursday, February 15, 2001 9:03 AM
> To: Subodh Nijsure
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: How does one get physical address for iorempped window?
>
>
>
> Subodh Nijsure wrote:
>
> > If I map memory window using ioremap_nocache() if I use
> virt_to_phys()
> > should one get back the actual physical address?
>
> Ummmm....you give ioremap_nocache() a physical address to map, so
> you have to know it........Using virt_to_phys() may not give you
> the proper physical address, depending upon the platform.  I'm working
> on a solution for 2.5 that will work.  Currently, it is wrapped into
> a heavier weight virt_to_bus/phys() but that many not be the right
> place.
>
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
