Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB27C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:09:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C5E610A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C5E610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNtcT36NHz3fZQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:09:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtVm5sMnz3cTZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:32 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4FNtVc3l2Xz9vGd; Mon, 19 Apr 2021 14:04:24 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVb50Htz9vGW; Mon, 19 Apr 2021 14:04:23 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Mahesh Salgaonkar <mahesh@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <161821396263.48361.2796709239866588652.stgit@jupiter>
References: <161821396263.48361.2796709239866588652.stgit@jupiter>
Subject: Re: [PATCH v2] powerpc/eeh: Fix EEH handling for hugepages in ioremap
 space.
Message-Id: <161880479477.1398509.366681090347824239.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 13:59:54 +1000
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 12 Apr 2021 13:22:50 +0530, Mahesh Salgaonkar wrote:
> During the EEH MMIO error checking, the current implementation fails to map
> the (virtual) MMIO address back to the pci device on radix with hugepage
> mappings for I/O. This results into failure to dispatch EEH event with no
> recovery even when EEH capability has been enabled on the device.
> 
> eeh_check_failure(token)		# token = virtual MMIO address
>   addr = eeh_token_to_phys(token);
>   edev = eeh_addr_cache_get_dev(addr);
>   if (!edev)
> 	return 0;
>   eeh_dev_check_failure(edev);	<= Dispatch the EEH event
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/eeh: Fix EEH handling for hugepages in ioremap space.
      https://git.kernel.org/powerpc/c/5ae5bc12d0728db60a0aa9b62160ffc038875f1a

cheers
