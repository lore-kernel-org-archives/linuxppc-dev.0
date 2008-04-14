Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound10-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CE1C4DE17A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Apr 2008 03:35:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problems of using APU/FPU under linux
Date: Mon, 14 Apr 2008 10:35:24 -0700
In-reply-to: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
References: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Shanyuan Gao" <sygao.research@gmail.com>, <linuxppc-embedded@ozlabs.org>,
	"git" <git@xilinx.com>
Message-Id: <20080414173525.2CB1250061@mail214-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm not sure exactly what's going on here.  Generally speaking, if you
have the FPU instantiated in the design and enable the APU in the msr,
then the processor should decode FP instructions and send them directly
to the APU with no trap.  I haven't done this myself, or I could
probably give you some better help...

One thing you should be aware of is that the there are gcc compiler
patches which are necessary to get the FPU working properly.  However, I
don't think the failure mode that these patches workaround would cause a
trap, so my guess is that there is still something else wrong.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Shanyuan
Gao
> Sent: Monday, April 14, 2008 9:18 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Problems of using APU/FPU under linux
>=20
> Hi,
>=20
> Recently I was trying to make APU/FPU working under Linux on Xilinx
> ML410. The standalone programs work perfectly. However under Linux,
> when I try to use a floating point operation, like *fmuls*, it will
> give me a *trap*.
>=20
> By studying the user guide from Xilinx and dumping the object files,
> I know I need to change the corresponding bits (APU enable, FP
> enable, maybe APU Exception enable) in Machine State Register. I
> guess I need to enable the bits whenever before the kernel uses
> *mtmsr*. However, it doesn't work. I got the same trap with the same
> MSR, as I had no APU/FPU before. I also tried to add the FPU.S to ppc
> tree, but it doesn't work either.
>=20
> The questions are
> 1. I guess there might be some place that changed MSR after all my
> changes. But I don't know where. And can I write a kernel module to
> change the MSR after booting in Linux? (well, it's hard for me though)
>=20
> 2. Does it have any exception/interrupt mechanism to direct FP
> operation to APU/FPU? Or after enabling APU/FPU it will mask the
> exception/interrupt and decode FP operation by itself?
>=20
>=20
> Any ideas are appreciated. Thank you very much!
>=20
>=20
> Shan
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
