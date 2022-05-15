Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF70C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 10:36:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1Jh32zdnz3flK
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 20:36:03 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1JZS2dj4z3cfP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2022 20:31:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZS1sXJz4xZv;
 Sun, 15 May 2022 20:31:12 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au
In-Reply-To: <20220504101244.12107-1-ldufour@linux.ibm.com>
References: <20220504101244.12107-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/rtas: Keep MSR[RI] set when calling RTAS
Message-Id: <165261054578.1047019.8022784676618367625.b4-ty@ellerman.id.au>
Date: Sun, 15 May 2022 20:29:05 +1000
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
Cc: stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 4 May 2022 12:12:44 +0200, Laurent Dufour wrote:
> RTAS runs in real mode (MSR[DR] and MSR[IR] unset) and in 32bits
> big endian mode (MSR[SF,LE] unset).
> 
> The change in MSR is done in enter_rtas() in a relatively complex way,
> since the MSR value could be hardcoded.
> 
> Furthermore, a panic has been reported when hitting the watchdog interrupt
> while running in RTAS, this leads to the following stack trace:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/rtas: Keep MSR[RI] set when calling RTAS
      https://git.kernel.org/powerpc/c/b6b1c3ce06ca438eb24e0f45bf0e63ecad0369f5

cheers
