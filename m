Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH] kexec-tools,
	ppc64: Fix segfault on parsing of large device trees.
In-reply-to: <4BE78E06.6080601@ozlabs.org>
References: <4BE78E06.6080601@ozlabs.org>
Date: Mon, 10 May 2010 14:55:03 +1000
Message-ID: <31392.1273467303@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <4BE78E06.6080601@ozlabs.org> you wrote:
> 
> ppc64's fs2dt used to use a fixed-size array into which the device tree
> was parsed.  There was no bounds checking, so with a large device tree other
> heap data ended up getting stomped -- SIGSEGV time.
> 
> This patch adds a function, 'dt_reserve', to check whether there's enough spa
ce
> left prior to writing data to the array.  If not, the array is realloced.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

FWIW...

Ack-by: Michael Neuling <mikey@neuling.org>

(also added linuxppc-dev@ozlabs.org to CC list)

> ---
>  kexec/arch/ppc64/fs2dt.c |   62 +++++++++++++++++++++++++++++++++++++++-----
-
>  1 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
> index f168cbc..762bf04 100644
> --- a/kexec/arch/ppc64/fs2dt.c
> +++ b/kexec/arch/ppc64/fs2dt.c
> @@ -35,13 +35,14 @@
>  
>  #define MAXPATH 1024		/* max path name length */
>  #define NAMESPACE 16384		/* max bytes for property names */
> -#define TREEWORDS 65536		/* max 32 bit words for property values
 */
> +#define INIT_TREE_WORDS 65536	/* Initial num words for prop values */
>  #define MEMRESERVE 256		/* max number of reserved memory blocks
 */
