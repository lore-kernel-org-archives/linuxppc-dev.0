Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8F0C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 12:02:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D6D61990
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 12:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D6D61990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4VNz0LPPz3brR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 23:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4VNd3hbYz304Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 23:02:25 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F4VNc060jz9sVS; Tue, 23 Mar 2021 23:02:22 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nathan Lynch <nathanl@linux.ibm.com>
In-Reply-To: <20210315080045.460331-1-nathanl@linux.ibm.com>
References: <20210315080045.460331-1-nathanl@linux.ibm.com>
Subject: Re: [PATCH 0/2] handle premature return from H_JOIN in pseries
 mobility code
Message-Id: <161650092238.1094211.1489505572228990458.b4-ty@ellerman.id.au>
Date: Tue, 23 Mar 2021 23:02:02 +1100
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
Cc: tyreld@linux.ibm.com, brking@linux.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Mar 2021 03:00:43 -0500, Nathan Lynch wrote:
> pseries VMs in shared processor mode are susceptible to failed
> migrations becasue stray H_PRODs from the paravirt spinlock
> implementation can bump threads out of joining state before the
> suspend has occurred. Fix this by adding a small amount of shared
> state and ordering accesses to it with respect to H_PROD and H_JOIN.
> 
> Nathan Lynch (2):
>   powerpc/pseries/mobility: use struct for shared state
>   powerpc/pseries/mobility: handle premature return from H_JOIN
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/pseries/mobility: use struct for shared state
      https://git.kernel.org/powerpc/c/e834df6cfc71d8e5ce2c27a0184145ea125c3f0f
[2/2] powerpc/pseries/mobility: handle premature return from H_JOIN
      https://git.kernel.org/powerpc/c/274cb1ca2e7ce02cab56f5f4c61a74aeb566f931

cheers
