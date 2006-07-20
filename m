Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 403AB67B9F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 17:22:39 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k6K7Y4uO017126 for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 00:34:04 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k6K7MZb0021529
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 02:22:36 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: reboot on PQ2FADS board. 
Date: Thu, 20 Jul 2006 15:22:34 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635018C78@zch01exm21.fsl.freescale.net>
In-Reply-To: <20060719063317.86A66352681@atlas.denx.de>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Wolfgang Denk" <wd@denx.de>, "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This way maybe can not work. when the MMU turn off,=20
the next instructions maybe can not be fetched if these instructions
didn't exist cache.=20
so it is possible these instruction can not executed. =20

>=20
> Trying to jump to some boot rom address is IMHO always a bad=20
> approach to reboot a system. You should always try to cause a=20
> reset  condition for  the CPU, and thus for all the=20
> associated hardware. On 8xx / 8260 systems this is usually=20
> done by going through  a  machine  check.  We have  the =20
> following code in our linuxppc_2_4_devel tree, which works on=20
> ALL 8260 systems, no matter whioch boot loder they use:
>=20
> static void
> m8260_restart(char *cmd)
> {  =20
>         __volatile__ unsigned char dummy;
>         ulong msr;
>    =20
>         cli();
>         volatile immap_t *immap =3D (immap_t *) IMAP_ADDR;
>    =20
>         immap->im_clkrst.car_rmr =3D 1;    /* Checkstop Reset enable =
*/
>    =20
>         /* Interrupts and MMU off */
>         __asm__ __volatile__ ("mfmsr    %0":"=3Dr" (msr):);
>    =20
>         msr &=3D ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR);
>         __asm__ __volatile__ ("mtmsr    %0"::"r" (msr));=20
>    =20
Now the MMU trun off, is real address mode. But the PC still is
0xC00xxxx.. It is old effective address.

>         dummy =3D ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
These instructions will locate on the real address space...... It is
0xC00xxxx- KERNELBASE
>    =20
>         printk("Restart failed\n");
>         for (;;);
> }  =20
>=20