>  #define MAX_MEMORY_RANGES 1024
>  
>  static char pathname[MAXPATH], *pathstart;
>  static char propnames[NAMESPACE] = { 0 };
> -static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
> +static unsigned *dt_base, *dt;
> +static unsigned int dt_cur_size;
>  static unsigned long long mem_rsrv[2*MEMRESERVE] = { 0, 0 };
>  
>  static int crash_param = 0;
> @@ -50,6 +51,28 @@ extern mem_rgns_t usablemem_rgns;
>  static struct bootblock bb[1];
>  extern int my_debug;
>  
> +/* Before we add something to the dt, reserve N words using this.
> + * If there isn't enough room, it's realloced -- and you don't overflow and
> + * splat bits of your heap. 
> + */
> +void dt_reserve(unsigned **dt_ptr, unsigned words)
> +{
> +	if (((*dt_ptr - dt_base) + words) >= dt_cur_size) {
> +		int offset;
> +		unsigned int new_size = dt_cur_size + INIT_TREE_WORDS;
> +		unsigned *new_dt = realloc(dt_base, new_size*4);
> +
> +		if (!new_dt)
> +			die("unrecoverable error: Can't realloc %d bytes for "
> +			    "device tree\n", new_size*4);
> +		offset = *dt_ptr - dt_base;
> +		dt_base = new_dt;
> +		dt_cur_size = new_size;
> +		*dt_ptr = dt_base + offset;
> +		memset(*dt_ptr, 0, (new_size - offset)*4);
> +	}
> +}
> +
>  void reserve(unsigned long long where, unsigned long long length)
>  {
>  	size_t offset;
> @@ -181,6 +204,7 @@ static void add_dyn_reconf_usable_mem_property(int fd)
>  	/*
>  	 * Add linux,drconf-usable-memory property.
>  	 */
> +	dt_reserve(&dt, 4+((rlen + 3)/4));
>  	*dt++ = 3;
>  	*dt++ = rlen;
>  	*dt++ = propnum("linux,drconf-usable-memory");
> @@ -253,6 +277,7 @@ static void add_usable_mem_property(int fd, size_t len)
>  	/*
>  	 * No add linux,usable-memory property.
>  	 */
> +	dt_reserve(&dt, 4+((rlen + 3)/4));
>  	*dt++ = 3;
>  	*dt++ = rlen;
>  	*dt++ = propnum("linux,usable-memory");
> @@ -317,6 +342,7 @@ static void putprops(char *fn, struct dirent **nlist, int
 numlist)
>  
>  		len = statbuf.st_size;
>  
> +		dt_reserve(&dt, 4+((len + 3)/4));
>  		*dt++ = 3;
>  		*dt++ = len;
>  		*dt++ = propnum(fn);
> @@ -388,13 +414,17 @@ static void putnode(void)
>  	struct dirent **namelist;
>  	int numlist, i;
>  	struct stat statbuf;
> +	int plen;
>  
> +	plen = *pathstart ? strlen(pathstart) : 1;
> +	/* Reserve space for string packed to words; e.g. string length 10 
> +	 * occupies 3 words, length 12 occupies 4 (for terminating \0s).  
> +	 * So round up & include the \0:
> +	 */
> +	dt_reserve(&dt, 1+((plen + 4)/4));
>  	*dt++ = 1;
>  	strcpy((void *)dt, *pathstart ? pathstart : "/");
> -	while(*dt)
> -		dt++;
> -	if (dt[-1] & 0xff)
> -		dt++;
> +	dt += ((plen + 4)/4);
>  
>  	numlist = scandir(pathname, &namelist, 0, comparefunc);
>  	if (numlist < 0)
> @@ -415,6 +445,8 @@ static void putnode(void)
>  	if (initrd_base && !strcmp(basename,"/chosen/")) {
>  		int len = 8;
>  		unsigned long long initrd_end;
> +
> +		dt_reserve(&dt, 12); /* both props, of 6 words ea. */
>  		*dt++ = 3;
>  		*dt++ = len;
>  		*dt++ = propnum("linux,initrd-start");
> @@ -487,6 +519,7 @@ static void putnode(void)
>  		cmd_len = cmd_len + 1;
>  
>  		/* add new bootargs */
> +		dt_reserve(&dt, 4+((cmd_len+3)/4));
>  		*dt++ = 3;
>  		*dt++ = cmd_len;
>  		*dt++ = propnum("bootargs");
> @@ -571,6 +604,7 @@ no_debug:
>  			putnode();
>  	}
>  
> +	dt_reserve(&dt, 1);
>  	*dt++ = 2;
>  	dn[-1] = '\0';
>  	free(namelist);
> @@ -588,12 +622,21 @@ int create_flatten_tree(char **bufp, off_t *sizep, char
 *cmdline)
>  	strcpy(pathname, "/proc/device-tree/");
>  
>  	pathstart = pathname + strlen(pathname);
> -	dt = dtstruct;
> +
> +	dt_cur_size = INIT_TREE_WORDS;
> +	dt_base = malloc(dt_cur_size*4);
> +	if (!dt_base) {
> +		die("Can't malloc %d bytes for dt struct!\n", dt_cur_size*4);
> +	}
> +	memset(dt_base, 0, dt_cur_size*4);
> +
> +	dt = dt_base;
>  
>  	if (cmdline)
>  		strcpy(local_cmdline, cmdline);
>  
>  	putnode();
> +	dt_reserve(&dt, 1);
>  	*dt++ = 9;
>  
>  	len = sizeof(bb[0]);
> @@ -608,7 +651,7 @@ int create_flatten_tree(char **bufp, off_t *sizep, char *
cmdline)
>  
>  	bb->off_dt_struct = bb->off_mem_rsvmap + len;
>  
> -	len = dt - dtstruct;
> +	len = dt - dt_base;
>  	len *= sizeof(unsigned);
>  	bb->off_dt_strings = bb->off_dt_struct + len;
>  
> @@ -628,10 +671,11 @@ int create_flatten_tree(char **bufp, off_t *sizep, char
 *cmdline)
>  	tlen = bb->off_mem_rsvmap;
>  	memcpy(buf+tlen, mem_rsrv, bb->off_dt_struct - bb->off_mem_rsvmap);
>  	tlen = tlen + (bb->off_dt_struct - bb->off_mem_rsvmap);
> -	memcpy(buf+tlen, dtstruct,  bb->off_dt_strings - bb->off_dt_struct);
> +	memcpy(buf+tlen, dt_base,  bb->off_dt_strings - bb->off_dt_struct);
>  	tlen = tlen +  (bb->off_dt_strings - bb->off_dt_struct);
>  	memcpy(buf+tlen, propnames,  bb->totalsize - bb->off_dt_strings);
>  	tlen = tlen + bb->totalsize - bb->off_dt_strings;
>  	*sizep = tlen;
> +	free(dt_base);
>  	return 0;
>  }
> -- 
> 1.6.3.3
> 
