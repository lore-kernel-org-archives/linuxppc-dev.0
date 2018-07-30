Return-Path: <bryantly@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fNGw1GB4zF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 01:07:45 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6UF4LFv106921
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 11:07:42 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kj3w8kgh2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 11:07:42 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.ibm.com>;
 Mon, 30 Jul 2018 11:07:40 -0400
Subject: Re: [PATCH v3 1/1] powerpc/pseries: fix EEH recovery of some IOV
 devices
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Cc: mpe@ellerman.id.au, bhelgaas@google.com, bryantly@linux.vnet.ibm.com
References: <e63eb03c87a1a54257aa2bcc384cf07761824a7e.1532915951.git.sbobroff@linux.ibm.com>
From: "Bryant G. Ly" <bryantly@linux.ibm.com>
Date: Mon, 30 Jul 2018 10:07:35 -0500
MIME-Version: 1.0
In-Reply-To: <e63eb03c87a1a54257aa2bcc384cf07761824a7e.1532915951.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <478afe66-34dd-458c-8b66-5e57c6b686eb@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/29/18 8:59 PM, Sam Bobroff wrote:

> EEH recovery currently fails on pSeries for some IOV capable PCI
> devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
> certain device tree properties for the device. (Found on an IOV
> capable device using the ipr driver.)
>
> Recovery fails in pci_enable_resources() at the check on r->parent,
> because r->flags is set and r->parent is not.  This state is due to
> sriov_init() setting the start, end and flags members of the IOV BARs
> but the parent not being set later in
> pseries_pci_fixup_iov_resources(), because the
> "ibm,open-sriov-vf-bar-info" property is missing.
>
> Correct this by zeroing the resource flags for IOV BARs when they
> can't be configured (this is the same method used by sriov_init() and
> __pci_read_base()).
>
> VFs cleared this way can't be enabled later, because that requires
> another device tree property, "ibm,number-of-configurable-vfs" as well
> as support for the RTAS function "ibm_map_pes". These are all part of
> hypervisor support for IOV and it seems unlikely that a hypervisor
> would ever partially, but not fully, support it. (None are currently
> provided by QEMU/KVM.)
>
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
> Hi,
>
> This is a fix to allow EEH recovery to succeed in a specific situation,
> which I've tried to explain in the commit message.
>
> As with the RFC version, the IOV BARs are disabled by setting the resource
> flags to 0 but the other fields are now left as-is because that is what is done
> elsewhere (see sriov_init() and __pci_read_base()).
>
> I've also examined the concern raised by Bjorn Helgaas, that VFs could be
> enabled later after the BARs are disabled, and it already seems safe: enabling
> VFs (on pseries) depends on another device tree property,
> "ibm,number-of-configurable-vfs" as well as support for the RTAS function
> "ibm_map_pes". Since these are all part of the hypervisor's support for IOV it
> seems unlikely that we would ever see some of them but not all. (None are
> currently provided by QEMU/KVM.) (Additionally, the ipr driver on which the EEH
> recovery failure was discovered doesn't even seem to have SR-IOV support so it
> certainly can't enable VFs.)
>
> Cheers,
> Sam.
>
> Patch set v3:
> Patch 1/1: powerpc/pseries: fix EEH recovery of some IOV devices
> * Moved some useful information from the cover letter to the commit log.
>
> Patch set v2:
> Patch 1/1: powerpc/pseries: fix EEH recovery of some IOV devices
> * Moved the BAR disabling code to a function.
> * Also check in pseries_pci_fixup_resources().
>
> Patch set v1:
> Patch 1/1: powerpc/pseries: fix EEH recovery of IOV devices
>
>  arch/powerpc/platforms/pseries/setup.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index b55ad4286dc7..0a9e4243ae1d 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -645,6 +645,15 @@ void of_pci_parse_iov_addrs(struct pci_dev *dev, const int *indexes)
>  	}
>  }

Reviewed-by: Bryant G. Ly <bryantly@linux.ibm.com>
