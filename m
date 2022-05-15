Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51404C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 10:36:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1Jj10F5vz3ftD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 20:36:53 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1JgQ3l9fz3fb7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2022 20:35:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JgQ2lXhz4xZ0;
 Sun, 15 May 2022 20:35:30 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alexander Graf <graf@amazon.com>, kvm@vger.kernel.org
In-Reply-To: <20220510123717.24508-1-graf@amazon.com>
References: <20220510123717.24508-1-graf@amazon.com>
Subject: Re: [PATCH v3] KVM: PPC: Book3S PR: Enable MSR_DR for
 switch_mmu_context()
Message-Id: <165261089230.1048761.8692230745966082398.b4-ty@ellerman.id.au>
Date: Sun, 15 May 2022 20:34:52 +1000
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
Cc: Matt Evans <matt@ozlabs.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 10 May 2022 14:37:17 +0200, Alexander Graf wrote:
> Commit 863771a28e27 ("powerpc/32s: Convert switch_mmu_context() to C")
> moved the switch_mmu_context() to C. While in principle a good idea, it
> meant that the function now uses the stack. The stack is not accessible
> from real mode though.
> 
> So to keep calling the function, let's turn on MSR_DR while we call it.
> That way, all pointer references to the stack are handled virtually.
> 
> [...]

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S PR: Enable MSR_DR for switch_mmu_context()
      https://git.kernel.org/powerpc/c/ee8348496c77e3737d0a6cda307a521f2cff954f

cheers
