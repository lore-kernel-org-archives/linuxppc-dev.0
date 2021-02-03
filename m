Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF85C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:20:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B3764F95
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B3764F95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW13P3KwqzF1Qp
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 23:20:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4DW09R1NrjzDwpK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09Q0dY4z9tlM; Wed,  3 Feb 2021 22:40:17 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Cédric Le Goater <clg@kaod.org>
In-Reply-To: <20210122075029.797013-1-clg@kaod.org>
References: <20210122075029.797013-1-clg@kaod.org>
Subject: Re: [PATCH] powerpc/prom: Fix "ibm,arch-vec-5-platform-support" scan
Message-Id: <161235200758.1516112.11532779504057524553.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:17 +1100 (AEDT)
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
Cc: stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 22 Jan 2021 08:50:29 +0100, Cédric Le Goater wrote:
> The "ibm,arch-vec-5-platform-support" property is a list of pairs of
> bytes representing the options and values supported by the platform
> firmware. At boot time, Linux scans this list and activates the
> available features it recognizes : Radix and XIVE.
> 
> A recent change modified the number of entries to loop on and 8 bytes,
> 4 pairs of { options, values } entries are always scanned. This is
> fine on KVM but not on PowerVM which can advertises less. As a
> consequence on this platform, Linux reads extra entries pointing to
> random data, interprets these as available features and tries to
> activate them, leading to a firmware crash in
> ibm,client-architecture-support.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/prom: Fix "ibm,arch-vec-5-platform-support" scan
      https://git.kernel.org/powerpc/c/ed5b00a05c2ae95b59adc3442f45944ec632e794

cheers
