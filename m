Message-ID: <6B546A602AD2D211BFF00008C7A4288905843F78@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Dan Malek '" <dan@embeddededge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MMU and BDI2000
Date: Thu, 13 Dec 2001 08:48:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

I am not sure I fully understand what you mean.

I have a BDI with MMU translation working. I patched the head_8xx.h of a
MontaVista 2.4.2 kernel
	lis			r5,	abatron_pteptrs@h
	ori			r5, r5, abatron_pteptrs@l
	stw			r5, 0xf0(r0)
	lis			r6, swapper_pg_dir@h
	ori			r6, r6, swapper_pg_dir@l
	tophys	(r5,r5)
	stw			r6, 0(r5)
and
_GLOBAL(set_context)
	lis	r5, KERNELBASE@h
	lwz	r5, 0xf0(r5)
	stw	r4, 0x4(r5)

The BDM sw is b20ppcgd.109

Yesterday evening I installed the later version b20ppcgd.110. After reading
your mail, I tested debugging again and yes it looks like MMU translation no
longer works correctly.

So, this newer version of BDM sw, uses another mechanism? I do not see any
of this mentioned in the newer version of the manual?!? In order to have it
working with this new version, is it just another patch for head_8xx.h or is
it more complex?

Thanks,
Frederic

-----Original Message-----
From: Dan Malek
To: Subodh Nijsure
Cc: 'Wolfgang Denk'; Michael Habermann; linuxppc-embedded@lists.linuxppc.org
Sent: 12/13/01 7:15 AM
Subject: Re: MMU and BDI2000


Subodh Nijsure wrote:



> I have kernel 2.4.4 and I do have MMU XLAT and latest BDI firmware
from
> Abatron

Can you use a newer kernel that will do all of this for you
automatically?

> and I am  not able to get translation to work. I have tried the
following

That isn't correct with the latest BDI firmware.  The address at 0xf0 is
not the address of the page table, it is an indirect pointer to an array
of page table root pointers.  Later kernels will set up all of this for
you.

We unfortunately had a short-lived version of kernel and BDI2000 that
did
use the low address as a pointer to the kernel page tables, but this
isn't
done any longer.

Thanks.


-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
