Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED71C4345F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2024 08:20:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNJ985q5yz3dF9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2024 18:20:44 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNJ6w0SDxz3cRc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2024 18:18:48 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
	id 4VNJ6w0FDXz4x23; Mon, 22 Apr 2024 18:18:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNJ6v6Y7Cz4x21;
	Mon, 22 Apr 2024 18:18:47 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Mahesh Salgaonkar <mahesh@linux.ibm.com>
In-Reply-To: <20240410043006.81577-1-mahesh@linux.ibm.com>
References: <20240410043006.81577-1-mahesh@linux.ibm.com>
Subject: Re: [PATCH v5] powerpc: Avoid nmi_enter/nmi_exit in real mode interrupt.
Message-Id: <171377378382.1025456.12202760161745086596.b4-ty@ellerman.id.au>
Date: Mon, 22 Apr 2024 18:16:23 +1000
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Shirisha Ganta <shirisha@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 10 Apr 2024 10:00:06 +0530, Mahesh Salgaonkar wrote:
> nmi_enter()/nmi_exit() touches per cpu variables which can lead to kernel
> crash when invoked during real mode interrupt handling (e.g. early HMI/MCE
> interrupt handler) if percpu allocation comes from vmalloc area.
> 
> Early HMI/MCE handlers are called through DEFINE_INTERRUPT_HANDLER_NMI()
> wrapper which invokes nmi_enter/nmi_exit calls. We don't see any issue when
> percpu allocation is from the embedded first chunk. However with
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there are chances where percpu
> allocation can come from the vmalloc area.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Avoid nmi_enter/nmi_exit in real mode interrupt.
      https://git.kernel.org/powerpc/c/0db880fc865ffb522141ced4bfa66c12ab1fbb70

cheers
