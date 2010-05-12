Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Matt Evans <matt@axio.ms>
Subject: Re: [PATCH] kexec-tools,
	ppc64: Fix segfault parsing DR memory property
In-reply-to: <4BE9102C.6040404@axio.ms>
References: <4BE9102C.6040404@axio.ms>
Date: Wed, 12 May 2010 12:50:07 +1000
Message-ID: <17320.1273632607@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <4BE9102C.6040404@axio.ms> you wrote:
> 
> add_dyn_reconf_usable_mem_property() iterates over memory spans
> in /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory and intersects
> these with usablemem_rgns ranges.  Not only did it seem to write
> null properties for every range that didn't match, but it used an unchecked
> fixed-size array which will overrun on machines with lots of LMBs.
> 
> This patch stops add_dyn_reconf_usable_mem_property() from adding null ranges
> to the linux,drconf-usable-memory property and removes its fixed-size array,
> as well as the array in add_usable_mem_property, in lieu of malloc/realloc/fr
ee.
> 

Thanks matt!

Acked-by: Michael Neuling <mikey@neuling.org>


> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  kexec/arch/ppc64/fs2dt.c |   66 +++++++++++++++++++++++++++++++++++++-------
-
>  1 files changed, 54 insertions(+), 12 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
> index 762bf04..7470132 100644
> --- a/kexec/arch/ppc64/fs2dt.c
> +++ b/kexec/arch/ppc64/fs2dt.c
> @@ -37,7 +37,7 @@
>  #define NAMESPACE 16384		/* max bytes for property names */
>  #define INIT_TREE_WORDS 65536	/* Initial num words for prop values */
>  #define MEMRESERVE 256		/* max number of reserved memory blocks
 */
