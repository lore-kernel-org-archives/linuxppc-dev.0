Return-Path: <SRS0=Rflt=F2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9C5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:22:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B502251E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B502251E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0cSd6xDNzDqQ3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Dec 2020 00:22:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4D0cDG4QLFzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2020 00:11:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4D0cDG10NPz9sWd; Wed, 23 Dec 2020 00:11:25 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Cédric Le Goater <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20201221074154.403779-1-clg@kaod.org>
References: <20201221074154.403779-1-clg@kaod.org>
Subject: Re: [PATCH] powerpc/smp: Add __init to init_big_cores()
Message-Id: <160864266123.1929899.2668729189824114282.b4-ty@ellerman.id.au>
Date: Wed, 23 Dec 2020 00:11:25 +1100 (AEDT)
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 21 Dec 2020 08:41:54 +0100, Cédric Le Goater wrote:
> It fixes this link warning:
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0x2d98): Section mismatch in reference from the function init_big_cores.isra.0() to the function .init.text:init_thread_group_cache_map()
> The function init_big_cores.isra.0() references
> the function __init init_thread_group_cache_map().
> This is often because init_big_cores.isra.0 lacks a __init
> annotation or the annotation of init_thread_group_cache_map is wrong.

Applied to powerpc/fixes.

[1/1] powerpc/smp: Add __init to init_big_cores()
      https://git.kernel.org/powerpc/c/9014eab6a38c60fd185bc92ed60f46cf99a462ab

cheers
