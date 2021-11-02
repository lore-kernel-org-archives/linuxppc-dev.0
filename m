Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F9C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:38:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B98603E5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34B98603E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Fx6QFFz30R8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:38:45 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7FX1VJWz2xDM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7FW1t9Jz4xbs;
 Tue,  2 Nov 2021 22:38:23 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
References: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/nohash: Fix __ptep_set_access_flags() and
 ptep_set_wrprotect()
Message-Id: <163584791973.1845480.6138102753649053681.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:59 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 26 Oct 2021 07:39:24 +0200, Christophe Leroy wrote:
> Commit 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
> changed those two functions to use pte helpers to determine which
> bits to clear and which bits to set.
> 
> This change was based on the assumption that bits to be set/cleared
> are always the same and can be determined by applying the pte
> manipulation helpers on __pte(0).
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/nohash: Fix __ptep_set_access_flags() and ptep_set_wrprotect()
      https://git.kernel.org/powerpc/c/b1b93cb7e794e914787bf7d9936b57a149cdee4f
[2/3] powerpc/book3e: Fix set_memory_x() and set_memory_nx()
      https://git.kernel.org/powerpc/c/b6cb20fdc2735f8b2e082937066c33fe376c2ee2
[3/3] powerpc/fsl_booke: Fix setting of exec flag when setting TLBCAMs
      https://git.kernel.org/powerpc/c/44c14509b0dabb909ad1ec28800893ea71762732

cheers
