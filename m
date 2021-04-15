Return-Path: <SRS0=H68/=JM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F61C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Apr 2021 18:56:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2718C610F7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Apr 2021 18:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2718C610F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FLpTB3FXPz3bxW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Apr 2021 04:55:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HNXlP42L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux-foundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=korg header.b=HNXlP42L; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FLpSj6Y11z30Dr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Apr 2021 04:55:32 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B112961152;
 Thu, 15 Apr 2021 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1618512930;
 bh=tAQpTOBvkJ3hO9SBP+PvxFjqv3ZJBkP6NKwXUOWSDMQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HNXlP42LpU+p8j7cbvKDbs0kNEL4K3d+jo0sxGNF5GAA1tEMwmLmF9ldGris8qG6T
 UPNLhbgnVGH8C4oOOf+LYW9+B5hMrMsQr/AJg4HXVzgV2yRa7pJo7/rf7X9lVOg68+
 NIrZ+0NCp39XcGwwQZH1V2i2PGLStNBOuQwhRgRw=
Date: Thu, 15 Apr 2021 11:55:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v13 14/14] powerpc/64s/radix: Enable huge vmalloc mappings
Message-Id: <20210415115529.9703ba8e9f7a38dea39efa56@linux-foundation.org>
In-Reply-To: <a5c57276-737d-930b-670c-58dc0c815501@csgroup.eu>
References: <20210317062402.533919-1-npiggin@gmail.com>
 <20210317062402.533919-15-npiggin@gmail.com>
 <a5c57276-737d-930b-670c-58dc0c815501@csgroup.eu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Ding Tianhong <dingtianhong@huawei.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 15 Apr 2021 12:23:55 +0200 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> > +	 * is done. STRICT_MODULE_RWX may require extra work to support this
> > +	 * too.
> > +	 */
> >   
> > -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP_KERNEL,
> > -				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> 
> 
> I think you should add the following in <asm/pgtable.h>
> 
> #ifndef MODULES_VADDR
> #define MODULES_VADDR VMALLOC_START
> #define MODULES_END VMALLOC_END
> #endif
> 
> And leave module_alloc() as is (just removing the enclosing #ifdef MODULES_VADDR and adding the 
> VM_NO_HUGE_VMAP  flag)
> 
> This would minimise the conflits with the changes I did in powerpc/next reported by Stephen R.
> 

I'll drop powerpc-64s-radix-enable-huge-vmalloc-mappings.patch for now,
make life simpler.

Nick, a redo on top of Christophe's changes in linux-next would be best
please.

