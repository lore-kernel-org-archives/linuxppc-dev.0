From: "Ron Bianco" <ronb@junction.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260 - Spurious interrupt when calling __sti()
Date: Wed, 10 Apr 2002 13:24:31 -0700
Message-ID: <000b01c1e0cd$b8f02d30$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CB48582.5030502@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For OpenPIC/EPIC hardware:
I don't think this subtracts from the validity of the points made in this
discussion so far, but not making sure of this did give us grief with 'initial'
spurious interrupts for a while on a pre- 2.4.x port for the 8240.

It is important in the bootrom code that the OpenPIC be reset by software before
setting mode and enabling.
For the 8240 this is done by writing 0xA0000000 to Global Configuration register
0.
There are a few other required steps after that too.

We had this code in our kernel for a while:

#if 0	// don't need this, it is done by boot loader now
	openpic_write(&OpenPIC->Global.Global_Configuration0, 0xa0000000); /* GCR -
reset epic */
	openpic_write(&OpenPIC->Global.Global_Configuration0, 0x20000000); /* GCR -
mixed mode */
	t = openpic_read(&OpenPIC->Global.Global_Configuration1);
	openpic_write(&OpenPIC->Global.Global_Configuration1, t & 0xf7ffffff); /*
EICR - direct */

	while ( openpic_readfield(&OpenPIC->THIS_CPU.Interrupt_Acknowledge,
		OPENPIC_VECTOR_MASK) != 0x000000ff);
#endif

I'm not yet familiar with the scope of open pic initialization in the 2.4.x
kernels.
But somewhere during startup this procedure is necessary to avoid the one time,
initial spurious int. problem.
If this is old news to anyone, then excuse redunancy.

Ron

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan
> Malek
> Sent: Wednesday, April 10, 2002 11:34 AM
> To: Jean-Denis Boyer
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: 8260 - Spurious interrupt when calling __sti()
>
>
>
> Jean-Denis Boyer wrote:
>
>
> > However, this apparent 'out of sync' has nothing to do
> > with the fact that the invalid interrupt pops up, right ?
>
> If it happens only once at boot, there must be some device
> with a dangling interrupt not properly initialized.
>
>
> 	-- Dan
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
