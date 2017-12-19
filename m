Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z157B0l4nzDsRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 15:50:14 +1100 (AEDT)
Date: Mon, 18 Dec 2017 22:50:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, aik@ozlabs.ru, ruscur@russell.cc,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com,
 Keith Busch <keith.busch@intel.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v2 2/7] powerpc/kernel: Add uevents in EEH error/resume
Message-ID: <20171219045009.GC14941@bhelgaas-glaptop.roam.corp.google.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
 <20171218223808.83928-3-bryantly@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218223808.83928-3-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Keith, Gabriele, Dongdong]

On Mon, Dec 18, 2017 at 04:38:03PM -0600, Bryant G. Ly wrote:
> Devices can go offline when EEH is reported. This patch adds
> a change to the kernel object and lets udev know of error.
> When device resumes a change is also set reporting device as
> online. Therefore, EEH events are better propagated to user
> space for devices in powerpc arch.

I'm on vacation and can't review this in detail, but I wonder if you
can compare this with the uevents we emit for DPC, AER, and hotplug
events (if any).  I hope we don't end up with userspace having to be
aware of the differences between EEH, DPC, AER, etc.

>From a very quick look, I only see a few uevents even mentioned in
drivers/pci: KOBJ_ADD in __pci_hp_register() and KOBJ_CHANGE in the
SR-IOV code.  I'm worried that we're missing some important uevents in
the PCI core.  That's not an argument against what you're doing here;
it just would be nice to fill in any missing pieces in the core also,
and hopefully make them consistent with these EEH events.

> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 3c0fa99c5533..9d4e8177c2e0 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -204,6 +204,7 @@ static void *eeh_report_error(void *data, void *userdata)
>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>  	enum pci_ers_result rc, *res = userdata;
>  	struct pci_driver *driver;
> +	char *envp[] = {"EVENT=EEH_ERROR", "ONLINE=0", NULL};
>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> @@ -228,6 +229,7 @@ static void *eeh_report_error(void *data, void *userdata)
>  
>  	edev->in_error = true;
>  	eeh_pcid_put(dev);
> +	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
>  	return NULL;
>  }
>  
> @@ -358,6 +360,7 @@ static void *eeh_report_resume(void *data, void *userdata)
>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>  	bool was_in_error;
>  	struct pci_driver *driver;
> +	char *envp[] = {"EVENT=EEH_RESUME", "ONLINE=1", NULL};
>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> @@ -381,6 +384,7 @@ static void *eeh_report_resume(void *data, void *userdata)
>  	driver->err_handler->resume(dev);
>  
>  	eeh_pcid_put(dev);
> +	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
>  	return NULL;
>  }
>  
> @@ -397,6 +401,7 @@ static void *eeh_report_failure(void *data, void *userdata)
>  	struct eeh_dev *edev = (struct eeh_dev *)data;
>  	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
>  	struct pci_driver *driver;
> +	char * envp[] = {"EVENT=EEH_PERMANENT_FAILURE", "ONLINE=0", NULL};
>  
>  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
>  		return NULL;
> @@ -415,6 +420,7 @@ static void *eeh_report_failure(void *data, void *userdata)
>  
>  	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
>  
> +	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
>  	eeh_pcid_put(dev);
>  	return NULL;
>  }
> -- 
> 2.14.3 (Apple Git-98)
> 
