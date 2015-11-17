Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FFAB1A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:14:50 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 11:14:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AE5452CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:14:45 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH1ELWD25624720
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:14:29 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH1ECKg000887
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:14:13 +1100
Date: Tue, 17 Nov 2015 11:54:59 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
 robherring2@gmail.com, panto@antoniou-consulting.com,
 frowand.list@gmail.com
Subject: Re: [PATCH v7 10/50] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
Message-ID: <20151117005459.GA24472@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-11-git-send-email-gwshan@linux.vnet.ibm.com>
 <87r3k4hx89.fsf@gamma.ozlabs.ibm.com>
 <20151105235218.GC30465@gwshan> <56498D4E.7010009@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56498D4E.7010009@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2015 at 07:01:18PM +1100, Alexey Kardashevskiy wrote:
>On 11/06/2015 10:52 AM, Gavin Shan wrote:
>>On Fri, Nov 06, 2015 at 09:56:06AM +1100, Daniel Axtens wrote:
>>>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>>>
>>>>The original implementation of pnv_ioda_setup_pe_seg() configures
>>>>IO and M32 segments by separate logics, which can be merged by
>>>>by caching @segmap, @seg_size, @win in advance. This shouldn't
>>>>cause any behavioural changes.
>>>>
>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>---
>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 62 ++++++++++++++-----------------
>>>>  1 file changed, 28 insertions(+), 34 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>index 7ee7cfe..553d3f3 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>@@ -2752,8 +2752,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>>>  	struct pnv_phb *phb = hose->private_data;
>>>>  	struct pci_bus_region region;
>>>>  	struct resource *res;
>>>>-	int i, index;
>>>>-	int rc;
>>>>+	unsigned int segsize;
>>>>+	int *segmap, index, i;
>>>>+	uint16_t win;
>>>>+	int64_t rc;
>>>
>>>Good catch! Opal return codes are 64 bit and that should be explicit
>>>in the type. However, I seem to remember that we preferred a different
>>>type for 64 bit ints in the kernel. I think it's s64, and there are some
>>>other uses of that in pci_ioda.c for return codes.
>>>
>>
>>Both int64_t and s64 are fine. I used s64 for the OPAL return value, but
>>Alexey likes "int64_t", which is ok to me as well. I won't change it back
>>to s64 :-)
>>
>>>(I'm actually surprised that's not picked up as a compiler
>>>warning. Maybe that's something to look at in future.)
>>>
>>
>>Indeed, I didn't see a warning from gcc.
>>
>>>The rest of the patch looks good on casual inspection - to be sure I'll
>>>test the entire series on a machine. (hopefully, time permitting!)
>>>
>>
>>I run scripts/checkpatch.pl on the patchset. Only one warning came from
>>[PATCH 44/50], but I won't bother to change that as the warning was
>>brought by original code.
>
>None of these patches failed checkpatch.pl check, what was the error in 44/50?
>

You're right that none of those patches failed with checkpatch.pl. I had revison
6.1, 6.2, 6.3 before this revision (v7) was posted. There was a warning for 44/50
in 6.3 (perhaps).

I run checkpatch.pl on all (v7) patches, no warning reported.

Thanks,
Gavin
