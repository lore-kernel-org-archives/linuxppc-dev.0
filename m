Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C788B7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 15:57:41 +1100 (EST)
Subject: Re: [PATCH 1/6] nvram: Generalize code for OS partitions in NVRAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jim Keniston <jkenisto@us.ibm.com>
In-Reply-To: <20101114041516.9457.2462.stgit@localhost.localdomain>
References: <20101114041510.9457.92921.stgit@localhost.localdomain>
	<20101114041516.9457.2462.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 15:57:02 +1100
Message-ID: <1297054622.14982.51.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-11-13 at 20:15 -0800, Jim Keniston wrote:
> Adapt the functions used to create and write to the RTAS-log partition
> to work with any OS-type partition.
> 
> Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
> ---

Overall pretty good (sorry for taking that long to review, I've been
swamped down). Just a handful of minor nits:

> +/*
> + * Per the criteria passed via nvram_remove_partition(), should this
> + * partition be removed?  1=remove, 0=keep
> + */
> +static int nvram_condemn_partition(struct nvram_partition *part,
> +		const char *name, int sig, const char *exceptions[])

As "fun" as this name is, it didn't help me understand what the function
was about until I read the code for the next one :-)

What about instead something like nvram_can_remove_partition() or
something a bit more explicit like that ?

"comdemn" made me thought it was a function used to "mark" partitions
to be killed later, which is not what the function does.

 .../...

> +static const char *valid_os_partitions[] = {
> +	"ibm,rtas-log",
> +	NULL
> +};

Can you pick a name that will be less confusing in the global
symbol table ? Something like "pseries_nvram_os_partitions"
or whatever shorter you can come up with which doesn't suck ?

Also, should we move that "os partition" core out of pseries ?

Looks like it will be useful for a few other platforms, I'd like
to move that to a more generically useful location in arch/powerpc
but that's not a blocker for this series but something to do next
maybe ?

In that case "struct os_partition" should also find itself a better
name, maybe struct nvram_os_partition ?

