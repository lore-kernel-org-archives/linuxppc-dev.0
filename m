Return-Path: <SRS0=Xl/Y=I3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF2CC433C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 13:41:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFFF61554
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 13:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFFF61554
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8DHj3W3Qz30L9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 00:41:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8DHM4nwcz2yxc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 00:40:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F8DHC1pQJz9sVS; Tue, 30 Mar 2021 00:40:39 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <20210326070755.304625-1-aneesh.kumar@linux.ibm.com>
References: <20210326070755.304625-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mm/book3s64: Use the correct storage key value
 when calling H_PROTECT
Message-Id: <161702520473.3080836.1729450250731388537.b4-ty@ellerman.id.au>
Date: Tue, 30 Mar 2021 00:40:04 +1100
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
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 26 Mar 2021 12:37:55 +0530, Aneesh Kumar K.V wrote:
> H_PROTECT expect the flag value to include
> flags: AVPN, pp0, pp1, pp2, key0-key4, Noexec, CMO Option flags
> 
> This patch updates hpte_updatepp() to fetch the storage key value from the linux page
> table and use the same in H_PROTECT hcall.
> 
> native_hpte_updatepp() is not updated because the kernel doesn't clear the existing
> storage key value there. The kernel also doesn't use hpte_updatepp() callback for
> updating storage keys.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mm/book3s64: Use the correct storage key value when calling H_PROTECT
      https://git.kernel.org/powerpc/c/53f1d31708f6240e4615b0927df31f182e389e2f

cheers
