Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE98C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 21:37:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815FA60F8F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 21:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 815FA60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GdDxj5wD8z3cQS
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 07:37:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4GdDxH3HdJz2yj0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Aug 2021 07:37:06 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 171LWnvj015149;
 Sun, 1 Aug 2021 16:32:49 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 171LWlIp015148;
 Sun, 1 Aug 2021 16:32:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sun, 1 Aug 2021 16:32:47 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 3/3] isystem: delete global -isystem compile option
Message-ID: <20210801213247.GM1583@gate.crashing.org>
References: <20210801201336.2224111-1-adobriyan@gmail.com>
 <20210801201336.2224111-3-adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801201336.2224111-3-adobriyan@gmail.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, masahiroy@kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Aug 01, 2021 at 11:13:36PM +0300, Alexey Dobriyan wrote:
> In theory, it enables "leakage" of userspace headers into kernel which
> may present licensing problem.

> -NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> +NOSTDINC_FLAGS += -nostdinc

This is removing the compiler's own include files.  These are required
for all kinds of basic features, and required to be compliant to the C
standard at all.  These are not "userspace headers", that is what
-nostdinc takes care of already.

In the case of GCC all these headers are GPL-with-runtime-exception, so
claiming this can cause licensing problems is fearmongering.

I strongly advise against doing this.


Segher
