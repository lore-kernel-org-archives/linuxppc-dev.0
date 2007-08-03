Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 73944DDE02
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 21:37:49 +1000 (EST)
Message-ID: <46B31352.1060503@ru.mvista.com>
Date: Fri, 03 Aug 2007 15:36:50 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
References: <20070730151628.GA5100@ru.mvista.com>
	<20070802153451.5a92947b@weaponx.rchland.ibm.com>
	<200708030844.13895.sr@denx.de>
In-Reply-To: <200708030844.13895.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Thursday 02 August 2007, Josh Boyer wrote:
>> On Mon, 30 Jul 2007 19:16:28 +0400
>>> +0400 +++ linux/arch/powerpc/kernel/cputable.c	2007-07-27
>>> 20:44:26.000000000 +0400 @@ -1132,6 +1132,42 @@
>>>  		.dcache_bsize		= 32,
>>>  		.platform		= "ppc440",
>>>  	},
>>> +	{ /* 440EPX  - with Security/Kasumi  */
>>> +		.pvr_mask		= 0xf0000fff,
>>> +		.pvr_value		= 0x200008D0,
>>> +		.cpu_name		= "440EPX - with Security/Kasumi",
>>> +		.cpu_features		= CPU_FTRS_44X,
>>> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /*
>>> 440EPX has an FPU */ +		.icache_bsize		= 32,
>>> +		.dcache_bsize		= 32,
>>> +	},
>>> +	{ /* 440EPX  - without Security/Kasumi  */
>>> +		.pvr_mask		= 0xf0000fff,
>>> +		.pvr_value		= 0x200008D4,
>>> +		.cpu_name		= "440EPX - no Security/Kasumi",
>>> +		.cpu_features		= CPU_FTRS_44X,
>>> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /*
>>> 440EPX has an FPU */ +		.icache_bsize		= 32,
>>> +		.dcache_bsize		= 32,
>>> +	},
>>> +	{ /* 440GRX  - with Security/Kasumi  */
>>> +		.pvr_mask		= 0xf0000fff,
>>> +		.pvr_value		= 0x200008D8,
>>> +		.cpu_name		= "440GRX - with Security/Kasumi",
>>> +		.cpu_features		= CPU_FTRS_44X,
>>> +		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
>>> +		.icache_bsize		= 32,
>>> +		.dcache_bsize		= 32,
>>> +	},
>>> +	{ /* 440GRX  - without Security/Kasumi  */
>>> +		.pvr_mask		= 0xf0000fff,
>>> +		.pvr_value		= 0x200008DC,
>>> +		.cpu_name		= "440GRX - no Security/Kasumi",
>>> +		.cpu_features		= CPU_FTRS_44X,
>>> +		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
>>> +		.icache_bsize		= 32,
>>> +		.dcache_bsize		= 32,
>>> +	},
>> Should the 440GRX PVR additions be done in a separate patch?  Or is the
>> PVR and cpu features truly the only difference between 440EPx and
>> 440GRx?
> 
> I think it makes sense to add the 440GRx with this patchset too. The 440GRx is 
> a subset of the 440EPx, missing some stuff like USB, FPU. And the AMCC 
> Rainier 440GRx eval board is a subset of the Sequoia eval board. So no new 
> board specific sources should be necessary to support the Rainier, just a 
> different defconfig file.
> 
> Best regards,
> Stefan

I have a Rainier 440GRx board and the PVR is equal to the 440EPx one 
(0x200008D0). This has to be handled somehow, since the 
PPC_FEATURE_HAS_FPU flag should *not* be set for 440GRx.
I'm really not sure how though. Any ideas are greatly appreciated :)
Is it a h/w bug?
Thanks,
Valentine.
