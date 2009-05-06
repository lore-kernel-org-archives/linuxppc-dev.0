Return-Path: <fkan@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BDCDCDDDEE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 03:44:57 +1000 (EST)
Message-ID: <4A01CC78.3060004@amcc.com>
Date: Wed, 06 May 2009 10:44:24 -0700
From: Feng Kan <fkan@amcc.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] Added support for Designware SATA controller driver
References: <1241211767-32697-1-git-send-email-fkan@amcc.com>
	<49FB68F2.10301@freescale.com>
In-Reply-To: <49FB68F2.10301@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mark Miesfeld <miesfeld@gmail.com>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott:

I agree with your statement, however this driver is wrapped with this 
AHB DMA controller.
It would be very hard for it to work on non 460EX platforms. I can 
expand the depend in
the future if it is available on more cores.

Thanks
Feng Kan

Scott Wood wrote:
> Feng Kan wrote:
>> This adds support for the Designware SATA controller.
>>
>> Signed-off-by: Feng Kan <fkan@amcc.com>
>> Signed-off-by: Mark Miesfeld <miesfeld@gmail.com>
>> ---
>>  drivers/ata/Kconfig    |   10 +
>>  drivers/ata/Makefile   |    1 +
>>  drivers/ata/sata_dwc.c | 2053 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 2064 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/ata/sata_dwc.c
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 0bcf264..c3d0b24 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -72,6 +72,16 @@ config SATA_FSL
>>  
>>        If unsure, say N.
>>  
>> +config SATA_DWC
>> +    tristate "DesignWare Cores SATA support"
>> +     depends on 460EX
>
> That "depends" looks too specific -- we don't want to grow a list if 
> this controller gets added to other chips.
>
> Only depend on what this driver actually needs in order to function.
>
> -Scott
