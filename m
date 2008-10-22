Return-Path: <Vejseli@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id 37DE0DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Oct 2008 23:10:16 +1100 (EST)
Received: from web.de
	by fmmailgate04.web.de (Postfix) with SMTP id E0F4A5F135CF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Oct 2008 14:10:13 +0200 (CEST)
Date: Wed, 22 Oct 2008 14:10:12 +0200
Message-Id: <1695261910@web.de>
MIME-Version: 1.0
From: Mirsad Vejseli <Vejseli@web.de>
To: linuxppc-embedded@ozlabs.org
Subject: virtex 4 linux driver bus error
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello at all,

at the moment I use development board ML410 with montavistalinux.=20

I have a problem, please help me!=20

I try to write a linux-driver for writing or reading registers.
I have a ace-file, which contents Linux and EDK-project with a component (=
IP-wizard) which is added on a PLB-bus.
I also have a driver-construct which I can register (insmod driver.ko) int=
o the linux-Kernel only if i do not use functions to write or read the bus=
 (XIO=5Fout32() or XIO=5Fin32 ()  ). If I use this function after registering =
the driver I got an error.
If I try to insert the modul with Insmod driver.ko I get a bus error! =20

my driver is similar to http://ozlabs.org/pipermail/linuxppc-embedded/2006=
-January/021578.html
=20

her the two importent functions  of the driver:

#define REG=5FBASE 	(u32) XPAR=5Fkomponente=5F0=5FBASEADDR // defined in xparamete=
rs=5Fml41x.h=20
#define REG=5FHIGH 	(u32) XPAR=5Fkomponente=5F0=5FHIGHADDR // defined in xparamete=
rs=5Fml41x.h=20


#define reg0=5Fupper	(u32) komponente=5FSLV=5FREG0=5FOFFSET // 32-bit register / d=
efined in komponente.h
#define reg1=5Fupper	(u32) komponente=5FSLV=5FREG1=5FOFFSET // 32-bit register / d=
efined in komponente.h
#define reg2=5Fupper	(u32) komponente=5FSLV=5FREG2=5FOFFSET // 32-bit register / d=
efined in komponente.h

const static long remap=5Fsize =3D REG=5FHIGH - REG=5FBASE + 1;

static void read=5Fregister=5Fvalues(void)
{
	static u32 upper;
=09

	printk("%s:\n",DRIVERNAME);
	printk("%s:                      |     upper         |\n",DRIVERNAME);
	printk("%s:----------------------|-------------------|\n",DRIVERNAME);
=09
	upper =3D XIo=5FIn32(reg=5Fremapped=5Faddress + reg1=5Fupper);

    printk("%s: Daten im Register 35 |%15X |\n", DRIVERNAME, upper );
=09
}


static int =5F=5Finit meintreiber=5Finit(void)   =20
reg=5Fremapped=5Faddress =3D (u32) ioremap(REG=5FBASE, remap=5Fsize);
  =20
    rtn =3D misc=5Fregister(&miscdev);
    if (rtn)=20
    {
		printk("%s: %s error driver not reg. \n",DRIVERNAME, miscdev.name);
        return rtn;
    }

	read2=5Fregister=5Fvalues();
=09
in the messeges log file i got the 3 printk lins and this line=20
"upper =3D XIo=5FIn32(reg=5Fremapped=5Faddress + reg1=5Fupper);"
creates a error

=20


Thank you very much for your kind help!=20
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Schon geh=F6rt=3F Bei WEB.DE gibt' s viele kostenlose Spiele:
http://games.entertainment.web.de/de/entertainment/games/free/index.html
