Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D7DC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D4921773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwxIdAS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D4921773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q72h2rnfzDqTq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:43:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="YwxIdAS6"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q6xD0tZbzDqVf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:38:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8hZM1Gyf4fDZiJSnpLr+9CpjRwzMyoCa/eWpJcbkvns=; b=YwxIdAS6731khu9kCiWmVeXp9
 YMEoAWYnT+jclFuTNRz2pTKEKNlbkri73h+mWY8XpclIyfYlVjg2Qczu6BnTrU4Ku4ZyKRadtG6oz
 wJ5G3t1gg1/wu6HAnGvXogj8xkFRkXVZtv+veGxkJ4sTcOYGfIPl/CYCBs3cxEdfuuSN29W9Tql1C
 zKu+4GeIwlaG9cmZbVQUExBdeAIwTRUf5hb92A4GjAuiGwVe46hE/dGt43LaABAX85fOwruFZUjHs
 vw/lvsiTZ7sM+e5N94GLmEnhMbaECyyeLF/aI7NAGOwGV7qKIl7P37glxB8eiseLwwwx3BTglF+ll
 XTmsYLzvg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1hJLqr-00018Z-F3; Wed, 24 Apr 2019 17:38:33 +0000
Date: Wed, 24 Apr 2019 10:38:33 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] mm: Fix modifying of page protection by
 insert_pfn_pmd()
Message-ID: <20190424173833.GE19031@bombadil.infradead.org>
References: <20190402115125.18803-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hzRj5yxVJ5-7AZgzzBxEL02xf2xwhDv-U9_osWFm9kiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hzRj5yxVJ5-7AZgzzBxEL02xf2xwhDv-U9_osWFm9kiA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Chandan Rajendra <chandan@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 10:13:15AM -0700, Dan Williams wrote:
> I think unaligned addresses have always been passed to
> vmf_insert_pfn_pmd(), but nothing cared until this patch. I *think*
> the only change needed is the following, thoughts?
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index ca0671d55aa6..82aee9a87efa 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1560,7 +1560,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
>                 }
> 
>                 trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
> -               result = vmf_insert_pfn_pmd(vma, vmf->address, vmf->pmd, pfn,
> +               result = vmf_insert_pfn_pmd(vma, pmd_addr, vmf->pmd, pfn,
>                                             write);

We also call vmf_insert_pfn_pmd() in dax_insert_pfn_mkwrite() -- does
that need to change too?
