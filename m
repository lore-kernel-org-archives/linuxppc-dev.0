Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B08C6786C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:37:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D552080F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 03:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="IKrBLO00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D552080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GGSb3tJGzDqk8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 14:37:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="IKrBLO00";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GG3Q3V36zDqPN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 14:18:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="IKrBLO00"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43GG3P6pKtz9s3q; Fri, 14 Dec 2018 14:18:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1544757521; bh=vR+DvB7UQ/mVud3XvxSic3T0TWBxPPciMdZWiM2UkoY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IKrBLO00SfsdXOKqd4BEz6chEETHNzSwgNerUp0bTIZ6MerOm55ejGY+XJ/UWjds5
 WKbcsLPvM6IqZkLGRzkNzKztQf0S/6tVsY3SVC0HGAFFiDcLjG9SuiMjmJYtGd24uN
 d9BBcyXEJGlq5G7dWdqKUbWsJNRF0r5XI7tCb9IhXk0AriK9iOhGv2LsRhDVj6jK7R
 E9Lerq5hZ0cAqFsN5Vqm05uTLtbs30Yg3rjXZaoL5fJAkdz5a5T/eMcsbOdkxBFdQE
 /nzunxK+sk3SoU9WzgYqKW9CpQXs1gBoAOHa5tBCPI34XzhEC967se+Wfs9sLWSN+x
 /JOTiy/qzZNGg==
Date: Fri, 14 Dec 2018 14:18:39 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v5 03/20] powerpc/vfio/iommu/kvm: Do not pin
 device memory
Message-ID: <20181214031839.GA25474@blackberry>
References: <20181213061734.16651-1-aik@ozlabs.ru>
 <20181213061734.16651-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213061734.16651-4-aik@ozlabs.ru>
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
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 13, 2018 at 05:17:17PM +1100, Alexey Kardashevskiy wrote:
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
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
