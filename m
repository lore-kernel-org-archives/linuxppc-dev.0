Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC5AC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 10:54:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6rfv2k2yz3cKm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 20:54:15 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6rfW6f00z308C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 20:53:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6rfW54fHz4xbd;
 Tue, 24 May 2022 20:53:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220506053755.3820702-1-aik@ozlabs.ru>
References: <20220506053755.3820702-1-aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2] KVM: PPC: Book3s: Retire H_PUT_TCE/etc real
 mode handlers
Message-Id: <165338951112.1711920.752815379112806107.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 20:51:51 +1000
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 6 May 2022 15:37:55 +1000, Alexey Kardashevskiy wrote:
> LoPAPR defines guest visible IOMMU with hypercalls to use it -
> H_PUT_TCE/etc. Implemented first on POWER7 where hypercalls would trap
> in the KVM in the real mode (with MMU off). The problem with the real mode
> is some memory is not available and some API usage crashed the host but
> enabling MMU was an expensive operation.
> 
> The problems with the real mode handlers are:
> 1. Occasionally these cannot complete the request so the code is
> copied+modified to work in the virtual mode, very little is shared;
> 2. The real mode handlers have to be linked into vmlinux to work;
> 3. An exception in real mode immediately reboots the machine.
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode handlers
      https://git.kernel.org/powerpc/c/cad32d9d42e8e6a659786f8a730b221a9fbee227

cheers
