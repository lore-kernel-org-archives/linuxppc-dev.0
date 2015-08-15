Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FDFB1A0037
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2015 09:29:26 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44EFC14012C
 for <linuxppc-dev@ozlabs.org>; Sun, 16 Aug 2015 09:29:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sun, 16 Aug 2015 09:29:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4D7CF2CE8052
 for <linuxppc-dev@ozlabs.org>; Sun, 16 Aug 2015 09:29:20 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7FNT5XA52363330
 for <linuxppc-dev@ozlabs.org>; Sun, 16 Aug 2015 09:29:14 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7FNSlVH008727
 for <linuxppc-dev@ozlabs.org>; Sun, 16 Aug 2015 09:28:47 +1000
Date: Sun, 16 Aug 2015 09:28:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 6/6] powerpc/powernv: allocate sparse PE# when using
 M64 BAR in Single PE mode
Message-ID: <20150815232822.GA6225@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150814010300.GC18334@gwshan> <55CF142A.5090208@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55CF142A.5090208@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 15, 2015 at 08:27:54PM +1000, Alexey Kardashevskiy wrote:
>On 08/14/2015 11:03 AM, Gavin Shan wrote:
>>On Thu, Aug 13, 2015 at 10:11:11PM +0800, Wei Yang wrote:
>>>When M64 BAR is set to Single PE mode, the PE# assigned to VF could be
>>>sparse.
>>>
>>>This patch restructures the patch to allocate sparse PE# for VFs when M64
>>>BAR is set to Single PE mode.
>>>
>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>---
>>>arch/powerpc/include/asm/pci-bridge.h     |    2 +-
>>>arch/powerpc/platforms/powernv/pci-ioda.c |   59 +++++++++++++++++++----------
>>>2 files changed, 41 insertions(+), 20 deletions(-)
>>>
>>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>>index 9d33ada..b026ef8 100644
>>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>>@@ -214,7 +214,7 @@ struct pci_dn {
>>>#ifdef CONFIG_PCI_IOV
>>>	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>>>	u16     num_vfs;		/* number of VFs enabled*/
>>>-	int     offset;			/* PE# for the first VF PE */
>>>+	int     pe_num_map[MAX_M64_BAR];/* PE# for the first VF PE or array */
>>
>>Same question as to "m64_map". pdn for non-PF doesn't need it.
>
>
>non-PF is VF, right?
>

3 types of devices: (A) PF (B) VF (C) All others. Here, I mean (C).

Thanks,
Gavin
