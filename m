Return-Path: <jcd@tribudubois.net>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id CE57B67A73
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 21:59:01 +1100 (EST)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: scarayol@assystembrime.com
In-Reply-To: <1111053440.5587.31.camel@fr-jdubois1.ad.mc.com>
References: <OFF0E6C961.C5D53940-ONC1256FC7.002D9E1C@brime.fr>
	<1111053440.5587.31.camel@fr-jdubois1.ad.mc.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Mar 2005 11:58:55 +0100
Message-Id: <1111057135.5587.59.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mapping large amount of memory on physical addresses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-03-17 at 10:57 +0100, Jean-Christophe Dubois wrote:
> Hello Sophie,
>=20
> If you really need the 36MB block in DV to be a physically contiguous
> memory block one possible simple solution would be to exclude both high
> memory blocks from Linux at boot time with mem=3D220M on the cmdline.

An alternate way is to integrate the bigphysarea patch (which uses
bootmem allocation) to your kernel. In this case you could reserve 36MB
of memory by providing "bigphysarea=3D37748736" on the command line. I
assume the MC memory will always be excluded from Linux main memory on
your platform.

see: http://ozlabs.org/pipermail/linuxppc64-dev/2005-March/003576.html

Note that this patch doesn't provide you with mapping capabilities from
user space so you would still have to write some kind of mapping driver
using the bigphysarea allocator if you want/need your application to get
at it.

JC

>  =20
> On Thu, 2005-03-17 at 09:51 +0100, scarayol@assystembrime.com wrote:
> > Hello,
> >=20
> > Could you help me : I work on embedded Linux on a MPC885 processor
> > (PowerPC). On my embedded system, i have 2 different components of RAM.=
 One
> > (name =3D DV, total size of 256 MB ) is only accessed by the processor,=
 the
> > other (name =3D MC, size =3D 2MB on the top of the RAM) is also access =
by an
> > FPGA. I want to do data transferts between each others. For that, I hav=
e to
> > allocate a big structure on DV for a size of 36 MB.
> > - Could I do like that to have contiguous memory on DV ?
> > For MC, it would be more complicated : I have to map on the physical
> > adresses of MC (for example 1300 0000-13FF FFFF) in order to be sure th=
at
> > the memory will be really allocated on MC and not on DV (as there is en=
ough
> > place on DV).
> > - How can I do that ?
> > - Do I have to write a driver and use ioremap on the physical address o=
f MC
> > (with reserving the top of memory with 'mem=3D' at boot time) ? Can i u=
se
> > physical addresses with ioremap or is it only virtual addresses ?
> > I think i can reserve the memory early in boot via the bootmem allocato=
r
> > but i think it isn't with physical addresses only an amount of memory a=
nd
> > it's only forbdrivers directly linked in  the kernel image and i want a
> > module.
> > - Is there another solution to do that ?
> >=20
> > Thank you really for your help.
> >=20
> > Best regards.
> >=20
> > ----------------------------------------------------------
> > Sophie CARAYOL
> >=20
> > TECHNOLOGIES & SYSTEMES
> > 50 rue du Pr=C3=A9sident Sadate
> > F - 29337 QUIMPER CEDEX
> >=20
> > T=C3=A9l: +33 2 98 10 30 06
> > mailto:scarayol@assystembrime.com
> > ----------------------------------------------------------
> >=20
> >=20
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
