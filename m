Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc2-s38.bay0.hotmail.com (bay0-omc2-s38.bay0.hotmail.com
	[65.54.246.174]) by ozlabs.org (Postfix) with ESMTP id 8FC2BDDF3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 17:50:53 +1000 (EST)
Message-ID: <BAY101-W3227AB825957D1D453830CBEB40@phx.gbl>
From: - Reyneke <reynekejunk@hotmail.com>
To: Stefan Roese <sr@denx.de>, <linuxppc-embedded@ozlabs.org>
Subject: RE: FP and signal 4
Date: Thu, 5 Jun 2008 07:50:51 +0000
In-Reply-To: <200806050659.30499.sr@denx.de>
References: <BAY101-W2A5F2B80B271BD10DE9BBBEB50@phx.gbl>
	<20080604213123.4e53f813@zod.rchland.ibm.com>
	<200806050659.30499.sr@denx.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Aaah - looks like that was it. Works OK now with CONFIG_MATH_EMULATION un-s=
et. For the record - cpu node looks as follows:



		cpu@0 {
			device_type =3D "cpu";
			model =3D "PowerPC,440EPx";
			reg =3D ;
			clock-frequency =3D ; /* Filled in by u-boot */
			timebase-frequency =3D ; /* Filled in by u-boot */
			i-cache-line-size =3D ;
			d-cache-line-size =3D ;
			i-cache-size =3D ;
			d-cache-size =3D ;
			dcr-controller;
			dcr-access-method =3D "native";
		};

Thanks for the help.


>
> On Thursday 05 June 2008, Josh Boyer wrote:
>>> Has anyone come across any floating point issues in the new powerpc
>>> kernel branch with regards to 44x? I'm seeing programs (i.e.
>>> init/busybox) generating signal 4 (illegal instruction) exceptions. If =
I
>>> compile a 2.6.25 kernel with the CONFIG_MATH_EMULATION option set, then
>>> everything works OK.
>>
>> I've not seen that.
>>
>>> Using a 440EPx (has a onchip FPU) with the ELDK 4.0 ppc_4xxFP toolchain
>>> for all apps/kernel/fs.
>>
>> 440EPx should get the FPU enabled at runtime. We use a virtual PVR to
>> do the APU/FPU init. What does your cpu node look like in your DTS
>> file for your board?
>
> And please use the dtc "-b 0" option for creating the dtb file. Without i=
t the
> virtual PVR setup doesn't work.
>
> Best regards,
> Stefan
>

_________________________________________________________________

http://clk.atdmt.com/UKM/go/msnnkmgl0010000007ukm/direct/01/=
