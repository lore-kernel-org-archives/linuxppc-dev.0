Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78275C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 05:13:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A392184D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 05:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="awm4grLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A392184D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JwMY5P4rzDr9M
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 15:13:29 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JwBJ08NCzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2020 15:05:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=awm4grLC; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49JwBH1w7Sz9sTC; Sat,  9 May 2020 15:05:27 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49JwBH07bSz9sSg; Sat,  9 May 2020 15:05:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1589000727; bh=2RLlhhGaeasDfLb3fZBQy4a2iqXLcsXLFtSJuhb3m+E=;
 h=Date:From:To:Subject:From;
 b=awm4grLCjj6LV+VP49HcwJF024bKoDXh+yRQvQ/Hi7kxFXSjGSd5IX2bhW9D4rOUh
 ytCPar83aNcWuGnifp84r2+s9hDVIpIU1q5hudRLImPpx2zpjxwDzE447ME5PV8A/O
 Gwy03urS7JH/UBFeG93go6ETXbPsOcGeTEPXnXXNowVJlKkSPH5C+WivNaojcC/GJ8
 IDW+zvf36osoq+0p0OUkQOFI88F6Dl5+l++SJj9rHIbjmaY7jdO9aTMTq6QO/Amcad
 gM5xiQ5txxOFgFeTcvas4K+eKG+LO27SkD/KV5QOKRXR+jRs8Hn200S648CNd5dneG
 mBDfY4a62reGQ==
Date: Sat, 9 May 2020 15:01:03 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH RFC 0/4] Add support for Microwatt-based SoCs
Message-ID: <20200509050103.GA1464954@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch series adds support for running Linux on a Microwatt SoC
(system on chip) implementation on an FPGA.  Microwatt is a small
Power ISA implementation, targetted at FPGAs, aiming for PowerISA
v3.0B compliance.  It does not currently implement any floating-point
or vector instructions, hypervisor mode, big-endian mode, 32-bit mode,
or the HPT/SLB MMU facilities.  However, it does support enough to run
Linux (as of my "mmu" branch plus Ben's "litedram" branch").

Paul.
