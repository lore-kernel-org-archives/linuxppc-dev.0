Return-Path: <john.bonesio@xilinx.com>
Received: from outbound9-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7C8BFDE2A3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 01:50:50 +1000 (EST)
Subject: Re: May I ask some questions?
From: John Bonesio <john.bonesio@xilinx.com>
To: Sergey Temerkhanov <temerkhanov@yandex.ru>
In-Reply-To: <483E555C.9050703@yandex.ru>
References: <12692943.1528961211977480208.JavaMail.coremail@bj163app110.163.com>
	<483E555C.9050703@yandex.ru>
Content-Type: text/plain
Date: Thu, 29 May 2008 08:50:40 -0700
Mime-Version: 1.0
Message-Id: <20080529155042.50AC8690091@mail4-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, vencent2006 <vencent2006@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

xparameters.h will #include the other xparameters_mlxxx.h file. When
using XPS in the EDK, you can use the 'software platforms settings'
dialog box to specify the peripherals to use, the size of memory to use,
and other parameters.  When this is done, you can select 'generate
libraries and bsps' which will generate an xparameters_mlxxx.h file,
where xxx is a board number. e.g. xparameters_ml40x.h, or
xparameters_ml507.h

The generated xparameters_mlxxx.h file will include the XPAR_xxx values
you need.

- John

> > I wanna ask u to point out what causes this problem.
> > There is another question about "xparameters.h" and
> > "xparameters_ml300.h". When I have generated BSP, there are two 
> > "xparameters.h" files in project which
> > have the same name while different size(eg: one is 22k ,the other is 
> > 4k). Which one is the proper?
> > And when I add "xparameters.h" and "xparameters_ml300.h" to the 
> > kernel, some compiling
> > error occurs.
> > eg:
> > arch/ppc/syslib/virtex_devices.c:116: error: 
> > 'XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared here (not in a function)
> > arch/ppc/syslib/virtex_devices.c:119: error: 
> > 'XPAR_UARTNS550_1_CLOCK_FREQ_HZ' undeclared here (not in a function)
> > I don't understand where to define them and whether i need them or not.
> > my eldk is:eldk/4.2/ppc-linux-x86
> > using Xilinx EDK/ISE 9.1
> > Linux 2.6.24
> These macros must be defined in xparameters_ml300.h. You need them as 
> they define base frequency for UARTNS550 and proper configuration of 
> baud rates depends on it


________________________________________________________________________

John Bonesio
Commercial Linux Solutions
john.bonesio@xilinx.com
(408) 879-5569

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
