Return-Path: <SRS0=3gej=EX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB650C388F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 03:11:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516CF20897
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 03:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="P4oIDwMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516CF20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZrZX2kRXzDqRx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 14:11:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZrTf47dwzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 14:07:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=P4oIDwMK; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CZrTd0nsVz9sSs;
 Tue, 17 Nov 2020 14:07:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1605582453;
 bh=R5WCF4I49UY8wfGLb6M2fPkbB9GljRtb7YtY1xSQRFE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=P4oIDwMK/anM/QTrDNLaU3orPQ2ggHQolEh9D6w7S2BXMz4iv2lthO1lKtuFl1DwC
 DBV7nRa8PofxPQ3ciO6PIuf4T8hXA1oASrQU6AswYNGHNK1+IO9p04qeNenyHnlXOe
 +oTKZD3qfMUF9gxO7PIxN9Zn22L33TYKWYH4dCwvowtJBP2h/anWjkdSwgasbXX9rG
 gIPUbfUVOKjosnlNYUf9cUBk74+2k8pBahYde3EZhTGcQt/0VgpJMcPQVWnnw44nCL
 Jbp+nrT0BK3Sjd7V/188EFcjLklRBMaJO3gZEqn5TxBWe8kKCzx4p8Krv2NCuvY6Fk
 mhVJg6EIS978Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <ajd@linux.ibm.com>, xiakaixu1987@gmail.com,
 fbarrat@linux.ibm.com, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/powernv/sriov: fix unsigned int win compared to
 less than zero
In-Reply-To: <40b8ba6f-4916-55c2-a1f0-b7daa3c2e201@linux.ibm.com>
References: <1605007170-22171-1-git-send-email-kaixuxia@tencent.com>
 <40b8ba6f-4916-55c2-a1f0-b7daa3c2e201@linux.ibm.com>
Date: Tue, 17 Nov 2020 14:07:29 +1100
Message-ID: <87zh3g3clq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Kaixu Xia <kaixuxia@tencent.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrew Donnellan <ajd@linux.ibm.com> writes:

> On 10/11/20 10:19 pm, xiakaixu1987@gmail.com wrote:
>> From: Kaixu Xia <kaixuxia@tencent.com>
>> 
>> Fix coccicheck warning:
>> 
>> ./arch/powerpc/platforms/powernv/pci-sriov.c:443:7-10: WARNING: Unsigned expression compared with zero: win < 0
>> ./arch/powerpc/platforms/powernv/pci-sriov.c:462:7-10: WARNING: Unsigned expression compared with zero: win < 0
>> 
>> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
>> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
>
> This seems like the right fix, the value assigned to win can indeed be 
> -1 so it should be signed. Thanks for sending the patch.
>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

I'll add:

  Fixes: 39efc03e3ee8 ("powerpc/powernv/sriov: Move M64 BAR allocation into a helper")

Which I think is the culprit as it changed:

  if (win >= phb->ioda.m64_bar_idx + 1)

to:

  if (win < 0)


cheers
