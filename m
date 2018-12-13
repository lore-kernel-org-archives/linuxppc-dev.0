Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DC0C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 03:28:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A080720811
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 03:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="QS0y30Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A080720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FfJb1JwtzDqX2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 14:27:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="QS0y30Vj";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FfFq70P5zDqSN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 14:25:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="QS0y30Vj"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43FfFq2xxbz9s9G; Thu, 13 Dec 2018 14:25:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1544671535; bh=oSJNgUCmi5w/QyYKzqvpbDEts4HNxo9omJ345IOYsak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QS0y30VjQclEs40pYFL7lhgZFLXisiDK58jVqqAWypCyQ7q26MWbvL5YjkWXYKS5C
 /FTMMXoUEY8+2zLKTk9dfnYXfftpkF81b7D34rMWSGTUX421VmbL8krM3ZkVC7bQIp
 lBN+65NSbmbEfjQdEwiygSeH24M9ntPwzUiOmNpipiKNXvbO7LWKDnDD9oIF7ljRLa
 fbZ+2JkiCJuv22wYJ493zYgu0kQS//bcaCePvZJCmeNeXyYl4JbI7hz45brtxHRq8c
 O/9w5t8K8NxX23Jh2nz5bwZROifnNW4gqAcBRM4bJD0zw3w44RucV/cHHL6kZHLev6
 qBvKvQkiIGSAQ==
Date: Thu, 13 Dec 2018 14:25:32 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 03/19] powerpc/vfio/iommu/kvm: Do not pin
 device memory
Message-ID: <20181213032532.GA7078@blackberry>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123055304.25116-4-aik@ozlabs.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 23, 2018 at 04:52:48PM +1100, Alexey Kardashevskiy wrote:
> This new memory does not have page structs as it is not plugged to
> the host so gup() will fail anyway.
> 
> This adds 2 helpers:
> - mm_iommu_newdev() to preregister the "memory device" memory so
> the rest of API can still be used;
> - mm_iommu_is_devmem() to know if the physical address is one of thise
> new regions which we must avoid unpinning of.
> 
> This adds @mm to tce_page_is_contained() and iommu_tce_xchg() to test
> if the memory is device memory to avoid pfn_to_page().
> 
> This adds a check for device memory in mm_iommu_ua_mark_dirty_rm() which
> does delayed pages dirtying.

This mostly looks good, but I have one concern:

> -static bool tce_page_is_contained(struct page *page, unsigned page_shift)
> +static bool tce_page_is_contained(struct mm_struct *mm, unsigned long hpa,
> +		unsigned int page_shift)
>  {
> +	struct page *page;
> +
> +	if (mm_iommu_is_devmem(mm, hpa, page_shift))
> +		return true;
> +
> +	page = pfn_to_page(hpa >> PAGE_SHIFT);

Is it possible for userspace or a guest to cause us to get here with
hpa value that is bogus?  If so what does pfn_to_page do with that
pfn, and do we handle that correctly?

(I realize that if there is a problem here, it's a problem that
already exists in the code without this patch.)

Paul.
