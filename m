Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 634D7DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 21:21:57 +1000 (EST)
Message-ID: <46B30F9A.8020605@ru.mvista.com>
Date: Fri, 03 Aug 2007 15:20:58 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
References: <20070730151628.GA5100@ru.mvista.com>
	<20070802153451.5a92947b@weaponx.rchland.ibm.com>
In-Reply-To: <20070802153451.5a92947b@weaponx.rchland.ibm.com>
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

Josh Boyer wrote:
> On Mon, 30 Jul 2007 19:16:28 +0400
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
>> diff -ruN linux.orig/arch/powerpc/kernel/cputable.c linux/arch/powerpc/kernel/cputable.c
>> --- linux.orig/arch/powerpc/kernel/cputable.c	2007-07-27 20:37:10.000000000 +0400
>> +++ linux/arch/powerpc/kernel/cputable.c	2007-07-27 20:44:26.000000000 +0400
>> @@ -1132,6 +1132,42 @@
>>  		.dcache_bsize		= 32,
>>  		.platform		= "ppc440",
>>  	},
>> +	{ /* 440EPX  - with Security/Kasumi  */
>> +		.pvr_mask		= 0xf0000fff,
>> +		.pvr_value		= 0x200008D0,
>> +		.cpu_name		= "440EPX - with Security/Kasumi",
>> +		.cpu_features		= CPU_FTRS_44X,
>> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 440EPX has an FPU */
>> +		.icache_bsize		= 32,
>> +		.dcache_bsize		= 32,
>> +	},
>> +	{ /* 440EPX  - without Security/Kasumi  */
>> +		.pvr_mask		= 0xf0000fff,
>> +		.pvr_value		= 0x200008D4,
>> +		.cpu_name		= "440EPX - no Security/Kasumi",
>> +		.cpu_features		= CPU_FTRS_44X,
>> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU, /* 440EPX has an FPU */
>> +		.icache_bsize		= 32,
>> +		.dcache_bsize		= 32,
>> +	},
>> +	{ /* 440GRX  - with Security/Kasumi  */
>> +		.pvr_mask		= 0xf0000fff,
>> +		.pvr_value		= 0x200008D8,
>> +		.cpu_name		= "440GRX - with Security/Kasumi",
>> +		.cpu_features		= CPU_FTRS_44X,
>> +		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
>> +		.icache_bsize		= 32,
>> +		.dcache_bsize		= 32,
>> +	},
>> +	{ /* 440GRX  - without Security/Kasumi  */
>> +		.pvr_mask		= 0xf0000fff,
>> +		.pvr_value		= 0x200008DC,
>> +		.cpu_name		= "440GRX - no Security/Kasumi",
>> +		.cpu_features		= CPU_FTRS_44X,
>> +		.cpu_user_features	= COMMON_USER_BOOKE, /* 440GRX has no FPU */
>> +		.icache_bsize		= 32,
>> +		.dcache_bsize		= 32,
>> +	},
> 
> Should the 440GRX PVR additions be done in a separate patch?  Or is the
> PVR and cpu features truly the only difference between 440EPx and
> 440GRx?

440GRx Doesn't have USB (host/device) controllers and and FPU.
Actually, I have a 440GRx board with the same PVR valus as 440EPx has.
HW bug may be?
I think I'll remove 440GRx for now.

> 
>> diff -ruN linux.orig/arch/powerpc/platforms/44x/sequoia.c linux/arch/powerpc/platforms/44x/sequoia.c
>> --- linux.orig/arch/powerpc/platforms/44x/sequoia.c	1970-01-01 03:00:00.000000000 +0300
>> +++ linux/arch/powerpc/platforms/44x/sequoia.c	2007-07-27 20:44:26.000000000 +0400
>> @@ -0,0 +1,66 @@
>> +/*
>> + * Sequoia board specific routines
>> + *
>> + * Wade Farnsworth <wfarnsworth@mvista.com>
>> + * Copyright 2004-2007 MontaVista Software Inc.
>> + *
>> + * Rewritten and ported to the merged powerpc tree:
>> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> + * Copyright 2007 IBM Corporation
> 
> I didn't really do this.  Might want to give yourself credit instead :).
> 
> josh

I'll change it to "base on Bamboo code by Josh" :)
