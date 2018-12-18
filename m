Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DE5C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 17:24:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D9F218A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 17:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SMIeIFMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D9F218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K4cs31qBzDqRF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 04:23:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="SMIeIFMj";
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
 header.b="SMIeIFMj"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K4Yr3BbMzDqR7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 04:21:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qaupg13V9meSheBqmpvIyKEMtuz3Sp76GWTjjBjiu28=; b=SMIeIFMjoEeZkZhBgA40xh4Ra
 2L9J0s/aqRfotYDU02lafxRA179Yeo1SRmcwK1qWFUZViMcXPNBWTRkEG5dPjyu3Tp4xtM68mOVWq
 Uiw3LwXBHT+JSG5+moaG7SAFjFInePjMfq33NXNLvK3g8rvNZ8U0G/WECdI9za31Os/tbUOYTmwvA
 wt0B8+DHDkojBdLtjdm5wzM/Wl84bA3twioBeWw5BMoSsGqUYU5vdV/pEbB6sr9ukSoWaawOaz2+4
 YfXNr+jktrT0uzzAHPz0SPmDcZoave2NGpK7MKcaeOkWF7cRk+dPX/NAs2sId/MUsnuyhvJYaaV6r
 YECxB83fA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gZJ3E-00030h-Du; Tue, 18 Dec 2018 17:21:00 +0000
Date: Tue, 18 Dec 2018 09:21:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH V3 3/5] arch/powerpc/mm: Nest MMU workaround for mprotect
 RW upgrade.
Message-ID: <20181218172100.GB22729@infradead.org>
References: <20181205030931.12037-1-aneesh.kumar@linux.ibm.com>
 <20181205030931.12037-4-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205030931.12037-4-aneesh.kumar@linux.ibm.com>
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
Cc: npiggin@gmail.com, linux-mm@kvack.org, paulus@samba.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 05, 2018 at 08:39:29AM +0530, Aneesh Kumar K.V wrote:
> +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
> +			     pte_t *ptep)
> +{
> +	unsigned long pte_val;
> +
> +	/*
> +	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
> +	 * possible. Also keep the pte_present true so that we don't take
> +	 * wrong fault.
> +	 */
> +	pte_val = pte_update(vma->vm_mm, addr, ptep, _PAGE_PRESENT, _PAGE_INVALID, 0);
> +
> +	return __pte(pte_val);
> +
> +}
> +EXPORT_SYMBOL(ptep_modify_prot_start);

As far as I can tell this is only called from mm/memory.c, mm/mprotect.c
and fs/proc/task_mmu.c, so there should be no need to export the
function.
