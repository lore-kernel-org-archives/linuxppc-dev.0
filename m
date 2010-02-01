Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F3F2B7D70
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Feb 2010 13:16:21 +1100 (EST)
Subject: Re: [PATCH 01/10] arch/powerpc: Fix continuation line formats
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joe Perches <joe@perches.com>
In-Reply-To: <d8e2cb6523906c5e77bb13ea9ffc077a9310dc9e.1264967498.git.joe@perches.com>
References: <cover.1264967493.git.joe@perches.com>
	<d8e2cb6523906c5e77bb13ea9ffc077a9310dc9e.1264967498.git.joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 13:16:14 +1100
Message-ID: <1264990574.8287.15.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-01-31 at 12:02 -0800, Joe Perches wrote:
> String constants that are continued on subsequent lines with \
> are not good.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

You want me to take that in the powerpc tree ?

A minor glitch below tho...

> ---
>  arch/powerpc/kernel/nvram_64.c               |    6 +++---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |    8 ++++----
>  arch/powerpc/platforms/pseries/smp.c         |    4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index ad461e7..9cf197f 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -338,8 +338,8 @@ static int __init nvram_create_os_partition(void)
>  
>  	rc = nvram_write_header(new_part);
>  	if (rc <= 0) {
> -		printk(KERN_ERR "nvram_create_os_partition: nvram_write_header \
> -				failed (%d)\n", rc);
> +		printk(KERN_ERR "nvram_create_os_partition: nvram_write_header "
> +				"failed (%d)\n", rc);
>  		return rc;
>  	}
>  
> @@ -349,7 +349,7 @@ static int __init nvram_create_os_partition(void)
>  	rc = ppc_md.nvram_write((char *)&seq_init, sizeof(seq_init), &tmp_index);
>  	if (rc <= 0) {
>  		printk(KERN_ERR "nvram_create_os_partition: nvram_write "
> -				"failed (%d)\n", rc);
> +		       "failed (%d)\n", rc);
>  		return rc;
>  	}

The above is objectionable :-)

>  	
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 6ea4698..a70de10 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -397,12 +397,12 @@ static int parse_cede_parameters(void)
>  				CEDE_LATENCY_PARAM_MAX_LENGTH);
>  
>  	if (call_status != 0)
> -		printk(KERN_INFO "CEDE_LATENCY: \
> -			%s %s Error calling get-system-parameter(0x%x)\n",
> +		printk(KERN_INFO "CEDE_LATENCY: "
> +			"%s %s Error calling get-system-parameter(0x%x)\n",
>  			__FILE__, __func__, call_status);
>  	else
> -		printk(KERN_INFO "CEDE_LATENCY: \
> -			get-system-parameter successful.\n");
> +		printk(KERN_INFO "CEDE_LATENCY: "
> +			"get-system-parameter successful.\n");
>  
>  	return call_status;
>  }
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index b488663..4e7f89a 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -144,8 +144,8 @@ static void __devinit smp_pSeries_kick_cpu(int nr)
>  		hcpuid = get_hard_smp_processor_id(nr);
>  		rc = plpar_hcall_norets(H_PROD, hcpuid);
>  		if (rc != H_SUCCESS)
> -			printk(KERN_ERR "Error: Prod to wake up processor %d\
> -						Ret= %ld\n", nr, rc);
> +			printk(KERN_ERR "Error: Prod to wake up processor %d "
> +						"Ret= %ld\n", nr, rc);
>  	}
>  }
>  
