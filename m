Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id BC54BDDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 09:23:03 +1000 (EST)
Date: Wed, 23 May 2007 18:22:56 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/4] powerpc: Add EEH sysfs blinkenlights
Message-ID: <20070523232256.GJ29914@localdomain>
References: <20070523171328.GY5921@austin.ibm.com>
	<20070523171646.GA32380@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070523171646.GA32380@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linas-

Linas Vepstas wrote:
> 
> Add sysfs blinkenlights for EEH statistics. Shuffle the
> eeh_add_device_tree() call so that it appears in the correct
> sequence.

( blinkenlights? :)

To me this seems a somewhat terse changelog considering that the patch
introduces a user-visible interface.  The changelog does not really
say what the code is doing or why, or who will use it.


> Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_sysfs.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_sysfs.c	2007-05-23 11:57:23.000000000 -0500
> @@ -0,0 +1,84 @@
> +/*
> + * Sysfs entries for PCI Error Recovery for PAPR-compliant platform.

platforms?

> +#include <linux/pci.h>
> +#include <asm/ppc-pci.h>
> +#include <asm/pci-bridge.h>
> +#include <linux/kobject.h>

Include linux/ before asm/ please.

> +/**
> + * EEH_SHOW_ATTR -- create sysfs entry for eeh statistic
> + * @_name: name of file in sysfs directory
> + * @_memb: name of member in struct pci_dn to access
> + * @_format: printf format for display
> + *
> + * All of the attributes look very similar, so just
> + * auto-gen a cut-n-paste routine to display them.
> + */
> +#define EEH_SHOW_ATTR(_name,_memb,_format)               \
> +static ssize_t eeh_show_##_name(struct device *dev,      \
> +		struct device_attribute *attr, char *buf)          \

I have been frustrated by similar constructions more than once in the
midst of debugging.  I know this has become a common practice with
sysfs-related code, but using cpp to generate function names
completely defeats grep etc. when you're trying to track down a
problem, and I'd not like to see this sort of thing propagated.


> --- linux-2.6.22-rc1.orig/include/asm-powerpc/ppc-pci.h	2007-05-23 11:43:42.000000000 -0500
> +++ linux-2.6.22-rc1/include/asm-powerpc/ppc-pci.h	2007-05-23 11:44:43.000000000 -0500
> @@ -139,6 +139,9 @@ void eeh_clear_slot (struct device_node 
>   */
>  struct device_node * find_device_pe(struct device_node *dn);
>  
> +void eeh_sysfs_add_device(struct pci_dev *pdev);
> +void eeh_sysfs_remove_device(struct pci_dev *pdev);

Don't you need dummy static inline placeholders for CONFIG_EEH=n?
