Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXwCb0X01zDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 10:44:27 +1100 (AEDT)
Message-ID: <1488325463.9162.2.camel@russell.cc>
Subject: Re: [RFC 1/3] powerpc/eeh: Refactor eeh_pe_update_time_stamp to
 update freeze_count
From: Russell Currey <ruscur@russell.cc>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,  frederic.barrat@fr.ibm.com
Cc: Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie
 <ianmunsi@au1.ibm.com>,  Christophe Lombard
 <christophe_lombard@fr.ibm.com>, Philippe Bergheaud
 <philippe.bergheaud@fr.ibm.com>, Gregory Kurz <KURZGREG@fr.ibm.com>, Gavin
 Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 01 Mar 2017 10:44:23 +1100
In-Reply-To: <20170228070222.21126-2-vaibhav@linux.vnet.ibm.com>
References: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
 <20170228070222.21126-2-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-28 at 12:32 +0530, Vaibhav Jain wrote:
> This patch introduces a new function named
> eeh_pe_update_freeze_counter replacing existing function
> eeh_pe_update_time_stamp. The new function also manages the value of
> freeze_count along with tstamp to track the number of times the PE
> froze in last one hour and if the freeze_count > eeh_max_freezes then
> reports an error(-ENOTRECOVERABLE) to indicate that the PE should be
> permanently disabled.

You should add parens to the end of function names in commit messages, i.e.
eeh_pe_update_freeze_counter().  Same goes for the title

> 
> This patch should not introduce any behavioral change.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h   |  2 +-
>  arch/powerpc/kernel/eeh_driver.c | 20 +++-------------
>  arch/powerpc/kernel/eeh_pe.c     | 50 ++++++++++++++++++++++++++-------------
> -
>  3 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 8e37b71..68806be 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -265,7 +265,7 @@ struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
>  struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
>  int eeh_add_to_parent_pe(struct eeh_dev *edev);
>  int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
> -void eeh_pe_update_time_stamp(struct eeh_pe *pe);
> +int eeh_pe_update_freeze_counter(struct eeh_pe *pe);
>  void *eeh_pe_traverse(struct eeh_pe *root,
>  		eeh_traverse_func fn, void *flag);
>  void *eeh_pe_dev_traverse(struct eeh_pe *root,
> diff --git a/arch/powerpc/kernel/eeh_driver.c
> b/arch/powerpc/kernel/eeh_driver.c
> index b948871..326b4e4 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -739,10 +739,9 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  		return;
>  	}
>  
> -	eeh_pe_update_time_stamp(pe);
> -	pe->freeze_count++;
> -	if (pe->freeze_count > eeh_max_freezes)
> -		goto excess_failures;
> +	/* Update freeze counters and see if we have tripped max-freeze limit
> */
> +	if (eeh_pe_update_freeze_counter(pe) < 0)

I would prefer dropping the "< 0" check here

> +		goto perm_error;
>  	pr_warn("EEH: This PCI device has failed %d times in the last
> hour\n",
>  		pe->freeze_count);
>  
> @@ -872,19 +871,6 @@ static void eeh_handle_normal_event(struct eeh_pe *pe)
>  
>  	return;
>  
> -excess_failures:
> -	/*
> -	 * About 90% of all real-life EEH failures in the field
> -	 * are due to poorly seated PCI cards. Only 10% or so are
> -	 * due to actual, failed cards.
> -	 */
> -	pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
> -	       "last hour and has been permanently disabled.\n"
> -	       "Please try reseating or replacing it.\n",
> -		pe->phb->global_number, pe->addr,
> -		pe->freeze_count);
> -	goto perm_error;
> -
>  hard_fail:
>  	pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
>  	       "Please try reseating or replacing it\n",
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index cc4b206..cf70a8b 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -504,30 +504,46 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
>  }
>  
>  /**
> - * eeh_pe_update_time_stamp - Update PE's frozen time stamp
> + * eeh_pe_update_freeze_counter - Update PE's frozen time stamp
> + * and freeze counter
>   * @pe: EEH PE
>   *
> - * We have time stamp for each PE to trace its time of getting
> - * frozen in last hour. The function should be called to update
> - * the time stamp on first error of the specific PE. On the other
> - * handle, we needn't account for errors happened in last hour.
> + * We have a freeze-counter and time stamp for each PE to trace

drop the hyphen between freeze and counter

> + * number of times the PE was frozen in last one hour. This function

this should probably "in the last hour", I know it was copied from the existing
comment but since you're in here, you may as well fix it

> + * updates the PE's freeze counter and if its > eeh_max_freezes then

this reads awkwardly.  perhaps "This function updates the PE's freeze counter
and returns an error if the number of freezes is greater than eeh_max_freezes." 

> + * returns an error. The function should be called to once every-time
> + * a specific PE freezes.

a hyphen between "every time" is unnecessary

>   */
> -void eeh_pe_update_time_stamp(struct eeh_pe *pe)
> +int eeh_pe_update_freeze_counter(struct eeh_pe *pe)
>  {
>  	struct timeval tstamp;
>  
> -	if (!pe) return;
> +	if (!pe)
> +		return -EINVAL;
>  
> -	if (pe->freeze_count <= 0) {
> -		pe->freeze_count = 0;
> -		do_gettimeofday(&pe->tstamp);
> -	} else {
> -		do_gettimeofday(&tstamp);
> -		if (tstamp.tv_sec - pe->tstamp.tv_sec > 3600) {
> -			pe->tstamp = tstamp;
> -			pe->freeze_count = 0;
> -		}
> -	}
> +	do_gettimeofday(&tstamp);
> +	if (pe->freeze_count <= 0 || tstamp.tv_sec - pe->tstamp.tv_sec >
> 3600) {
> +		pe->tstamp = tstamp;
> +		pe->freeze_count = 1;
> +
> +	} else if (pe->freeze_count >= eeh_max_freezes) {
> +		pe->freeze_count++;
> +		/*
> +		 * About 90% of all real-life EEH failures in the field
> +		 * are due to poorly seated PCI cards. Only 10% or so are
> +		 * due to actual, failed cards.
> +		 */
> +		pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
> +		       "last hour and has been permanently disabled.\n"
> +		       "Please try reseating or replacing it.\n",
> +		       pe->phb->global_number, pe->addr,
> +		       pe->freeze_count);
> +		return -ENOTRECOVERABLE;
> +
> +	} else
> +		pe->freeze_count++;

Wrap this in brackets too.  It looks messy hanging off the end, even though it's
a single line statement.

> +
> +	return 0;
>  }
>  
>  /**
