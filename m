Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F13FE679EF
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Mar 2006 14:13:30 +1100 (EST)
In-Reply-To: <18AEF66AFDF06F4CAAA1D419D000FD332ECDEA@az33exm24.fsl.freescale.net>
References: <18AEF66AFDF06F4CAAA1D419D000FD332ECDEA@az33exm24.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <71C14F4B-B668-4B7A-9D2F-9F91EC3BA603@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix MPC8548CDS rebooting procedure
Date: Wed, 8 Mar 2006 21:13:45 -0600
To: Haruki Dai-r35557 <Dai.Haruki@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 8, 2006, at 1:24 PM, Haruki Dai-r35557 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Wednesday, March 08, 2006 12:33 PM
>> To: Haruki Dai-r35557
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH] Fix MPC8548CDS rebooting procedure
>>
>>
>> On Mar 8, 2006, at 11:22 AM, Haruki Dai-r35557 wrote:
>>
>>> This patch fixes the MPC8548 CDS rebooting procedure.
>>> Without this patche, issuing reboot from shell doesn't reboot the
>>> machine.
>>>
>>> Signed-off-by: Dai Haruki <dai.haruki@freescale.com>
>>
>> Dai, I'm avoid taking patches for 85xx that effect new
>> functionality.  If you want change this to work with
>> arch/powerpc and make it a run time check for 8548.
>
> Hi Kumar, what kind of new feature is affected by this bug fix? 8548
> requires reboot to set the hardware reset bits. The mpc85xx_restart 
> () is
> not ported to arch/powerpc yet. Which portion of the arch/powerpc code
> should be modified in order to restart the machine correctly?
> And how do you want me to do run time check? Check SVR?

Restart has never worked properly on the 85xx boards from freescale  
since they never provided a reasonable way to reset the systems in  
software.  So I consider this new functionality at this point.

The powerpc.git tree has an arch/powerpc/platforms/85xx/misc.c that  
has a mpc85xx_restart() in it.

As for run time checking, yes use something like SVR or PVR to  
determine the feature.  In this case its probably best to using  
something like PVR and check for E500r1.  I imagine 8540, 8541, 8555,  
8560 don't support this feature (all e500r1), but all future 8548 and  
newer parts will (e500r2, etc.)

- kumar
