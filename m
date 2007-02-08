Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3A69DDE42
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 18:43:50 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900D441A@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D441A@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <82ABE776-0C94-4FAE-BD24-071988842EA9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
Date: Thu, 8 Feb 2007 01:41:51 -0600
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: netdev@vger.kernel.org, Tabi Timur-B04825 <timur@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 1:36 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, February 08, 2007 3:16 PM
>> To: Li Yang-r58472
>> Cc: Tabi Timur-B04825; netdev@vger.kernel.org; linuxppc- 
>> dev@ozlabs.org
>> Subject: Re: [PATCH 1/4] ucc_geth: Change private  
>> immrbar_virt_to_phys
> to generic
>> iopa
>>
>>
>> On Feb 8, 2007, at 1:06 AM, Li Yang-r58472 wrote:
>>
>>>>> MURAM is a mmio region so it don't share the characteristic of
> main
>>>>> memory that phy_addr = virt_addr - PAGE_OFFSET.  While they can
>>>>> both be
>>>>> mapped through page table using iopa().
>>>>
>>>> Right, so when do you know if you'll be using MURAM or normal
>>>> memory?  Why not just keep around a token that is the physical
>>>> address at the point you make the decision of MURAM vs normal
> memory.
>>>
>>> Yes, that can be a way.  But as the virt to phy mapping is only used
>>> once, it's nothing bad to do it this way.
>>
>> The problem as I stated before with using iopa() is that its not
>> supported across platforms.
>
> Yes, it is only for PPC32.  But we don't have another API to do  
> it.  How
> about make it more generic to add PPC64 version?

Why do you need another API to do this, you already have the  
information you want, its just a matter of you keeping track of it.

- k
