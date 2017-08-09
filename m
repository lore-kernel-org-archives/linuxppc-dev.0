Return-Path: <clg@kaod.org>
Received: from 5.mo177.mail-out.ovh.net (5.mo177.mail-out.ovh.net
 [46.105.39.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS2lV6k5PzDqvc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 17:22:14 +1000 (AEST)
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 8886374309
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:14:58 +0200 (CEST)
Subject: Re: [PATCH 08/10] powerpc/xive: take into account
 '/ibm,plat-res-int-priorities'
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-9-git-send-email-clg@kaod.org>
 <20170809040227.GE13670@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0aaa22ae-6bb7-719c-f772-4f24b8eb9dc9@kaod.org>
Date: Wed, 9 Aug 2017 09:14:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170809040227.GE13670@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2017 06:02 AM, David Gibson wrote:
> On Tue, Aug 08, 2017 at 10:56:18AM +0200, Cédric Le Goater wrote:
>> '/ibm,plat-res-int-priorities' contains a list of priorities that the
>> hypervisor has reserved for its own use. Scan these ranges to choose
>> the lowest unused priority for the xive spapr backend.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/sysdev/xive/spapr.c | 62 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
>> index 7fc40047c23d..220331986bd8 100644
>> --- a/arch/powerpc/sysdev/xive/spapr.c
>> +++ b/arch/powerpc/sysdev/xive/spapr.c
>> @@ -532,13 +532,70 @@ static const struct xive_ops xive_spapr_ops = {
>>  	.name			= "spapr",
>>  };
>>  
>> +/*
>> + * get max priority from "/ibm,plat-res-int-priorities"
>> + */
>> +static bool xive_get_max_prio(u8 *max_prio)
>> +{
>> +	struct device_node *rootdn;
>> +	const __be32 *reg;
>> +	u32 len;
>> +	int prio, found;
>> +
>> +	rootdn = of_find_node_by_path("/");
>> +	if (!rootdn) {
>> +		pr_err("not root node found !\n");
>> +		return false;
>> +	}
>> +
>> +	reg = of_get_property(rootdn, "ibm,plat-res-int-priorities", &len);
>> +	if (!reg) {
>> +		pr_err("Failed to read 'ibm,plat-res-int-priorities' property\n");
>> +		return false;
>> +	}
>> +
>> +	if (len % (2 * sizeof(u32)) != 0) {
>> +		pr_err("invalid 'ibm,plat-res-int-priorities' property\n");
>> +		return false;
>> +	}
>> +
>> +	/* HW supports priorities in the range [0-7] and 0xFF is a
>> +	 * wildcard priority used to mask. We scan the ranges reserved
>> +	 * by the hypervisor to find the lowest priority we can use.
>> +	 */
>> +	found = 0xFF;
>> +	for (prio = 0; prio < 8; prio++) {
>> +		int reserved = 0;
>> +		int i;
>> +
>> +		for (i = 0; i < len / (2 * sizeof(u32)); i++) {
>> +			int base  = be32_to_cpu(reg[2 * i]);
>> +			int range = be32_to_cpu(reg[2 * i + 1]);
>> +
>> +			if (prio >= base && prio < base + range)
>> +				reserved++;
>> +		}
>> +
>> +		if (!reserved)
>> +			found = prio;
> 
> So you continue the loop here, rather than using break.  Which means
> found will be the highest valued priority that's not reserved.  Is
> that what you intended?  The commit message says you find the lowest
> unused, but do lower numbers mean higher priorities or the other way around?

yes. I should probably add a statement on how the priorities are 
ordered : the most privileged is the lowest value.

Thanks,

C. 

>> +	}
>> +
>> +	if (found == 0xFF) {
>> +		pr_err("no valid priority found in 'ibm,plat-res-int-priorities'\n");
>> +		return false;
>> +	}
>> +
>> +	*max_prio = found;
>> +	return true;
>> +}
>> +
>>  bool xive_spapr_init(void)
>>  {
>>  	struct device_node *np;
>>  	struct resource r;
>>  	void __iomem *tima;
>>  	struct property *prop;
>> -	u8 max_prio = 7;
>> +	u8 max_prio;
>>  	u32 val;
>>  	u32 len;
>>  	const __be32 *reg;
>> @@ -566,6 +623,9 @@ bool xive_spapr_init(void)
>>  		return false;
>>  	}
>>  
>> +	if (!xive_get_max_prio(&max_prio))
>> +		return false;
>> +
>>  	/* Feed the IRQ number allocator with the ranges given in the DT */
>>  	reg = of_get_property(np, "ibm,xive-lisn-ranges", &len);
>>  	if (!reg) {
> 
