Return-Path: <clumsycg@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 39EA5DDFA5
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 01:27:14 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so205845pyg.27
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 08:27:13 -0700 (PDT)
Message-ID: <486B9E53.7070606@gmail.com>
Date: Wed, 02 Jul 2008 23:27:15 +0800
From: Chen Gong <clumsycg@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Add support for MPC8536DS
References: <Pine.LNX.4.64.0807020201030.24791@blarg.am.freescale.net>
	<20080702170814.de282293.sfr@canb.auug.org.au>
	<486B8AFE.7060303@gmail.com>
	<F2A6FF1A-CF7F-4B2A-94B3-4C0E0693CB21@kernel.crashing.org>
In-Reply-To: <F2A6FF1A-CF7F-4B2A-94B3-4C0E0693CB21@kernel.crashing.org>
Content-Type: text/plain; charset=GB2312
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala Ð´µÀ:
> 
> On Jul 2, 2008, at 9:04 AM, Chen Gong wrote:
> 
>> Stephen Rothwell Ð´µÀ:
>>> Hi Kumar,
>>>
>>> On Wed, 2 Jul 2008 02:01:10 -0500 (CDT) Kumar Gala 
>>> <galak@kernel.crashing.org> wrote:
>>>> +void __init mpc8536_ds_pic_init(void)
>>>> +{
>>>> +    struct mpic *mpic;
>>>> +    struct resource r;
>>>> +    struct device_node *np = NULL;
>>>
>>> You don't need to initialise this.
>>>
>>>> +    np = of_find_node_by_type(np, "open-pic");
>>>> +
>>>
>>> Extra blank line.
>>>
>>>> +    if (np == NULL) {
>>>> +        printk(KERN_ERR "Could not find open-pic node\n");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (of_address_to_resource(np, 0, &r)) {
>>>> +        printk(KERN_ERR "Failed to map mpic register space\n");
>>>> +        of_node_put(np);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    mpic = mpic_alloc(np, r.start,
>>>> +              MPIC_PRIMARY | MPIC_WANTS_RESET |
>>>> +              MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
>>>> +            0, 256, " OpenPIC  ");
>>>> +    BUG_ON(mpic == NULL);
>>>> +
>>>> +    mpic_init(mpic);
>>>
>>> You leak a reference to np here.
>>
>> It looks like there are same problem in other mpc85xx_xx.c files
> 
> agreed for the mpc85xx_ds.c, I dont see the _cds or _ads having these 
> issues.

Yes, maybe I should write as mpc8xxx_xx.c, because it seems there is
the same problem in mpc8610_hpcd.c mpc86xx_hpcn.c etc.
> 
> - k
> 
> 
