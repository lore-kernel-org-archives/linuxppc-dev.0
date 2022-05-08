Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7133DC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 May 2022 11:12:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kx1q70s2gz3cgQ
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 May 2022 21:12:19 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kx1pL46W9z3c8l
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 May 2022 21:11:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kx1pH5Mg2z4yT6;
 Sun,  8 May 2022 21:11:35 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220502125010.1319370-1-mpe@ellerman.id.au>
References: <20220502125010.1319370-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/vdso: Fix incorrect CFI in gettimeofday.S
Message-Id: <165200827500.2672957.3801145559467507501.b4-ty@ellerman.id.au>
Date: Sun, 08 May 2022 21:11:15 +1000
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
Cc: amodra@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2 May 2022 22:50:10 +1000, Michael Ellerman wrote:
> As reported by Alan, the CFI (Call Frame Information) in the VDSO time
> routines is incorrect since commit ce7d8056e38b ("powerpc/vdso: Prepare
> for switching VDSO to generic C implementation.").
> 
> In particular the changes to the frame address register (r1) are not
> properly described, which prevents gdb from being able to generate a
> backtrace from inside VDSO functions, eg:
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/vdso: Fix incorrect CFI in gettimeofday.S
      https://git.kernel.org/powerpc/c/6d65028eb67dbb7627651adfc460d64196d38bd8

cheers
