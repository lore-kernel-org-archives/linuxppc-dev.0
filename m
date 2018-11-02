Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E1C32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 10:20:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A872081B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 10:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A872081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mdPh3lgHzF369
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 21:20:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mdMY4469zF342
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 21:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42mdMX5smPzB4VP;
 Fri,  2 Nov 2018 21:18:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/powernv: remove dead npu-dma code
In-Reply-To: <2c87f9d2-3beb-6c7e-71a4-db8a905f57b1@ozlabs.ru>
References: <20181030133122.GA31102@lst.de>
 <2c87f9d2-3beb-6c7e-71a4-db8a905f57b1@ozlabs.ru>
Date: Fri, 02 Nov 2018 21:18:48 +1100
Message-ID: <877ehveq9j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: James Bottomley <jejb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> On 31/10/2018 00:31, Christoph Hellwig wrote:
>> This code has never been unused in the kernel since it was merged, and
>> there has been no attempt that I could find to even submit users for
>> it.  Besides the general policy of not keep 1000+ lines of dead
>> code, it helps cleaning up the DMA code and making powerpc user common
>> infrastructure.
>> 
>> This effectively reverts commit 5d2aa710 ("powerpc/powernv: Add support
>> for Nvlink NPUs").
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
...
>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
>> deleted file mode 100644
>> index 6f60e0931922..000000000000
>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
>> +++ /dev/null
>> @@ -1,989 +0,0 @@
...
>> -int pnv_npu2_init(struct pnv_phb *phb)
>> -{
>> -	unsigned int i;
>> -	u64 mmio_atsd;
>> -	struct device_node *dn;
>> -	struct pci_dev *gpdev;
>> -	static int npu_index;
>> -	uint64_t rc = 0;
>> -
>> -	phb->npu.nmmu_flush =
>> -		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
>> -	for_each_child_of_node(phb->hose->dn, dn) {
>> -		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
>> -		if (gpdev) {
>> -			rc = opal_npu_map_lpar(phb->opal_id,
>> -				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
>> -				0, 0);
>
> I heavily hacked on these (draft):
> https://patchwork.ozlabs.org/project/kvm-ppc/list/?series=70791
>
> and the result is going to be used for VFIO purposes (draft too):
> https://patchwork.ozlabs.org/project/kvm-ppc/list/?series=70793
>
> Other bits can go away from npu-dma but I still need some to make
> KVM+VFIO work for GPUs, this is without any vendor driver on the host
> side whatsoever.

OK, so to be clear we will need at least some of this code so that a KVM
host can pass through a GPU to a guest, and that requires no binary
driver on the host.

I don't think anyone's arguing that we should prevent passing through
devices that might need a binary driver in a guest?

Christoph I think that establishes that this is not all dead code, and
so I'm nacking this patch in its current form. If you have other
objections to this code please raise them specifically.

I'll merge Alistair's patch to remove the NPU dma_ops, because they're
not really necessary and might legitimately be getting in the way of
dma_ops cleanups.

  https://patchwork.ozlabs.org/patch/990721/


cheers
