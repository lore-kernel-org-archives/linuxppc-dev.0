Return-Path: <B10716@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 664262C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:30:04 +1000 (EST)
Received: from mail228-tx2 (localhost [127.0.0.1])	by
 mail228-tx2-R.bigfish.com (Postfix) with ESMTP id 3E194380220	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 12:30:00 +0000 (UTC)
Received: from TX2EHSMHS001.bigfish.com (unknown [10.9.14.241])	by
 mail228-tx2.bigfish.com (Postfix) with ESMTP id A071CBC0063	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 12:29:58 +0000 (UTC)
Message-ID: <51D41937.3000509@freescale.com>
Date: Wed, 3 Jul 2013 15:29:43 +0300
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][v2] powerpc/85xx: Move ePAPR paravirt initialization
 earlier
References: <1372769189-17864-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <1372787740.8183.113@snotra>
In-Reply-To: <1372787740.8183.113@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 08:55 PM, Scott Wood wrote:
> On 07/02/2013 07:46:29 AM, Laurentiu Tudor wrote:
>> diff --git a/arch/powerpc/kernel/epapr_paravirt.c
>> b/arch/powerpc/kernel/epapr_paravirt.c
>> index d44a571..d05f9da 100644
>> --- a/arch/powerpc/kernel/epapr_paravirt.c
>> +++ b/arch/powerpc/kernel/epapr_paravirt.c
>> @@ -30,38 +30,45 @@ extern u32 epapr_ev_idle_start[];
>>
>> bool epapr_paravirt_enabled;
>>
>> -static int __init epapr_paravirt_init(void)
>> +static int __init early_init_dt_scan_epapr(unsigned long node,
>> + const char *uname,
>> + int depth, void *data)
>> {
>> - struct device_node *hyper_node;
>> - const u32 *insts;
>> - int len, i;
>> + const u32 *instrs;
>> + unsigned long len;
>> + int i;
>>
>> - hyper_node = of_find_node_by_path("/hypervisor");
>> - if (!hyper_node)
>> - return -ENODEV;
>> + if (!of_flat_dt_is_compatible(node, "epapr,hypervisor-1"))
>> + return 0;
>
> QEMU doesn't set "epapr,hypervisor-1" but it still uses the same hcall
> mechanism. The compatible that QEMU sets is "linux,kvm". Perhaps QEMU
> should change, but we'd still like to be compatible with older QEMUs.
>
> How is this change related to moving initialization earlier?

Just a (extra-)check to see that i'm on the right node.
But considering your mention on qemu/kvm using a different compatible 
i'm thinking of dropping it and only try reading the 
"hcall-instructions" property.

>> - insts = of_get_property(hyper_node, "hcall-instructions", &len);
>> - if (!insts)
>> - return -ENODEV;
>> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>> + if (of_get_flat_dt_prop(node, "has-idle", NULL))
>> + ppc_md.power_save = epapr_ev_idle;
>> +#endif
>
> Why are you doing this before processing hcall-instructions?
>

Nothing of importance. The code seemed more clear to me.

---
Best Regards, Laurentiu
