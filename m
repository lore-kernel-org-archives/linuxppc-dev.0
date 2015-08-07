Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F1F51A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 15:45:47 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 31DFE140216
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 15:45:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 7 Aug 2015 15:45:44 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7F8F23578058
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 15:45:23 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t775jFgU59572280
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 15:45:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t775ioTi023552
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Aug 2015 15:44:51 +1000
Date: Fri, 7 Aug 2015 13:44:33 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 6/6] powerpc/powernv: allocate discrete PE# when using
 M64 BAR in Single PE mode
Message-ID: <20150807054433.GA7971@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806053601.GB5636@gwshan> <20150806134141.GA6235@richard>
 <20150807013656.GB20794@gwshan> <20150807023333.GH8292@richard>
 <20150807034301.GA8624@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150807034301.GA8624@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2015 at 01:43:01PM +1000, Gavin Shan wrote:
>On Fri, Aug 07, 2015 at 10:33:33AM +0800, Wei Yang wrote:
>>On Fri, Aug 07, 2015 at 11:36:56AM +1000, Gavin Shan wrote:
>>>On Thu, Aug 06, 2015 at 09:41:41PM +0800, Wei Yang wrote:
>>>>On Thu, Aug 06, 2015 at 03:36:01PM +1000, Gavin Shan wrote:
>>>>>On Wed, Aug 05, 2015 at 09:25:03AM +0800, Wei Yang wrote:
>>>>>>When M64 BAR is set to Single PE mode, the PE# assigned to VF could be
>>>>>>discrete.
>>>>>>
>>>>>>This patch restructures the patch to allocate discrete PE# for VFs when M64
>>>>>>BAR is set to Single PE mode.
>>>>>>
>>>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>>>---
>>>>>> arch/powerpc/include/asm/pci-bridge.h     |    2 +-
>>>>>> arch/powerpc/platforms/powernv/pci-ioda.c |   69 +++++++++++++++++++++--------
>>>>>> 2 files changed, 51 insertions(+), 20 deletions(-)
>>>>>>
>>>>>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>>>>>index 8aeba4c..72415c7 100644
>>>>>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>>>>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>>>>>@@ -213,7 +213,7 @@ struct pci_dn {
>>>>>> #ifdef CONFIG_PCI_IOV
>>>>>> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>>>>>> 	u16     num_vfs;		/* number of VFs enabled*/
>>>>>>-	int     offset;			/* PE# for the first VF PE */
>>>>>>+	int     *offset;		/* PE# for the first VF PE or array */
>>>>>> 	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>>>>>> #define IODA_INVALID_M64        (-1)
>>>>>> 	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
>>>>>
>>>>>how about renaming "offset" to "pe_num_map", or "pe_map" ? Similar to the comments
>>>>>I gave to the "m64_bar_map", num_of_max_vfs entries can be allocated. Though not
>>>>>all of them will be used, not too much memory will be wasted.
>>>>>
>>>>
>>>>Thanks for your comment.
>>>>
>>>>I have thought about change the name to make it more self explain. While
>>>>another fact I want to take in is this field is also used to be reflect the
>>>>shift offset when M64 BAR is used in the Shared Mode. So I maintain the name.
>>>>
>>>>How about use "enum", one maintain the name "offset", and another one rename to
>>>>"pe_num_map". And use the meaningful name at proper place?
>>>>
>>
>>So I suppose you agree with my naming proposal.
>>
>
>No, I dislike the "enum" things.
>

OK, then you suggest to rename it pe_num_map or keep it as offset?

>>>
>>>Ok. I'm explaining it with more details. There are two cases: single vs shared
>>>mode. When PHB M64 BARs run in single mode, you need an array to track the
>>>allocated discrete PE#. The VF_index is the index to the array. When PHB M64
>>>BARs run in shared mode, you need continuous PE#. No array required for this
>>>case. Instead, the starting PE# should be stored to somewhere, which can
>>>be pdn->offset[0] simply.
>>>
>>>So when allocating memory for this array, you just simply allocate (sizeof(*pdn->offset)
>>>*max_vf_num) no matter what mode PHB's M64 BARs will run in. The point is nobody
>>>can enable (max_vf_num + 1) VFs.
>>
>>The max_vf_num is 15?
>>
>
>I don't understand why you said: the max_vf_num is 15. Since max_vf_num is variable
>on different PFs, how can it be fixed value - 15 ?
>

In Shared PE case, only one int to indicate the start PE# is fine.
In Single PE mode, we totally could enable 15 VF, the same number of PEs for
each VF, which is limited by the number M64 BARs we have in the system.

If not, the number you expected is total_vfs?

>>>
>>>With above way, the arrays for PE# and M64 BAR remapping needn't be allocated
>>>when enabling SRIOV capability and releasing on disabling SRIOV capability.
>>>Instead, those two arrays can be allocated during resource fixup time and free'ed
>>>when destroying the pdn.
>>>
>>
>>My same point of view like previous, if the memory is not in the concern, how
>>about define them static?
>>
>
>It's a bad idea from my review. How many entries this array is going to have?
>256 * NUM_OF_MAX_VF_BARS ?
>

No.

It has 15 * 6, 15 VFs we could enable at most and 6 VF BARs a VF could have at
most.

>>And for the long term, we may support more VFs. Then at that moment, we need
>>to restructure the code to meet it.
>>
>>So I suggest if we want to allocate it dynamically, we allocate the exact
>>number of space.
>>
>
>Fine... it can be improved when it has to be, as you said.
>

-- 
Richard Yang
Help you, Help me
