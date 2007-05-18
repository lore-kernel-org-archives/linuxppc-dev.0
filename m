Return-Path: <dragos.carp@toptica.com>
Received: from hypercube.tuioptics.com (gateway.tuioptics.com [213.183.22.85])
	by ozlabs.org (Postfix) with ESMTP id DFDEADDE39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 May 2007 18:14:58 +1000 (EST)
Message-ID: <464D5951.7070602@toptica.com>
Date: Fri, 18 May 2007 09:44:17 +0200
From: Dragos Carp <dragos.carp@toptica.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
References: <20070516073707.GD9667@nd47.coderock.org>
	<464ABE97.7090603@246tNt.com>
	<200705160911.55867.david-b@pacbell.net>
	<464B329E.8030600@246tNt.com>
In-Reply-To: <464B329E.8030600@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	Domen Puncer <domen@coderock.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:
> David Brownell wrote:
>   
>> On Wednesday 16 May 2007, Sylvain Munaut wrote:
>>   
>>     
>>> Well, this comment is not about the patch but about the driver it self,
>>> I didn't see it before today.
>>>     
>>>       
>> It merged earlier in the 2.6.22 cycle.  If you don't have criticisms
>> about the patch itself, I'll forward it for merging after I get at
>> least an ack from Dragos.
>>   
>>     
> Yes, I saw when looking at the spi-devl archive. Would have been nice if the
> author though of cc-ing the ppc-embedded list ;)
>
>   
Sorry about not cc-ing ppc-embedded, this was my first kernel patch, I'm 
not very familiar with the submitting process.
> The patch looks ok to me (and needed actually since as Domen pointed
> out, 52xx
> has been replaced by 5200 in the device tree).
> And cell-index has been added to know the psc id without dirty tricks.
>
>   
The patch looks ok. I'm currently still using 2.6.20 which still has 
52xx. I compiled it for 2.6.22-rc2 and of course this problem was not 
caught by the compiler. Unfortunately for the board that I'm using 
(MPC5200-tiny from Pythec),  there is no adaptation yet for  2.6.21.
>>>  - MPC52xx_PA(MPC52xx_PSCx_OFFSET(...)) ??? You should get that from the
>>> resource of the platform_device. This macro is just there for early
>>> console stuff.
>>>     
>>>       
>> That PPC_MERGE stuff does look messy.
>>   
>>     
> Yes, trying to support both in a driver is really not pretty.
> Once we can finally get rid of it I'll submit a patch to clear that out.
>
>   
A clean up for PPC_MERGE will be nice. There are still some magic 
numbers used in the driver (SICR_SIM_CODEC8, SICR_GENCLK, etc..) that 
should be defined in mpc52xx_psc.h.

Dragos
