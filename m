Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7EAA467A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 03:27:06 +1000 (EST)
In-Reply-To: <424ACFF1.5000403@bitsim.se>
References: <424ACFF1.5000403@bitsim.se>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <111d2ae873d1bfee413409dfc4f2f064@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 30 Mar 2005 11:26:55 -0600
To: "Jakob Viketoft" <jakob.viketoft@bitsim.se>
Cc: Jon Masters <jonathan@jonmasters.org>, Sylvain Munaut <tnt@246tNt.com>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform bus/ppc sys model...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> My intention was to give a device tree structure to the kernel at boot
> time via a (pseudo?) pointer in bd_info or similar. Then you would only
>  need to recompile a little bootloader (which is needed for setting up
> the FPGA anyway) with this structure for every specific card. You could
> even be shrewd enough to have a single kernel image but several
> structures to launch several processors on the same chip. Does it sound
> like a sane solution?

I think this is reasonable.  The best device tree would be a flattened 
OF tree since we are trying to move the world in that direction.  Jon 
Masters around?

> Otherwise, I'm a bit unsure as to whether a system with a gigantic list
> of devices in ???_devices.c is the right way to go. In the Xilinx case,
> not only is a list of possible IP:s needed, but also the usual standard
>  circuits which can be connected from outside to the chip. Wouldn't it 
> be
> more realistic to have knowledge of the compiled in drivers somehow?

Your needs are a bit different than the initial purpose of ppc_sys.  
The reason the device list works well for us today is that it replaced 
duplication between every variant of 85xx.

I'm not that familiar with exactly what information you would need to 
have access to in the Xilinx case.  I would think if you information 
compiled into drivers some of this might all be moot.  Part of the 
whole device model is to have drivers that are agnostic of the system 
they are in.

- kumar
