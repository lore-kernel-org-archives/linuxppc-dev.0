Return-Path: <martin@egholm-nielsen.dk>
Received: from softscan.infopaq.dk (softscan.infopaq.dk [213.150.59.22])
	by ozlabs.org (Postfix) with SMTP id ABDDC67A88
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 06:13:25 +1000 (EST)
Received: from unknown (HELO [192.168.0.5]) ([212.242.189.63])
	(envelope-sender <martin@egholm-nielsen.dk>)
	by mail.freepaq.dk (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 31 Mar 2005 20:13:27 -0000
Message-ID: <424C59E1.7010605@egholm-nielsen.dk>
Date: Thu, 31 Mar 2005 22:13:21 +0200
From: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <ORION1DXU7J3Ty2cTBM000000a9@orion1.ariodata.com>
In-Reply-To: <ORION1DXU7J3Ty2cTBM000000a9@orion1.ariodata.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Overcommit (OOM) problem on embedded device (PPChameleon)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

>>>Look in mm/mmap.c and search for overcommit_memory, then do same
>>>in the sources for your redhat kernels.
>>I'll look into RH kernel to see if it isn't like you say :-)
>>>Perhaps there's a patch for it floating around somewhere? ;-)
>>Now, that would be really nice.
>>Though I have no idea of where to look!?
> Here is what I do.  Patch is against BK linuxppc-2.4 version 1.1285
> (2.4.28-pre3) but might work.
Well, the patch goes straight into my 2.4.20 ppc-kernel - but we have to 
wait until tomorrow to see if it does the magic.

> Burns 5% of the RAM but alternatives all seem worse and I never
I can live with that (3%)...

> If you find out why RH works it would be interesting ... perhaps
> there is a better way.
I downloaded the 2.4.20-10 kernel SRPM from RH8 - it contains all the 
patches they apply to the serene 2.4.20 kernel.
There is some stuff regarding introducing the 
"overcommit_memory_accounting" variable from the 2.5 kernel, but I 
haven't looked into it in depth.

I'll try with your patch first :-)

BR,
  Martin Egholm

> #
> # mm/mmap.c
> #   Add pessimistic overcommit mode similar to 2.6 mode 2.
> #   This allows malloc aka sbrk() to actually fail before
> #   process is killed.
> #   Overloaded sysctl_overcommit_memory to be both enable
> #   and ratio to avoid making a new sysctl.
> # 
> diff -Nru a/mm/mmap.c b/mm/mmap.c
> --- a/mm/mmap.c	2005-03-30 07:15:13 -08:00
> +++ b/mm/mmap.c	2005-03-30 07:15:13 -08:00
> @@ -45,9 +45,13 @@
>  	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>  };
>  
> -int sysctl_overcommit_memory;
> +int sysctl_overcommit_memory = 98;
> +
>  int max_map_count = DEFAULT_MAX_MAP_COUNT;
>  
> +extern unsigned long totalram_pages;
> +extern unsigned long totalhigh_pages;
> +
>  /* Check that a process has enough memory to allocate a
>   * new virtual mapping.
>   */
> @@ -66,7 +70,7 @@
>  	unsigned long free;
>  	
>          /* Sometimes we want to use more memory than we have. */
> -	if (sysctl_overcommit_memory)
> +	if (sysctl_overcommit_memory == 1)
>  	    return 1;
>  
>  	/* The page cache contains buffer pages these days.. */
> @@ -91,7 +95,20 @@
>  	free += (dentry_stat.nr_unused * sizeof(struct dentry)) >>
> PAGE_SHIFT;
>  	free += (inodes_stat.nr_unused * sizeof(struct inode)) >>
> PAGE_SHIFT;
>  
> +	/*
> +	 * Leave the last 3% for root
> +	 */
> +	if (current->euid)
> +		free -= free / 32;
> +
> +	/* Strict mode do not allocate last bit of memory */
> +	if (sysctl_overcommit_memory) {
> +		pages += (totalram_pages - totalhigh_pages)
> +			* (100 - sysctl_overcommit_memory) / 100;
> +	}
> +
>  	return free > pages;
> +
>  }
>  
>  /* Remove one vm structure from the inode's i_mapping address space. */
> 
> 
> 
