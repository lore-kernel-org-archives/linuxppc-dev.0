Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 001E9DDFD6
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 01:34:48 +1000 (EST)
Message-ID: <48626588.8050202@freescale.com>
Date: Wed, 25 Jun 2008 10:34:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating point	registers
	in thread_struct.
References: <20080625040718.028B470296@localhost.localdomain>
	<F09034D9-1B3C-4087-B6DF-FAB7B3AFA191@kernel.crashing.org>
In-Reply-To: <F09034D9-1B3C-4087-B6DF-FAB7B3AFA191@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> +/* Macros to workout the correct index for the FPR in the thread 
>> struct */
>> +#define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
>> +#define FPRHALF(i) (((i) - PT_FPR0) % 2)
> 
> Have you looked at what the compiler spits out here to make sure we 
> aren't getting a divide?  Seems like we could use '& 0x1'.

GCC's not *that* dumb.  However, you may get some unnecessary 
sign-twiddling if "i" is signed.

-Scott
