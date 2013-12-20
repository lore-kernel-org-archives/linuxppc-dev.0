Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22e.google.com (mail-ie0-x22e.google.com
 [IPv6:2607:f8b0:4001:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D03A2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 03:43:23 +1100 (EST)
Received: by mail-ie0-f174.google.com with SMTP id at1so3372376iec.19
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 08:43:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1387533832-34554-1-git-send-email-dongsheng.wang@freescale.com>
References: <1387533832-34554-1-git-send-email-dongsheng.wang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 20 Dec 2013 09:42:59 -0700
Message-ID: <CAErSpo7+8sLZVi24fi+xxTEW2_DTJ2_zUrW+vobMGsvCEFwY_Q@mail.gmail.com>
Subject: Re: [RFC] linux/pci: move pci_platform_pm_ops to linux/pci.h
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PM list <linux-pm@vger.kernel.org>, roy.zang@freescale.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 20, 2013 at 3:03 AM, Dongsheng Wang
<dongsheng.wang@freescale.com> wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> make Freescale platform use pci_platform_pm_ops struct.

This changelog doesn't say anything about what the patch does.

I infer that you want to use pci_platform_pm_ops from some Freescale
code.  This patch should be posted along with the patches that add
that Freescale code, so we can see how you intend to use it.

The existing use is in drivers/pci/pci-acpi.c, so it's possible that
your new use should be added in the same way, in drivers/pci, so we
don't have to make pci_platform_pm_ops part of the public PCI
interface in include/linux/pci.h.

That said, if Raphael thinks this makes sense, it's OK with me.

> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
>
> If device's not set power state, we will use this interface to put the
> device's into the correct state.
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9c91ecc..48f8b1a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -33,36 +33,6 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
>  #endif
>  int pci_probe_reset_function(struct pci_dev *dev);
>
> -/**
> - * struct pci_platform_pm_ops - Firmware PM callbacks
> - *
> - * @is_manageable: returns 'true' if given device is power manageable by the
> - *                 platform firmware
> - *
> - * @set_state: invokes the platform firmware to set the device's power state
> - *
> - * @choose_state: returns PCI power state of given device preferred by the
> - *                platform; to be used during system-wide transitions from a
> - *                sleeping state to the working state and vice versa
> - *
> - * @sleep_wake: enables/disables the system wake up capability of given device
> - *
> - * @run_wake: enables/disables the platform to generate run-time wake-up events
> - *             for given device (the device's wake-up capability has to be
> - *             enabled by @sleep_wake for this feature to work)
> - *
> - * If given platform is generally capable of power managing PCI devices, all of
> - * these callbacks are mandatory.
> - */
> -struct pci_platform_pm_ops {
> -       bool (*is_manageable)(struct pci_dev *dev);
> -       int (*set_state)(struct pci_dev *dev, pci_power_t state);
> -       pci_power_t (*choose_state)(struct pci_dev *dev);
> -       int (*sleep_wake)(struct pci_dev *dev, bool enable);
> -       int (*run_wake)(struct pci_dev *dev, bool enable);
> -};
> -
> -int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
>  void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>  void pci_power_up(struct pci_dev *dev);
>  void pci_disable_enabled_device(struct pci_dev *dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1084a15..20e07b8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -365,6 +365,37 @@ struct pci_dev {
>         size_t romlen; /* Length of ROM if it's not from the BAR */
>  };
>
> +/**
> + * struct pci_platform_pm_ops - Firmware PM callbacks
> + *
> + * @is_manageable: returns 'true' if given device is power manageable by the
> + *                 platform firmware
> + *
> + * @set_state: invokes the platform firmware to set the device's power state
> + *
> + * @choose_state: returns PCI power state of given device preferred by the
> + *                platform; to be used during system-wide transitions from a
> + *                sleeping state to the working state and vice versa
> + *
> + * @sleep_wake: enables/disables the system wake up capability of given device
> + *
> + * @run_wake: enables/disables the platform to generate run-time wake-up events
> + *             for given device (the device's wake-up capability has to be
> + *             enabled by @sleep_wake for this feature to work)
> + *
> + * If given platform is generally capable of power managing PCI devices, all of
> + * these callbacks are mandatory.
> + */
> +struct pci_platform_pm_ops {
> +       bool (*is_manageable)(struct pci_dev *dev);
> +       int (*set_state)(struct pci_dev *dev, pci_power_t state);
> +       pci_power_t (*choose_state)(struct pci_dev *dev);
> +       int (*sleep_wake)(struct pci_dev *dev, bool enable);
> +       int (*run_wake)(struct pci_dev *dev, bool enable);
> +};
> +
> +int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
> +
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>  {
>  #ifdef CONFIG_PCI_IOV
> --
> 1.8.5
>
>
