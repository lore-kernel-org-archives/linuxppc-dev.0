Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 206A51007D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2012 13:09:06 +1100 (EST)
Message-ID: <4F050653.6010601@windriver.com>
Date: Thu, 5 Jan 2012 10:09:23 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: Problem in getting shared memory access on P1022RDK
References: <93CD5F41FDBC6042A6B449764F3B35CC050CCA22@EU-MBX-03.mgc.mentorg.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CCA80@EU-MBX-03.mgc.mentorg.com>
 <4F033685.6000509@freescale.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CCB2E@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050CCB2E@EU-MBX-03.mgc.mentorg.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arshad, Farrukh wrote:
> How can I verify if the memory mapped is coherent on both cores. My memory partitioning is given below
> 
> Core		Base Address		Size
> Core 0		0x0000,0000		0x1000,0000	--> CONFIG_PHYSICAL_START = bootm_low = Base Address
> Core 1		0x1000,0000		0x0C00,0000	--> CONFIG_PHYSICAL_START = bootm_low = Base Address
> Shared Mem	0x1C00,0000		0x0400,0000

Was the kernel option, CONFIG_SMP, enabled for both two kernels?

CONFIG_SMP would affect the memory attribute for cache coherency. Maybe you
should make sure if kernel have a appropriate memory attribute by dumping TLB entry.

Tiejun

> 
> Regards,
> Farrukh Arshad
> 
> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com] 
> Sent: Tuesday, January 03, 2012 10:10 PM
> To: Arshad, Farrukh
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: Problem in getting shared memory access on P1022RDK
> 
> On 01/03/2012 03:42 AM, Arshad, Farrukh wrote:
>> Adding more to it,
>>
>>  
>>
>> When I write from Core 1 on the shared memory region it is visible at 
>> Core 0 and it can read what I have written from Core 1 but when I 
>> write from Core 0 on this shared memory it is not visible on Core 1.
> 
> Is the memory mapped coherent on both cores?
> 
> -Scott
