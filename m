Subject: Re: Why not kmalloc() ??
From: sanjeev ramachandran <sanjeev.ramachandran@fci.com>
To: Magnus Damm <damm@opensource.se>
Cc: Rupesh S <rupeshs@myw.ltindia.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1089977681.27006.90.camel@kubu.opensource.se>
References: <s0f7edc2.025@EMAIL>
	 <1089977681.27006.90.camel@kubu.opensource.se>
Content-Type: text/plain
Message-Id: <1089979617.1055.19.camel@bng-d000218>
Mime-Version: 1.0
Date: 16 Jul 2004 17:36:59 +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Bingo , But there is another function called dpalloc which does the same
job of allocating from the dual port ram. The host alloc function
allocates from the host page address that is passed when the cpm is
resetted. How are the dpalloc and hostalloc different.


San


On Fri, 2004-07-16 at 17:04, Magnus Damm wrote:
> On Fri, 2004-07-16 at 11:25, Rupesh S wrote:
> > Hi,
> >
> > I just figured out that I need to use m8xx_cpm_hostalloc() to allocate memory for "buffer" that needs to be attached to the "Buffer Descriptor" of an  MPC8xx CPM peripheral (like IIC, SPI, SCC etc). Instead, if I try to use kmalloc() or a static memory allocation, my driver isn't working.
> >
> > 1) Can somebody throw some light on what exactly is the difference between m8xx_cpm_hostalloc() and kmalloc().
>
> kmalloc allocates from the kernel memory pool, ie your sdram.
> you usually have several megabytes of sdram.
> hostalloc allocates memory from the internal dpram area in the mpc8xx
> processor. a mpc8xx-processor usually has around 4-8 kilobyte dpram.
>
> > 2) Why is the difference important in ppc linux ?
>
> the dpram (dual port ram) is used to communicate with the cpm devices
> such as scc:s and smc.s found inside processors from the mpc8xx family.
> the powerpc core has access to one side, the cpm has access to the other
> side of the dual port memory. sort of anyway.
>
> consult your friendly mpc8xx manual for further info.
>
> /magnus
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
