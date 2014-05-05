Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8DC141402B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 22:21:15 +1000 (EST)
Message-ID: <53678236.7060206@suse.de>
Date: Mon, 05 May 2014 14:21:10 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Tudor Laurentiu <b10716@freescale.com>
Subject: Re: [PATCH] powerpc: move epapr paravirt init of power_save to an
 initcall
References: <1398887641-20705-1-git-send-email-stuart.yoder@freescale.com>
 <5361556D.7080805@suse.de>
 <33939d8249c34c8fb694da3e94196211@DM2PR03MB352.namprd03.prod.outlook.com>
 <53615872.3010006@suse.de> <5367815F.5010509@freescale.com>
In-Reply-To: <5367815F.5010509@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, Laurentiu.Tudor@freescale.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/2014 02:17 PM, Tudor Laurentiu wrote:
> On 04/30/2014 11:09 PM, Alexander Graf wrote:
>>
>> On 30.04.14 22:03, Stuart Yoder wrote:
>>>
>>>> -----Original Message-----
>>>> From: Alexander Graf [mailto:agraf@suse.de]
>>>> Sent: Wednesday, April 30, 2014 2:56 PM
>>>> To: Yoder Stuart-B08248; benh@kernel.crashing.org; Wood Scott-B07421
>>>> Cc: linuxppc-dev@lists.ozlabs.org
>>>> Subject: Re: [PATCH] powerpc: move epapr paravirt init of 
>>>> power_save to
>>>> an initcall
>>>>
>>>>
>>>> On 30.04.14 21:54, Stuart Yoder wrote:
>>>>> From: Stuart Yoder <stuart.yoder@freescale.com>
>>>>>
>>>>> some restructuring of epapr paravirt init resulted in
>>>>> ppc_md.power_save being set, and then overwritten to
>>>>> NULL during machine_init.  This patch splits the
>>>>> initialization of ppc_md.power_save out into a postcore
>>>>> init call.
>>>>>
>>>>> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
>>>>> ---
>>>>>    arch/powerpc/kernel/epapr_paravirt.c |   25
>>>>> ++++++++++++++++++++-----
>>>>>    1 file changed, 20 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kernel/epapr_paravirt.c
>>>> b/arch/powerpc/kernel/epapr_paravirt.c
>>>>> index 6300c13..c49b69c 100644
>>>>> --- a/arch/powerpc/kernel/epapr_paravirt.c
>>>>> +++ b/arch/powerpc/kernel/epapr_paravirt.c
>>>>> @@ -52,11 +52,6 @@ static int __init 
>>>>> early_init_dt_scan_epapr(unsigned
>>>> long node,
>>>>>    #endif
>>>>>        }
>>>>>
>>>>> -#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>>>>> -    if (of_get_flat_dt_prop(node, "has-idle", NULL))
>>>>> -        ppc_md.power_save = epapr_ev_idle;
>>>>> -#endif
>>>>> -
>>>>>        epapr_paravirt_enabled = true;
>>>>>
>>>>>        return 1;
>>>>> @@ -69,3 +64,23 @@ int __init epapr_paravirt_early_init(void)
>>>>>        return 0;
>>>>>    }
>>>>>
>>>>> +static int __init epapr_idle_init_dt_scan(unsigned long node,
>>>>> +                       const char *uname,
>>>>> +                       int depth, void *data)
>>>>> +{
>>>>> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>>>>> +    if (of_get_flat_dt_prop(node, "has-idle", NULL))
>>>>> +        ppc_md.power_save = epapr_ev_idle;
>>>>> +#endif
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int __init epapr_idle_init(void)
>>>>> +{
>>>>> +    if (epapr_paravirt_enabled)
>>>>> +        of_scan_flat_dt(epapr_idle_init_dt_scan, NULL);
>>>> Doesn't this scan all nodes? We only want to match on
>>>> /hypervisor/has-idle, no?
>>> I cut/pasted from  the approach the existing code in that file
>>> took, but yes you're right we just need the one property.
>>> Let me respin that to look at the hypervisor node only.
>>
>> Yeah, the same commit that introduced the breakage on has-idle also
>> removed the explicit check for /hypervisor.
>>
>> Laurentiu, was this change on purpose?
>>
>
> Alex,
>
> IIRC, at that time i had to switch from the normal "of" functions to a 
> completely different api that's available in early init stage. This 
> early "of" api is pretty limited (e.g. doesn't have a way to address a 
> specific node) and i had to use that function that scans the whole tree.

Ok, so it is an accident. Could you please post a patch that checks that 
the node we're looking at is called "hypervisor"? The simple API should 
give you enough information for that at least. Maybe you could even 
check that the parent node is the root node.


Alex
