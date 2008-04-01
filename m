Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 1D52BDE2FF
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 03:35:38 +1100 (EST)
Date: Tue, 1 Apr 2008 11:35:04 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: [PATCH] RTAS - adapt procfs interface
Message-ID: <20080401163504.GP7137@localdomain>
References: <200804011512.20834.jens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804011512.20834.jens@de.ibm.com>
Cc: maxim@de.ibm.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jens Osterkamp wrote:
> 
> Handling of the proc_dir_entry->count has being changed in 2.6.24-rc5.

Do you know which commit caused the change?


> After this change the default value for pde->count is 1 and not 0 as it
> was in earlier kernels. Therefore, if we want to check wether our procfs
> file is already opened (already in use), we have to check if pde->count
> is not greater than 2 but not 1.
> 
> Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
> Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
> 
> Index: linux-2.6/arch/powerpc/kernel/rtas_flash.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/rtas_flash.c
> +++ linux-2.6/arch/powerpc/kernel/rtas_flash.c
> @@ -356,7 +356,7 @@ static int rtas_excl_open(struct inode *
>  
>  	/* Enforce exclusive open with use count of PDE */
>  	spin_lock(&flash_file_open_lock);
> -	if (atomic_read(&dp->count) > 1) {
> +	if (atomic_read(&dp->count) > 2) {
>  		spin_unlock(&flash_file_open_lock);
>  		return -EBUSY;
>  	}

One could argue that the real problem is using the proc_dir_entry's
reference count to enforce exclusive open.
