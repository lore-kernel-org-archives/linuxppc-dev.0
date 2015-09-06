Return-Path: <sojkam1@fel.cvut.cz>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 329EA1A1F3A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 05:05:26 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: memcpy regression
In-Reply-To: <55EBF6CD.5010001@c-s.fr>
References: <871teeux4w.fsf@steelpick.2x.cz> <55E9A354.6070600@c-s.fr>
 <87si6utfpf.fsf@steelpick.2x.cz> <55E9DE87.4070805@c-s.fr>
 <55E9F5CE.6050904@fel.cvut.cz> <55EA3281.3000806@fel.cvut.cz>
 <55EBF6CD.5010001@c-s.fr>
Date: Sun, 06 Sep 2015 21:05:15 +0200
Message-ID: <87twr74bdg.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 06 2015, christophe leroy wrote:
> Le 05/09/2015 02:08, Michal Sojka a =C3=A9crit :
>> On 4.9.2015 21:49, Michal Sojka wrote:
>>> On 4.9.2015 20:10, christophe leroy wrote:
>>>>
>>>>
>>>> Le 04/09/2015 16:35, Michal Sojka a =C3=A9crit :
>>>>> On Fri, Sep 04 2015, Christophe LEROY wrote:
>>>>>> Le 04/09/2015 15:33, Michal Sojka a =C3=A9crit :
>>>>>>> Dear Christophe,
>>>>>>>
>>>>>>> my MPC5200-based system stopped booting recently. I bisected the=20
>>>>>>> problem
>>>>>>> to your commit below. If I revert that commit (on top of
>>>>>>> 807249d3ada1ff28a47c4054ca4edd479421b671 =3D v4.2-6663-g807249d), my
>>>>>>> system boots again.
>>>>>>>
>>>>>>>
>>>>>> Do you use mainline code only, or do you have home-made code ?
>>>>> I use mainline only sources with non-mainline device-tree.
>>>>>
>>>>>> memcpy() is not supposed to be used on non-cacheable memory.
>>>>>> memcpy_toio() is the function to use when copying to non-cacheble=20
>>>>>> area.
>>>>>>
>>>>>> When I submitted the patch, I looked for erroneous use of memcpy()=20
>>>>>> and
>>>>>> memset().
>>>>>> I found one wrong use of memset() that I changed to memset_io() but I
>>>>>> didn't find any misuse of memcpy().
>>>>>> But I may have missed one.
>>>>> I attach my .config, if it helps. I have there
>>>>>
>>>>> CONFIG_PPC_MPC52xx=3Dy
>>>>> CONFIG_PPC_MPC5200_SIMPLE=3Dy
>>>>>
>>>>> so arch/powerpc/platforms/52xx is probably the directory to look.=20
>>>>> Do you
>>>>> see any mempcy misuse there?
>>>> I only found one suspect use of memcpy() in=20
>>>> arch/powerpc/platforms/52xx/
>>>> It is in mpc52xx_pm.c but it's linked to CONFIG_PM which is not=20
>>>> selected by your .config
>>>> I'll check in the drivers selected by your .config
>>>>
>>>> In parallele, are you able to try with CONFIG_PPC_EARLY_DEBUG in=20
>>>> order to try and locate the blocking point ?
>>> I don't get any output from the system even with CONFIG_PPC_EARLY_DEBUG.
>>
>> Hmm, there is no udbg console for MPC5200. I hacked something up and=20
>> the earliest place I was able to initialize it is after=20
>> early_init_devtree() in setup_32.c. Even with this console, I got no=20
>> output when the problematic patch was applied. So the problem is=20
>> somewhere earlier.
>>
>
> In early_init() in setup_32.c, there is the following comment:
> /* First zero the BSS -- use memset_io, some platforms don't have caches=
=20
> on yet */
>
> In that case, when does cache get activated ?
>
> In move_device_tree(), called from early_init_devtree(), there is a call=
=20
> to memcpy().
> Can you try replacing it by memcpy_io() ?

I tried replacing it by memcpy_toio(), memcpy_fromio() and by
generic_memcpy(). Nothing helped :(

-Michal
