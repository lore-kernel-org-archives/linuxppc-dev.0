Return-Path: <SRS0=ynH/=IA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327FC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 11:09:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8879F64F04
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 11:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8879F64F04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DqZC34HDlz3d3X
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 22:09:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=GUZczDfr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=GUZczDfr; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DqZBd2d8xz3cGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Mar 2021 22:08:56 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DqZBX4cbBz9sWC;
 Tue,  2 Mar 2021 22:08:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1614683333;
 bh=E5E320AMUXuU79/x2LXrgb3lWNabFwBhGvYvTjQ9Vvs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GUZczDfrzu40onQa5Kh4fAmQ13WUIlUDpG5ZzfqlGn7006acZH7GjLNrNhUJvviNA
 5O2ff3izXVqXVOC0CEwFG9eQSRN7/Y/Ctmp9VJpuQzLFPGQK9QcQYBLn59yt7lshgP
 Q+ULkGMa7JqvXSQAY/2u0p/XJUCauuC9svJFSiZoP2hVrpHzEQlUbUSXksd1gzJHP6
 QzeOadAnZbsNoKDH/15TDMGR48xwbMNxmSsJ27NzIvluCnav7ECB264ezK6qZ5V3mI
 P28XH8Tgj7MW+Jc1k7X12bSVxO7EAa0jmGNgEXH133q2wbpbYDrMSVGvSqbBc6DoAH
 LDFMnWhf09SrQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: iommu: fix build when neither PCI or IBMVIO is
 set
In-Reply-To: <20210302082811.8671-1-rdunlap@infradead.org>
References: <20210302082811.8671-1-rdunlap@infradead.org>
Date: Tue, 02 Mar 2021 22:08:43 +1100
Message-ID: <87lfb5sthg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 kernel test robot <lkp@intel.com>, Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Randy Dunlap <rdunlap@infradead.org> writes:
> When neither CONFIG_PCI nor CONFIG_IBMVIO is enabled:
>
> ../arch/powerpc/kernel/iommu.c:178:30: error: 'fail_iommu_bus_notifier' defined but not used [-Werror=unused-variable]
>   178 | static struct notifier_block fail_iommu_bus_notifier = {
>
> If only that struct is bounded by 2 #if defined() phrases (PCI && IBMVIO):
>
> ../arch/powerpc/kernel/iommu.c:162:12: error: 'fail_iommu_bus_notify' defined but not used [-Werror=unused-function]
>   162 | static int fail_iommu_bus_notify(struct notifier_block *nb,
>
> If that function is also guarded by 2 #if defined() phrases:
>
> In file included from ../include/linux/dma-mapping.h:7,
>                  from ../arch/powerpc/kernel/iommu.c:19:
> ../include/linux/device.h:131:26: error: 'dev_attr_fail_iommu' defined but not used [-Werror=unused-variable]
>   131 |  struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
> ../arch/powerpc/kernel/iommu.c:160:8: note: in expansion of macro 'DEVICE_ATTR_RW'
>   160 | static DEVICE_ATTR_RW(fail_iommu);
>
> and the snowball continues to grow.
> Next I got this one:
>
> ../arch/powerpc/kernel/iommu.c: In function 'iommu_range_alloc':
> ../arch/powerpc/kernel/iommu.c:234:6: error: implicit declaration of function 'should_fail_iommu'; did you mean 'should_failslab'? [-Werror=implicit-function-declaration]
>   234 |  if (should_fail_iommu(dev))
>
> and
>
> ../arch/powerpc/kernel/iommu.c: In function 'should_fail_iommu':
> ../arch/powerpc/kernel/iommu.c:122:50: error: 'fail_iommu' undeclared (first use in this function)
>   122 |  return dev->archdata.fail_iommu && should_fail(&fail_iommu, 1);
>
> So combine CONFIG_FAIL_IOMMU && (CONFIG_PCI || CONFIG_IBMVIO)
> to decide on building some of this code/data.

Couldn't we just make FAIL_IOMMU depend on PCI || IBMVIO?

cheers
