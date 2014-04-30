Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DFE1F14008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 06:09:26 +1000 (EST)
Message-ID: <53615872.3010006@suse.de>
Date: Wed, 30 Apr 2014 22:09:22 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Stuart Yoder <stuart.yoder@freescale.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: move epapr paravirt init of power_save to an
 initcall
References: <1398887641-20705-1-git-send-email-stuart.yoder@freescale.com>
 <5361556D.7080805@suse.de>
 <33939d8249c34c8fb694da3e94196211@DM2PR03MB352.namprd03.prod.outlook.com>
In-Reply-To: <33939d8249c34c8fb694da3e94196211@DM2PR03MB352.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Laurentiu.Tudor@freescale.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.04.14 22:03, Stuart Yoder wrote:
>
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Wednesday, April 30, 2014 2:56 PM
>> To: Yoder Stuart-B08248; benh@kernel.crashing.org; Wood Scott-B07421
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH] powerpc: move epapr paravirt init of power_save to
>> an initcall
>>
>>
>> On 30.04.14 21:54, Stuart Yoder wrote:
>>> From: Stuart Yoder <stuart.yoder@freescale.com>
>>>
>>> some restructuring of epapr paravirt init resulted in
>>> ppc_md.power_save being set, and then overwritten to
>>> NULL during machine_init.  This patch splits the
>>> initialization of ppc_md.power_save out into a postcore
>>> init call.
>>>
>>> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
>>> ---
>>>    arch/powerpc/kernel/epapr_paravirt.c |   25 ++++++++++++++++++++-----
>>>    1 file changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/epapr_paravirt.c
>> b/arch/powerpc/kernel/epapr_paravirt.c
>>> index 6300c13..c49b69c 100644
>>> --- a/arch/powerpc/kernel/epapr_paravirt.c
>>> +++ b/arch/powerpc/kernel/epapr_paravirt.c
>>> @@ -52,11 +52,6 @@ static int __init early_init_dt_scan_epapr(unsigned
>> long node,
>>>    #endif
>>>    	}
>>>
>>> -#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>>> -	if (of_get_flat_dt_prop(node, "has-idle", NULL))
>>> -		ppc_md.power_save = epapr_ev_idle;
>>> -#endif
>>> -
>>>    	epapr_paravirt_enabled = true;
>>>
>>>    	return 1;
>>> @@ -69,3 +64,23 @@ int __init epapr_paravirt_early_init(void)
>>>    	return 0;
>>>    }
>>>
>>> +static int __init epapr_idle_init_dt_scan(unsigned long node,
>>> +					   const char *uname,
>>> +					   int depth, void *data)
>>> +{
>>> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>>> +	if (of_get_flat_dt_prop(node, "has-idle", NULL))
>>> +		ppc_md.power_save = epapr_ev_idle;
>>> +#endif
>>> +	return 0;
>>> +}
>>> +
>>> +static int __init epapr_idle_init(void)
>>> +{
>>> +	if (epapr_paravirt_enabled)
>>> +		of_scan_flat_dt(epapr_idle_init_dt_scan, NULL);
>> Doesn't this scan all nodes? We only want to match on
>> /hypervisor/has-idle, no?
> I cut/pasted from  the approach the existing code in that file
> took, but yes you're right we just need the one property.
> Let me respin that to look at the hypervisor node only.

Yeah, the same commit that introduced the breakage on has-idle also 
removed the explicit check for /hypervisor.

Laurentiu, was this change on purpose?



commit 4e21b94c9c644c43223878f4c848e852743e789c
Author: Laurentiu TUDOR <Laurentiu.Tudor@freescale.com>
Date:   Wed Jul 3 17:13:15 2013 +0300

     powerpc/85xx: Move ePAPR paravirt initialization earlier

     At console init, when the kernel tries to flush the log buffer
     the ePAPR byte-channel based console write fails silently,
     losing the buffered messages.
     This happens because The ePAPR para-virtualization init isn't
     done early enough so that the hcall instruction to be set,
     causing the byte-channel write hcall to be a nop.
     To fix, change the ePAPR para-virt init to use early device
     tree functions and move it in early init.

     Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
     Signed-off-by: Scott Wood <scottwood@freescale.com>
[...]
diff --git a/arch/powerpc/kernel/epapr_paravirt.c 
b/arch/powerpc/kernel/epapr_paravirt.c
index d44a571..6300c13 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -30,22 +30,20 @@ extern u32 epapr_ev_idle_start[];

  bool epapr_paravirt_enabled;

-static int __init epapr_paravirt_init(void)
+static int __init early_init_dt_scan_epapr(unsigned long node,
+                                          const char *uname,
+                                          int depth, void *data)
  {
-       struct device_node *hyper_node;
         const u32 *insts;
-       int len, i;
+       unsigned long len;
+       int i;

-       hyper_node = of_find_node_by_path("/hypervisor");
-       if (!hyper_node)
-               return -ENODEV;
-
-       insts = of_get_property(hyper_node, "hcall-instructions", &len);
+       insts = of_get_flat_dt_prop(node, "hcall-instructions", &len);
         if (!insts)
-               return -ENODEV;
+               return 0;

         if (len % 4 || len > (4 * 4))
-               return -ENODEV;
+               return -1;
[...]


Alex
