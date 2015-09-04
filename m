Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 329971A027B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2015 04:10:20 +1000 (AEST)
Subject: Re: memcpy regression
To: Michal Sojka <sojkam1@fel.cvut.cz>
References: <871teeux4w.fsf@steelpick.2x.cz> <55E9A354.6070600@c-s.fr>
 <87si6utfpf.fsf@steelpick.2x.cz>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <55E9DE87.4070805@c-s.fr>
Date: Fri, 4 Sep 2015 20:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <87si6utfpf.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/09/2015 16:35, Michal Sojka a écrit :
> On Fri, Sep 04 2015, Christophe LEROY wrote:
>> Le 04/09/2015 15:33, Michal Sojka a écrit :
>>> Dear Christophe,
>>>
>>> my MPC5200-based system stopped booting recently. I bisected the problem
>>> to your commit below. If I revert that commit (on top of
>>> 807249d3ada1ff28a47c4054ca4edd479421b671 = v4.2-6663-g807249d), my
>>> system boots again.
>>>
>>>
>> Do you use mainline code only, or do you have home-made code ?
> I use mainline only sources with non-mainline device-tree.
>
>> memcpy() is not supposed to be used on non-cacheable memory.
>> memcpy_toio() is the function to use when copying to non-cacheble area.
>>
>> When I submitted the patch, I looked for erroneous use of memcpy() and
>> memset().
>> I found one wrong use of memset() that I changed to memset_io() but I
>> didn't find any misuse of memcpy().
>> But I may have missed one.
> I attach my .config, if it helps. I have there
>
> CONFIG_PPC_MPC52xx=y
> CONFIG_PPC_MPC5200_SIMPLE=y
>
> so arch/powerpc/platforms/52xx is probably the directory to look. Do you
> see any mempcy misuse there?
I only found one suspect use of memcpy() in arch/powerpc/platforms/52xx/
It is in mpc52xx_pm.c but it's linked to CONFIG_PM which is not selected 
by your .config
I'll check in the drivers selected by your .config

In parallele, are you able to try with CONFIG_PPC_EARLY_DEBUG in order 
to try and locate the blocking point ?

Christophe


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
