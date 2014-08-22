Return-Path: <prabhakar@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1857E1A0183
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 00:37:43 +1000 (EST)
Message-ID: <53F755A0.8020504@freescale.com>
Date: Fri, 22 Aug 2014 20:07:20 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] fsl_ifc: Support all 8 IFC chip selects
References: <1234993482.57039.1408136876321.JavaMail.zimbra@xes-inc.com>
 <1408493285.4058.55.camel@snotra.buserror.net>
 <53F4179F.1010803@freescale.com>
 <1408576886.4058.73.camel@snotra.buserror.net>
In-Reply-To: <1408576886.4058.73.camel@snotra.buserror.net>
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

Sorry Scott for late reply,

Please find my reply in-lined


On 8/21/2014 4:51 AM, Scott Wood wrote:
> On Wed, 2014-08-20 at 09:05 +0530, Prabhakar Kushwaha wrote:
>> On 8/20/2014 5:38 AM, Scott Wood wrote:
>>> On Fri, 2014-08-15 at 16:07 -0500, Aaron Sierra wrote:
>>>> Freescale's QorIQ T Series processors support 8 IFC chip selects
>>>> within a memory map backward compatible with previous P Series
>>>> processors which supported only 4 chip selects.
>>>>
>>>> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>>>> ---
>>>>    include/linux/fsl_ifc.h | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
>>>> index 84d60cb..62762ff 100644
>>>> --- a/include/linux/fsl_ifc.h
>>>> +++ b/include/linux/fsl_ifc.h
>>>> @@ -29,7 +29,7 @@
>>>>    #include <linux/of_platform.h>
>>>>    #include <linux/interrupt.h>
>>>>    
>>>> -#define FSL_IFC_BANK_COUNT 4
>>>> +#define FSL_IFC_BANK_COUNT 8
>>> First please modify fsl_ifc_nand.c to limit itself to the number of
>>> banks it dynamically determines are present based on the IFC version.
>>>
>>>
>> Number of available bank/chip select are defined by SoC and it is
>> independent of SoC.
> Do you mean defined by the SoC and independent of the IFC version?

IFC v 1.0.0 supports 4 Chip Select.
IFC v 1.1.0 onwards, IFC supports 8 chip select.

But SoC finally defines number of chip select coming out of SoC. Like 
LS1021A with IFC ver 1.4.0 have only 7 Chip Select.

>> It should be fix in following way
>>
>> Option 1:
>> u-boot:  fix device tree with number of available chip select. It may
>> require IFC binding change
>> Linux: Read device tree and determine the Chip Selects
> If we do this then it will need to be an optional property that defaults
> to the current assumption being made (4).

Yes, I agree with you.

> In the future we really ought to check whether there are integration
> parameters when coming up with the initial binding for a hardware
> block...

True.


>> Option 2:
>> Make it static because any way IFC NAND driver polls to
>> FSL_IFC_BANK_COUNT to know NAND flash chip select. This patch is doing same.
> I don't understand what you're saying here.  The driver does not know at
> compile time how many there are.  What this patch does is assume it's OK
> to access non-existent registers in the rare case that there's no match
> in the registers that exist.

in case of P1010, If we run loop for 8 times,
      we are accessing reserved memory, that's why it may work. In Ideal 
scenario, we should not access the reserved memory.


> Aaron tested this on P1010 and it seemed to work, though I'm not
> generally fond of relying on such things.
>
yes, I agree.

  If I conclude  ==>   We should go with option 1.  Am I correct?


Regards,
Prabhakar
