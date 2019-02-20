Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E56C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:29:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D12420851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="C5I/f3FS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9CT+5HS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D12420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Fkp0mYRzDqH3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 22:29:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444FfG3K9YzDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 22:25:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="C5I/f3FS"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="L9CT+5HS"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444FfF1cZXz8t2S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 22:25:57 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444FfF0kBnz9sB8; Wed, 20 Feb 2019 22:25:57 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="C5I/f3FS"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="L9CT+5HS"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 444FfD3179z9s9L
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 22:25:56 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 5A42E2257C;
 Wed, 20 Feb 2019 06:25:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 20 Feb 2019 06:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 LiXXIm4HKfv+P+wGNpJzOqGsJjFpw6ysvjYxYXFVYUY=; b=C5I/f3FSHWR9QQRU
 NE6vKM1jBAuQ9LJlnXujlLTuTcforlXxhTVmPSgKx3roW5HTvUkXkoaMes/l7GRD
 JDF34QUtHye3tpK5ZjatMP7+Cz7dNGAH6lavSR3DYsJU/AN58VNx3z7i66v/Zgwa
 N2ZXN0lLl4ssWD9GlLvCFShOrbP0RSnZB5hfYwPwkJNpTVO1J0maY+le5X2euBcG
 Lr3MWy7pWvqe+hnb+nAaX4pjZGW7rgvfuYD4eEL5ENmRnBf44i4NVu2cIPKfgquO
 fi6XVIKG9ezgcvQm/1Q3KBKhTt1G9zLgMQc3ITYOaXqODu7jDy9JPAptJo+QjrnC
 Q0Sbfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=LiXXIm4HKfv+P+wGNpJzOqGsJjFpw6ysvjYxYXFVY
 UY=; b=L9CT+5HSyX6ahrNMvy85eKWVIdAcqULIgVP197XiVxyIDe1yESu1VQYvH
 VRW0jXmhLkaNlvyDqEHQj6o+ZGwoeJmafNIaGtkNgmjusTGowUzUejgoy/RVBrqQ
 oNnhQP7d/djRwIjz/0jmjeX5BpCkR6S8KNsakYbt48+zLiBKqB0d/IceQLk5SPGW
 g6D7hCu76cdL5ziM2U/tIGSirv/pxCYPmtRB/9f0/m5mmKPtojkxPZW2f5BUBURk
 gemFzWHsme/k5AQo1uS/twZeYtwymAQNZ/7wOOD/f56avgYJd3gWSLmxh8UNGT34
 5j6Mh3rgmdBgsCiVsPncNWIboNUSQ==
X-ME-Sender: <xms:QTltXNJ8VsIY3fQJdFpmjVD4UvA4TqHqzrhP6UFGDeUpyeezpD-EDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdeigddvkeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefkuf
 fhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhr
 rhgvhicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucfkphepuddvuddrgeehrd
 dvudelrdefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrhhushhsvghl
 lhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:QTltXPHyfx3vjIL4ZZf7AtvIBDxb46Iz9_ncEhqruLlLm4_09sjOxQ>
 <xmx:QTltXC2WWN3oB3e88zSFYec7EA2JKp2SvhovIyfapXpv0HeEHX8KPA>
 <xmx:QTltXPJpCuYnAe4u1aUZ3-PVWm3WBfMCLGFNYB553CIEk7qpaRxwXg>
 <xmx:QjltXFg25fxCYv2okBinvXIlpJglhIwir3hisk34hw6sJljc1WCa8Q>
Received: from crackle.ozlabs.ibm.com
 (ppp121-45-219-3.bras1.cbr2.internode.on.net [121.45.219.3])
 by mail.messagingengine.com (Postfix) with ESMTPA id 94C8910310;
 Wed, 20 Feb 2019 06:25:51 -0500 (EST)
Message-ID: <dd19f66a8cbf31197e3dc2652b5d25e8c50fcfa2.camel@russell.cc>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Context switch IAMR on Power9
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Wed, 20 Feb 2019 22:25:49 +1100
In-Reply-To: <20190220085500.29837-1-mpe@ellerman.id.au>
References: <20190220085500.29837-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
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
Cc: paulus@samba.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-20 at 19:55 +1100, Michael Ellerman wrote:
> kvmhv_p9_guest_entry() implements a fast-path guest entry for Power9
> when guest and host are both running with the Radix MMU.
> 
> Currently in that path we don't save the host AMR (Authority Mask
> Register) value, and we always restore 0 on return to the host. That
> is OK at the moment because the AMR is not used for storage keys with
> the Radix MMU.
> 
> However we plan to start using the AMR on Radix to prevent the kernel
> from reading/writing to userspace outside of copy_to/from_user(). In
> order to make that work we need to save/restore the AMR value.
> 
> We only restore the value if it is different from the guest value,
> which is already in the register when we exit to the host. This
> should
> mean we rarely need to actually restore the value when running a
> modern Linux as a guest, because it will be using the same value as
> us.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Tested-by: Russell Currey <ruscur@russell.cc>

