Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id BD54667A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2005 20:35:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 28 Apr 2005 12:36:03 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B25@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: "Conn Clark" <clark@esteem.com>
Cc: linuxppc-dev@ozlabs.org
Subject: RE : Booting linux for 405EP --> mem_pieces_find( ) nightmare
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

First of all tks everybody for your answers but I found a way to solve =
my problem.
I know it's not a very clean solution but it could help for people in =
emergency as me ...lol

In fact the problem had its roots much earlier.=20
I had to have a look in the file "arch/ppc/kernel/ppc_4xx_setup.c" in =
the platform_init() function.
I saw that the residual structure given traditionnaly by the bootloader =
is retreived there as below:

        /*
	 * If we were passed in a board information, copy it into the
	 * residual data area.
	 */
	if (r3) {
		memcpy((void *) __res, (void *) (r3 + KERNELBASE),sizeof (bd_t));
	}=20

This variable "__res" is used after that in several actions. In my case, =
that was directly linked to my mapping problem cause=20
the kernel wasn't able to get the quantity of ram available. In ordr to =
do that, it uses the following function in my case:

ppc4xx_find_end_of_memory(void)
{
    bd_t *bip =3D (bd_t *) __res;
    return ((unsigned long) bip->bi_memsize);
}

So the return of this function was incoherent and drove me to a kernel =
panic.

As a conclusion I just defined my own board info structure in the =
platform_init() function:

  bd_t my_bd_t;
 =20
  strcpy(my_bd_t.bi_s_version,"v1");                  /*  Version of =
this structure   */
  strcpy(my_bd_t.bi_r_version,"bootrom linux 1.0") ;  /*  Version of the =
IBM ROM      */
  my_bd_t.bi_memsize      =3D 16000000 ;                /* DRAM =
installed, in bytes     */
  my_bd_t.bi_enetaddr[0][0] =3D 0x00;                   /* Local =
Ethernet MAC address 1 */
  my_bd_t.bi_enetaddr[0][1] =3D 0x01;
  my_bd_t.bi_enetaddr[0][2] =3D 0x73;
  my_bd_t.bi_enetaddr[0][3] =3D 0x01;
  my_bd_t.bi_enetaddr[0][4] =3D 0xC1;
  my_bd_t.bi_enetaddr[0][5] =3D 0x3B;
  my_bd_t.bi_enetaddr[1][0] =3D 0x00;                   /* Local =
Ethernet MAC address 2 */
  my_bd_t.bi_enetaddr[1][1] =3D 0x01;
  my_bd_t.bi_enetaddr[1][2] =3D 0x73;
  my_bd_t.bi_enetaddr[1][3] =3D 0x01;
  my_bd_t.bi_enetaddr[1][4] =3D 0xC1;
  my_bd_t.bi_enetaddr[1][5] =3D 0x3C;
  my_bd_t.bi_intfreq      =3D 200000000 ;     /* Processor speed, in Hz  =
     */
  my_bd_t.bi_busfreq      =3D 100000000 ;     /* PLB Bus speed, in Hz    =
     */
  my_bd_t.bi_pllouta_freq =3D 800000000 ;     /* PLL OUTA speed, in Hz   =
     */
  my_bd_t.bi_opb_busfreq  =3D 50000000 ;      /* OPB Bus speed, in Hz    =
     */
  my_bd_t.bi_iic_fast[0]  =3D 0 ;             /* Use fast i2c mode       =
     */  =20

  memcpy((void *) __res, (void *) &my_bd_t,sizeof (bd_t));    =20


  And here we go!
  I know that this is a terrible hack but I haven't find better =
solution.

  Regards, J=E9r=E9mie

-------- Message d'origine--------
De: Conn Clark [mailto:clark@esteem.com]
Date: mer. 27/04/2005 11:21
=C0: Garcia J=E9r=E9mie
Cc: linuxppc-dev@ozlabs.org
Objet : Re: Booting linux for 405EP --> mem_pieces_find( ) nightmare
=20
Hi J=E9r=E9mie,

/
Garcia J=E9r=E9mie wrote:
> Hi everybody,
> I'm tryin to adapt a linux LSP deom Montavista (the one for the 405EP =
evaluation board) to a proprietary hardware using a 405EP.
> Unfortunately, it is not as easy as I thought. Here is my problem:
> To load our linux image (zImage.treeboot), we use the "VxWorks =
bootrom" bootloader which download the image via tftp.
> That works well except the fact that in the LSP, linux tried to get a =
board info structure in flash memory at an address where we have =
nothing. So we replace this behavior in "embed_config.c" with the =
following lines (note: I had to re-code the strcpy although there is the =
#include<string.h> because it cannot find the reference at the link =
level... why???):
>=20

I would recomend using u-boot for a boot rom. It was a god send to us in =

getting our MPC850 board up and going the first time. On our 405EP board =

we did have to do some slight hacking but nothing really major.


> /* We use VxWorks bootrom, so we have to create ourselves the boot =
info structure */

<snip>


> J=E9r=E9mie        \\ (=B0.=B0) //~ ~ ~ HELP ~ ~ ~ \\ (=B0.=B0) //
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20

-- Conn

*****************************************************************
Blessed be the heretic, for he causes some to think and unites
the rest against him.
*****************************************************************

Conn Clark
Engineering Assistant                clark@esteem.com
Electronic Systems Technology Inc.        www.esteem.com

Stock Ticker Symbol                ELST
