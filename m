Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C261F67A89
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 10:14:08 +1100 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8592EA@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B8592EA@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <1a5fcb31206258ffb8b8f7cd28f054b1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 8 Mar 2005 17:13:57 -0600
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hmm, I think there is an expectation that virt->phys is a simple=20
translation (ie, subtract KERNELBASE) for lowmem.  lowmem most parts=20
tops out at 768M.  So changing VMALLOC_START would break that.

Is there an issue with moving the IMMR virt address up higher?

- kumar

On Mar 8, 2005, at 3:16 PM, Rune Torgersen wrote:

> What about moving the VMALLOC_START and VMALLOC_END #defines to
>  something else (like start at 0x80000000 and end at 0xc0000000), or=20=

> will
>  that break some assumptions in the kernel about the position of the
>  vmalloc area?
>
> > -----Original Message-----
>  > From: Matt Porter [mailto:mporter@kernel.crashing.org]
> > Sent: Tuesday, March 08, 2005 14:33
>  > To: Rune Torgersen
>  > Cc: Kumar Gala; linuxppc-embedded@ozlabs.org
> > Subject: Re: Lots of memory on 826x
>  >
> > On Tue, Mar 08, 2005 at 12:37:33PM -0600, Rune Torgersen wrote:
>  > > Ok... Got a little closer....
>  > >
> > > I have PCI (outbound) mapped in the area 0x80000000-0x8fffffff
>  > > (prefetch/non-prefetch and IO)
>  > > IMMR of cource is at 0xf0000000
>  > >
> > > So I map the IO as following:
>  > > =A0=A0=A0 /* Map IMMR region to a 256MB BAT */
>  > > =A0=A0=A0 addr =3D (cpm2_immr !=3D NULL) ? (uint)cpm2_immr : =
CPM_MAP_ADDR;
> > > =A0=A0=A0 io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
>  > >
> > > =A0=A0=A0 io_block_mapping(0x80000000, 0x80000000, 0x10000000, =
_PAGE_IO);
>  > >
> > > Now I can almost boot....:
> > > It craches when trying to read from harddisk
>  > > (only happens with more than 512MB)
>  >
> > That's expected if you are going to 768MB. You have kernel lowmem
> > being mapped at 0xc0000000+<size_of_system_memory>. With 768MB that
>  > takes you all the way to where you have the IMMR mapped 1:1 I
>  > guess. This leaves no room for vmalloc space.=A0 With 768MB of ram
>  > the kernel will calculate VMALLOC_START at 0xf1000000 which is a
>  > problem.
>  >
> > A few options are:
>  >
> > * Move the IMMR much higher to allow vmalloc space
>  > * Modify maximum low memory to limit to 512MB using the advanced
>  >=A0=A0 options menu
>  > * Modify KERNELBASE to something like 0xa0000000 using the advanced
>  >=A0=A0 options menu
>  >
> > All of these methods will provide addition vmalloc space.
> >
> > Don't forget to turn on HIGHMEM to use everything above MAX_LOW_MEM.
> >
> > -Matt
>  >
> >
