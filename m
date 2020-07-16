Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC4EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 12:53:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2819D20739
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 12:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2819D20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6vLZ01y7zDqYX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 22:53:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6vDN5CPNzDqx1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 22:47:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4B6vDN4HnLz9sTC; Thu, 16 Jul 2020 22:47:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Haren Myneni <haren@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <019fd53e7538c6f8f332d175df74b1815ef5aa8c.camel@linux.ibm.com>
References: <019fd53e7538c6f8f332d175df74b1815ef5aa8c.camel@linux.ibm.com>
Subject: Re: [PATCH V2 1/2] powerpc/vas: Report proper error code for address
 translation failure
Message-Id: <159490364701.3801815.3911560040521961518.b4-ty@ellerman.id.au>
Date: Thu, 16 Jul 2020 22:47:48 +1000 (AEST)
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
Cc: tulioqm@br.ibm.com, linuxppc-dev@lists.ozlabs.org, abali@us.ibm.com,
 rzinsly@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 10 Jul 2020 16:47:19 -0700, Haren Myneni wrote:
> P9 DD2 NX workbook (Table 4-36) says DMA controller uses CC=5
> internally for translation fault handling. NX reserves CC=250 for
> OS to notify user space when NX encounters address translation
> failure on the request buffer. Not an issue in earlier releases
> as NX does not get faults on kernel addresses.
> 
> This patch defines CSB_CC_FAULT_ADDRESS(250) and updates CSB.CC with
> this proper error code for user space.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/vas: Report proper error code for address translation failure
      https://git.kernel.org/powerpc/c/6068e1a4427e88f5cc62f238d1baf94a8b824ef4
[2/2] selftests/powerpc: Use proper error code to check fault address
      https://git.kernel.org/powerpc/c/f0479c4bcbd92d1a457d4a43bcab79f29d11334a

cheers
