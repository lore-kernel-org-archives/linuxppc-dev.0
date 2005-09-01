Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 90BC46814D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2005 23:44:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 1 Sep 2005 15:44:23 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B55@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Error while accessing physical address
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody.

As a kernel newbie, I still encounter basic problems. I read a lot of =
things on the memory management,
but obviously I didn't understand some things.

I have some kernel source code that only write data to our card =
registers:
>>>>>>>
void bhWriteCardRegister(unsigned short * address, unsigned short data)
{
  unsigned short * regHdwAddress;

  printk("Writing data: %x at address:%x\n",data,address);

  /* Get the virtual address for the physical one */
  regHdwAddress =3D (unsigned short *) ioremap((unsigned =
short)address,0x1);

  printk("ioremap returned : %x\n",regHdwAddress);
 =20
  /* write hardware register data value */=20
  *regHdwAddress =3D data;
 =20
  iounmap((void *)regHdwAddress);
}
<<<<<<<<

In a module init I call this function:
>>>>>>>>
#define CARD_PROCESSOR_CTRL_IN_SERVICE    0x8000
#define CARD_PROCESSOR_CTRL_REG_P 0x40000400
bhWriteCardRegister((unsigned short *)(CARD_PROCESSOR_CTRL_REG_P), =
(unsigned short)CARD_PROCESSOR_CTRL_IN_SERVICE);
<<<<<<<<

When I load this module on our powerPC 405EP based arch, the execution =
gives that:
>>>>>>>>
Writing data: 8000 at address:40000400
ioremap returned : c2090400
<<<<<<<<

The problem is that after this write operation, every shell cmd I try =
give a "segmentation fault".
What I did wrong ??

Please help me cause I have to go on fast... (tks boss...)
