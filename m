Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804EAC25B67
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 10:09:04 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Ixb1CVVE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGz0H0KtXz3cZC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 21:09:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Ixb1CVVE;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGyzM4GWQz3bx0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2023 21:08:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1698401295;
	bh=RnI3PP7savIzhrPAfbY+0mVll5niIq9XCcECAQLlqC0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Ixb1CVVETu0IF1fYAdkzFUjllVC8JqPkyi6g2LLd8ziEdtSX6SZlNDBWHbKJ1V5rz
	 TMunDWnqGSBouTWDfHqBK4Ie0ZNHVrbcqhqcIFE9zJiwZ+xJy9qSKOXumtRtLta3VB
	 9T/8DleCBheV603IxcHB0qnCCkLHSuCvB1h+LrlSJ4SIdOgkFBsHI5MAO6Je21VgEQ
	 Z7YsOBqMycna4A6Aw1uT3usgS9zQrr6CgQzZBukOtDLrjL+Z2sRADX6jRFauWq21IX
	 vD4q4XA6G75P7udSwCjuB+hDmjDbFe/WGV3XavJbn6u5nCZ+IIGTbEUg4YSd+v28C5
	 ad5K7sQLBDMeQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzM2rtjz4xWK;
	Fri, 27 Oct 2023 21:08:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Gray <bgray@linux.ibm.com>
In-Reply-To: <20231011053711.93427-1-bgray@linux.ibm.com>
References: <20231011053711.93427-1-bgray@linux.ibm.com>
Subject: Re: (subset) [PATCH 00/12] Miscellaneous Sparse fixes
Message-Id: <169840079669.2701453.6341592895089218365.b4-ty@ellerman.id.au>
Date: Fri, 27 Oct 2023 20:59:56 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 11 Oct 2023 16:36:59 +1100, Benjamin Gray wrote:
> There are many Sparse warnings in the kernel, including the powerpc
> directory. This series provides fixes for some low-hanging fruit found
> when trying to triage the warnings earlier this year. It addresses about
> 100 warnings (many have the same root cause).
> 
> I know there's concerns about making it harder to backport things. In
> general, as someone who was not around during the development of these
> features, I think that it is useful make the annotations as correct as
> possible. But it's no fuss if some/all of the patches are nacked for this
> reason. I just figured some of it might be useful instead of continuing to
> sit on it indefinitely.
> 
> [...]

Patch 1, and 3-12 applied to powerpc/next.

[01/12] powerpc/xive: Fix endian conversion size
        https://git.kernel.org/powerpc/c/ff7a60ab1e065257a0e467c13b519f4debcd7fcf
[03/12] powerpc: Explicitly reverse bytes when checking for byte reversal
        https://git.kernel.org/powerpc/c/340a60e3725b9a229eaf03a9b3f8538f22f6ac16
[04/12] powerpc: Use NULL instead of 0 for null pointers
        https://git.kernel.org/powerpc/c/ddfb7d9db843fd4fbdff81fb8a8743f865c3dd96
[05/12] powerpc: Remove extern from function implementations
        https://git.kernel.org/powerpc/c/419d5d112c2e1e78beda9c3299f71c35141d8dba
[06/12] powerpc: Annotate endianness of various variables and functions
        https://git.kernel.org/powerpc/c/2b4a6cc9a1a7cf6958c8b11f94e61c8e81b60b88
[07/12] powerpc/kvm: Force cast endianness of KVM shared regs
        https://git.kernel.org/powerpc/c/b7bce570430e42229fb63f775fcbb10f38b83c71
[08/12] powerpc/opal: Annotate out param endianness
        https://git.kernel.org/powerpc/c/8577dd00a6ba335bc359313599d6100522a1931c
[09/12] powerpc/uaccess: Cast away __user annotation after verification
        https://git.kernel.org/powerpc/c/c6519c6df0722e432f330afbc7c00d16d5be5c58
[10/12] powerpc: Cast away __iomem in low level IO routines
        https://git.kernel.org/powerpc/c/2c4ce3e65b1a543123ffcec4b021ad6ebd4e4e4e
[11/12] powerpc/eeh: Remove unnecessary cast
        https://git.kernel.org/powerpc/c/82f635243f209a85d3deb9f64439c3ea84cd4ecb
[12/12] powerpc/fadump: Annotate endianness cast with __force
        https://git.kernel.org/powerpc/c/b574b817cc7bfcc87bbc92b4b19525442401ae5e

cheers
