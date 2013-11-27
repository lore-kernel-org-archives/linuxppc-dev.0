Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 552E32C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 12:54:05 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 26 Nov 2013 18:54:01 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 10A85C90042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 20:53:57 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAR1rwWD8716786
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 01:53:58 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAR1rwuf012045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 20:53:58 -0500
Date: Wed, 27 Nov 2013 09:53:55 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Increase EEH recovery timeout for SR-IOV
Message-ID: <20131127015355.GA12086@shangw.(null)>
References: <201311252227.rAPMRtC2018812@d03av05.boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201311252227.rAPMRtC2018812@d03av05.boulder.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 25, 2013 at 04:27:54PM -0600, Brian King wrote:
>
>In order to support concurrent adapter firmware download
>to SR-IOV adapters on pSeries, each VF will see an EEH event
>where the slot will remain in the unavailable state for
>the duration of the adapter firmware update, which can take
>as long as 5 minutes. Extend the EEH recovery timeout to
>account for this.
>
>Signed-off-by: Brian King <brking@linux.vnet.ibm.com>

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>---
>
> arch/powerpc/kernel/eeh.c        |    2 +-
> arch/powerpc/kernel/eeh_driver.c |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff -puN arch/powerpc/kernel/eeh.c~eeh_sriov_vf_delay arch/powerpc/kernel/eeh.c
>--- linux/arch/powerpc/kernel/eeh.c~eeh_sriov_vf_delay	2013-11-25 16:12:26.000000000 -0600
>+++ linux-bjking1/arch/powerpc/kernel/eeh.c	2013-11-25 16:12:26.000000000 -0600
>@@ -84,7 +84,7 @@
> #define EEH_MAX_FAILS	2100000
>
> /* Time to wait for a PCI slot to report status, in milliseconds */
>-#define PCI_BUS_RESET_WAIT_MSEC (60*1000)
>+#define PCI_BUS_RESET_WAIT_MSEC (5*60*1000)
>
> /* Platform dependent EEH operations */
> struct eeh_ops *eeh_ops = NULL;
>diff -puN arch/powerpc/kernel/eeh_driver.c~eeh_sriov_vf_delay arch/powerpc/kernel/eeh_driver.c
>--- linux/arch/powerpc/kernel/eeh_driver.c~eeh_sriov_vf_delay	2013-11-25 16:12:26.000000000 -0600
>+++ linux-bjking1/arch/powerpc/kernel/eeh_driver.c	2013-11-25 16:12:26.000000000 -0600
>@@ -468,7 +468,7 @@ static int eeh_reset_device(struct eeh_p
> /* The longest amount of time to wait for a pci device
>  * to come back on line, in seconds.
>  */
>-#define MAX_WAIT_FOR_RECOVERY 150
>+#define MAX_WAIT_FOR_RECOVERY 300
>
> static void eeh_handle_normal_event(struct eeh_pe *pe)
> {

Thanks,
Gavin
