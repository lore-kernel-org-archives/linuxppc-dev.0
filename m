Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17DDC1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 09:10:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 13 May 2015 09:10:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D89F02CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 09:10:01 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4CN9rwm30015678
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 09:10:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4CN9Sdq008231
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 09:09:29 +1000
Date: Wed, 13 May 2015 09:09:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 6/9] powerpc/powernv: create/release eeh_dev for VF
Message-ID: <20150512230904.GA6321@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150511024856.GB8816@gwshan> <20150512080643.GC16788@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150512080643.GC16788@richard>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 04:06:43PM +0800, Wei Yang wrote:
>On Mon, May 11, 2015 at 12:48:56PM +1000, Gavin Shan wrote:
>>On Mon, May 04, 2015 at 03:07:35PM +0800, Wei Yang wrote:
>>
>>Please order this patch and PATCH[5] because EEH device is expected to
>>be created before EEH PE.
>>
>>>EEH on powerpc platform needs eeh_dev structure to track the pci device
>>                                                              ^^^
>>							      PCI
>>
>>>status. Since VFs are created/released dynamically, VF's eeh_dev is also
>>>dynamically created/released in system.
>>>
>>>This patch creates/removes eeh_dev when pci_dn is created/removed for VFs,
>>>and marks it with EEH_DEV_VF type.
>>>
>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>---
>>> arch/powerpc/include/asm/eeh.h |    7 +++++++
>>> arch/powerpc/kernel/eeh.c      |    4 ++++
>>> arch/powerpc/kernel/eeh_dev.c  |   20 ++++++++++++++++++++
>>> arch/powerpc/kernel/pci_dn.c   |    7 +++++++
>>> 4 files changed, 38 insertions(+)
>>>
>>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>>index 56e8cd9..2067de4 100644
>>>--- a/arch/powerpc/include/asm/eeh.h
>>>+++ b/arch/powerpc/include/asm/eeh.h
>>>@@ -124,6 +124,7 @@ static inline bool eeh_pe_passed(struct eeh_pe *pe)
>>> #define EEH_DEV_NO_HANDLER	(1 << 8)	/* No error handler	*/
>>> #define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
>>> #define EEH_DEV_REMOVED		(1 << 10)	/* Removed permanently	*/
>>>+#define EEH_DEV_VF		(1 << 11)	/* VF port		*/
>>>
>>
>>Why you need this flag? I guess "edev->physfn" can be used to distinguish
>>it's a normal or VF eeh_dev.
>>
>
>Just like we have EEH_DEV_BRIDGE and EEH_DEV_DS_PORT, I use the flag
>EEH_DEV_VF to mark it a VF eeh_dev.
>
>

They're not equal from my point of review. When the VF edev is created
from VF's pdn, edev->physfn is determined. Furthermore, edev->physfn
is only meaningful to VF's edev. It's why I think you needn't introduce
another one flag (EEH_DEV_VF), which is just duplicated to (edev->physfn).
So I think you can use following condition to check if one edev is created
from VF's pdn or others:

	if (edev->physfn)
		/* VF's edev */
	else
		/* All other cases */

In order to use the above condition, edev->phyfn is initialized to dereference
the VF's physical function when it's created from VF's pdn in arch/powerpc/kernel/pdn.c.

Thanks,
Gavin
