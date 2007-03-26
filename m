Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 49301DDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 04:32:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Reading and writing from/to VME device
Date: Mon, 26 Mar 2007 11:31:56 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE48710888A6FA@VCAEXCH01.hq.corp.viasat.com>
In-reply-to: <929bf310703260814q18957942s218d56bed8fb4009@mail.gmail.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Konstantin Boyanov" <kkboyanov@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I'm using the MVME6100 board with the Motorola driver for linux v3.5
(kernel 2.6.15).

I'm not sure what a "Linux v3.5" is - Montavista?  There are patches
available from Motorola to the vanila kernel if you're interested in
using something newer than 2.6.15.

> I try to access the CSR registers of an ADC board, in order to
configure it as to be
> able to access its memory, on the VME bus using one of the outbound
windows defined by
> the driver. As I am new to the whole VME stuff, I'm getting into
trouble to find out when
> I'm actually reading something on the VME, i.e. which addresses
respond.
> 1. open() and ioctl() one of the /dev/vme_m* devices, which I assume
is corresponding to
> an outbound window (at least I try to > configure it as one),=20
> 2. then mmap() a memory area to hold the contents of the /dev/vme_m*
device file
> 3. and finally doing incrementation of the pointer returned by mmap()
and dereferencing it in the hope that I'll read something, which in most
cases is 0xFF=20

This sounds like the right steps.  You don't appear to have the ioctl()
configuration structure set correctly.
=09
> memset(&outWinCfgADC, 0, sizeof(vmeOutWindowCfg_t));
>     perror("memset");
>	    outWinCfgADC.windowNbr           =3D 0;
>	    outWinCfgADC.windowEnable     =3D 1;
>	    outWinCfgADC.wrPostEnable      =3D 0;
>	    outWinCfgADC.userAccessType  =3D VME_SUPER;
>	    outWinCfgADC.dataAccessType  =3D VME_DATA;
>	    outWinCfgADC.windowSizeL        =3D 0x200000;
>	    outWinCfgADC.xferProtocol         =3D VME_SCT;
>	    outWinCfgADC.addrSpace           =3D VME_A24;
>	    outWinCfgADC.maxDataWidth     =3D VME_D16;
=09
This will setup a window of size 0x200000, type SingleCycleTransfer (vs.
BLT, 2eSST, etc), 24-bit addressing, 16-bit data.=09
The target VME address will be 0x00000000, since you didn't configure
the .xlatedAddrU or .xlatedAddrL portions of outWinCfgADC.  Typically,
the VME address space is partitioned by VME chassis slot number or some
other application-specific scheme.  I'm guessing that 0 is not an
address that any VME board in your chassis is configured to respond to,
hence your errors.

Also, since you're doing 16-bit SCT reads, you probably want to
dereference your mmap'ed pointer as a 16-bit (unsigned short *) instead
of a (u_char *).

Tim
