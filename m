Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9713AC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 00:33:00 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A686220811
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 00:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A686220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Kt5P19StzDqnw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 11:32:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Kt302W6SzDqWQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 11:30:52 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wBK0UCGh022847;
 Wed, 19 Dec 2018 18:30:13 -0600
Message-ID: <493d07674c58d9ab32b8ba60c7153c323dfe9ab7.camel@kernel.crashing.org>
Subject: Re: [PATCH V4 5/5] arch/powerpc/mm/hugetlb: NestMMU workaround for
 hugetlb mprotect RW upgrade
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christoph Hellwig
 <hch@infradead.org>
Date: Thu, 20 Dec 2018 11:30:12 +1100
In-Reply-To: <87r2eefbhi.fsf@linux.ibm.com>
References: <20181218094137.13732-1-aneesh.kumar@linux.ibm.com>
 <20181218094137.13732-6-aneesh.kumar@linux.ibm.com>
 <20181218172236.GC22729@infradead.org> <87r2eefbhi.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
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
Cc: x86@kernel.org, npiggin@gmail.com, linux-mm@kvack.org, paulus@samba.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-12-19 at 08:50 +0530, Aneesh Kumar K.V wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Tue, Dec 18, 2018 at 03:11:37PM +0530, Aneesh Kumar K.V wrote:
> > > +EXPORT_SYMBOL(huge_ptep_modify_prot_start);
> > 
> > The only user of this function is the one you added in the last patch
> > in mm/hugetlb.c, so there is no need to export this function.
> > 
> > > +
> > > +void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> > > +				  pte_t *ptep, pte_t old_pte, pte_t pte)
> > > +{
> > > +
> > > +	if (radix_enabled())
> > > +		return radix__huge_ptep_modify_prot_commit(vma, addr, ptep,
> > > +							   old_pte, pte);
> > > +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> > > +}
> > > +EXPORT_SYMBOL(huge_ptep_modify_prot_commit);
> > 
> > Same here.
> 
> That was done considering that ptep_modify_prot_start/commit was defined
> in asm-generic/pgtable.h. I was trying to make sure I didn't break
> anything with the patch. Also s390 do have that EXPORT_SYMBOL() for the
> same. hugetlb just inherited that.
> 
> If you feel strongly about it, I can drop the EXPORT_SYMBOL().

At the very least it should be _GPL

Cheers,
Ben.

