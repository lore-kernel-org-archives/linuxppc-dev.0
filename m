Return-Path: <clumsycg@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 79FA1DDF47
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 00:04:54 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so180889pyg.27
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 07:04:53 -0700 (PDT)
Message-ID: <486B8AFE.7060303@gmail.com>
Date: Wed, 02 Jul 2008 22:04:46 +0800
From: Chen Gong <clumsycg@gmail.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/85xx: Add support for MPC8536DS
References: <Pine.LNX.4.64.0807020201030.24791@blarg.am.freescale.net>
	<20080702170814.de282293.sfr@canb.auug.org.au>
In-Reply-To: <20080702170814.de282293.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell Ð´µÀ:
> Hi Kumar,
> 
> On Wed, 2 Jul 2008 02:01:10 -0500 (CDT) Kumar Gala <galak@kernel.crashing.org> wrote:
>> +void __init mpc8536_ds_pic_init(void)
>> +{
>> +	struct mpic *mpic;
>> +	struct resource r;
>> +	struct device_node *np = NULL;
> 
> You don't need to initialise this.
> 
>> +	np = of_find_node_by_type(np, "open-pic");
>> +
> 
> Extra blank line.
> 
>> +	if (np == NULL) {
>> +		printk(KERN_ERR "Could not find open-pic node\n");
>> +		return;
>> +	}
>> +
>> +	if (of_address_to_resource(np, 0, &r)) {
>> +		printk(KERN_ERR "Failed to map mpic register space\n");
>> +		of_node_put(np);
>> +		return;
>> +	}
>> +
>> +	mpic = mpic_alloc(np, r.start,
>> +			  MPIC_PRIMARY | MPIC_WANTS_RESET |
>> +			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
>> +			0, 256, " OpenPIC  ");
>> +	BUG_ON(mpic == NULL);
>> +
>> +	mpic_init(mpic);
> 
> You leak a reference to np here.

It looks like there are same problem in other mpc85xx_xx.c files

> 
>> +static struct of_device_id mpc8536_ds_ids[] = {
> 
> __initdata, please.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