>  static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
>  {
> @@ -134,7 +147,7 @@ static ssize_t pSeries_nvram_get_size(void)
>  }
>  
> 
> -/* nvram_write_error_log
> +/* nvram_write_os_partition, nvram_write_error_log
>   *
>   * We need to buffer the error logs into nvram to ensure that we have
>   * the failure information to decode.  If we have a severe error there
> @@ -156,48 +169,55 @@ static ssize_t pSeries_nvram_get_size(void)
>   * The 'data' section would look like (in bytes):
>   * +--------------+------------+-----------------------------------+
>   * | event_logged | sequence # | error log                         |
> - * |0            3|4          7|8            nvram_error_log_size-1|
> + * |0            3|4          7|8                  error_log_size-1|
>   * +--------------+------------+-----------------------------------+
>   *
>   * event_logged: 0 if event has not been logged to syslog, 1 if it has
>   * sequence #: The unique sequence # for each event. (until it wraps)
>   * error log: The error log from event_scan
>   */
> -int nvram_write_error_log(char * buff, int length,
> +int nvram_write_os_partition(struct os_partition *part, char * buff, int length,
>                            unsigned int err_type, unsigned int error_log_cnt)
>  {
>  	int rc;
>  	loff_t tmp_index;
>  	struct err_log_info info;
>  	
> -	if (nvram_error_log_index == -1) {
> +	if (part->index == -1) {
>  		return -ESPIPE;
>  	}
>  
> -	if (length > nvram_error_log_size) {
> -		length = nvram_error_log_size;
> +	if (length > part->size) {
> +		length = part->size;
>  	}
>  
>  	info.error_type = err_type;
>  	info.seq_num = error_log_cnt;
>  
> -	tmp_index = nvram_error_log_index;
> +	tmp_index = part->index;
>  
>  	rc = ppc_md.nvram_write((char *)&info, sizeof(struct err_log_info), &tmp_index);
>  	if (rc <= 0) {
> -		printk(KERN_ERR "nvram_write_error_log: Failed nvram_write (%d)\n", rc);
> +		printk(KERN_ERR "nvram_write_os_partition: Failed nvram_write (%d)\n", rc);
>  		return rc;
>  	}
>  
>  	rc = ppc_md.nvram_write(buff, length, &tmp_index);
>  	if (rc <= 0) {
> -		printk(KERN_ERR "nvram_write_error_log: Failed nvram_write (%d)\n", rc);
> +		printk(KERN_ERR "nvram_write_os_partition: Failed nvram_write (%d)\n", rc);
>  		return rc;
>  	}
>  	
>  	return 0;
>  }

While at it, turn these into pr_err and use __FUNCTION__ or __func__

> +int nvram_write_error_log(char * buff, int length,
> +                          unsigned int err_type, unsigned int error_log_cnt)
> +{
> +	return nvram_write_os_partition(&rtas_log_partition, buff, length,
> +						err_type, error_log_cnt);
> +}

That's a candidate for a static inline in a .h

>  /* nvram_read_error_log
>   *
>   * Reads nvram for error log for at most 'length'
> @@ -209,13 +229,13 @@ int nvram_read_error_log(char * buff, int length,
>  	loff_t tmp_index;
>  	struct err_log_info info;
>  	
> -	if (nvram_error_log_index == -1)
> +	if (rtas_log_partition.index == -1)
>  		return -1;
>  
> -	if (length > nvram_error_log_size)
> -		length = nvram_error_log_size;
> +	if (length > rtas_log_partition.size)
> +		length = rtas_log_partition.size;
>  
> -	tmp_index = nvram_error_log_index;
> +	tmp_index = rtas_log_partition.index;
>  
>  	rc = ppc_md.nvram_read((char *)&info, sizeof(struct err_log_info), &tmp_index);
>  	if (rc <= 0) {
> @@ -244,10 +264,10 @@ int nvram_clear_error_log(void)
>  	int clear_word = ERR_FLAG_ALREADY_LOGGED;
>  	int rc;
>  
> -	if (nvram_error_log_index == -1)
> +	if (rtas_log_partition.index == -1)
>  		return -1;
>  
> -	tmp_index = nvram_error_log_index;
> +	tmp_index = rtas_log_partition.index;
>  	
>  	rc = ppc_md.nvram_write((char *)&clear_word, sizeof(int), &tmp_index);
>  	if (rc <= 0) {
> @@ -258,67 +278,71 @@ int nvram_clear_error_log(void)
>  	return 0;
>  }
>  
> -/* pseries_nvram_init_log_partition
> +/* pseries_nvram_init_os_partition
>   *
> - * This will setup the partition we need for buffering the
> - * error logs and cleanup partitions if needed.
> + * This set up a partition with an "OS" signature.
>   *
>   * The general strategy is the following:
> - * 1.) If there is log partition large enough then use it.
> - * 2.) If there is none large enough, search
> - * for a free partition that is large enough.
> - * 3.) If there is not a free partition large enough remove 
> - * _all_ OS partitions and consolidate the space.
> - * 4.) Will first try getting a chunk that will satisfy the maximum
> - * error log size (NVRAM_MAX_REQ).
> - * 5.) If the max chunk cannot be allocated then try finding a chunk
> - * that will satisfy the minum needed (NVRAM_MIN_REQ).
> + * 1.) If a partition with the indicated name already exists...
> + *	- If it's large enough, use it.
> + *	- Otherwise, recycle it and keep going.
> + * 2.) Search for a free partition that is large enough.
> + * 3.) If there's not a free partition large enough, recycle any obsolete
> + * OS partitions and try again.
> + * 4.) Will first try getting a chunk that will satisfy the requested size.
> + * 5.) If a chunk of the requested size cannot be allocated, then try finding
> + * a chunk that will satisfy the minum needed.
> + *
> + * Returns 0 on success, else -1.
>   */
> -static int __init pseries_nvram_init_log_partition(void)
> +static int __init pseries_nvram_init_os_partition(struct os_partition *part)
>  {
>  	loff_t p;
>  	int size;
>  
> -	p = nvram_find_partition(NVRAM_LOG_PART_NAME, NVRAM_SIG_OS, &size);
> +	p = nvram_find_partition(part->name, NVRAM_SIG_OS, &size);
>  
>  	/* Found one but too small, remove it */
> -	if (p && size < NVRAM_MIN_REQ) {
> -		pr_info("nvram: Found too small "NVRAM_LOG_PART_NAME" partition"
> -			",removing it...");
> -		nvram_remove_partition(NVRAM_LOG_PART_NAME, NVRAM_SIG_OS);
> +	if (p && size < part->min_size) {
> +		pr_info("nvram: Found too small %s partition,"
> +					" removing it...\n", part->name);
> +		nvram_remove_partition(part->name, NVRAM_SIG_OS, NULL);
>  		p = 0;
>  	}
>  
>  	/* Create one if we didn't find */
>  	if (!p) {
> -		p = nvram_create_partition(NVRAM_LOG_PART_NAME, NVRAM_SIG_OS,
> -					   NVRAM_MAX_REQ, NVRAM_MIN_REQ);
> -		/* No room for it, try to get rid of any OS partition
> -		 * and try again
> -		 */
> +		p = nvram_create_partition(part->name, NVRAM_SIG_OS,
> +					part->req_size, part->min_size);
>  		if (p == -ENOSPC) {
> -			pr_info("nvram: No room to create "NVRAM_LOG_PART_NAME
> -				" partition, deleting all OS partitions...");
> -			nvram_remove_partition(NULL, NVRAM_SIG_OS);
> -			p = nvram_create_partition(NVRAM_LOG_PART_NAME,
> -						   NVRAM_SIG_OS, NVRAM_MAX_REQ,
> -						   NVRAM_MIN_REQ);
> +			pr_info("nvram: No room to create %s partition, "
> +				"deleting any obsolete OS partitions...\n",
> +				part->name);
> +			nvram_remove_partition(NULL, NVRAM_SIG_OS,
> +						valid_os_partitions);
> +			p = nvram_create_partition(part->name, NVRAM_SIG_OS,
> +					part->req_size, part->min_size);
>  		}
>  	}
>  
>  	if (p <= 0) {
> -		pr_err("nvram: Failed to find or create "NVRAM_LOG_PART_NAME
> -		       " partition, err %d\n", (int)p);
> -		return 0;
> +		pr_err("nvram: Failed to find or create %s"
> +		       " partition, err %d\n", part->name, (int)p);
> +		return -1;
>  	}
>  
> -	nvram_error_log_index = p;
> -	nvram_error_log_size = nvram_get_partition_size(p) -
> -		sizeof(struct err_log_info);
> +	part->index = p;
> +	part->size = nvram_get_partition_size(p) - sizeof(struct err_log_info);
>  	
>  	return 0;
>  }
> -machine_late_initcall(pseries, pseries_nvram_init_log_partition);
> +
> +static int __init pseries_nvram_init_log_partitions(void)
> +{
> +	(void) pseries_nvram_init_os_partition(&rtas_log_partition);
> +	return 0;
> +}
> +machine_late_initcall(pseries, pseries_nvram_init_log_partitions);
>  
>  int __init pSeries_nvram_init(void)
>  {
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
