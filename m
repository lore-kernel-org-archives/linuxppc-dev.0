Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 062D8B7B94
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 03:52:40 +1100 (EST)
Date: Thu, 5 Nov 2009 10:53:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/7] powerpc/85xx: Add power management support for
	MPC85xxMDS boards
Message-ID: <20091105165301.GC1667@loki.buserror.net>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214359.GE24821@oksana.dev.rtsoft.ru>
	<197B3989-3373-4172-B5FA-727CA1EEE2AA@kernel.crashing.org>
	<20091105140407.GA16698@oksana.dev.rtsoft.ru>
	<39FA5DC3-BE71-442B-9EDC-2764D1391074@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39FA5DC3-BE71-442B-9EDC-2764D1391074@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 08:06:51AM -0600, Kumar Gala wrote:
>
> On Nov 5, 2009, at 8:04 AM, Anton Vorontsov wrote:
>
>> On Thu, Nov 05, 2009 at 07:58:49AM -0600, Kumar Gala wrote:
>> [...]
>>> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
>>> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
>>> @@ -40,6 +40,8 @@
>>> 			i-cache-line-size = <32>;	// 32 bytes
>>> 			d-cache-size = <0x8000>;		// L1, 32K
>>> 			i-cache-size = <0x8000>;		// L1, 32K
>>> +			sleep = <&pmc 0x00008000	// core
>>> +				 &pmc 0x00004000>;	// timebase
>>>
>>> Just so I'm clear this is the devdisr bit position?
>>
>> Yep, as described in the bindings.
>
> I don't think the binding is clear that for 85xx these are DEVDISR bit  
> positions for the given SoC.

>From dts-bindings/fsl/pmc.txt:

  fsl,mpc8548-pmc: Sleep specifiers consist of one or two cells, the
  first of which will be ORed into DEVDISR (and the second into
  DEVDISR2, if present -- this cell should be zero or absent if the
  hardware does not have DEVDISR2) upon a request for permanent device
  disabling.  This sleep controller does not support configuring devices
  to disable during system sleep (unless supported by another compatible
  match), or dynamically.

-Scott
