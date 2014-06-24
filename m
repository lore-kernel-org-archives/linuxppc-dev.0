Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC9231A017A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 12:32:31 +1000 (EST)
Message-ID: <1403577141.4587.147.camel@pasglop>
Subject: Re: [PATCH 5/9] [arch/powerpc] replace obsolete strict_strto* calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Walter <dwalter@google.com>
Date: Tue, 24 Jun 2014 12:32:21 +1000
In-Reply-To: <20140621120536.GA7372@google.com>
References: <20140621120536.GA7372@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-06-21 at 13:05 +0100, Daniel Walter wrote:
> Replace strict_strto calls with more appropriate kstrto calls
> 
> Signed-off-by: Daniel Walter <dwalter@google.com>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

Should I put that in the powerpc tree ?

>  arch/powerpc/kernel/setup_64.c            | 6 +++---
>  arch/powerpc/kernel/vio.c                 | 2 +-
>  arch/powerpc/platforms/pseries/dlpar.c    | 4 ++--
>  arch/powerpc/platforms/pseries/mobility.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index ee082d7..5257166 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -149,13 +149,13 @@ static void check_smt_enabled(void)
>  		else if (!strcmp(smt_enabled_cmdline, "off"))
>  			smt_enabled_at_boot = 0;
>  		else {
> -			long smt;
> +			int smt;
>  			int rc;
>  
> -			rc = strict_strtol(smt_enabled_cmdline, 10, &smt);
> +			rc = kstrtoint(smt_enabled_cmdline, 10, &smt);
>  			if (!rc)
>  				smt_enabled_at_boot =
> -					min(threads_per_core, (int)smt);
> +					min(threads_per_core, smt);
>  		}
>  	} else {
>  		dn = of_find_node_by_path("/options");
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 904c661..5bfdab9 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -977,7 +977,7 @@ static ssize_t viodev_cmo_desired_set(struct device *dev,
>  	size_t new_desired;
>  	int ret;
>  
> -	ret = strict_strtoul(buf, 10, &new_desired);
> +	ret = kstrtoul(buf, 10, &new_desired);
>  	if (ret)
>  		return ret;
>  
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 022b38e..abc6892 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -399,10 +399,10 @@ out:
>  static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
>  {
>  	struct device_node *dn, *parent;
> -	unsigned long drc_index;
> +	u32 drc_index;
>  	int rc;
>  
> -	rc = strict_strtoul(buf, 0, &drc_index);
> +	rc = kstrtou32(buf, 0, &drc_index);
>  	if (rc)
>  		return -EINVAL;
>  
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index bde7eba..0694ac6 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -319,7 +319,7 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
>  	u64 streamid;
>  	int rc;
>  
> -	rc = strict_strtoull(buf, 0, &streamid);
> +	rc = kstrtou64(buf, 0, &streamid);
>  	if (rc)
>  		return rc;
>  
