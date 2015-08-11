Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 762AD1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 13:42:02 +1000 (AEST)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E22701402BC
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 13:42:01 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so120203520pab.0
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 20:42:00 -0700 (PDT)
Date: Tue, 11 Aug 2015 13:42:54 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Subject: Re: [PATCH v2 02/10] cxl: Allocate and release the SPA with the AFU
Message-ID: <20150811134254.0358f0e3@camb691>
In-Reply-To: <1438061323-20710-3-git-send-email-dja@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-3-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jul 2015 15:28:35 +1000
Daniel Axtens <dja@axtens.net> wrote:

> Previously the SPA was allocated and freed upon entering and leaving
> AFU-directed mode. This causes some issues for error recovery - contexts
> hold a pointer inside the SPA, and they may persist after the AFU has
> been detached.
> 
> We would ideally like to allocate the SPA when the AFU is allocated, and
> release it until the AFU is released. However, we don't know how big the
> SPA needs to be until we read the AFU descriptor.
> 
> Therefore, restructure the code:
> 
>  - Allocate the SPA only once, on the first attach.
> 
>  - Release the SPA only when the entire AFU is being released (not
>    detached). Guard the release with a NULL check, so we don't free
>    if it was never allocated (e.g. dedicated mode)
> 

I'm sure you tested this :), looks fine to me, from an outsiders perspective
code appears to do what the commit message says.

Just one super minor question, you do the NULL check in the caller. How obvious
is the error if/when a caller forgets?

Acked-by: Cyril Bur <cyrilbur@gmail.com>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/cxl.h    |  3 +++
>  drivers/misc/cxl/native.c | 28 ++++++++++++++++++----------
>  drivers/misc/cxl/pci.c    |  3 +++
>  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 47eadbcfd379..88a88c445e2a 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -603,6 +603,9 @@ void unregister_cxl_calls(struct cxl_calls *calls);
>  int cxl_alloc_adapter_nr(struct cxl *adapter);
>  void cxl_remove_adapter_nr(struct cxl *adapter);
>  
> +int cxl_alloc_spa(struct cxl_afu *afu);
> +void cxl_release_spa(struct cxl_afu *afu);
> +
>  int cxl_file_init(void);
>  void cxl_file_exit(void);
>  int cxl_register_adapter(struct cxl *adapter);
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 16948915eb0d..debd97147b58 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -182,10 +182,8 @@ static int spa_max_procs(int spa_size)
>  	return ((spa_size / 8) - 96) / 17;
>  }
>  
> -static int alloc_spa(struct cxl_afu *afu)
> +int cxl_alloc_spa(struct cxl_afu *afu)
>  {
> -	u64 spap;
> -
>  	/* Work out how many pages to allocate */
>  	afu->spa_order = 0;
>  	do {
> @@ -204,6 +202,13 @@ static int alloc_spa(struct cxl_afu *afu)
>  	pr_devel("spa pages: %i afu->spa_max_procs: %i   afu->num_procs: %i\n",
>  		 1<<afu->spa_order, afu->spa_max_procs, afu->num_procs);
>  
> +	return 0;
> +}
> +
> +static void attach_spa(struct cxl_afu *afu)
> +{
> +	u64 spap;
> +
>  	afu->sw_command_status = (__be64 *)((char *)afu->spa +
>  					    ((afu->spa_max_procs + 3) * 128));
>  
> @@ -212,13 +217,15 @@ static int alloc_spa(struct cxl_afu *afu)
>  	spap |= CXL_PSL_SPAP_V;
>  	pr_devel("cxl: SPA allocated at 0x%p. Max processes: %i, sw_command_status: 0x%p CXL_PSL_SPAP_An=0x%016llx\n", afu->spa, afu->spa_max_procs, afu->sw_command_status, spap);
>  	cxl_p1n_write(afu, CXL_PSL_SPAP_An, spap);
> -
> -	return 0;
>  }
>  
> -static void release_spa(struct cxl_afu *afu)
> +static inline void detach_spa(struct cxl_afu *afu)
>  {
>  	cxl_p1n_write(afu, CXL_PSL_SPAP_An, 0);
> +}
> +
> +void cxl_release_spa(struct cxl_afu *afu)
> +{
>  	free_pages((unsigned long) afu->spa, afu->spa_order);
>  }
>  
> @@ -446,8 +453,11 @@ static int activate_afu_directed(struct cxl_afu *afu)
>  
>  	dev_info(&afu->dev, "Activating AFU directed mode\n");
>  
> -	if (alloc_spa(afu))
> -		return -ENOMEM;
> +	if (afu->spa == NULL) {
> +		if (cxl_alloc_spa(afu))
> +			return -ENOMEM;
> +	}
> +	attach_spa(afu);
>  
>  	cxl_p1n_write(afu, CXL_PSL_SCNTL_An, CXL_PSL_SCNTL_An_PM_AFU);
>  	cxl_p1n_write(afu, CXL_PSL_AMOR_An, 0xFFFFFFFFFFFFFFFFULL);
> @@ -560,8 +570,6 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
>  	cxl_afu_disable(afu);
>  	cxl_psl_purge(afu);
>  
> -	release_spa(afu);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 32ad09705949..1849c1785b49 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -551,6 +551,9 @@ static void cxl_release_afu(struct device *dev)
>  
>  	pr_devel("cxl_release_afu\n");
>  
> +	if (afu->spa)
> +		cxl_release_spa(afu);
> +
>  	kfree(afu);
>  }
>  
