Return-Path: <albert_herranz@yahoo.es>
Received: from smtp105.mail.ukl.yahoo.com (smtp105.mail.ukl.yahoo.com
	[77.238.184.37]) by ozlabs.org (Postfix) with SMTP id 31139B6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 16:23:07 +1100 (EST)
Message-ID: <4B14A834.4070907@yahoo.es>
Date: Tue, 01 Dec 2009 06:23:00 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Richard Holden <aciddeath@gmail.com>
Subject: Re: [RFC PATCH v3 3/3] powerpc: gamecube/wii: early debugging using
	usbgecko
References: <cover.1259609263.git.albert_herranz@yahoo.es>
	<86935119c483c2d6e4c810c0afd079e049443b18.1259609263.git.albert_herranz@yahoo.es>
	<4B147086.6070602@gmail.com>
In-Reply-To: <4B147086.6070602@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Richard Holden wrote:
> Albert Herranz wrote:
>> Add support for using the USB Gecko adapter as an early debugging
>> console on the Nintendo GameCube and Wii video game consoles.
>> The USB Gecko is a 3rd party memory card interface adapter that provides
>> a EXI (External Interface) to USB serial converter.
>>
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
>> ---
>>  arch/powerpc/Kconfig.debug                         |    8 +++
>>  arch/powerpc/include/asm/udbg.h                    |    1 +
>>  arch/powerpc/kernel/head_32.S                      |   21 +++++++
>>  arch/powerpc/kernel/udbg.c                         |    2 +
>>  arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   59 ++++++++++++++++++++
>>  arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h |    2 +
>>  6 files changed, 93 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
>> index 3b10051..11e385b 100644
>> --- a/arch/powerpc/Kconfig.debug
>> +++ b/arch/powerpc/Kconfig.debug
>> @@ -254,6 +254,14 @@ config PPC_EARLY_DEBUG_CPM
>>  	  using a CPM-based serial port.  This assumes that the bootwrapper
>>  	  has run, and set up the CPM in a particular way.
>>  
>> +config PPC_EARLY_DEBUG_USBGECKO
>> +	bool "Early debugging through the USB Gecko adapter"
>> +	depends on GAMECUBE_COMMON
>> +	select USBGECKO_UDBG
>> +	help
>> +	  Select this to enable early debugging for Nintendo GameCube/Wii
>> +	  consoles via an external USB Gecko adapter.
>> +
>>  endchoice
>>  
>>  config PPC_EARLY_DEBUG_44x_PHYSLOW
> 
> Small nit, my preference would be for this to be in the patch 1 where it
> is first referenced.
> 

The first patch is generic, and uses PPC_EARLY_DEBUG.
This is the first patch where PPC_EARLY_DEBUG_USBGECKO is referenced.

>> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
>> index ba4c7cc..3f125b6 100644
>> --- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
>> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
>> @@ -17,6 +17,7 @@
>>  #include <asm/io.h>
>>  #include <asm/prom.h>
>>  #include <asm/udbg.h>
>> +#include <asm/fixmap.h>
>>  
>>  #include "usbgecko_udbg.h"
>>  
>> @@ -270,3 +271,61 @@ done:
>>  		of_node_put(np);
>>  	return;
>>  }
>> +
>> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
>> +
>> +static void __init ug_early_remap(void)
> 
> you may want to rename the ug_ prefix, it took me a while looking back
> and forth through the patch to convince myself it wasn't a typo.
> 

What's wrong with ug_ ? (ug = (u)sb(g)ecko)

> -Richard Holden
> 

Thanks,
Albert
