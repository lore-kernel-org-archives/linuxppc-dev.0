Return-Path: <SRS0=Z3yz=JH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3341C433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:35:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209A46115B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209A46115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHcwj5pxSz3fVB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 00:35:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHcpG1xfwz3btr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 00:29:42 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FHcpF53B9z9sXH; Sun, 11 Apr 2021 00:29:41 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20210404192623.10697-1-rdunlap@infradead.org>
References: <20210404192623.10697-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] powerpc: iommu: fix build when neither PCI or IBMVIO
 is set
Message-Id: <161806493809.1467223.11225410842334545249.b4-ty@ellerman.id.au>
Date: Sun, 11 Apr 2021 00:28:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
 Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 4 Apr 2021 12:26:23 -0700, Randy Dunlap wrote:
> When neither CONFIG_PCI nor CONFIG_IBMVIO is set/enabled, iommu.c has a
> build error. The fault injection code is not useful in that kernel config,
> so make the FAIL_IOMMU option depend on PCI || IBMVIO.
> 
> Prevents this build error (warning escalated to error):
> ../arch/powerpc/kernel/iommu.c:178:30: error: 'fail_iommu_bus_notifier' defined but not used [-Werror=unused-variable]
>   178 | static struct notifier_block fail_iommu_bus_notifier = {

Applied to powerpc/next.

[1/1] powerpc: iommu: fix build when neither PCI or IBMVIO is set
      https://git.kernel.org/powerpc/c/b27dadecdf9102838331b9a0b41ffc1cfe288154

cheers
