Return-Path: <geoff@infradead.org>
Message-ID: <4E39CBFC.2010501@infradead.org>
Date: Wed, 3 Aug 2011 15:30:20 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 02/15] [PS3] Get lv1 high memory region from devtree
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-3-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-3-git-send-email-a.heider@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2011 01:02 PM, Andre Heider wrote:
> 
> This lets the bootloader preallocate the high lv1 region and pass its
> location to the kernel through the devtree. Thus, it can be used to hold
> the initrd. If the property doesn't exist, the kernel retains the old
> behavior and attempts to allocate the region itself.

With this mechanism how is the address of the initrd passed to the
new kernel, in the DT?

How would a kexec based bootloader work?  If it's kernel were to allocate
high mem and the bootloader program uses the high mem, how could it tell
that kernel not to destroy the region on shutdown?

If arch/powerpc/boot/ps3.c allocated the mem and added a DT entry
then other OSes that don't know about the Linux device tree won't
be able to use that allocated memory.  Other OSes could do a
test to see if the allocation was already done.  Another option
that might work is to write info into the LV1 repository then
have boot code look there for allocated hig mem.

> Signed-off-by: Hector Martin <hector@marcansoft.com>
> [a.heider: Various cleanups to make checkpatch.pl happy]
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/mm.c |   61 +++++++++++++++++++++++++++++++++++++-
>  1 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
> index c204588..30bb096 100644
> --- a/arch/powerpc/platforms/ps3/mm.c
> +++ b/arch/powerpc/platforms/ps3/mm.c
> @@ -110,6 +110,7 @@ struct map {
>  	u64 htab_size;
>  	struct mem_region rm;
>  	struct mem_region r1;
> +	int destroy_r1;

In the general case we could have multiple high mem
regions, and each could need to be destroyed, so I
think struct mem_region should have a destroy flag.

>  };
>  
>  #define debug_dump_map(x) _debug_dump_map(x, __func__, __LINE__)
> @@ -287,6 +288,49 @@ static void ps3_mm_region_destroy(struct mem_region *r)
>  	}
>  }
>  
> +static int ps3_mm_scan_memory(unsigned long node, const char *uname,
> +			      int depth, void *data)
> +{

Something like 'ps3_mm_dt_scan_highmem() is more descriptive.

> +	struct mem_region *r = data;
> +	void *p;
> +	u64 prop[2];
> +	unsigned long l;
> +	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +
> +	if (type == NULL)
> +		return 0;
> +	if (strcmp(type, "memory") != 0)

Should this be 'if (strcmp(type, "memory"))'?

> +		return 0;
> +
> +	p = of_get_flat_dt_prop(node, "sony,lv1-highmem", &l);
> +	if (p == NULL)
> +		return 0;
> +
> +	BUG_ON(l != sizeof(prop));
> +	memcpy(prop, p, sizeof(prop));
> +
> +	r->base = prop[0];
> +	r->size = prop[1];
> +	r->offset = r->base - map.rm.size;
> +
> +	return -1;
> +}
> +
> +static int ps3_mm_get_devtree_highmem(struct mem_region *r)
> +{
> +	r->size = r->base = r->offset = 0;
> +	of_scan_flat_dt(ps3_mm_scan_memory, r);
> +
> +	if (r->base && r->size) {
> +		DBG("%s:%d got high region from devtree: %llxh %llxh\n",
> +		__func__, __LINE__, r->base, r->size);
> +		return 0;
> +	} else {
> +		DBG("%s:%d no high region in devtree...\n", __func__, __LINE__);
> +		return -1;
> +	}
> +}
> +
>  /**
>   * ps3_mm_add_memory - hot add memory
>   */
> @@ -303,6 +347,12 @@ static int __init ps3_mm_add_memory(void)
>  
>  	BUG_ON(!mem_init_done);
>  
> +	if (!map.r1.size) {
> +		DBG("%s:%d: no region 1, not adding memory\n",
> +		    __func__, __LINE__);
> +		return 0;
> +	}

Did you find this to be hit?  Also, in the general case,
there could be more than one high mem region, but I don't
know of any current systems that do.

> +
>  	start_addr = map.rm.size;
>  	start_pfn = start_addr >> PAGE_SHIFT;
>  	nr_pages = (map.r1.size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> @@ -1219,7 +1269,13 @@ void __init ps3_mm_init(void)
>  
>  
>  	/* arrange to do this in ps3_mm_add_memory */
> -	ps3_mm_region_create(&map.r1, map.total - map.rm.size);
> +
> +	if (ps3_mm_get_devtree_highmem(&map.r1) == 0) {
> +		map.destroy_r1 = 0;
> +	} else {

This should be

	if (!ps3_mm_get_devtree_highmem(&map.r1))
		map.destroy_r1 = 0;
	else {

> +		ps3_mm_region_create(&map.r1, map.total - map.rm.size);
> +		map.destroy_r1 = 1;
> +	}
>  
>  	/* correct map.total for the real total amount of memory we use */
>  	map.total = map.rm.size + map.r1.size;
> @@ -1233,5 +1289,6 @@ void __init ps3_mm_init(void)
>  
>  void ps3_mm_shutdown(void)
>  {
> -	ps3_mm_region_destroy(&map.r1);
> +	if (map.destroy_r1)
> +		ps3_mm_region_destroy(&map.r1);
>  }

-Geoff
