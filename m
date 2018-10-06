Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CCBC65C30
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 12:16:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449312147D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 12:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449312147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42S5FN44m6zF3bv
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 22:16:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42S5CB1FfYzF3bY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 22:14:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42S5CB0SzVz9s4Z; Sat,  6 Oct 2018 22:14:13 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ac1788cc7da4ce54edcfd2e499afdb0a23d5c41d
In-Reply-To: <1538106452-7643-1-git-send-email-srikar@linux.vnet.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/numa: Skip onlining a offline node in kdump path
Message-Id: <42S5CB0SzVz9s4Z@ozlabs.org>
Date: Sat,  6 Oct 2018 22:14:13 +1000 (AEST)
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
Cc: Pavithra Prakash <pavrampu@in.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Bringmann <mbringm@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-09-28 at 03:47:32 UTC, Srikar Dronamraju wrote:
> With Commit 2ea626306810 ("powerpc/topology: Get topology for shared
> processors at boot"), kdump kernel on shared lpar may crash.
> 
> The necessary conditions are
> - Shared Lpar with atleast 2 nodes having memory and CPUs.
> - Memory requirement for kdump kernel must be met by the first N-1 nodes
>   where there are atleast N nodes with memory and CPUs.
...
> 
> As part of fix, detect and skip early onlining of a offline node.
> 
> Fixes: 2ea626306810 ("powerpc/topology: Get topology for shared processors at boot")
> Reported-by: Pavithra Prakash <pavrampu@in.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Tested-by: Hari Bathini <hbathini@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/ac1788cc7da4ce54edcfd2e499afdb

cheers
