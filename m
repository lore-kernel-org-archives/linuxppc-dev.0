Return-Path: <SRS0+9585c4e39412ddbfd682+1236+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6795EDE029
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:40:06 +1100 (EST)
Date: Thu, 11 Jan 2007 19:40:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH/RFC 2.6.21 2/5] ehca: ehca_uverbs.c: "proper" use of mmap
Message-ID: <20070111194000.GE24623@infradead.org>
References: <200701112008.15841.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701112008.15841.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org,
	hch@infradead.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 08:08:15PM +0100, Hoang-Nam Nguyen wrote:
> +static void mm_open(struct vm_area_struct *vma)

This should be name ehca_vma_open, dito for mm_close/ehca_vma_close and
vm_ops/ehca_vm_ops.

> +	u32 *count = (u32*)vma->vm_private_data;

No need for the cast here (both in the open and close routine)

> +	for (ofs = 0; ofs < queue->queue_length; ofs += PAGE_SIZE) {
> +		u64 virt_addr = (u64)ipz_qeit_calc(queue, ofs);
> +		page = virt_to_page(virt_addr);
> +		rc = vm_insert_page(vma, start, page);
> +		if (unlikely(rc)) {
> +			ehca_gen_err("vm_insert_page() failed rc=%x", rc);
> +			return rc;
> +		}
> +		start +=  PAGE_SIZE;

Not required for now, but long term you really should rework your
whole queue abstraction to operate on an array of struct pages, that
makes things like this and various other bits in ipz_pt_fn.[ch] a lot
simpler.

>  int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  {

Can you split this monster routine into individual functions for
each type of mmap please?  With two helpers to get and verify the cq/qp
shared by the individual sub-variants, that would also help to get rid
of all those magic offsets.

Actually, this routine directly comes from ib_device.mmap - Roland,
can you shed some light on what's going on here?

Also after applying this patch I have a prototype and various callers
for ehca_mmap_nopage but no actual implementation.  Could it be that
there are some bits missing?
