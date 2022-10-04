Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D988C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 13:47:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhfBy4nHRz3f1L
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 00:47:06 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhf1V6KXZz3bjm
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:38:54 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1V54rxz4xHB;
	Wed,  5 Oct 2022 00:38:54 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Haren Myneni <haren@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, npiggin@gmail.com, mpe@ellerman.id.au
In-Reply-To: <b9cd844b85eb8f70459109ce1b14e44c4cc85fa7.camel@linux.ibm.com>
References: <b9cd844b85eb8f70459109ce1b14e44c4cc85fa7.camel@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc: Ignore DSI error caused by the copy/paste instruction
Message-Id: <166488996568.779920.3285817727782486217.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:26:05 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 27 Sep 2022 18:29:27 -0700, Haren Myneni wrote:
> The data storage interrupt (DSI) error will be generated when the
> paste operation is issued on the suspended Nest Accelerator (NX)
> window due to NX state changes. The hypervisor expects the
> partition to ignore this error during page fault handling.
> To differentiate DSI caused by an actual HW configuration or by
> the NX window, a new “ibm,pi-features” type value is defined.
> Byte 0, bit 3 of pi-attribute-specifier-type is now defined to
> indicate this DSI error. If this error is not ignored, the user
> space can get SIGBUS when the NX request is issued.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Ignore DSI error caused by the copy/paste instruction
      https://git.kernel.org/powerpc/c/335e1a91042764629fbbcd8c7e40379fa3762d35

cheers
