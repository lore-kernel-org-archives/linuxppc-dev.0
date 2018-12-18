Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D66C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 17:26:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B95C218A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 17:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IMyfT08M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B95C218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K4hG2t6zzDqWY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 04:26:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="IMyfT08M";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+d491747419b3b25c4164+5595+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="IMyfT08M"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K4bp5gkXzDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 04:23:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3WicD3bSF1JRmpgErM6MUgZ0HmF33s4RIhrKjXHVWqA=; b=IMyfT08MJOKMJeoLxOBTI3qcq
 xeUSSiDcnNlijrmZMe9bqafx1nBS3xMupeQP3ey3WwJ6/2ZgrEikNIKG/DbeZTHEF/gwnp7kOZrcU
 hS1NGQgeWt/fVFRhZT+iRL4qTkPVRv0+Chue44tTMscz99WLqMbuPXViFkAaX34l0uhLnPZXrDFER
 9DafpHzFsPkynyPSSZCbx9FmPW9lLSWwHsKfMifTCr3ZuVq4sgRlYTE1rMb99whn7Gzee5Mh3SqB2
 ikAOp0dBIPfE8udHANduucjCK3DvkGGeNHHJh1s9ZNreaH6/lO+rkOhQBv4H3ongQFqK+0RQbQ+26
 ex61vnZNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gZJ4m-0003Ks-N5; Tue, 18 Dec 2018 17:22:36 +0000
Date: Tue, 18 Dec 2018 09:22:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH V4 5/5] arch/powerpc/mm/hugetlb: NestMMU workaround for
 hugetlb mprotect RW upgrade
Message-ID: <20181218172236.GC22729@infradead.org>
References: <20181218094137.13732-1-aneesh.kumar@linux.ibm.com>
 <20181218094137.13732-6-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218094137.13732-6-aneesh.kumar@linux.ibm.com>
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
Cc: x86@kernel.org, npiggin@gmail.com, linux-mm@kvack.org, paulus@samba.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 18, 2018 at 03:11:37PM +0530, Aneesh Kumar K.V wrote:
> +EXPORT_SYMBOL(huge_ptep_modify_prot_start);

The only user of this function is the one you added in the last patch
in mm/hugetlb.c, so there is no need to export this function.

> +
> +void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> +				  pte_t *ptep, pte_t old_pte, pte_t pte)
> +{
> +
> +	if (radix_enabled())
> +		return radix__huge_ptep_modify_prot_commit(vma, addr, ptep,
> +							   old_pte, pte);
> +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +}
> +EXPORT_SYMBOL(huge_ptep_modify_prot_commit);

Same here.
