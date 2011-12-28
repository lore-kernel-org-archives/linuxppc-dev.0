Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1916BB6FE8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 17:18:37 +1100 (EST)
Message-ID: <4EFAB4B9.1020205@windriver.com>
Date: Wed, 28 Dec 2011 14:18:33 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: Kernel not booting when supplying boot parameter mem
References: <93CD5F41FDBC6042A6B449764F3B35CC050C9F21@EU-MBX-03.mgc.mentorg.com>
 <4EF9A6F2.8020708@windriver.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CB4E4@EU-MBX-03.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050CB4E4@EU-MBX-03.mgc.mentorg.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arshad, Farrukh wrote:
> Hi Tiejun,
> 
> Thanks for your response. Yes, I am running two kernels one on each core in SAMP configuration on P1022RDK board. Given is my memory partitioning. Core 0 is loading fine but Core 1 is not loading. CONFIG_RELOCATABLE is not set.
> 
> ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> Core                      	| Base Address  	|    Size                 			| Uboot parameters					| Kernel Configuration									|
> -----------------------------|---------------------------|-------------------------------------|------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
> Core 0 (MEL RT Kernel) 	| 0x0000,0000   		| 0x1000,0000 - 256 (MB)   	|bootm_low = 0x0000,0000, bootm_size = 0x1000,0000	| CONFIG_PHYSICAL_START = 0x0000,0000, CONFIG_KERNEL_START = 0xC000,0000	|
> Core 1 (LTIB Kernel)      	|0x1000,0000    		| 0x0800,0000 - 128 (MB)   	|bootm_low = 0x1000,0000, bootm_size = 0x0800,0000	| CONFIG_PHYSICAL_START = 0x1000,0000, CONFIG_KERNEL_START = 0xC000,0000	|
> ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 

Please check if the following commit is already in your kernel:
------
    powerpc: Fix memory limits when starting at a non-zero address

    memblock_enforce_memory_limit() takes the desired maximum quantity of memory
    to end up with, not an address above which memory will not be used.

Tiejun
