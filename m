Return-Path: <thor.thayer@linux.intel.com>
Received: from mga01.intel.com (unknown [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmhKx2sNlzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 04:31:00 +1000 (AEST)
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH v2 2/3] EDAC: altera: simplify calculation of total memory
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, bp@alien8.de,
 linux-edac@vger.kernel.org
Cc: mchehab@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20170606235500.22772-1-chris.packham@alliedtelesis.co.nz>
 <20170606235500.22772-3-chris.packham@alliedtelesis.co.nz>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <b052bfda-c5a3-7b23-682c-ab59c9c8ad3a@linux.intel.com>
Date: Mon, 12 Jun 2017 13:34:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170606235500.22772-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2017 06:54 PM, Chris Packham wrote:
> Use of_address_to_resource() and resource_size() instead of manually
> parsing the "reg" property from the "memory" node(s).
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - New
> 
>   drivers/edac/altera_edac.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 7717b094fabb..f8b623352627 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -214,24 +214,16 @@ static void altr_sdr_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
>   static unsigned long get_total_mem(void)
>   {
>   	struct device_node *np = NULL;
> -	const unsigned int *reg, *reg_end;
> -	int len, sw, aw;
> -	unsigned long start, size, total_mem = 0;
> +	struct resource res;
> +	int ret;
> +	unsigned long total_mem = 0;
>   
>   	for_each_node_by_type(np, "memory") {
> -		aw = of_n_addr_cells(np);
> -		sw = of_n_size_cells(np);
> -		reg = (const unsigned int *)of_get_property(np, "reg", &len);
> -		reg_end = reg + (len / sizeof(u32));
> -
> -		total_mem = 0;
> -		do {
> -			start = of_read_number(reg, aw);
> -			reg += aw;
> -			size = of_read_number(reg, sw);
> -			reg += sw;
> -			total_mem += size;
> -		} while (reg < reg_end);
> +		ret = of_address_to_resource(np, 0, &res);
> +		if (ret)
> +			continue;
> +
> +		total_mem += resource_size(&res);
>   	}
>   	edac_dbg(0, "total_mem 0x%lx\n", total_mem);
>   	return total_mem;
> 
Nice change! Tested on Cyclone5 DevKit & Arria10 DevKit.

Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
