Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B46DB2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 16:21:54 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 27 Dec 2012 22:21:51 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7C7D61FF0027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 22:21:39 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBS5LmmT084438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 22:21:48 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBS5LlNY015839
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2012 22:21:47 -0700
Date: Fri, 28 Dec 2012 13:21:35 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc/iommu: prevent false TCE leak message
Message-ID: <20121228052135.GB9975@shangw.(null)>
References: <1356625686-8943-1-git-send-email-cascardo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356625686-8943-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 27, 2012 at 02:28:06PM -0200, Thadeu Lima de Souza Cascardo wrote:
>When a device DMA window includes the address 0, it's reserved in the
>TCE bitmap to avoid returning that address to drivers.
>
>When the device is removed, the bitmap is checked for any mappings not
>removed by the driver, indicating a possible DMA mapping leak. Since the
>reserved address is not cleared, a message is printed, warning of such a
>leak.
>
>Check for the reservation, and clear it before checking for any other
>standing mappings.
>
>Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/iommu.c |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)
>
>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>index 8226c6c..226e9e5 100644
>--- a/arch/powerpc/kernel/iommu.c
>+++ b/arch/powerpc/kernel/iommu.c
>@@ -717,6 +717,11 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
> 		return;
> 	}
>
>+	/* In case we have reserved the first bit, we should not emit
>+	 * the warning below. */

At least, the comment would look like:

	/*
	 * xxxxxxx
	 */

>+	if (tbl->it_offset == 0)
>+		clear_bit(0, tbl->it_map);
>+
> 	/* verify that table contains no entries */
> 	/* it_size is in entries, and we're examining 64 at a time */

The comment would be merged as well? :-)

> 	for (i = 0; i < (tbl->it_size/64); i++) {

Thanks,
Gavin
