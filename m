Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D2E01A05A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jun 2014 19:09:52 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 2 Jun 2014 14:39:48 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 69163394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jun 2014 14:39:45 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s529AQri57540856
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jun 2014 14:40:26 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5299is0011995
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jun 2014 14:39:44 +0530
Received: from [9.124.94.161] ([9.124.94.161])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5299i33011985
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jun 2014 14:39:44 +0530
Message-ID: <538C3F57.2080300@linux.vnet.ibm.com>
Date: Mon, 02 Jun 2014 14:39:43 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: Split __SYSFS_SPRSETUP macro
References: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
 <c0db1b210405db5ff579a2d7432dde2c73bd47bb.1400652868.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <c0db1b210405db5ff579a2d7432dde2c73bd47bb.1400652868.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 21 May 2014 12:02 PM, Sam Bobroff wrote:
> Split the __SYSFS_SPRSETUP macro into two parts so that registers requiring
> custom read and write functions can use common code for their show and store
> functions.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  arch/powerpc/kernel/sysfs.c |   19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index d90d4b7..e2a1d6f 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -404,7 +404,7 @@ void ppc_enable_pmcs(void)
>  }
>  EXPORT_SYMBOL(ppc_enable_pmcs);
>  
> -#define __SYSFS_SPRSETUP(NAME, ADDRESS, EXTRA) \
> +#define __SYSFS_SPRSETUP_READ_WRITE(NAME, ADDRESS, EXTRA) \
>  static void read_##NAME(void *val) \
>  { \
>  	*(unsigned long *)val = mfspr(ADDRESS);	\
> @@ -413,7 +413,9 @@ static void write_##NAME(void *val) \
>  { \
>  	EXTRA; \
>  	mtspr(ADDRESS, *(unsigned long *)val);	\
> -} \
> +}
> +
> +#define __SYSFS_SPRSETUP_SHOW_STORE(NAME) \
>  static ssize_t show_##NAME(struct device *dev, \
>  			struct device_attribute *attr, \
>  			char *buf) \
> @@ -436,10 +438,15 @@ static ssize_t __used \
>  	return count; \
>  }
>  
> -#define SYSFS_PMCSETUP(NAME, ADDRESS)	\
> -	__SYSFS_SPRSETUP(NAME, ADDRESS, ppc_enable_pmcs())
> -#define SYSFS_SPRSETUP(NAME, ADDRESS)	\
> -	__SYSFS_SPRSETUP(NAME, ADDRESS, )
> +#define SYSFS_PMCSETUP(NAME, ADDRESS) \
> +	__SYSFS_SPRSETUP_READ_WRITE(NAME, ADDRESS, ppc_enable_pmcs()) \
> +	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
> +#define SYSFS_SPRSETUP(NAME, ADDRESS) \
> +	__SYSFS_SPRSETUP_READ_WRITE(NAME, ADDRESS, ) \
> +	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
> +
> +#define SYSFS_SPRSETUP_SHOW_STORE(NAME) \
> +	__SYSFS_SPRSETUP_SHOW_STORE(NAME)
>  
>  /* Let's define all possible registers, we'll only hook up the ones
>   * that are implemented on the current processor
> 

Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
