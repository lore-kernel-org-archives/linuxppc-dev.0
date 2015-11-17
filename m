Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62F171A0352
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:43:05 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 11:43:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2F472357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:43:01 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH1gsHt34275552
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:43:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH1gRib026816
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:42:28 +1100
Date: Tue, 17 Nov 2015 12:42:03 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 14/50] powerpc/powernv: M64 support on P7IOC
Message-ID: <20151117014203.GC31584@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D8A.2050505@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56498D8A.2050505@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2015 at 07:02:18PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>This enables M64 window on P7IOC, which has been enabled on PHB3.
>>Different from PHB3 where 16 M64 BARs are supported and each of
>>them can be owned by one particular PE# exclusively or divided
>>evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
>>of them are divided to 8 segments. So every P7IOC PHB supports
>>128 M64 segments in total. P7IOC has M64DT, which helps mapping
>>one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
>>M64DT, indicating that one M64 segment can only be pinned to the
>>fixed PE#. In order to have same code to support M64 on P7IOC and
>>PHB3, we just provide 128 M64 segments on every P7IOC PHB and each
>>of them is pinned to the fixed PE# by bypassing the function of
>>M64DT. In turn, we just need different phb->init_m64() for P7IOC
>>and PHB3 to support M64.
>
>I thought we decided (Ben suggested?) not to push P7IOC code now (or ever) as
>there is no user for it, has this changed?
>

Remember that the code is mixed for P7IOC/PHB3. It's not harmful to support
M64 window on P7IOC, which is much larger than M32.

>btw please put ioda1/ioda2/p7ioc/etc to the subject line to make it easier to
>see how much work is there about particular PHB type. You rename quite many
>functions and I generally want to ask you to group all renaming patches first
>but it would also make sense to keep them close to (for example)
>p7ioc-related patches so having more descriptive subject lines may help.
>Thanks.
>

As the code is mixed for P7IOC/PHB3, I'm not following the line (IODA1/IODA2/p7ioc/phb3)
in this patchset. Instead, the sequence of patchset is order related to: cod refactoring,
IO/M32/M64, DMA, PE allocation/releaseing.

Thanks,
Gavin
