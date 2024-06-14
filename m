Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B143C27C6E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2024 07:55:44 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=HjrG/3Fy;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W0s5n5qBYz3cWx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2024 17:55:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=HjrG/3Fy;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W0s4x6Pqlz3bwL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2024 17:54:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718351690;
	bh=/EbTuSwaLt88VY4aLtR+tIbwCPpZ9zrwjvem1QZrNA0=;
	h=From:To:Cc:Subject:Date:From;
	b=HjrG/3FyCx7gfMb5+XF0jFIjPIgJGuZ4oA0/WL2PwoNBd70bgMUKNXMoFTVANnPyh
	 sRubgNHfK0dzwu67EA+dCGO2Zxkr1PGmPwRfP97sxi7VV8BtM9fp0RaclFk331N6MZ
	 0QeAAR8JYvvXjKSQbMB2i4Hdla53GhomjuadfLAkeq4G4TbSwjkMuLhgTS4DOPac6H
	 sSMNdpwcuPhL/WQPfaunQQSeqBGDcaic9PoItptQIktwpTCpcMyVhaqoxQRVIxpPOh
	 Gc7E9vGtBYK60rbkAKuItrXYsxr5UwbeVvcRByKJmh7Za+AcmkrT6CxAOVBdA85azt
	 NjUo+zk8m1vDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0s4p3bP5z4wcq;
	Fri, 14 Jun 2024 17:54:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Subject: Please backport 2d43cc701b96 to v6.9 and v6.6
Date: Fri, 14 Jun 2024 17:54:50 +1000
Message-ID: <87wmmsnelx.fsf@mail.lhotse>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi stable team,

Can you please backport:
  2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with GCC 13/14")

To v6.9 and v6.6.

It was marked for backporting, but hasn't been picked up AFAICS. I'm not
sure if it clashed with the asm_goto_output changes or something. But it
backports cleanly to the current stable branches.

It needs a custom backport for earlier kernels, I'll send those.

cheers
