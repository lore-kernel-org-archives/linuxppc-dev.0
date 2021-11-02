Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E2FC433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:49:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4FA60F56
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A4FA60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Tp0Jncz3gDP
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:49:02 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7G02N8cz30Qx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7G00XhGz4xdZ;
 Tue,  2 Nov 2021 22:38:48 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211014024424.528848-1-mpe@ellerman.id.au>
References: <20211014024424.528848-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/dcr: Use cmplwi instead of 3-argument cmpli
Message-Id: <163584792457.1845480.16320937670703968873.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:12:04 +1100
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
Cc: ndesaulniers@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Oct 2021 13:44:24 +1100, Michael Ellerman wrote:
> In dcr-low.S we use cmpli with three arguments, instead of four
> arguments as defined in the ISA:
> 
> 	cmpli	cr0,r3,1024
> 
> This appears to be a PPC440-ism, looking at the "PPC440x5 CPU Core
> User’s Manual" it shows cmpli having no L field, but implied to be 0 due
> to the core being 32-bit. It mentions that the ISA defines four
> arguments and recommends using cmplwi.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/dcr: Use cmplwi instead of 3-argument cmpli
      https://git.kernel.org/powerpc/c/fef071be57dc43679a32d5b0e6ee176d6f12e9f2

cheers
