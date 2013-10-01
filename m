Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 14:50:35 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/kernel/sysfs: cleanup set up macros for pmc/non
 pmc sprs
Message-ID: <20131001045035.GC17966@concordia>
References: <1380539849-6162-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380539849-6162-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 30, 2013 at 04:47:29PM +0530, Madhavan Srinivasan wrote:
> Currently pmc setup macros are used for non pmc sprs. This patch
> add new set of macros and cleans up the code to use the new setup macro
> for non pmc sprs.

Hi Maddy,

Firstly you should use "PMC" not pmc, it's an acronym. You should also
spell out what it means the first time you use it, eg:

  Currently the PMC (Performance Monitor Counter) macros are used ..

Secondly you need to say _why_ it is a bad idea to use the PMC macros
for non-PMC SPRs.

> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 27a90b9..73b6f9f 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -139,6 +139,37 @@ static ssize_t __used \
>  	return count; \
>  }
> 
> +#define SYSFS_SPRSETUP(NAME, ADDRESS) \
> +static void read_##NAME(void *val) \
> +{ \
> +	*(unsigned long *)val = mfspr(ADDRESS);	\
> +} \
> +static void write_##NAME(void *val) \
> +{ \
> +	mtspr(ADDRESS, *(unsigned long *)val);	\
> +} \
> +static ssize_t show_##NAME(struct device *dev, \
> +			struct device_attribute *attr, \
> +			char *buf) \
> +{ \
> +	struct cpu *cpu = container_of(dev, struct cpu, dev); \
> +	unsigned long val; \
> +	smp_call_function_single(cpu->dev.id, read_##NAME, &val, 1);	\
> +	return sprintf(buf, "%lx\n", val); \
> +} \
> +static ssize_t __used \
> +	store_##NAME(struct device *dev, struct device_attribute *attr, \
> +			const char *buf, size_t count) \
> +{ \
> +	struct cpu *cpu = container_of(dev, struct cpu, dev); \
> +	unsigned long val; \
> +	int ret = sscanf(buf, "%lx", &val); \
> +	if (ret != 1) \
> +		return -EINVAL; \
> +	smp_call_function_single(cpu->dev.id, write_##NAME, &val, 1); \
> +	return count; \
> +}

This is basically a complete copy of the SYSFS_PMCSETUP() macro, except
for the one line removal of the call to ppc_enable_pmcs().

You should be able to do better, by defining a macro that does all the
boiler plate and takes an "extra" argument, which for PMCs is
"ppc_enable_pmcs()" and for regular SPRs is empty.

cheers
