Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D06C76195
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 14:39:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B5C21852
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 14:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B5C21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nR4R58PgzDqBN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 00:39:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nQtg16xXzDqXS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 00:30:47 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C945368B05; Mon, 15 Jul 2019 16:30:39 +0200 (CEST)
Date: Mon, 15 Jul 2019 16:30:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
Message-ID: <20190715143039.GA6892@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
 <20190712053631.9814-4-bauerman@linux.ibm.com>
 <20190712150912.3097215e.pasic@linux.ibm.com>
 <87tvbqgboc.fsf@morokweng.localdomain>
 <20190715160317.7e3dfb33.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715160317.7e3dfb33.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-s390@vger.kernel.org, Mike Anderson <andmike@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Lendacky,
 Thomas" <thomas.lendacky@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 15, 2019 at 04:03:17PM +0200, Halil Pasic wrote:
> > I thought about that but couldn't put my finger on a general concept.
> > Is it "guest with memory inaccessible to the host"?
> > 
> 
> Well, force_dma_unencrypted() is a much better name thatn sev_active():
> s390 has no AMD SEV, that is sure, but for virtio to work we do need to
> make our dma accessible to the hypervisor. Yes, your "guest with memory
> inaccessible to the host" shows into the right direction IMHO.
> Unfortunately I don't have too many cycles to spend on this right now.

In x86 it means that we need to remove dma encryption using
set_memory_decrypted before using it for DMA purposes.  In the SEV
case that seems to be so that the hypervisor can access it, in the SME
case that Tom just fixes it is because there is an encrypted bit set
in the physical address, and if the device doesn't support a large
enough DMA address the direct mapping code has to encrypt the pages
used for the contigous allocation.

> Being on cc for your patch made me realize that things got broken on
> s390. Thanks! I've sent out a patch that fixes protvirt, but we are going
> to benefit from your cleanups. I think with your cleanups and that patch
> of mine both sev_active() and sme_active() can be removed. Feel free to
> do so. If not, I can attend to it as well.

Yes, I think with the dma-mapping fix and this series sme_active and
sev_active should be gone from common code.  We should also be able
to remove the exports x86 has for them.

I'll wait a few days and will then feed the dma-mapping fix to Linus,
it might make sense to either rebase Thiagos series on top of the
dma-mapping for-next branch, or wait a few days before reposting.
