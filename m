Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6y0y1nJzzDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 09:48:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s6y0x4dddz9sCy
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 09:48:33 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u77NieeW085036
 for <linuxppc-dev@ozlabs.org>; Sun, 7 Aug 2016 19:48:31 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24nc2y3q95-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 07 Aug 2016 19:48:31 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 09:48:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2A8B82BB0055
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 09:48:26 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u77NmQ7j27852872
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 09:48:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u77NmPEF009929
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 09:48:26 +1000
Date: Mon, 8 Aug 2016 09:48:24 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, chzigotzky@xenosoft.de,
 gpiccoli@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/pci: Only do fixed PHB numbering on powernv
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1470379256-24266-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470379256-24266-1-git-send-email-mpe@ellerman.id.au>
Message-Id: <20160807234824.GA4628@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2016 at 04:40:56PM +1000, Michael Ellerman wrote:
>The recent commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number
>based on device-tree properties"), added code to read a 64-bit property
>from the device tree, and if not found read a 32-bit property (reg).
>
>There was a bug in the 32-bit case, on big endian machines, due to the
>use of the 64-bit value to read the 32-bit property. The cast of &prop
>means we end up writing to the high 32-bit of prop, leaving the low
>32-bits containing whatever junk was on the stack.
>
>If that junk value was non-zero, and < MAX_PHBS, we would end up using
>it as the PHB id.
>
>This exposed a second problem, which is that Xorg can't cope with a
>domain number > 256.
>
>So for now drop the fallback to reg, and only use "ibm,opal-phbid" for
>PHB numbering.
>
>Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>---
> arch/powerpc/kernel/pci-common.c | 24 +++++++++---------------
> 1 file changed, 9 insertions(+), 15 deletions(-)
>
>
>This is my bad. Guilherme limited the reg case to pseries only, but I made it
>generic. I tested it on G5, Cell etc. which all booted - but that's not really
>a good enough test.
>
>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>index f93942b4b6a6..f9c2ffaa1884 100644
>--- a/arch/powerpc/kernel/pci-common.c
>+++ b/arch/powerpc/kernel/pci-common.c
>@@ -77,29 +77,23 @@ EXPORT_SYMBOL(get_pci_dma_ops);
>  */
> static int get_phb_number(struct device_node *dn)
> {
>-	int ret, phb_id = -1;
>+	int ret, phb_id;
> 	u64 prop;
>
> 	/*
>-	 * Try fixed PHB numbering first, by checking archs and reading
>-	 * the respective device-tree properties. Firstly, try powernv by
>-	 * reading "ibm,opal-phbid", only present in OPAL environment.
>+	 * On powernv machines we should have the "ibm,opal-phbid" property, if
>+	 * so use that so that PHB numbers are predictable.
> 	 */
> 	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
>-	if (ret)
>-		ret = of_property_read_u32_index(dn, "reg", 1, (u32 *)&prop);
>-
>-	if (!ret)
>+	if (ret == 0) {
> 		phb_id = (int)(prop & (MAX_PHBS - 1));
>

Michael, It's going to ignore the issue addressed by commit 63a72284b159
("powerpc/pci: Assign fixed PHB number based on device-tree properties").
The commit tried to get the PCI domain number from "reg" on pSeries. We
still need check "reg" and try to get PCI domain number from it on pSeries
only:

	if (ret && machine_is(pseries))
		ret = of_property_read_u32_index(dn, "reg", 1, (u32 *)&prop);

Thanks,
Gavin

>-	/* We need to be sure to not use the same PHB number twice. */
>-	if ((phb_id >= 0) && !test_and_set_bit(phb_id, phb_bitmap))
>-		return phb_id;
>+		/* Make sure never to use the same PHB number twice. */
>+		if (!test_and_set_bit(phb_id, phb_bitmap))
>+			return phb_id;
>+	}
>
>-	/*
>-	 * If not pseries nor powernv, or if fixed PHB numbering tried to add
>-	 * the same PHB number twice, then fallback to dynamic PHB numbering.
>-	 */
>+	/* If fixed PHB numbering failed, fallback to dynamic PHB numbering. */
> 	phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
> 	BUG_ON(phb_id >= MAX_PHBS);
> 	set_bit(phb_id, phb_bitmap);
>-- 
>2.7.4
>
