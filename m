Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E3DC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 07:14:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A44020815
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 07:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gndvChQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A44020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L30956przDqw3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 18:14:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="gndvChQ2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+4320e4c38c4ab4f6f328+5597+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L2xR2LJpzDqvg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 18:11:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HnSw96zEybu9OzsLQGZyJGvp2aRESEy0ZaY1Y7/pqPk=; b=gndvChQ2lSvsic5typ83ymnV/
 fg/FCOpvOq8vNIikgPwB2OR3+po6F7SHxs0W6rlrPkm+tbN6YMhZZw4bumFh7GmLjcW07d9q+VH8U
 01K8E9+DeJbpdsCGwVmC2q0GMuXUhGv0wMAeCCROOKQhl4OjocSSrif1E/m2V4ivxo2lEOT6OnMGI
 VKZLc/9oOeXH+Wp/zFYmQqtZQ0QajF2pbyrkZM81gW3xJNkoez/+t6eMNS6zZLiQf2egAMPYwtBdi
 fUnp0ahnaenwBGueFfolDwPlMdW4Ln/9BCB0fhzWqK7yEPaQdi9GDILBomoMdSuUyqsa4gSnK93cS
 Vjw6293LA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gZsUK-0004Qt-23; Thu, 20 Dec 2018 07:11:20 +0000
Date: Wed, 19 Dec 2018 23:11:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V4 5/5] arch/powerpc/mm/hugetlb: NestMMU workaround for
 hugetlb mprotect RW upgrade
Message-ID: <20181220071119.GA16944@infradead.org>
References: <20181218094137.13732-1-aneesh.kumar@linux.ibm.com>
 <20181218094137.13732-6-aneesh.kumar@linux.ibm.com>
 <20181218172236.GC22729@infradead.org>
 <87r2eefbhi.fsf@linux.ibm.com>
 <493d07674c58d9ab32b8ba60c7153c323dfe9ab7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493d07674c58d9ab32b8ba60c7153c323dfe9ab7.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
 npiggin@gmail.com, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 paulus@samba.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 20, 2018 at 11:30:12AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2018-12-19 at 08:50 +0530, Aneesh Kumar K.V wrote:
> > Christoph Hellwig <hch@infradead.org> writes:
> > 
> > > On Tue, Dec 18, 2018 at 03:11:37PM +0530, Aneesh Kumar K.V wrote:
> > > > +EXPORT_SYMBOL(huge_ptep_modify_prot_start);
> > > 
> > > The only user of this function is the one you added in the last patch
> > > in mm/hugetlb.c, so there is no need to export this function.
> > > 
> > > > +
> > > > +void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> > > > +				  pte_t *ptep, pte_t old_pte, pte_t pte)
> > > > +{
> > > > +
> > > > +	if (radix_enabled())
> > > > +		return radix__huge_ptep_modify_prot_commit(vma, addr, ptep,
> > > > +							   old_pte, pte);
> > > > +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> > > > +}
> > > > +EXPORT_SYMBOL(huge_ptep_modify_prot_commit);
> > > 
> > > Same here.
> > 
> > That was done considering that ptep_modify_prot_start/commit was defined
> > in asm-generic/pgtable.h. I was trying to make sure I didn't break
> > anything with the patch. Also s390 do have that EXPORT_SYMBOL() for the
> > same. hugetlb just inherited that.
> > 
> > If you feel strongly about it, I can drop the EXPORT_SYMBOL().
> 
> At the very least it should be _GPL

In general yes, but in this case it just needs to go.  The s390
maintainers already removed a patch to remove their
ptep_modify_prot_start / ptep_modify_prot_commit exports.
