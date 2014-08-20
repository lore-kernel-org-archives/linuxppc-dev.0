Return-Path: <prabhakar@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A6D61A01C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 13:51:27 +1000 (EST)
Message-ID: <53F4179F.1010803@freescale.com>
Date: Wed, 20 Aug 2014 09:05:59 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 2/2] fsl_ifc: Support all 8 IFC chip selects
References: <1234993482.57039.1408136876321.JavaMail.zimbra@xes-inc.com>
 <1408493285.4058.55.camel@snotra.buserror.net>
In-Reply-To: <1408493285.4058.55.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 8/20/2014 5:38 AM, Scott Wood wrote:
> On Fri, 2014-08-15 at 16:07 -0500, Aaron Sierra wrote:
>> Freescale's QorIQ T Series processors support 8 IFC chip selects
>> within a memory map backward compatible with previous P Series
>> processors which supported only 4 chip selects.
>>
>> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>> ---
>>   include/linux/fsl_ifc.h | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
>> index 84d60cb..62762ff 100644
>> --- a/include/linux/fsl_ifc.h
>> +++ b/include/linux/fsl_ifc.h
>> @@ -29,7 +29,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/interrupt.h>
>>   
>> -#define FSL_IFC_BANK_COUNT 4
>> +#define FSL_IFC_BANK_COUNT 8
> First please modify fsl_ifc_nand.c to limit itself to the number of
> banks it dynamically determines are present based on the IFC version.
>
>

Number of available bank/chip select are defined by SoC and it is 
independent of SoC.
It should be fix in following way

Option 1:
u-boot:  fix device tree with number of available chip select. It may 
require IFC binding change
Linux: Read device tree and determine the Chip Selects

or

Option 2:
Make it static because any way IFC NAND driver polls to 
FSL_IFC_BANK_COUNT to know NAND flash chip select. This patch is doing same.

Regards,
Prabhakar
