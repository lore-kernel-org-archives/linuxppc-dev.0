Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id E31E11A0AB1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 06:15:32 +1000 (EST)
Message-ID: <542F03CF.8010900@c-s.fr>
Date: Fri, 03 Oct 2014 22:15:11 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
References: <20141003125609.5BEA11AB276@localhost.localdomain>
 <20141003144420.GC24441@sirena.org.uk>
In-Reply-To: <20141003144420.GC24441@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 03/10/2014 16:44, Mark Brown a écrit :
> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:
>
>> +config CPM1_RELOCSPI
>> +	bool "Dynamic SPI relocation"
>> +	default n
>> +	help
>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocated
>> +	  without micropatch. This activates relocation to a dynamically
>> +	  allocated area in the CPM Dual port RAM.
>> +	  When combined with SPI relocation patch (for older MPC8xx) it avoids
>> +	  the "loss" of additional Dual port RAM space just above the patch,
>> +	  which might be needed for example when using the CPM QMC.
> Something like this shouldn't be a compile time option.  Either it
> should be unconditional or it should be triggered in some system
> specific manner (from DT, from knowing about other users or similar).
Can't be unconditional as older versions of mpc8xx (eg MPC860) don't 
support relocation without a micropatch.
I have therefore submitted a v2 based on a DTS compatible property.

---
Ce courrier électronique ne contient aucun virus ou logiciel malveillant parce que la protection avast! Antivirus est active.
http://www.avast.com
