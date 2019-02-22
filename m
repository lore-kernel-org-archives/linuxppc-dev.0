Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C43C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:11:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04FC20836
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="wOxDWryB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1wTlKwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04FC20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445BZk3D9fzDqTX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:11:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="wOxDWryB"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="E1wTlKwY"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445BXr08fGzDqSV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 11:09:31 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 7712D22252;
 Thu, 21 Feb 2019 19:09:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 21 Feb 2019 19:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 ilHHJeKNQVAXWVIEo81s8qVuOqwIEGjlx5IhFcSzrdI=; b=wOxDWryBcgz8Hsou
 Fm3Y5kGGs/o7K9UPoicth5KkedOF4c1H+/S/5xL1Nfb7uuu3UUOsd+Gt9A2h13jf
 YHp4WHDxV3w6gmKQQnS/Hw9RNb9d45LmjAcQP8LiMQpr1DfjAu+Mct71nq+Wgqu9
 CVKMhOBpXO1Fxr3DlRNcF0gGoonhBfiYp3h92iZFdbObdZA4eRJJM0Y8hao5xdg4
 LmO9g8bqHbmqBlZN5P/rjr1LWOh/WkiC2d0NU4ezDOJzHll+sK02IPlTOve0kSK+
 iGBG9bEha5n1YwpczG4vDpsHt3PHvOc7e/t1pmGu45251DMey7JDRoBb/Kv+3lDn
 dpOveQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=ilHHJeKNQVAXWVIEo81s8qVuOqwIEGjlx5IhFcSzr
 dI=; b=E1wTlKwY0tfdbtQEkCLRoNAEwU7oZWChihGpop4pKKhfv9aitdbVGJp0d
 h98ZglKetOEwUphlgdpl+gS/IJKoGYjDYNIGEqeqcrvVpYcnD7kFAhYTcxRMX0kX
 YdSo3XnbwE/Ax+CvyGrAVDtT78+40Y6Vv/ArQij5YConprTe/Ll4TBQGH1sUHWn2
 nHf4A2b2+UJEt5rHA4F5V+hpD+KjEmzO6HJST9jCgAQ9P28/NE3LI8IkAFgimuio
 0kQAYRl5La1QPLkmHO70Vd7v+1RFI3CtPr88orduh2DDpWu3zypas7K29bzD5hAS
 RZtP3cOboTy5jMTAeW/CNtch8DS5Q==
X-ME-Sender: <xms:uD1vXBvC4akDp1_psdjSL1AhBwE65YngdAZ9LyyhsT9rXrE_Go8A-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdelgddujeculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdlfedtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddt
 reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucfkphepuddvvddrleelrdekvddruddtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehruhhstghurhesrhhushhsvghllhdrtggtnecuvehluhhsthgvrhfuih
 iivgeptd
X-ME-Proxy: <xmx:uD1vXI7kKli9_kB8JKhiG5pS-fejFfRzEbmRdNiGzgADtGUgLlN6yA>
 <xmx:uD1vXHhvOAfwZkA0j6S8Q9Q1LKwQ1QsO6bsEqQ5Ci6C7Y23QUXuA3g>
 <xmx:uD1vXNALRPEGpBtN_5n5e4Tbyjnq2tOsjPZ-BYwjnn2qujXQD8Uhrw>
 <xmx:uT1vXFOSh-lf-m3flFcOyjDwQ92BWgUkieMZImcl3M57nCzMpFxb1w>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id C928C1030F;
 Thu, 21 Feb 2019 19:09:25 -0500 (EST)
Message-ID: <8ef1669cdfbcc6114eebc30c610c91c191c7cc7a.camel@russell.cc>
Subject: Re: [PATCH 0/7] Kernel Userspace Protection for radix
From: Russell Currey <ruscur@russell.cc>
To: Kees Cook <keescook@chromium.org>
Date: Fri, 22 Feb 2019 11:09:22 +1100
In-Reply-To: <CAGXu5j+P1wh0uf1kfMywSTo4NYtwFPSnKXg6wbfyBRqwVRZVYA@mail.gmail.com>
References: <20190221093601.27920-1-ruscur@russell.cc>
 <CAGXu5j+P1wh0uf1kfMywSTo4NYtwFPSnKXg6wbfyBRqwVRZVYA@mail.gmail.com>
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>, Nick Piggin <npiggin@gmail.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-02-21 at 08:07 -0800, Kees Cook wrote:
> On Thu, Feb 21, 2019 at 1:36 AM Russell Currey <ruscur@russell.cc>
> wrote:
> > The first three patches of these series are from Christophe's work
> > and are
> > the bare minimum framework needed to implement the support for
> > radix.
> > 
> > In patch 3, I have removed from Christophe's patch my
> > implementation of
> > the 64-bit exception handling code, since we don't have an answer
> > for
> > making nested exceptions work yet.  This is mentioned in the final
> > KUAP
> > patch.  Regardless, this is still a significant security
> > improvement
> > and greatly narrows the attack surface.
> 
> Nice! Am I understanding correctly that with this series powerpc9 and
> later, using radix, will pass the lkdtm tests for KUAP and KUEP (i.e.
> EXEC_USERSPACE and ACCESS_USERSPACE)?

Yes!  We've had execution prevention for a while on radix (which is
default on POWER9) since 3b10d0095a1e, the only functional thing this
series does is allow disabling it with nosmep.  This series adds access
prevention.

