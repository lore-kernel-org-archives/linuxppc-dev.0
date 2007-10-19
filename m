Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43516DE0AD
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:09:31 +1000 (EST)
In-Reply-To: <20071019104318.edfd2ad1.sfr@canb.auug.org.au>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com>
	<1192719847-25045-2-git-send-email-leoli@freescale.com>
	<1192719847-25045-3-git-send-email-leoli@freescale.com>
	<1192719847-25045-4-git-send-email-leoli@freescale.com>
	<20071019104318.edfd2ad1.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <044B09E9-2B1B-4BCC-BDFD-31269E41CC8F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 4/9] add platform support for MPC837x MDS board
Date: Fri, 19 Oct 2007 08:10:00 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 7:43 PM, Stephen Rothwell wrote:

> On Thu, 18 Oct 2007 23:04:02 +0800 Li Yang <leoli@freescale.com>  
> wrote:
>>
>> +++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
>> +static void __init mpc837x_mds_setup_arch(void)
>> +{
>> +#ifdef CONFIG_PCI
>> +	struct device_node *np;
>> +#endif
>> +
>> +	if (ppc_md.progress)
>> +		ppc_md.progress("mpc837x_mds_setup_arch()", 0);
>> +
>> +#ifdef CONFIG_PCI
>> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
>
> 	for_each_node_by_type(np, "pci")
>
>> +static int __init mpc837x_mds_probe(void)
>> +{
>> +        unsigned long root = of_get_flat_dt_root();
>> +
>> +        return of_flat_dt_is_compatible(root, "fsl,mpc837xmds");
>
> To call these two routines, you should include <asm/prom.h> directly.

what's the rule of thumb to know when to include <asm/prom.h> does  
everything starting with of_flat_* come from there?

- k
