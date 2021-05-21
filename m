Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E647C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 12:45:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D150C613CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 12:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D150C613CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmmXr2QxQz3btQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 22:45:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmmXQ15tnz2yQy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 22:44:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FmmXK2jnRz9sW4; Fri, 21 May 2021 22:44:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20210520111931.2597127-1-npiggin@gmail.com>
References: <20210520111931.2597127-1-npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64s/syscall: Use pt_regs.trap to distinguish
 syscall ABI difference between sc and scv syscalls
Message-Id: <162160105357.3327984.5220875134917058575.b4-ty@ellerman.id.au>
Date: Fri, 21 May 2021 22:44:13 +1000
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
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 20 May 2021 21:19:30 +1000, Nicholas Piggin wrote:
> The sc and scv 0 system calls have different ABI conventions, and
> ptracers need to know which system call type is being used if it wants
> to look at the syscall registers.
> 
> Document that pt_regs.trap can be used for this, and fix one in-tree user
> to work with scv 0 syscalls.

Applied to powerpc/fixes.

[1/2] powerpc/64s/syscall: Use pt_regs.trap to distinguish syscall ABI difference between sc and scv syscalls
      https://git.kernel.org/powerpc/c/5665bc35c1ed917ac8fd06cb651317bb47a65b10
[2/2] powerpc/64s/syscall: Fix ptrace syscall info with scv syscalls
      https://git.kernel.org/powerpc/c/d72500f992849d31ebae8f821a023660ddd0dcc2

cheers
