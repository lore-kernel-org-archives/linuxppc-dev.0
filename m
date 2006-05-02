Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id EAF3F67BDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 May 2006 14:10:08 +1000 (EST)
Received: by nproxy.gmail.com with SMTP id k27so1941269nfc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 01 May 2006 21:10:06 -0700 (PDT)
Message-ID: <528646bc0605012109q61f8e47ehe2f41216f86481a3@mail.gmail.com>
Date: Mon, 1 May 2006 22:09:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: yding <yding@lnxw.com>
Subject: Re: question about Linux 2.6 with Xilinx ML-403
In-Reply-To: <445696A9.5070200@lnxw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4436BD2B.9050306@lnxw.com>
	<528646bc0604071518i5f95b4dbtd232d8cb92ef4fb9@mail.gmail.com>
	<445696A9.5070200@lnxw.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/1/06, yding <yding@lnxw.com> wrote:
>  HI, Grant,
>
>  It looks like that the patch for ML-403 in Linux 2.6.17 kernel(I downloa=
ded
> from Linus git tree) does not have the directory :
> ./arch/ppc/platform/4xx/xilinx_ocp like the one in the
> 2.4.30 kernel.

That's right.  AFAIK, The 2.6 kernel is not yet supported by the
Xilinx EDK tools; and so it cannot generate a 2.6 BSP.  If you want to
use the generated BSP; use the montavista 2.4 kernel.

>  And also, I saw this thread: "Migrate Xilinx Vertex support from the OCP
> bus to the platfom bus"
>
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D3933
>  Does it mean all of onchip peripherals for Virtex-4 FX must reside on th=
e
> PLB bus instead of OPB (OCB) bus ?

No.  Platform bus is a Linux construct to make it simpler to handle
"directly attached" devices.  ie. Anything that the processor can
access directly w/o PCI et all.  OPB and PLB devices are both
'platform' devices in Linux 2.6 terminology.

>  (i.e. during the process of creating the ref design for Linux using Xili=
nx
> Platform studio, I have to select PLB peripherals instead of OPB
> peripherals. Is is correct ?)

No, use whatever peripherals you want (either PLB, or OPB).  Just be
prepared to port device drivers for anything beyond a serial port.

>
>  BTW, do you have a sample ref design for ML-403 board for Xilinx Platfor=
m
> studio ?

Why not use the ref design that Xilinx provides?  (I have a number of
designs that work; but most of the time I use the ML403 ref design
because I know it's proven)

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
