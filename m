Return-Path: <vgallardo@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 43419DDF34
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 03:31:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH v2] Add AMCC Arches eval board support to platforms/44x
Date: Fri, 19 Sep 2008 10:31:34 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D6050D1768@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <20080918200143.0367482f@zod.rchland.ibm.com>
From: "Victor Gallardo" <vgallardo@amcc.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
Hi Josh,

See below...

>> ...
>> @@ -83,9 +83,23 @@ config CANYONLANDS
>>  	select 460EX
>>  	select PCI
>>  	select PPC4xx_PCI_EXPRESS
>> +	select IBM_NEW_EMAC_EMAC4
>> +	select IBM_NEW_EMAC_RGMII
>> +	select IBM_NEW_EMAC_ZMII
>> +	select IBM_NEW_EMAC_TAH
>>  	help
>>  	  This option enables support for the AMCC PPC460EX evaluation =
board.
>>=20
>> +config ARCHES
>> +	bool "Arches"
>> +	depends on 44x
>> +	default n
>> +	select 460EX
>> +	select IBM_NEW_EMAC_EMAC4
>> +	select IBM_NEW_EMAC_TAH
>> +	help
>> +	  This option enables support for the AMCC PPC460GT evaluation =
board.
>
>This seems fine.
>
> ...
>
>> +obj-$(CONFIG_ARCHES)	+=3D canyonlands.o
>>  obj-$(CONFIG_CANYONLANDS) +=3D canyonlands.o
>>  obj-$(CONFIG_XILINX_VIRTEX_5_FXT) +=3D virtex.o
>
>Instead of modifying the Makefile, you should only have to add the =
"amcc,arches"
> string to the >"board" array in ppc44x_simple.c.
>
> We switched to doing this as opposed to having a somewhat bogus=20
> "board compatible" statement with >other boards.  That is what was =
discussed at
> OLS, and this is the result.

The reason for two different board types is to remove RGMII and ZMII =
from the build. Arches does not use it.

Where is ppc4xx_simple.c? I just pulled your git tree and did not find =
this file.

Thanks,

Victor Gallardo
