Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F1EC43334
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jul 2022 10:18:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lg5hr0P3qz3drR
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jul 2022 20:18:52 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lg5gy5mD1z30Mr
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2022 20:18:06 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lg5gw4PS4z4xn3;
	Sat,  9 Jul 2022 20:18:04 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20220628080228.1508847-1-aik@ozlabs.ru>
References: <20220628080228.1508847-1-aik@ozlabs.ru>
Subject: Re: [PATCH kernel] KVM: PPC: Do not warn when userspace asked for too big TCE table
Message-Id: <165736167184.12236.12724791428724317908.b4-ty@ellerman.id.au>
Date: Sat, 09 Jul 2022 20:14:31 +1000
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 28 Jun 2022 18:02:28 +1000, Alexey Kardashevskiy wrote:
> KVM manages emulated TCE tables for guest LIOBNs by a two level table
> which maps up to 128TiB with 16MB IOMMU pages (enabled in QEMU by default)
> and MAX_ORDER=11 (the kernel's default). Note that the last level of
> the table is allocated when actual TCE is updated.
> 
> However these tables are created via ioctl() on kvmfd and the userspace
> can trigger WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp) in mm/page_alloc.c
> and flood dmesg.
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Do not warn when userspace asked for too big TCE table
      https://git.kernel.org/powerpc/c/4dee21e0f2520f5032b0abce0ecae593a71bd19d

cheers
