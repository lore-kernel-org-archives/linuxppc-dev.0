Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1047267A72
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Feb 2005 04:21:02 +1100 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Sun, 27 Feb 2005 18:20:44 +0100
References: <200502262328.24165.niklaus.giger@member.fsf.org>
	<200502271610.30615.niklaus.giger@member.fsf.org>
	<20050227090851.B11020@cox.net>
In-Reply-To: <20050227090851.B11020@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502271820.45081.niklaus.giger@member.fsf.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problems porting to a custom PPC405GPr board using a vanilla
	2.6.10 kernel
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Sonntag, 27. Februar 2005 17.08 schrieb Matt Porter:
> On Sun, Feb 27, 2005 at 04:10:30PM +0100, Niklaus Giger wrote:
> > Am Samstag, 26. Februar 2005 23.28 schrieb Niklaus Giger:
> > > Hi
> > >
> > > I would like to port Linux to a custom PPC405GPr board. Its hardware
> > > runs vxWorks fine for more than a year.
> >
> > I made some more progress. After adding 3 lines for MMU support with the
> > BDI I can debug the startup up to kernel_start using BDI.
> >
> > Afterwards my console changes the baudrate for still unknown reasons.
> How do you know this? Console isn't initialized until after the kernel
> command line printk and a few other facilities are initialized.
Because I see the following output
arch: exit
*=CB=AB=E3=BE=B5=BA=B3=B9=BF=BE=B6=B9=B3=BC=B1=B5=B3=A0=B6=B7=BE=B7=B9=B7=
=B5=B2=B4=B9=B6=B4=BE=B3=BF=BA=B7=B7=B3=B3=A6=B5=B2=BB=B9=BF=BE=A4=B5=B2=B9=
=B1=BE=A3=B5=BE=A6=B5=B2=A3=A5=A4=A2=BD=B9=BC
=B4=BA=B7=BE=B5=BC=B9=B3=BC=B3=A3=B5=B2=BE=B5=BC=B3=B7=BD=BD=B1=BE=B4=BC=B1=
=BE=B5=B3=B7=BE=BB=BF=BC=B5=B4=BC=B9=AB=B1=B0=A0=A1=A4=B8=B1=B3=B8=BC=B1=B2=
=BC=B5=B5=BE=BC=B2=B1=B5=BB=B7=B2=B4=B5=B2=B2=B9=B4=B5=B3  =20
which for me is typical for a wrong baudrate.=20
Okay, I do not know this. Specially it may not be the "console" device but=
=20
whatever is going out at this moment via the PPC405GPr internal UART0 devic=
e.
> > Analysing the __log_buf I get the following output
> > (gdb) x/s &__log_buf
> > 0xc01accfc <ratelimit_lock.9>:   "<4>Linux version 2.6.10
> > (niklaus@ng.ngiger.dyndns.org) (gcc-Version 3.3.5 (Debian 1:3.3.5-8)) #=
15
> > Sun Feb 27 14:44:27 CET 2005\n<7>On node 0 totalpages: 8240\n<7>  DMA
> > zone: 8240 pages, LIFO batch:2\n<7>"...
> > (gdb) x
> > 0xc01acdc4 <ratelimit_lock.9+200>:       "  Normal zone: 0 pages, LIFO
> > batch:1\n<7>  HighMem zone: 0 pages, LIFO batch:1\n<4>Built 1
> > zonelists\n<4>Kernel command line: ip=3D172.25.1.6\n<4>PID hash table
> > entries: 256 (order:8, 4096 bytes)\n"
> > (gdb) x
> > 0xc01ace84 <ratelimit_lock.9+392>:       ""
>
> Is this all of the log_buf output? Try setting your kernel cmdline
> with "console=3DttyS0,115200" where 115200 is you console baudrate
> you are using in U-Boot. Otherwise, the kernel 8250 driver has no
> idea which baudrate to set for the 8250/console.
Yes, this is all. I tried you suggestion, but I got no other result. The=20
paramter "console=3DttyS0,9600" now is found in the log buffer. Or is ttyS0=
 the=20
wrong device name for the internal PPC405Gpr UART0?
I am using 9600 8 bit no parity which should be anyway the default baudrate=
=20
for the console.

Thanks for your help
=2D-=20
Niklaus Giger
Wieshoschet 6
CH-8753 Mollis
Tel. ++41 55 612 20 54 (privat)
Tel. ++41 55 618 64 68 (Gesch=E4ft)
