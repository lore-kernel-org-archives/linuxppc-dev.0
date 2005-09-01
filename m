Return-Path: <TNghiem@oerlikon.ca>
Received: from mail.oerlikon.ca (mx.oerlikon.ca [205.233.198.228])
	by ozlabs.org (Postfix) with ESMTP id 0D21067F88
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2005 00:52:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 1 Sep 2005 10:40:51 -0400
Message-ID: <A93DEE5BF142D6419D27C298B6F463D812CCF5@mail.oerlikon.ca>
From: "Nghiem, Tien" <TNghiem@oerlikon.ca>
To: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>,
	"Marcin Dawidowicz" <marcin.dawidowicz@kontron.pl>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: RE : Error while accessing physical address
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Garcia,

unsigned short is 2 bytes, so you should use:

regHdwAddress =3D (unsigned short *) ioremap((unsigned =
short)address,0x2);

Tien
-----Original Message-----
From: linuxppc-dev-bounces@ozlabs.org
[mailto:linuxppc-dev-bounces@ozlabs.org]On Behalf Of Garcia J=E9r=E9mie
Sent: Thursday, September 01, 2005 10:20 AM
To: Marcin Dawidowicz
Cc: linuxppc-dev@ozlabs.org
Subject: RE : Error while accessing physical address


Tks for your answer Marcin. This is a good idea but unfortunately,=20
the result remains the same...
When using "ioremap", do I need need to use inb/oub... family to=20
handle those remapped address??


-------- Message d'origine--------
De: Marcin Dawidowicz [mailto:marcin.dawidowicz@kontron.pl]
Date: jeu. 01/09/2005 16:11
=C0: Garcia J=E9r=E9mie
Objet : Re: Error while accessing physical address
=20
Maybe you could try to change this:
>   regHdwAddress =3D (unsigned short *) ioremap((unsigned =
short)address,0x1);
into this:
regHdwAddress =3D (unsigned short *) ioremap((unsigned =
short)address,sizeof=20
(unsigned short));

Cause you are accessing unsigned short register later.... and "unsigned =
short"=20
I assume is 2 bytes long.

Marcin


On Thursday 01 of September 2005 15:44, you wrote:
> Hi everybody.
>
> As a kernel newbie, I still encounter basic problems. I read a lot of
> things on the memory management, but obviously I didn't understand =
some
> things.
>
> I have some kernel source code that only write data to our card =
registers:
>
> void bhWriteCardRegister(unsigned short * address, unsigned short =
data)
> {
>   unsigned short * regHdwAddress;
>
>   printk("Writing data: %x at address:%x\n",data,address);
>
>   /* Get the virtual address for the physical one */
>   regHdwAddress =3D (unsigned short *) ioremap((unsigned =
short)address,0x1);
>
>   printk("ioremap returned : %x\n",regHdwAddress);
>
>   /* write hardware register data value */
>   *regHdwAddress =3D data;
>
>   iounmap((void *)regHdwAddress);
> }
> <<<<<<<<
>
> In a module init I call this function:
>
> #define CARD_PROCESSOR_CTRL_IN_SERVICE    0x8000
> #define CARD_PROCESSOR_CTRL_REG_P 0x40000400
> bhWriteCardRegister((unsigned short *)(CARD_PROCESSOR_CTRL_REG_P),
> (unsigned short)CARD_PROCESSOR_CTRL_IN_SERVICE); <<<<<<<<
>
> When I load this module on our powerPC 405EP based arch, the execution
> gives that:
>
> Writing data: 8000 at address:40000400
> ioremap returned : c2090400
> <<<<<<<<
>
> The problem is that after this write operation, every shell cmd I try =
give
> a "segmentation fault". What I did wrong ??
>
> Please help me cause I have to go on fast... (tks boss...)
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