> -#define MAX_MEMORY_RANGES 1024
> +#define MEM_RANGE_CHUNK_SZ 2048 /* Initial num dwords for mem ranges */
>  
>  static char pathname[MAXPATH], *pathstart;
>  static char propnames[NAMESPACE] = { 0 };
> @@ -148,7 +148,8 @@ static void add_dyn_reconf_usable_mem_property(int fd)
>  {
>  	char fname[MAXPATH], *bname;
>  	uint64_t buf[32];
> -	uint64_t ranges[2*MAX_MEMORY_RANGES];
> +	uint64_t *ranges;
> +	int ranges_size = MEM_RANGE_CHUNK_SZ;
>  	uint64_t base, end, loc_base, loc_end;
>  	size_t i, rngs_cnt, range;
>  	int rlen = 0;
> @@ -165,6 +166,11 @@ static void add_dyn_reconf_usable_mem_property(int fd)
>  		die("unrecoverable error: error seeking in \"%s\": %s\n",
>  			pathname, strerror(errno));
>  
> +	ranges = malloc(ranges_size*8);
> +	if (!ranges)
> +		die("unrecoverable error: can't alloc %d bytes for ranges.\n",
> +		    ranges_size*8);
> +
>  	rlen = 0;
>  	for (i = 0; i < num_of_lmbs; i++) {
>  		if (read(fd, buf, 24) < 0)
> @@ -180,24 +186,41 @@ static void add_dyn_reconf_usable_mem_property(int fd)
>  
>  		rngs_cnt = 0;
>  		for (range = 0; range < usablemem_rgns.size; range++) {
> +			int add = 0;
>  			loc_base = usablemem_rgns.ranges[range].start;
>  			loc_end = usablemem_rgns.ranges[range].end;
>  			if (loc_base >= base && loc_end <= end) {
> -				ranges[rlen++] = loc_base;
> -				ranges[rlen++] = loc_end - loc_base;
> -				rngs_cnt++;
> +				add = 1;
>  			} else if (base < loc_end && end > loc_base) {
>  				if (loc_base < base)
>  					loc_base = base;
>  				if (loc_end > end)
>  					loc_end = end;
> +				add = 1;
> +			}
> +
> +			if (add) {
> +				if (rlen >= (ranges_size-2)) {
> +					ranges_size += MEM_RANGE_CHUNK_SZ;
> +					ranges = realloc(ranges, ranges_size*8)
;
> +					if (!ranges)
> +						die("unrecoverable error: can't
"
> +						    " realloc %d bytes for"
> +						    " ranges.\n",
> +						    ranges_size*8);
> +				}
>  				ranges[rlen++] = loc_base;
>  				ranges[rlen++] = loc_end - loc_base;
>  				rngs_cnt++;
>  			}
>  		}
> -		/* Store the count of (base, size) duple */
> -		ranges[tmp_indx] = rngs_cnt;
> +		if (rngs_cnt == 0) {
> +			/* Don't store anything for unwritten iterations! */
> +			rlen = tmp_indx;
> +		} else {
> +			/* Store the count of (base, size) duple */
> +			ranges[tmp_indx] = rngs_cnt;
> +		}
>  	}
>  		
>  	rlen = rlen * sizeof(uint64_t);
> @@ -210,7 +233,8 @@ static void add_dyn_reconf_usable_mem_property(int fd)
>  	*dt++ = propnum("linux,drconf-usable-memory");
>  	if ((rlen >= 8) && ((unsigned long)dt & 0x4))
>  		dt++;
> -	memcpy(dt, &ranges, rlen);
> +	memcpy(dt, ranges, rlen);
> +	free(ranges);
>  	dt += (rlen + 3)/4;
>  }
>  
> @@ -218,7 +242,8 @@ static void add_usable_mem_property(int fd, size_t len)
>  {
>  	char fname[MAXPATH], *bname;
>  	uint64_t buf[2];
> -	uint64_t ranges[2*MAX_MEMORY_RANGES];
> +	uint64_t *ranges;
> +	int ranges_size = MEM_RANGE_CHUNK_SZ;
>  	uint64_t base, end, loc_base, loc_end;
>  	size_t range;
>  	int rlen = 0;
> @@ -247,17 +272,33 @@ static void add_usable_mem_property(int fd, size_t len)
>  	base = buf[0];
>  	end = base + buf[1];
>  
> +	ranges = malloc(ranges_size*8);
> +	if (!ranges)
> +		die("unrecoverable error: can't alloc %d bytes for ranges.\n",
> +		    ranges_size*8);
> +
>  	for (range = 0; range < usablemem_rgns.size; range++) {
> +		int add = 0;
>  		loc_base = usablemem_rgns.ranges[range].start;
>  		loc_end = usablemem_rgns.ranges[range].end;
>  		if (loc_base >= base && loc_end <= end) {
> -			ranges[rlen++] = loc_base;
> -			ranges[rlen++] = loc_end - loc_base;
> +			add = 1;
>  		} else if (base < loc_end && end > loc_base) {
>  			if (loc_base < base)
>  				loc_base = base;
>  			if (loc_end > end)
>  				loc_end = end;
> +			add = 1;
> +		}
> +		if (add) {
> +			if (rlen >= (ranges_size-2)) {
> +				ranges_size += MEM_RANGE_CHUNK_SZ;
> +				ranges = realloc(ranges, ranges_size*8);
> +				if (!ranges) 
> +					die("unrecoverable error: can't realloc
"
> +					    "%d bytes for ranges.\n",
> +					    ranges_size*8);
> +			}
>  			ranges[rlen++] = loc_base;
>  			ranges[rlen++] = loc_end - loc_base;
>  		}
> @@ -283,7 +324,8 @@ static void add_usable_mem_property(int fd, size_t len)
>  	*dt++ = propnum("linux,usable-memory");
>  	if ((rlen >= 8) && ((unsigned long)dt & 0x4))
>  		dt++;
> -	memcpy(dt,&ranges,rlen);
> +	memcpy(dt, ranges, rlen);
> +	free(ranges);
>  	dt += (rlen + 3)/4;
>  }
>  
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
