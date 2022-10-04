Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9770EC433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 13:22:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mhdg51jKhz3drp
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 00:22:57 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhdfR2X0hz2xHw
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:22:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhdfN4svqz4xGj;
	Wed,  5 Oct 2022 00:22:20 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220816222517.1916391-1-farosas@linux.ibm.com>
References: <20220816222517.1916391-1-farosas@linux.ibm.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix decrementer migration
Message-Id: <166488970203.778266.13672388386206891818.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:21:42 +1100
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
Cc: kvm-ppc@vger.kernel.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 16 Aug 2022 19:25:17 -0300, Fabiano Rosas wrote:
> We used to have a workaround[1] for a hang during migration that was
> made ineffective when we converted the decrementer expiry to be
> relative to guest timebase.
> 
> The point of the workaround was that in the absence of an explicit
> decrementer expiry value provided by userspace during migration, KVM
> needs to initialize dec_expires to a value that will result in an
> expired decrementer after subtracting the current guest timebase. That
> stops the vcpu from hanging after migration due to a decrementer
> that's too large.
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Book3S HV: Fix decrementer migration
      https://git.kernel.org/powerpc/c/0a5bfb824a6ea35e54b7e5ac6f881beea5e309d2

cheers
