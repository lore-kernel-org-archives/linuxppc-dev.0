Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4921BDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 03:53:11 +1100 (EST)
Subject: Re: Trouble moving custom MPC8548 board to U-boot 1.3
From: Jon Loeliger <jdl@freescale.com>
To: Pieter <phenning@vastech.co.za>
In-Reply-To: <49635C62.5090307@vastech.co.za>
References: <49635C62.5090307@vastech.co.za>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 10:52:48 -0600
Message-Id: <1231260769.21398.5.camel@ld0161-tx32>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-01-06 at 15:28 +0200, Pieter wrote:
> Hi all,
> 
> I have spent quite some time trying to move from U-Boot 1.2 to a newer
> version.. I am stuck at the initialization of the ram. The ram checksum
> fails and gives me a "total memory of 0". (the board has 512MB and work
> when booting uboot 1.2)
> 
> can anyone pls. point me in the right direction?
> 
> My console output is as follows:
> 
>     U-Boot 2008.10-00334-g90665e3-dirty-svn1154 (Jan  6 2009 -
>     13:40:47)           
>                                                                                    
> 
>     CPU:   8548E, Version: 1.1,
>     (0x80390011)                                       
>     Core:  E500, Version: 1.0,
>     (0x80210010)                                        
>     Clock
>     Configuration:                                                           
> 
>            CPU:990  MHz, CCB:396 
>     MHz,                                             
>            DDR:198  MHz (396 MT/s data rate), LBC:49.500
>     MHz                       
>     L1:    D-cache 32 kB
>     enabled                                                   
>            I-cache 32 kB
>     enabled                                                   
>     Board: Equus
>     MPC8548                                                           
>         PCI1: 64 bit, 66 MHz,
>     sync                                                 
>     I2C:  
>     ready                                                                   
> 
>     DRAM: 
>     Initializing                                                            
> 
>     fsl_ddr_sdram                                                                  
> 
>     starting at step 1
>     (STEP_GET_SPD)                                              
>     SPD checksum unexpected. Checksum in SPD = 27, computed SPD =
>     74               
>     DIMM 0: failed

This is your root cause:  Unable to get the SPD information
for the DDR DIMM in slot 0 of controller 0.

What part are you using?  Does it support SPD?
Is your I2C to it hooked up correctly?
Can you dump the SPD information that is read?
Does it match the part specs?

HTH,
jdl
