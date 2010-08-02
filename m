Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5ECC71007D3
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 11:40:47 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o721ef0q021620
	for <linuxppc-dev@ozlabs.org>; Sun, 1 Aug 2010 20:40:42 -0500
Subject: Re: [PATCH 10/11] powerpc/nvram: Move the log partition stuff to
	pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1280710522-6362-11-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-5-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-7-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-8-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-9-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-10-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-11-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 11:40:40 +1000
Message-ID: <1280713240.1902.37.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-08-02 at 10:55 +1000, Benjamin Herrenschmidt wrote:
> The nvram log partition stuff currently in nvram_64.c is really
> pseries specific. It isn't actually used on anything else (despite
> the fact that we ran the code to setup the partition on anything
> except powermac) and the log format is specific to pseries RTAS
> implementation. So move it where it belongs

Some glitches in this one, like the wrong init order. I'll move
the nvram scan to be explicitely called by archs who want that stuff.

In fact, I might move the whole partition handling to a separate
file to be selected by archs who want it, and try to merge that with
powermac, but at least we have a first step here.

I'll send an updated patch later, in case there are other comments.

Cheers,
Ben.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/nvram.h       |    9 ++-
>  arch/powerpc/kernel/nvram_64.c         |  216 +-------------------------------
>  arch/powerpc/platforms/pseries/nvram.c |  196 +++++++++++++++++++++++++++++
>  3 files changed, 208 insertions(+), 213 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
> index 459dc09..457a1a5 100644
> --- a/arch/powerpc/include/asm/nvram.h
> +++ b/arch/powerpc/include/asm/nvram.h
> @@ -30,13 +30,14 @@
>  #include <linux/errno.h>
>  #include <linux/list.h>
>  
> +#ifdef CONFIG_PPC_PSERIES
>  extern int nvram_write_error_log(char * buff, int length,
>  					 unsigned int err_type, unsigned int err_seq);
>  extern int nvram_read_error_log(char * buff, int length,
>  					 unsigned int * err_type, unsigned int *err_seq);
>  extern int nvram_clear_error_log(void);
> -
>  extern int pSeries_nvram_init(void);
> +#endif /* CONFIG_PPC_PSERIES */
>  
>  #ifdef CONFIG_MMIO_NVRAM
>  extern int mmio_nvram_init(void);
> @@ -47,6 +48,12 @@ static inline int mmio_nvram_init(void)
>  }
>  #endif
>  
> +extern loff_t nvram_create_partition(const char *name, int sig,
> +				     int req_size, int min_size);
> +extern int nvram_remove_partition(const char *name, int sig);
> +extern int nvram_get_partition_size(loff_t data_index);
> +extern loff_t nvram_find_partition(const char *name, int sig, int *out_size);
> +
>  #endif /* __KERNEL__ */
>  
>  /* PowerMac specific nvram stuffs */
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index ddc94cf..d467f8c 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -36,8 +36,6 @@
>  
>  #define NVRAM_HEADER_LEN	sizeof(struct nvram_header)
>  #define NVRAM_BLOCK_LEN		NVRAM_HEADER_LEN
> -#define NVRAM_MAX_REQ		2079
> -#define NVRAM_MIN_REQ		1055
>  
>  /* If change this size, then change the size of NVNAME_LEN */
>  struct nvram_header {
> @@ -54,13 +52,6 @@ struct nvram_partition {
>  };
>  
>  static struct nvram_partition * nvram_part;
> -static long nvram_error_log_index = -1;
> -static long nvram_error_log_size = 0;
> -
> -struct err_log_info {
> -	int error_type;
> -	unsigned int seq_num;
> -};
>  
>  static loff_t dev_nvram_llseek(struct file *file, loff_t offset, int origin)
>  {
> @@ -254,7 +245,7 @@ static unsigned char __init nvram_checksum(struct nvram_header *p)
>   * @sig: signature of the partition(s) to remove
>   */
>  
> -static int __init nvram_remove_partition(const char *name, int sig)
> +int __init nvram_remove_partition(const char *name, int sig)
>  {
>  	struct nvram_partition *part, *prev, *tmp;
>  	int rc;
> @@ -313,8 +304,8 @@ static int __init nvram_remove_partition(const char *name, int sig)
>   * you need to query for the actual size yourself after the
>   * call using nvram_partition_get_size().
>   */
> -static loff_t __init nvram_create_partition(const char *name, int sig,
> -					    int req_size, int min_size)
> +loff_t __init nvram_create_partition(const char *name, int sig,
> +				     int req_size, int min_size)
>  {
>  	struct nvram_partition *part;
>  	struct nvram_partition *new_part;
> @@ -417,7 +408,7 @@ static loff_t __init nvram_create_partition(const char *name, int sig,
>   *              the partition. The same value that is returned by
>   *              nvram_create_partition().
>   */
> -static int nvram_get_partition_size(loff_t data_index)
> +int nvram_get_partition_size(loff_t data_index)
>  {
>  	struct nvram_partition *part;
>  	
> @@ -451,74 +442,6 @@ loff_t nvram_find_partition(const char *name, int sig, int *out_size)
>  	return 0;
>  }
>  
> -/* nvram_setup_partition
> - *
> - * This will setup the partition we need for buffering the
> - * error logs and cleanup partitions if needed.
> - *
> - * The general strategy is the following:
> - * 1.) If there is ppc64,linux partition large enough then use it.
> - * 2.) If there is not a ppc64,linux partition large enough, search
> - * for a free partition that is large enough.
> - * 3.) If there is not a free partition large enough remove 
> - * _all_ OS partitions and consolidate the space.
> - * 4.) Will first try getting a chunk that will satisfy the maximum
> - * error log size (NVRAM_MAX_REQ).
> - * 5.) If the max chunk cannot be allocated then try finding a chunk
> - * that will satisfy the minum needed (NVRAM_MIN_REQ).
> - */
> -static int __init nvram_setup_partition(void)
> -{
> -	loff_t p;
> -	int size;
> -
> -	/* For now, we don't do any of this on pmac, until I
> -	 * have figured out if it's worth killing some unused stuffs
> -	 * in our nvram, as Apple defined partitions use pretty much
> -	 * all of the space
> -	 */
> -	if (machine_is(powermac))
> -		return -ENOSPC;
> -
> -	p = nvram_find_partition("ppc64,linux", NVRAM_SIG_OS, &size);
> -
> -	/* Found one but too small, remove it */
> -	if (p && size < NVRAM_MIN_REQ) {
> -		pr_info("nvram: Found too small ppc64,linux partition"
> -			",removing it...");
> -		nvram_remove_partition("ppc64,linux", NVRAM_SIG_OS);
> -		p = 0;
> -	}
> -
> -	/* Create one if we didn't find */
> -	if (!p) {
> -		p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
> -					   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
> -		/* No room for it, try to get rid of any OS partition
> -		 * and try again
> -		 */
> -		if (p == -ENOSPC) {
> -			pr_info("nvram: No room to create ppc64,linux"
> -				" partition, deleting all OS partitions...");
> -			nvram_remove_partition(NULL, NVRAM_SIG_OS);
> -			p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
> -						   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
> -		}
> -	}
> -
> -	if (p <= 0) {
> -		pr_err("nvram: Failed to find or create ppc64,linux"
> -		       " partition, err %d\n", (int)p);
> -		return 0;
> -	}
> -
> -	nvram_error_log_index = p;
> -	nvram_error_log_size = nvram_get_partition_size(p) -
> -		sizeof(struct err_log_info);
> -	
> -	return 0;
> -}
> -
>  static int __init nvram_scan_partitions(void)
>  {
>  	loff_t cur_index = 0;
> @@ -617,10 +540,6 @@ static int __init nvram_init(void)
>    		printk(KERN_ERR "nvram_init: Failed nvram_scan_partitions\n");
>    		return error;
>    	}
> -  		
> -  	if(nvram_setup_partition()) 
> -  		printk(KERN_WARNING "nvram_init: Could not find nvram partition"
> -  		       " for nvram buffered error logging.\n");
>    
>  #ifdef DEBUG_NVRAM
>  	nvram_print_partitions("NVRAM Partitions");
> @@ -635,133 +554,6 @@ void __exit nvram_cleanup(void)
>  }
>  
> 
> -#ifdef CONFIG_PPC_PSERIES
> -
> -/* nvram_write_error_log
> - *
> - * We need to buffer the error logs into nvram to ensure that we have
> - * the failure information to decode.  If we have a severe error there
> - * is no way to guarantee that the OS or the machine is in a state to
> - * get back to user land and write the error to disk.  For example if
> - * the SCSI device driver causes a Machine Check by writing to a bad
> - * IO address, there is no way of guaranteeing that the device driver
> - * is in any state that is would also be able to write the error data
> - * captured to disk, thus we buffer it in NVRAM for analysis on the
> - * next boot.
> - *
> - * In NVRAM the partition containing the error log buffer will looks like:
> - * Header (in bytes):
> - * +-----------+----------+--------+------------+------------------+
> - * | signature | checksum | length | name       | data             |
> - * |0          |1         |2      3|4         15|16        length-1|
> - * +-----------+----------+--------+------------+------------------+
> - *
> - * The 'data' section would look like (in bytes):
> - * +--------------+------------+-----------------------------------+
> - * | event_logged | sequence # | error log                         |
> - * |0            3|4          7|8            nvram_error_log_size-1|
> - * +--------------+------------+-----------------------------------+
> - *
> - * event_logged: 0 if event has not been logged to syslog, 1 if it has
> - * sequence #: The unique sequence # for each event. (until it wraps)
> - * error log: The error log from event_scan
> - */
> -int nvram_write_error_log(char * buff, int length,
> -                          unsigned int err_type, unsigned int error_log_cnt)
> -{
> -	int rc;
> -	loff_t tmp_index;
> -	struct err_log_info info;
> -	
> -	if (nvram_error_log_index == -1) {
> -		return -ESPIPE;
> -	}
> -
> -	if (length > nvram_error_log_size) {
> -		length = nvram_error_log_size;
> -	}
> -
> -	info.error_type = err_type;
> -	info.seq_num = error_log_cnt;
> -
> -	tmp_index = nvram_error_log_index;
> -
> -	rc = ppc_md.nvram_write((char *)&info, sizeof(struct err_log_info), &tmp_index);
> -	if (rc <= 0) {
> -		printk(KERN_ERR "nvram_write_error_log: Failed nvram_write (%d)\n", rc);
> -		return rc;
> -	}
> -
> -	rc = ppc_md.nvram_write(buff, length, &tmp_index);
> -	if (rc <= 0) {
> -		printk(KERN_ERR "nvram_write_error_log: Failed nvram_write (%d)\n", rc);
> -		return rc;
> -	}
> -	
> -	return 0;
> -}
> -
> -/* nvram_read_error_log
> - *
> - * Reads nvram for error log for at most 'length'
> - */
> -int nvram_read_error_log(char * buff, int length,
> -                         unsigned int * err_type, unsigned int * error_log_cnt)
> -{
> -	int rc;
> -	loff_t tmp_index;
> -	struct err_log_info info;
> -	
> -	if (nvram_error_log_index == -1)
> -		return -1;
> -
> -	if (length > nvram_error_log_size)
> -		length = nvram_error_log_size;
> -
> -	tmp_index = nvram_error_log_index;
> -
> -	rc = ppc_md.nvram_read((char *)&info, sizeof(struct err_log_info), &tmp_index);
> -	if (rc <= 0) {
> -		printk(KERN_ERR "nvram_read_error_log: Failed nvram_read (%d)\n", rc);
> -		return rc;
> -	}
> -
> -	rc = ppc_md.nvram_read(buff, length, &tmp_index);
> -	if (rc <= 0) {
> -		printk(KERN_ERR "nvram_read_error_log: Failed nvram_read (%d)\n", rc);
> -		return rc;
> -	}
> -
> -	*error_log_cnt = info.seq_num;
> -	*err_type = info.error_type;
> -
> -	return 0;
> -}
> -
> -/* This doesn't actually zero anything, but it sets the event_logged
> - * word to tell that this event is safely in syslog.
> - */
> -int nvram_clear_error_log(void)
> -{
> -	loff_t tmp_index;
> -	int clear_word = ERR_FLAG_ALREADY_LOGGED;
> -	int rc;
> -
> -	if (nvram_error_log_index == -1)
> -		return -1;
> -
> -	tmp_index = nvram_error_log_index;
> -	
> -	rc = ppc_md.nvram_write((char *)&clear_word, sizeof(int), &tmp_index);
> -	if (rc <= 0) {
> -		printk(KERN_ERR "nvram_clear_error_log: Failed nvram_write (%d)\n", rc);
> -		return rc;
> -	}
> -
> -	return 0;
> -}
> -
> -#endif /* CONFIG_PPC_PSERIES */
>  
>  module_init(nvram_init);
>  module_exit(nvram_cleanup);
> diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
> index 2a1ef5c..c8b3f0f 100644
> --- a/arch/powerpc/platforms/pseries/nvram.c
> +++ b/arch/powerpc/platforms/pseries/nvram.c
> @@ -30,6 +30,16 @@ static int nvram_fetch, nvram_store;
>  static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
>  static DEFINE_SPINLOCK(nvram_lock);
>  
> +static long nvram_error_log_index = -1;
> +static long nvram_error_log_size = 0;
> +
> +struct err_log_info {
> +	int error_type;
> +	unsigned int seq_num;
> +};
> +#define NVRAM_MAX_REQ		2079
> +#define NVRAM_MIN_REQ		1055
> +
>  static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
>  {
>  	unsigned int i;
> @@ -121,6 +131,192 @@ static ssize_t pSeries_nvram_get_size(void)
>  	return nvram_size ? nvram_size : -ENODEV;
>  }
>  
> +
> +/* nvram_write_error_log
> + *
> + * We need to buffer the error logs into nvram to ensure that we have
> + * the failure information to decode.  If we have a severe error there
> + * is no way to guarantee that the OS or the machine is in a state to
> + * get back to user land and write the error to disk.  For example if
> + * the SCSI device driver causes a Machine Check by writing to a bad
> + * IO address, there is no way of guaranteeing that the device driver
> + * is in any state that is would also be able to write the error data
> + * captured to disk, thus we buffer it in NVRAM for analysis on the
> + * next boot.
> + *
> + * In NVRAM the partition containing the error log buffer will looks like:
> + * Header (in bytes):
> + * +-----------+----------+--------+------------+------------------+
> + * | signature | checksum | length | name       | data             |
> + * |0          |1         |2      3|4         15|16        length-1|
> + * +-----------+----------+--------+------------+------------------+
> + *
> + * The 'data' section would look like (in bytes):
> + * +--------------+------------+-----------------------------------+
> + * | event_logged | sequence # | error log                         |
> + * |0            3|4          7|8            nvram_error_log_size-1|
> + * +--------------+------------+-----------------------------------+
> + *
> + * event_logged: 0 if event has not been logged to syslog, 1 if it has
> + * sequence #: The unique sequence # for each event. (until it wraps)
> + * error log: The error log from event_scan
> + */
> +int nvram_write_error_log(char * buff, int length,
> +                          unsigned int err_type, unsigned int error_log_cnt)
> +{
> +	int rc;
> +	loff_t tmp_index;
> +	struct err_log_info info;
> +	
> +	if (nvram_error_log_index == -1) {
> +		return -ESPIPE;
> +	}
> +
> +	if (length > nvram_error_log_size) {
> +		length = nvram_error_log_size;
> +	}
> +
> +	info.error_type = err_type;
> +	info.seq_num = error_log_cnt;
> +
> +	tmp_index = nvram_error_log_index;
> +
> +	rc = ppc_md.nvram_write((char *)&info, sizeof(struct err_log_info), &tmp_index);
> +	if (rc <= 0) {
> +		printk(KERN_ERR "nvram_write_error_log: Failed nvram_write (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	rc = ppc_md.nvram_write(buff, length, &tmp_index);
> +	if (rc <= 0) {
> +		printk(KERN_ERR "nvram_write_error_log: Failed nvram_write (%d)\n", rc);
> +		return rc;
> +	}
> +	
> +	return 0;
> +}
> +
> +/* nvram_read_error_log
> + *
> + * Reads nvram for error log for at most 'length'
> + */
> +int nvram_read_error_log(char * buff, int length,
> +                         unsigned int * err_type, unsigned int * error_log_cnt)
> +{
> +	int rc;
> +	loff_t tmp_index;
> +	struct err_log_info info;
> +	
> +	if (nvram_error_log_index == -1)
> +		return -1;
> +
> +	if (length > nvram_error_log_size)
> +		length = nvram_error_log_size;
> +
> +	tmp_index = nvram_error_log_index;
> +
> +	rc = ppc_md.nvram_read((char *)&info, sizeof(struct err_log_info), &tmp_index);
> +	if (rc <= 0) {
> +		printk(KERN_ERR "nvram_read_error_log: Failed nvram_read (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	rc = ppc_md.nvram_read(buff, length, &tmp_index);
> +	if (rc <= 0) {
> +		printk(KERN_ERR "nvram_read_error_log: Failed nvram_read (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	*error_log_cnt = info.seq_num;
> +	*err_type = info.error_type;
> +
> +	return 0;
> +}
> +
> +/* This doesn't actually zero anything, but it sets the event_logged
> + * word to tell that this event is safely in syslog.
> + */
> +int nvram_clear_error_log(void)
> +{
> +	loff_t tmp_index;
> +	int clear_word = ERR_FLAG_ALREADY_LOGGED;
> +	int rc;
> +
> +	if (nvram_error_log_index == -1)
> +		return -1;
> +
> +	tmp_index = nvram_error_log_index;
> +	
> +	rc = ppc_md.nvram_write((char *)&clear_word, sizeof(int), &tmp_index);
> +	if (rc <= 0) {
> +		printk(KERN_ERR "nvram_clear_error_log: Failed nvram_write (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/* pseries_nvram_init_log_partition
> + *
> + * This will setup the partition we need for buffering the
> + * error logs and cleanup partitions if needed.
> + *
> + * The general strategy is the following:
> + * 1.) If there is ppc64,linux partition large enough then use it.
> + * 2.) If there is not a ppc64,linux partition large enough, search
> + * for a free partition that is large enough.
> + * 3.) If there is not a free partition large enough remove 
> + * _all_ OS partitions and consolidate the space.
> + * 4.) Will first try getting a chunk that will satisfy the maximum
> + * error log size (NVRAM_MAX_REQ).
> + * 5.) If the max chunk cannot be allocated then try finding a chunk
> + * that will satisfy the minum needed (NVRAM_MIN_REQ).
> + */
> +static int __init pseries_nvram_init_log_partition(void)
> +{
> +	loff_t p;
> +	int size;
> +
> +	p = nvram_find_partition("ppc64,linux", NVRAM_SIG_OS, &size);
> +
> +	/* Found one but too small, remove it */
> +	if (p && size < NVRAM_MIN_REQ) {
> +		pr_info("nvram: Found too small ppc64,linux partition"
> +			",removing it...");
> +		nvram_remove_partition("ppc64,linux", NVRAM_SIG_OS);
> +		p = 0;
> +	}
> +
> +	/* Create one if we didn't find */
> +	if (!p) {
> +		p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
> +					   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
> +		/* No room for it, try to get rid of any OS partition
> +		 * and try again
> +		 */
> +		if (p == -ENOSPC) {
> +			pr_info("nvram: No room to create ppc64,linux"
> +				" partition, deleting all OS partitions...");
> +			nvram_remove_partition(NULL, NVRAM_SIG_OS);
> +			p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
> +						   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
> +		}
> +	}
> +
> +	if (p <= 0) {
> +		pr_err("nvram: Failed to find or create ppc64,linux"
> +		       " partition, err %d\n", (int)p);
> +		return 0;
> +	}
> +
> +	nvram_error_log_index = p;
> +	nvram_error_log_size = nvram_get_partition_size(p) -
> +		sizeof(struct err_log_info);
> +	
> +	return 0;
> +}
> +machine_arch_initcall(pseries, pseries_nvram_init_log_partition);
> +
>  int __init pSeries_nvram_init(void)
>  {
>  	struct device_node *nvram;
