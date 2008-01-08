Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13A78DDED7
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:01:40 +1100 (EST)
Message-ID: <4783BA6E.50204@freescale.com>
Date: Tue, 08 Jan 2008 11:01:18 -0700
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<20080108174038.GA20819@lixom.net>
In-Reply-To: <20080108174038.GA20819@lixom.net>
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

Olof Johansson wrote:
> Hi,
>
>
>   
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 66a3d8c..81c3f05 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -470,7 +470,7 @@ config PCI
>>  	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
>>  		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
>>  		|| PPC_PS3
>> -	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
>> +	default y if !40x && !CPM2 && !8xx && !PPC_512x && !PPC_83xx \
>>  		&& !PPC_85xx && !PPC_86xx
>>     
>
> This is getting out of control. Not a comment to this specific patch,
> but it's getting silly.
>
> Btw, why no PCI by default on this platform when it seemingly is default
> on 5200? I thought they were fairly similar.
>   

PCI has issues in first silicon so I left that out.

Also contrary to popular rumor, 5121 is more like a 83xx that 52xx.
The PCI and USB are very similar to 83xx.


>   
>> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
>> new file mode 100644
>> index 0000000..399d279
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/512x/Kconfig
>> @@ -0,0 +1,20 @@
>> +menu "Platform support"
>> +	depends on PPC_512x
>> +
>> +choice
>> +	prompt "Machine Type"
>> +	default MPC5121_ADS
>> +
>> +config MPC5121_ADS
>> +	bool "Freescale MPC5121E ADS"
>> +	select DEFAULT_UIMAGE
>> +	help
>> +	  This option enables support for the MPC5121E ADS board.
>> +
>> +endchoice
>>     
>
> For new platforms it makes more sense to make it possible to build
> multiplatform kernels instead of using 'choice'.
>
> I know some embedded board guys prefer to build a custom kernel for just
> their board (since it means extra revenue for them to spin a kernel
> for every customer), but it's still convenient to be able to build
> multiplatform kernels. Especially since there's some companies out there
> with intent to make end-user products with this cpu.
>   
Grant made the same comment about multiplatform support.
I'll change this.
>   
>> @@ -0,0 +1,90 @@
>> +#include <asm/system.h>
>> +#include <asm/atomic.h>
>> +#include <asm/machdep.h>
>> +#include <asm/ipic.h>
>> +#include <asm/prom.h>
>> +#include <asm/time.h>
>> +#include <asm/of_platform.h>
>>     
>
> Stephen will tell you to include linux/of_platform.h instead. :-)
>   
Oops, this patch was originally done before the open firmware
unification.  I guess checkpatch.pl needs an update too.
>   
>> @@ -229,7 +229,7 @@ config NR_CPUS
>>  
>>  config NOT_COHERENT_CACHE
>>  	bool
>> -	depends on 4xx || 8xx || E200
>> +	depends on 4xx || 8xx || E200 || PPC_512x
>>  	default y
>>     
>
> Why do you need this, when 5200 doesn't?
>
>
> -Olof
>
>   
