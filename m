Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BF7C4345F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2024 10:46:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VW6tk0czdz3vjc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2024 20:46:54 +1000 (AEST)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VW6nl0YN3z3cc6
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2024 20:42:35 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
	id 4VW6nl0N41z4xPR; Fri,  3 May 2024 20:42:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW6nk6jvtz4x0w;
	Fri,  3 May 2024 20:42:34 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240422195932.1583833-1-sourabhjain@linux.ibm.com>
References: <20240422195932.1583833-1-sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v10 0/3] powerpc: make fadump resilient with memory add/remove events
Message-Id: <171473286292.451432.11432896911033997980.b4-ty@ellerman.id.au>
Date: Fri, 03 May 2024 20:41:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Aditya Gupta <adityag@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 23 Apr 2024 01:29:29 +0530, Sourabh Jain wrote:
> Problem:
> ========
> Due to changes in memory resources caused by either memory hotplug or
> online/offline events, the elfcorehdr, which describes the cpus and
> memory of the crashed kernel to the kernel that collects the dump (known
> as second/fadump kernel), becomes outdated. Consequently, attempting
> dump collection with an outdated elfcorehdr can lead to failed or
> inaccurate dump collection.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc: make fadump resilient with memory add/remove events
      https://git.kernel.org/powerpc/c/c6c5b14dac0d1bd0da8b4d1d3b77f18eb9085fcb
[2/3] powerpc/fadump: add hotplug_ready sysfs interface
      https://git.kernel.org/powerpc/c/bc446c5acabadeb38b61b565535401c5dfdd1214
[3/3] Documentation/powerpc: update fadump implementation details
      https://git.kernel.org/powerpc/c/57e6700145c5d1f49c52137e9163f73ec5441256

cheers
