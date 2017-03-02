Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYZ5Y05fGzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 12:11:28 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2219kEa007375
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 20:11:26 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wxrbdc4p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 20:11:25 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 2 Mar 2017 11:11:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 40C403578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 12:11:21 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v221BDtd55509106
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:11:21 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v221AmFB028720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:10:49 +1100
Subject: Re: [RESEND-RFC v2 2/3] powerpc/eeh: Introduce function
 eeh_pe_reset_freeze_counter()
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Russell Currey <ruscur@russell.cc>
References: <20170301112452.15798-1-vaibhav@linux.vnet.ibm.com>
 <20170301112452.15798-3-vaibhav@linux.vnet.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 2 Mar 2017 12:10:22 +1100
MIME-Version: 1.0
In-Reply-To: <20170301112452.15798-3-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5e74f7b2-9b40-7833-94fc-42a7d11a59ee@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/03/17 22:24, Vaibhav Jain wrote:
> This patch introduces function eeh_pe_reset_freeze_counter() which can
> be used to reset the PE's freeze count variable outside eeh code. This
> is useful for devices that can acquire a different personality after
> a PERST event (e.g FPGA Adapters). Presently an existing freeze
> count for an adapter with personality N will be taken into account
> when the adapter acquired personality N+1.
>
> By calling eeh_pe_reset_freeze_counter() drivers can reset the freeze
> counter for an adapter once it has acquired a new personality and
> ideally wont be plagued by the failures similar to the one before.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

LGTM

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
> Change-log:
>
> v1 -> v2
> * Changes as suggested by Russell Currey:
> - Suffixed function names with '()'
> - Rephrased the description comment for functon eeh_pe_reset_freeze_counter()
> - Inserted logging for PHB and PE number inside eeh_pe_reset_freeze_counter()
>
> * Moved definition of eeh_pe_reset_freeze_counter() from eeh.h to eeh_pe.c to
>   avoid adding a header dependency to 'pci-bridge.h'. The function is
>   now marked as an exported gpl symbol.
> ---
>  arch/powerpc/include/asm/eeh.h |  5 +++++
>  arch/powerpc/kernel/eeh_pe.c   | 17 +++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 68806be..8dcfb88 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -266,6 +266,9 @@ struct eeh_pe *eeh_pe_get(struct eeh_dev *edev);
>  int eeh_add_to_parent_pe(struct eeh_dev *edev);
>  int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
>  int eeh_pe_update_freeze_counter(struct eeh_pe *pe);
> +
> +void eeh_pe_reset_freeze_counter(struct eeh_pe *pe);
> +
>  void *eeh_pe_traverse(struct eeh_pe *root,
>  		eeh_traverse_func fn, void *flag);
>  void *eeh_pe_dev_traverse(struct eeh_pe *root,
> @@ -339,6 +342,8 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
>  	return 0;
>  }
>
> +static inline void eeh_pe_reset_freeze_counter(struct eeh_pe *pe) { }
> +
>  #define eeh_dev_check_failure(x) (0)
>
>  static inline void eeh_addr_cache_build(void) { }
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index d367c16..75c781f 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -504,6 +504,23 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
>  }
>
>  /**
> + * eeh_pe_reset_freeze_counter - Resets the PE freeze counter
> + * @pe: EEH PE
> + *
> + * This function is useful while re-configuring an FPGA adapter
> + * as its about to acquire new a personality and you don't want
> + * freeze count to be carry forwarded. As such calling this function
> + * for regular pci devices might be a bad idea.
> + */
> +void eeh_pe_reset_freeze_counter(struct eeh_pe *pe)
> +{
> +	pr_info("Resetting freeze count for PHB#%x-PE#%x\n",
> +		pe->phb->global_number, pe->addr);
> +	pe->freeze_count = 0;
> +}
> +EXPORT_SYMBOL_GPL(eeh_pe_reset_freeze_counter);
> +
> +/**
>   * eeh_pe_update_freeze_counter - Update PE's frozen time stamp
>   * and freeze counter
>   * @pe: EEH PE
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
