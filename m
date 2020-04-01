Return-Path: <SRS0=4P7+=5R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC77CC43331
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFD0206F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 13:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFD0206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48snYR6HfczDqX6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 00:46:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48smMz12f6zDr1f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2020 23:53:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48smMx2C3Nz9sRf; Wed,  1 Apr 2020 23:53:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: efbc4303b255bb80ab1283794b36dd5fe1fb0ec3
In-Reply-To: <20200326184916.31172-1-ganeshgr@linux.ibm.com>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v4] powerpc/pseries: Handle UE event for memcpy_mcsafe
Message-Id: <48smMx2C3Nz9sRf@ozlabs.org>
Date: Wed,  1 Apr 2020 23:53:33 +1100 (AEDT)
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
Cc: mahesh@linux.vnet.ibm.com, santosh@fossix.org,
 Ganesh Goudar <ganeshgr@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-03-26 at 18:49:16 UTC, Ganesh Goudar wrote:
> memcpy_mcsafe has been implemented for power machines which is used
> by pmem infrastructure, so that an UE encountered during memcpy from
> pmem devices would not result in panic instead a right error code
> is returned. The implementation expects machine check handler to ignore
> the event and set nip to continue the execution from fixup code.
> 
> Appropriate changes are already made to powernv machine check handler,
> make similar changes to pseries machine check handler to ignore the
> the event and set nip to continue execution at the fixup entry if we
> hit UE at an instruction with a fixup entry.
> 
> while we are at it, have a common function which searches the exception
> table entry and updates nip with fixup address, and any future common
> changes can be made in this function that are valid for both architectures.
> 
> powernv changes are made by
> commit 895e3dceeb97 ("powerpc/mce: Handle UE event for memcpy_mcsafe")
> 
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Reviewed-by: Santosh S <santosh@fossix.org>
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/efbc4303b255bb80ab1283794b36dd5fe1fb0ec3

cheers
