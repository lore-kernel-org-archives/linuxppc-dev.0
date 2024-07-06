Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0EEC2BD09
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jul 2024 22:51:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WGlxN3Sspz3bYR
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jul 2024 08:51:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WGlww22vPz30V3
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jul 2024 08:51:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WGlwv4dFNz4wc3;
	Sun,  7 Jul 2024 08:51:11 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20240625134047.298759-1-npiggin@gmail.com>
References: <20240625134047.298759-1-npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/pseries: Fix scv instruction crash with kexec
Message-Id: <172030619793.961024.13628081006171087103.b4-ty@ellerman.id.au>
Date: Sun, 07 Jul 2024 08:49:57 +1000
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
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 25 Jun 2024 23:40:47 +1000, Nicholas Piggin wrote:
> kexec on pseries disables AIL (reloc_on_exc), required for scv
> instruction support, before other CPUs have been shut down. This means
> they can execute scv instructions after AIL is disabled, which causes an
> interrupt at an unexpected entry location that crashes the kernel.
> 
> Change the kexec sequence to disable AIL after other CPUs have been
> brought down.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries: Fix scv instruction crash with kexec
      https://git.kernel.org/powerpc/c/21a741eb75f80397e5f7d3739e24d7d75e619011

cheers
