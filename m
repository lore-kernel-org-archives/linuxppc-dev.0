Message-ID: <638AA0336D7ED411928700D0B7B0D75BB32416@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BDI2000 and failed MMU translations
Date: Wed, 23 Jan 2002 17:55:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok,

This still doesn't solve my problem.

In the Makefile:
	CONFIG_KERNEL = -g -ggdb

In mpc860.cnf for the bdi:
	MMU XLAT 0xc0000000 (this is the default BTW)
	PTBASE	0xf0
	BREAK SOFT

On the BDI:
	bi 0xc0157640 (start_kernel)
	go
	<breakpoint>

Now, start gdb w/ vmlinux
(gdb) target remote bdi:2001
(gdb) br scc_enet_init

On the BDI it says:
*** MMU: address translation for 0xC015ECB8 failed
(gdb) c
Continuing.
warning: Cannot insert breakpoint 1:
Error accessing memory address 0xc015ecb8: Operation not permitted

I'm using gdb 5.0.

Does this shed any more light?

TIA Dan and all,

Regards,

Matt

> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddededge.com]
> Sent: Wednesday, January 23, 2002 5:51 PM
> To: Gessner, Matt
> Cc: 'Linux PPC'
> Subject: Re: BDI2000 and failed MMU translations
>
>
> Gessner, Matt wrote:
>
> > It's straight 2_4.  I wasn't stopping at start_kernel though.
>
> You don't need to stop anywhere unless there are some breakpoints
> you want to set for early debug.
>
> > I don't have PTBASE set up.
>
> You need:
> 	MMU XLAT 0xc0000000
> 	PTBASE 0x000000f0
>
> The newer kernels initialize the page table pointers for the BDI2000,
> so ignore comments about stopping and setting values.  We went through
> several iterations of implementation, so anything written about how to
> do this manually is probably wrong :-).
>
> > ...... I'm going to
> > break at start kernel FIRST, then connect with BDI, then
> > see if I can look at my data.
>
> How do you break and then connect the BDI?  You need the BDI
> connected to set and trap the breakpoint.
>
> Have fun.
>
>
> 	-- Dan
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
