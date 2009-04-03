Return-Path: <Qingtao.Cao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 6607EDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 16:54:50 +1100 (EST)
Message-ID: <49D5A381.3080108@windriver.com>
Date: Fri, 03 Apr 2009 13:49:53 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: qingtao.cao@windriver.com
Subject: Re: [v0 PATCH 5/5] EDAC: CPC925 MC platform device setup
References: <1238652440-9224-1-git-send-email-qingtao.cao@windriver.com>
	<1238652440-9224-5-git-send-email-qingtao.cao@windriver.com>
	<1238652440-9224-6-git-send-email-qingtao.cao@windriver.com>
	<200904021436.44822.arnd@arndb.de> <49D57FBA.3090508@windriver.com>
In-Reply-To: <49D57FBA.3090508@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, norsk5@yahoo.com, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, bluesmoke-devel@lists.sourceforge.net
Reply-To: qingtao.cao@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Harry Ciao 写道:
> Arnd Bergmann 写道:
>> On Thursday 02 April 2009, Harry Ciao wrote:
>>  
>>> +#ifdef CONFIG_EDAC
>>> +#define CPC925_MC_START                0xf8000000
>>> +#define CPC925_MC_END          0xf8ffffff /* sizeof 16MB */
>>> +/* Register a platform device for CPC925 memory controller */
>>> +static int __init maple_cpc925_edac_setup(void)
>>>     
>>
>> It's not good to have these encoded as magic numbers.
>> Can't you find the addresses in the device tree? Maybe it's
>> even possible to make this an of_platform_driver if you
>> find a good node to bind to.
>>
>> Does the driver also work on a G5 Mac, or is it limited
>> to the maple platform?
>>
>>     Arnd <><
>>
>>  
Hi Arnd,

I forgot to mention that so far I have tested this CPC925 driver on the 
Maple platform, I have no G5 Mac to test with.
CPC925 is specific to the PowerPC 970 family of processors, but I don't 
think Maple is the only platform that ever use PowerPC 970 
processors(that is why this driver should depend on PP64, rather than 
PPC_MAPLE).

Thanks,

Harry

> Hi Arnd,
>
> I did try to get resource information from its DTB node first, the 
> "hostbridge" node do can be found successfully, however, 
> unfortunately, as I put in the notes in that function, the 
> #address-cells and #size-cells specified by its parent node are both 
> 2, but the cell number used in its "reg" property is actually 1, as
>
> reg = <0xf8000000 0x1000000>;
>
> which will make of_address_to_resource() failed with -EINVAL; that's 
> why I have to set it up from scratch manually.
>
> Cheers,
>
> Harry
>
>
>
