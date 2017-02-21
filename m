Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSCS12LhmzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 18:53:52 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L7rbol008593
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 02:53:49 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28r2pp05f1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 02:53:49 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 21 Feb 2017 17:53:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8ADF42CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 18:53:43 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L7rZkR45416604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 18:53:43 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L7rAF2001394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 18:53:11 +1100
Subject: Re: [PATCH] cxl: fix nested locking hang during EEH hotplug
To: linuxppc-dev@lists.ozlabs.org
References: <20170206010717.3460-1-andrew.donnellan@au1.ibm.com>
Cc: vaibhav@linux.vnet.ibm.com, stable@vger.kernel.org,
 ukrishn@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 pradghos@in.ibm.com, imunsie@au1.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 21 Feb 2017 18:52:46 +1100
MIME-Version: 1.0
In-Reply-To: <20170206010717.3460-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8d97d390-55d0-9f26-c841-69e87a2fec1c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/17 12:07, Andrew Donnellan wrote:
> Commit 14a3ae34bfd0 ("cxl: Prevent read/write to AFU config space while AFU
> not configured") introduced a rwsem to fix an invalid memory access that
> occurred when someone attempts to access the config space of an AFU on a
> vPHB whilst the AFU is deconfigured, such as during EEH recovery.
>
> It turns out that it's possible to run into a nested locking issue when EEH
> recovery fails and a full device hotplug is required.
> cxl_pci_error_detected() deconfigures the AFU, taking a writer lock on
> configured_rwsem. When EEH recovery fails, the EEH code calls
> pci_hp_remove_devices() to remove the device, which in turn calls
> cxl_remove() -> cxl_pci_remove_afu() -> pci_deconfigure_afu(), which tries
> to grab the writer lock that's already held.
>
> Standard rwsem semantics don't express what we really want to do here and
> don't allow for nested locking. Fix this by replacing the rwsem with an
> atomic_t which we can control more finely. Allow the AFU to be locked
> multiple times so long as there are no readers.
>
> Fixes: 14a3ae34bfd0 ("cxl: Prevent read/write to AFU config space while AFU not configured")
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

This patch has now been tested within IBM and should be good to go.

Michael/stable team - please make sure this gets in at the same time as 
14a3ae34bfd0.


Andrew


>
> ---
>
> I've asked Uma and Pradipta to give this a test.
>
> ---
>  drivers/misc/cxl/cxl.h  |  5 +++--
>  drivers/misc/cxl/main.c |  3 +--
>  drivers/misc/cxl/pci.c  | 11 +++++++++--
>  drivers/misc/cxl/vphb.c | 18 ++++++++++++++----
>  4 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index b4a43fd14b99..08e7d3a54425 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -418,8 +418,9 @@ struct cxl_afu {
>  	struct dentry *debugfs;
>  	struct mutex contexts_lock;
>  	spinlock_t afu_cntl_lock;
> -	/* Used to block access to AFU config space while deconfigured */
> -	struct rw_semaphore configured_rwsem;
> +
> +	/* -1: AFU deconfigured/locked, >= 0: number of readers */
> +	atomic_t configured_state;
>
>  	/* AFU error buffer fields and bin attribute for sysfs */
>  	u64 eb_len, eb_offset;
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index 2a6bf1d0a3a4..cc1706a92ace 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -268,8 +268,7 @@ struct cxl_afu *cxl_alloc_afu(struct cxl *adapter, int slice)
>  	idr_init(&afu->contexts_idr);
>  	mutex_init(&afu->contexts_lock);
>  	spin_lock_init(&afu->afu_cntl_lock);
> -	init_rwsem(&afu->configured_rwsem);
> -	down_write(&afu->configured_rwsem);
> +	atomic_set(&afu->configured_state, -1);
>  	afu->prefault_mode = CXL_PREFAULT_NONE;
>  	afu->irqs_max = afu->adapter->user_irqs;
>
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index f512e13ec0f2..bdfa5ff11aea 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1129,7 +1129,7 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
>  	if ((rc = cxl_native_register_psl_irq(afu)))
>  		goto err2;
>
> -	up_write(&afu->configured_rwsem);
> +	atomic_set(&afu->configured_state, 0);
>  	return 0;
>
>  err2:
> @@ -1142,7 +1142,14 @@ static int pci_configure_afu(struct cxl_afu *afu, struct cxl *adapter, struct pc
>
>  static void pci_deconfigure_afu(struct cxl_afu *afu)
>  {
> -	down_write(&afu->configured_rwsem);
> +	/*
> +	 * It's okay to deconfigure when AFU is already locked, otherwise wait
> +	 * until there are no readers
> +	 */
> +	if (atomic_read(&afu->configured_state) != -1) {
> +		while (atomic_cmpxchg(&afu->configured_state, 0, -1) != -1)
> +			schedule();
> +	}
>  	cxl_native_release_psl_irq(afu);
>  	if (afu->adapter->native->sl_ops->release_serr_irq)
>  		afu->adapter->native->sl_ops->release_serr_irq(afu);
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 639a343b7836..512a4897dbf6 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -83,6 +83,16 @@ static inline struct cxl_afu *pci_bus_to_afu(struct pci_bus *bus)
>  	return phb ? phb->private_data : NULL;
>  }
>
> +static void cxl_afu_configured_put(struct cxl_afu *afu)
> +{
> +	atomic_dec_if_positive(&afu->configured_state);
> +}
> +
> +static bool cxl_afu_configured_get(struct cxl_afu *afu)
> +{
> +	return atomic_inc_unless_negative(&afu->configured_state);
> +}
> +
>  static inline int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
>  				       struct cxl_afu *afu, int *_record)
>  {
> @@ -107,7 +117,7 @@ static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
>
>  	afu = pci_bus_to_afu(bus);
>  	/* Grab a reader lock on afu. */
> -	if (afu == NULL || !down_read_trylock(&afu->configured_rwsem))
> +	if (afu == NULL || !cxl_afu_configured_get(afu))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>
>  	rc = cxl_pcie_config_info(bus, devfn, afu, &record);
> @@ -132,7 +142,7 @@ static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
>  	}
>
>  out:
> -	up_read(&afu->configured_rwsem);
> +	cxl_afu_configured_put(afu);
>  	return rc ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
>  }
>
> @@ -144,7 +154,7 @@ static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
>
>  	afu = pci_bus_to_afu(bus);
>  	/* Grab a reader lock on afu. */
> -	if (afu == NULL || !down_read_trylock(&afu->configured_rwsem))
> +	if (afu == NULL || !cxl_afu_configured_get(afu))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>
>  	rc = cxl_pcie_config_info(bus, devfn, afu, &record);
> @@ -166,7 +176,7 @@ static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
>  	}
>
>  out:
> -	up_read(&afu->configured_rwsem);
> +	cxl_afu_configured_put(afu);
>  	return rc ? PCIBIOS_SET_FAILED : PCIBIOS_SUCCESSFUL;
>  }
>
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
