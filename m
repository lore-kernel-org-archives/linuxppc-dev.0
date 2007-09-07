Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 630DBDDE98
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 19:16:23 +1000 (EST)
Date: Fri, 7 Sep 2007 04:16:37 -0500
From: Olof Johansson <olof@lixom.net>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Add workaround for MPICs with broken register
	reads
Message-ID: <20070907091637.GA32102@lixom.net>
References: <20070905024417.GE27139@lixom.net>
	<d62ce2299f9d423f95cd8ee50b3b7cff@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d62ce2299f9d423f95cd8ee50b3b7cff@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 09:55:21AM -0500, Milton Miller wrote:
> On Wed Sep 5 12:44:17 EST 2007, Olof Johansson wrote:
>> diff --git a/arch/powerpc/platforms/Kconfig 
>> b/arch/powerpc/platforms/Kconfig
>> index 041df77..b9f1efa 100644
>> --- a/arch/powerpc/platforms/Kconfig
>> +++ b/arch/powerpc/platforms/Kconfig
>> @@ -137,6 +137,10 @@ config MPIC_U3_HT_IRQS
>>         depends on PPC_MAPLE
>>         default y
>>
>> +config MPIC_BROKEN_REGREAD
>> +       bool
>> +       depends on PPC_PASEMI
>> +
>>  config IBMVIO
>>         depends on PPC_PSERIES || PPC_ISERIES
>>         bool
>> diff --git a/arch/powerpc/platforms/pasemi/Kconfig 
>> b/arch/powerpc/platforms/pasemi/Kconfig
>> index 95cd90f..117d90a 100644
>> --- a/arch/powerpc/platforms/pasemi/Kconfig
>> +++ b/arch/powerpc/platforms/pasemi/Kconfig
>> @@ -5,6 +5,7 @@ config PPC_PASEMI
>>         select MPIC
>>         select PPC_UDBG_16550
>>         select PPC_NATIVE
>> +       select MPIC_BROKEN_REGREAD
>>         help
>>           This option enables support for PA Semi's PWRficient line
>>           of SoC processors, including PA6T-1682M
>
>
> Since you are using select (and not default y), instead of the depends on 
> PPC_PASEMI how about adding a short description of what the config does as 
> help text, in case some future mpic has a similar bug?

Thanks Milton, that's a reasonable suggestion (not that any of the other
options do it, including the very vague MPIC_WEIRD :-).

New patch posted shortly.


-Olof
