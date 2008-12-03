Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD86CDDEEE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 10:11:13 +1100 (EST)
Date: Wed, 3 Dec 2008 15:09:22 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors
In-Reply-To: <1228209641.7356.176.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0812031451450.7648@t2.domain.actdsltmp>
References: <20081201060152.00DCCDDDE3@ozlabs.org>
	<BD75FAE9-7D10-488B-9906-23B2D93F1FB6@kernel.crashing.org>
	<1228209641.7356.176.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2 Dec 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-12-02 at 01:36 -0600, Kumar Gala wrote:
>
>>> #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
>>> 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
>>> -	    CPU_FTR_UNIFIED_ID_CACHE)
>>> +	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
>>> #define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
>>> -	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN)
>>> +	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP |
>>> CPU_FTR_NODSISRALIGN \
>>
>> Added a '|' at the end of the line before the escape
>
> Right. Will send a new patch tomorrow. Appart from that, have you
> verified it doesn't have any adverse effects for you ? I did some quick
> tests on 440 and things seem to be fine.


#ifdef __powerpc64__
#define LONG_ASM_CONST(x)               ASM_CONST(x)
#else
#define LONG_ASM_CONST(x)               0
#endif

#define CPU_FTR_NOEXECUTE               LONG_ASM_CONST(0x0000000800000000)

Am I not looking at the right code?  Since e200 and e500 aren't powerpc64,
doesn't adding CPU_FTR_NOEXECUTE have no effect at all?
