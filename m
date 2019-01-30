Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27256C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 14:48:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F09D20882
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckNDq87I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F09D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qR7V1hGFzDqVv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 01:48:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ckNDq87I"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qR5h37rSzDqTG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 01:46:47 +1100 (AEDT)
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0218E218A3;
 Wed, 30 Jan 2019 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548859605;
 bh=zeRVrBr0oJAGowAGSlPVn+Ttm5DoqTDo+5G1ws4CBKc=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
 b=ckNDq87Iv8Rk1hTCOWdqkHElWM1K5BFOHA6DxNFPvg1xgOncHEkOWrUwCotmc3Ue0
 0XuXlCnjJp30U623HtB5gEuOfdXI5V1hi2o/TJKBHPmfHHFYAjxnaPR1unOxt+BLeX
 68qn7QUpFYPNxCs6kncKvuXK9JU6CQOa3Ysf3+Ao=
Date: Wed, 30 Jan 2019 14:46:44 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
Subject: Re: [RESEND PATCH v3] cxl: Wrap iterations over afu slices inside
 'afu_list_lock'
In-Reply-To: <20190129110618.13481-1-vaibhav@linux.ibm.com>
References: <20190129110618.13481-1-vaibhav@linux.ibm.com>
Message-Id: <20190130144645.0218E218A3@mail.kernel.org>
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
Cc: , Vaibhav Jain <vaibhav@linux.ibm.com>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: .

The bot has tested the following trees: v4.20.5, v4.19.18, v4.14.96, v4.9.153, v4.4.172, v3.18.133.

v4.20.5: Build OK!
v4.19.18: Build OK!
v4.14.96: Build OK!
v4.9.153: Failed to apply! Possible dependencies:
    bb81733de28c ("cxl: Fix error handling in _cxl_pci_associate_default_context()")

v4.4.172: Failed to apply! Possible dependencies:
    14baf4d9c739 ("cxl: Add guest-specific code")
    2b04cf310ba8 ("cxl: Rename some bare-metal specific functions")
    5be587b11101 ("cxl: Introduce implementation-specific API")
    73d55c3b59f7 ("cxl: IRQ allocation for guests")
    8633186209e3 ("cxl: Move common code away from bare-metal-specific files")
    cbffa3a5146a ("cxl: Separate bare-metal fields in adapter and AFU data structures")
    d56d301b5174 ("cxl: Move bare-metal specific code to specialized files")
    ea2d1f95efd7 ("cxl: Isolate a few bare-metal-specific calls")

v3.18.133: Failed to apply! Possible dependencies:
    0520336afe5d ("cxl: Export file ops for use by API")
    0b3f9c757cab ("cxl: Drop commands if the PCI channel is not in normal state")
    14baf4d9c739 ("cxl: Add guest-specific code")
    27d4dc7116ee ("cxl: Implement an ioctl to fetch afu card-id, offset-id and mode")
    3d6b040e7338 ("cxl: sparse: Make declarations static")
    406e12ec0b64 ("cxl: Cleanup Makefile")
    456295e284be ("cxl: Fix leaking interrupts if attach process fails")
    588b34be20bc ("cxl: Convert MMIO read/write macros to inline functions")
    5be587b11101 ("cxl: Introduce implementation-specific API")
    62fa19d4b4fd ("cxl: Add ability to reset the card")
    6428832a7bfa ("cxl: Add cookie parameter to afu_release_irqs()")
    6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
    73d55c3b59f7 ("cxl: IRQ allocation for guests")
    7bb5d91a4dda ("cxl: Rework context lifetimes")
    80c394fab896 ("cxl: Add explicit precision specifiers")
    80fa93fce37d ("cxl: Name interrupts in /proc/interrupt")
    8dde152ea348 ("cxl: fix leak of IRQ names in cxl_free_afu_irqs()")
    95bc11bcd142 ("cxl: Add image control to sysfs")
    9bcf28cdb28e ("cxl: Add tracepoints")
    b087e6190ddc ("cxl: Export optional AFU configuration record in sysfs")
    b12994fbfe93 ("cxl: cxl_afu_reset() -> __cxl_afu_reset()")
    bc78b05bb412 ("cxl: Return error to PSL if IRQ demultiplexing fails & print clearer warning")
    c358d84b4e57 ("cxl: Split afu_register_irqs() function")
    cbffa3a5146a ("cxl: Separate bare-metal fields in adapter and AFU data structures")
    de369538436a ("cxl: use more common format specifier")
    e36f6fe1f7aa ("cxl: Export AFU error buffer via sysfs")
    ea2d1f95efd7 ("cxl: Isolate a few bare-metal-specific calls")
    eda3693c842e ("cxl: Rework detach context functions")


How should we proceed with this patch?

--
Thanks,
Sasha
