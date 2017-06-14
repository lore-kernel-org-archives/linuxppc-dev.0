Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wndpK53DdzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 17:40:25 +1000 (AEST)
Subject: Re: [PATCH v1 1/3] powerpc, 8xx: remove support for 8xx
To: hs@denx.de
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <8472b742-049b-070b-2627-27704f5bfc0a@c-s.fr>
 <c47ea679-cd3f-d993-7eb6-247762b87081@c-s.fr> <593F9644.5080305@denx.de>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <e14b80d8-e2b9-4f27-0191-bb64cd987edb@c-s.fr>
Date: Wed, 14 Jun 2017 09:40:18 +0200
MIME-Version: 1.0
In-Reply-To: <593F9644.5080305@denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/06/2017 à 09:37, Heiko Schocher a écrit :
> Hello Christophe,
> 
> Am 13.06.2017 um 07:40 schrieb Christophe LEROY:
>>
>>
>> Le 13/06/2017 à 07:26, Christophe LEROY a écrit :
>>> There was for long time no activity in the 8xx area.
>>> We need to go further and convert to Kconfig, but it
>>> turned out, nobody is interested anymore in 8xx,
>>> so remove it (with a heavy heart, knowing that I remove
>>> here the root of U-Boot).
>>>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>
>>
>> Please don't do that.
> 
> Tom already applied the patch to mainline ...

Can be reverted ?

> 
>> As you can see in Linux kernel activity, there have been a lot 
>> activity related to the 8xx,
>> including but not limited to:
>> 1/ HW Crypto for the 885 (Talitos SEC1)
>> 2/ TX NAPI in the 8xx Ethernet driver
>> 3/ Scatter/Gather support in the 8xx Ethernet driver
>> 4/ Hugepages
>> 5/ Perf events
>> 6/ hw breakpoints
>> 7/ Linear memory mapping via Large TLBs
> 
> Thats linux ... not u-boot!

Sure, but it shows there is still interest to that processor. The 885 is 
a good recent 8xx.
u-boot is not really something we focus on. We update it once a year, as 
far as it can start our Linux box we are happy.

> 
>> The followings links give an overview of the activity:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/crypto/talitos.c 
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c 
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/arch/powerpc/kernel/head_8xx.S 
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/arch/powerpc/mm/8xx_mmu.c 
>>
>>
>> We have thousands of boards with mpc885 running and requiring support 
>> for at least the next 10 years.
> 
> Ok, nice to hear!
> 
>> How can the 8xx survive without U-boot support ?
> 
> Tom asked (I think a lot of times) regarding converting mpc8xx to
> Kconfig / DM and nobody did the necessary steps. We also asked
> our customers if they can do the necessary changes, none was interested.

I did't know. Indeed I was not following uboot activity until someone 
who knows the level of interest we have in 8xx alerted me yesterday.
It would have been nice if you had notified linuxppc-dev list.

> 
> So, if you need mpc8xx support in U-Boot, simply add it again with
> Kconfig and DM support included!

Ok, I'll try and come with a patch to convert 8xx in the coming weeks. 
In the mean time please revert the deletion in order to avoid nightmare 
conflicts when the converting patch comes.

Thanks
Christophe
