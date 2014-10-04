Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id C84241A02F5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 20:15:47 +1000 (EST)
Message-ID: <542FC8C1.1000707@c-s.fr>
Date: Sat, 04 Oct 2014 12:15:29 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
References: <20141003125609.5BEA11AB276@localhost.localdomain>	
 <20141003144420.GC24441@sirena.org.uk> <542F03CF.8010900@c-s.fr>
 <1412367858.13320.432.camel@snotra.buserror.net>
In-Reply-To: <1412367858.13320.432.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 03/10/2014 22:24, Scott Wood a écrit :
> On Fri, 2014-10-03 at 22:15 +0200, christophe leroy wrote:
>> Le 03/10/2014 16:44, Mark Brown a écrit :
>>> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:
>>>
>>>> +config CPM1_RELOCSPI
>>>> +	bool "Dynamic SPI relocation"
>>>> +	default n
>>>> +	help
>>>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocated
>>>> +	  without micropatch. This activates relocation to a dynamically
>>>> +	  allocated area in the CPM Dual port RAM.
>>>> +	  When combined with SPI relocation patch (for older MPC8xx) it avoids
>>>> +	  the "loss" of additional Dual port RAM space just above the patch,
>>>> +	  which might be needed for example when using the CPM QMC.
>>> Something like this shouldn't be a compile time option.  Either it
>>> should be unconditional or it should be triggered in some system
>>> specific manner (from DT, from knowing about other users or similar).
>> Can't be unconditional as older versions of mpc8xx (eg MPC860) don't
>> support relocation without a micropatch.
>> I have therefore submitted a v2 based on a DTS compatible property.
> So the device tree change is about whether relocation is supported, not
> whether it is required?
Indeed no, my intension is to say that relocation is requested. Do you 
mean that it should then not use a compatible ?
> Is this specific to SPI or does the relocation
> mechanism work for other things?
Relocation is the same for I2C.

It is also possible to relocate SMC1 and SMC2 parameter RAM but only 
with a micropatch.
Today, the kernel only implements relocation of SMC1, and it relocates 
it at a fixed address just after SMC2 at offset 0x1FC0.
>
> How about checking for the existing specific-SoC compatibles?
What do you mean ?

Christophe

---
Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
http://www.avast.com
