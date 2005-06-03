Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id AD4BA679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 16:13:05 +1000 (EST)
In-Reply-To: <429F30D7.2040806@ru.mvista.com>
References: <429F30D7.2040806@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <81bbf71b42314c9168681be6ef2725e1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 3 Jun 2005 01:13:02 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] PlatformDevice definitions for 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 2, 2005, at 11:16 AM, Vitaly Bordug wrote:

> Hi!
> This adds platform definition files for 82xx, while the platform_info 
> is
> filled in board-specific .C file residing in platforms/82xx. Another
> disputable thing I did - I moved m8260_setup.c from the syslib/ up to
> platforms/82xx/. The file was slightly changed  - added 2 prototypes
> from the cpm2_pic.h and removed the respective include.

Why the move of m8260_setup.c?  Also, if this is required can we do 
this as two different patches so we can see clearly any changes also 
maded to m8260_setup.c

mpc82xx_devices.c need a bit of work we need to at least cover the same 
set of devices that 85xx does for the CPM:
	SPI, I2C, USB, SCC1-4, FCC1-3, MCC1-2, SMC1-2

Additionally, the device name can not me FS_ENET_NAME, which assumes 
that FCC is only used for enet.

mpc82xx_sys.c: what is the .value field?  is this the IMMR and if so 
why bother shifting it?  Also there are a whole bunch of variants that 
need to be captured

Let's get clean versions of these two files before we worry about how 
to handle FCC enet specific bits.

- kumar
