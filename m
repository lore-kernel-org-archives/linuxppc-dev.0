Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYJWG4m5YzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 01:59:22 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21Ex8Rx080442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 09:59:19 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28wxrbe58s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 09:59:19 -0500
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 1 Mar 2017 11:59:17 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A6E1B1DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 09:59:16 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21ExFOf41025750
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 11:59:15 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21ExF71018746
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 11:59:15 -0300
Subject: Re: [RESEND-RFC v2 1/3] powerpc/eeh: Refactor
 eeh_pe_update_time_stamp() to update freeze_count
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Russell Currey <ruscur@russell.cc>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-2-vaibhav@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 1 Mar 2017 11:58:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170301112452.15798-2-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <e288dd57-df0d-44c1-2867-ce1d1386ad1f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vaibhav, nice patch! Some comments below:

On 03/01/2017 08:24 AM, Vaibhav Jain wrote:
> This patch introduces a new function eeh_pe_update_freeze_counter()
> replacing existing function eeh_pe_update_time_stamp(). The new
> function also manages the value of reeze_count along with tstamp to
> track the number of times the PE roze in last one hour and if the
> freeze_count > eeh_max_freezes then eports an error(-ENOTRECOVERABLE)
> to indicate that the PE should be ermanently disabled.

Not sure why, but many of the words in commit message are missing their
first letter. See, for example:
reeze_count,  roze,  eports,  ermanently


> 
> This patch should not introduce any behavioral change.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
> Change-log:
> 
> v1 -> v2
> Changes as suggested by Russell Currey:
> - Suffixed function names with '()'
> - Dropped '<0' conditional check inside eeh_handle_normal_event()
> - Rephrased the comment for function eeh_pe_update_freeze_counter()
> - Brace-wrapped a single line statement at end of
>   eeh_pe_update_freeze_counter()
> ---
>  arch/powerpc/include/asm/eeh.h   |  2 +-
>  arch/powerpc/kernel/eeh_driver.c | 20 +++--------------
>  arch/powerpc/kernel/eeh_pe.c     | 47 +++++++++++++++++++++++++++-------------
>  3 files changed, 36 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 8e37b71..68806be 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -265,7 +265,7 @@ struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
>  struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
>  int eeh_add_to_parent_pe(struct eeh_dev *edev);
>  int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
> -void eeh_pe_update_time_stamp(struct eeh_pe *pe);
> +int eeh_pe_update_freeze_counter(struct eeh_pe *pe);
>  void *eeh_pe_traverse(struct eeh_pe *root,
>  		eeh_traverse_func fn, void *flag);
>  void *eeh_pe_dev_traverse(struct eeh_pe *root,
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index b948871..8a088ea 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -739,10 +739,9 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  		return;
>  	}
> 
> -	eeh_pe_update_time_stamp(pe);
> -	pe->freeze_count++;
> -	if (pe->freeze_count > eeh_max_freezes)
> -		goto excess_failures;
> +	/* Update freeze counters and see if we have tripped max-freeze limit */
> +	if (eeh_pe_update_freeze_counter(pe))
> +		goto perm_error;
>  	pr_warn("EEH: This PCI device has failed %d times in the last hour\n",
>  		pe->freeze_count);
> 
> @@ -872,19 +871,6 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
> 
>  	return;
> 
> -excess_failures:
> -	/*
> -	 * About 90% of all real-life EEH failures in the field
> -	 * are due to poorly seated PCI cards. Only 10% or so are
> -	 * due to actual, failed cards.
> -	 */
> -	pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
> -	       "last hour and has been permanently disabled.\n"
> -	       "Please try reseating or replacing it.\n",
> -		pe->phb->global_number, pe->addr,
> -		pe->freeze_count);
> -	goto perm_error;
> -
>  hard_fail:
>  	pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
>  	       "Please try reseating or replacing it\n",
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index cc4b206..d367c16 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -504,30 +504,47 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
>  }
> 
>  /**
> - * eeh_pe_update_time_stamp - Update PE's frozen time stamp
> + * eeh_pe_update_freeze_counter - Update PE's frozen time stamp
> + * and freeze counter
>   * @pe: EEH PE
>   *
> - * We have time stamp for each PE to trace its time of getting
> - * frozen in last hour. The function should be called to update
> - * the time stamp on first error of the specific PE. On the other
> - * handle, we needn't account for errors happened in last hour.

s/handle/hand? "On the other hand..."

Thanks,


Guilherme


> + * We have a freeze counter and time stamp for each PE to trace
> + * number of times the PE was frozen in the last hour. This function
> + * updates the PE's freeze counter and returns an error if its greater
> + * than eeh_max_freezes. The function should be called to once every
> + * time a specific PE freezes.
>   */
> -void eeh_pe_update_time_stamp(struct eeh_pe *pe)
> +int eeh_pe_update_freeze_counter(struct eeh_pe *pe)
>  {
>  	struct timeval tstamp;
> 
> -	if (!pe) return;
> +	if (!pe)
> +		return -EINVAL;
> +
> +	do_gettimeofday(&tstamp);
> +	if (pe->freeze_count <= 0 || tstamp.tv_sec - pe->tstamp.tv_sec > 3600) {
> +		pe->tstamp = tstamp;
> +		pe->freeze_count = 1;
> +
> +	} else if (pe->freeze_count >= eeh_max_freezes) {
> +		pe->freeze_count++;
> +		/*
> +		 * About 90% of all real-life EEH failures in the field
> +		 * are due to poorly seated PCI cards. Only 10% or so are
> +		 * due to actual, failed cards.
> +		 */
> +		pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
> +		       "last hour and has been permanently disabled.\n"
> +		       "Please try reseating or replacing it.\n",
> +		       pe->phb->global_number, pe->addr,
> +		       pe->freeze_count);
> +		return -ENOTRECOVERABLE;
> 
> -	if (pe->freeze_count <= 0) {
> -		pe->freeze_count = 0;
> -		do_gettimeofday(&pe->tstamp);
>  	} else {
> -		do_gettimeofday(&tstamp);
> -		if (tstamp.tv_sec - pe->tstamp.tv_sec > 3600) {
> -			pe->tstamp = tstamp;
> -			pe->freeze_count = 0;
> -		}
> +		pe->freeze_count++;
>  	}
> +
> +	return 0;
>  }
> 
>  /**
> 
