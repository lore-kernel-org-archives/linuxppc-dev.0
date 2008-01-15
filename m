Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99726DDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 01:14:09 +1100 (EST)
Message-Id: <0D036B51-00BD-428C-9B24-57BE796AE90D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080109180105.7c745bde.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/3] sbc834x: Add support for Wind River SBC834x boards
Date: Tue, 15 Jan 2008 08:13:56 -0600
References: <11998577723665-git-send-email-paul.gortmaker@windriver.com>
	<1199857773848-git-send-email-paul.gortmaker@windriver.com>
	<20080109180105.7c745bde.sfr@canb.auug.org.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2008, at 1:01 AM, Stephen Rothwell wrote:

> Hi Paul,
>
> On Wed,  9 Jan 2008 00:49:30 -0500 Paul Gortmaker <paul.gortmaker@windriver.com 
> > wrote:
>>
>> +static void __init sbc834x_init_IRQ(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	np = of_find_node_by_type(NULL, "ipic");
>> +	if (!np)
>> +		return;
>> +
>> +	ipic_init(np, 0);
>> +
>> +	/* Initialize the default interrupt mapping priorities,
>> +	 * in case the boot rom changed something on us.
>> +	 */
>> +	ipic_set_default_priority();
>> +}
>
> This needs an of_node_put(np) somewhere.
>
>> +static struct of_device_id sbc834x_ids[] = {
>
> __initdata
>
>> +static int __init sbc834x_declare_of_platform_devices(void)
>> +{
>> +	if (!machine_is(sbc834x))
>> +		return 0;
>> +
>> +	of_platform_bus_probe(NULL, sbc834x_ids, NULL);
>> +	return 0;
>> +}
>> +device_initcall(sbc834x_declare_of_platform_devices);
>
> machine_device_initcall(sbc834x, ...

Any updates here?  While David's .dts comments are probably valid I'm  
not going to make you have to deal with them to get into the tree.  We  
need to fix all the other 83xx platforms w/respect to those things.

- k
