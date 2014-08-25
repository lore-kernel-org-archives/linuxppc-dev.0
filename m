Return-Path: <prabhakar@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A65F11A0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 16:28:32 +1000 (EST)
Message-ID: <53FAD771.7010304@freescale.com>
Date: Mon, 25 Aug 2014 11:58:01 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] fsl_ifc: Support all 8 IFC chip selects
References: <1234993482.57039.1408136876321.JavaMail.zimbra@xes-inc.com>
 <1408493285.4058.55.camel@snotra.buserror.net>
 <53F4179F.1010803@freescale.com>
 <1408576886.4058.73.camel@snotra.buserror.net>
 <53F755A0.8020504@freescale.com>
 <1408729900.6510.2.camel@snotra.buserror.net>
In-Reply-To: <1408729900.6510.2.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Aaron Sierra <asierra@xes-inc.com>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 8/22/2014 11:21 PM, Scott Wood wrote:
> On Fri, 2014-08-22 at 20:07 +0530, Prabhakar Kushwaha wrote:
>> Sorry Scott for late reply,
>>
>> Please find my reply in-lined
>>
>>
>> On 8/21/2014 4:51 AM, Scott Wood wrote:
>>> On Wed, 2014-08-20 at 09:05 +0530, Prabhakar Kushwaha wrote:
>>>> On 8/20/2014 5:38 AM, Scott Wood wrote:
>>>>> On Fri, 2014-08-15 at 16:07 -0500, Aaron Sierra wrote:
>>>>>> Freescale's QorIQ T Series processors support 8 IFC chip selects
>>>>>> within a memory map backward compatible with previous P Series
>>>>>> processors which supported only 4 chip selects.
>>>>>>
>>>>>> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>>>>>> ---
>>>>>>     include/linux/fsl_ifc.h | 10 +++++-----
>>>>>>     1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
>>>>>> index 84d60cb..62762ff 100644
>>>>>> --- a/include/linux/fsl_ifc.h
>>>>>> +++ b/include/linux/fsl_ifc.h
>>>>>> @@ -29,7 +29,7 @@
>>>>>>     #include <linux/of_platform.h>
>>>>>>     #include <linux/interrupt.h>
>>>>>>     
>>>>>> -#define FSL_IFC_BANK_COUNT 4
>>>>>> +#define FSL_IFC_BANK_COUNT 8
>>>>> First please modify fsl_ifc_nand.c to limit itself to the number of
>>>>> banks it dynamically determines are present based on the IFC version.
>>>>>
>>>>>
>>>> Number of available bank/chip select are defined by SoC and it is
>>>> independent of SoC.
>>> Do you mean defined by the SoC and independent of the IFC version?
>> IFC v 1.0.0 supports 4 Chip Select.
>> IFC v 1.1.0 onwards, IFC supports 8 chip select.
>>
>> But SoC finally defines number of chip select coming out of SoC. Like
>> LS1021A with IFC ver 1.4.0 have only 7 Chip Select.
> What matters here is whether the registers are implemented, not whether
> a chip select is pinned out -- so use the IFC version.

I checked with IFC IP team " There is no side-effect of reading CS-8  
register if only 7 CS exposed by SoC"

IFC version can be used.

Regards,
Prabhakar
