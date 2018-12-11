Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B49C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 05:26:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2409720811
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 05:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aP+PP6Ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2409720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DT2Z3ddszDqyP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 16:26:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="aP+PP6Ej";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out1-smtp.messagingengine.com (client-ip=66.111.4.25;
 helo=out1-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="aP+PP6Ej"; dkim-atps=neutral
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DSzp40lmzDqwt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 16:24:22 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 9260C21AFB;
 Tue, 11 Dec 2018 00:24:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Dec 2018 00:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=pMxm48d9UHOSlbEZYv6rkEmhC3bI8rIFomvnflUbk
 l4=; b=aP+PP6EjbmmeRsntvCr4m0DaMmsrtX39zSUPFEYkQOFJMkx4jlZhpuluy
 RCeXPNE7Kl8ldG+uLXBFGJAUga9dYMh8owI+3+MY6+B9cWhGNCLfL3d6TSw/Gih4
 o34I8XwZn00w2c570fjn0kh2qE9g1ZNFUgE7TpXxu27NGz6zHSO1SPCuTRXIsmyc
 u67fTYYFII/mAu5TUSt7EQiM0M4nZnYMO9ZItaQln6yXiTEQliFPbtNurH8w8I2z
 2aZv0B86mQqSxl8cJVDukwuGr8nd1TwiVl1OtWXYptnDd6ibTI+HnMrWRkCPX885
 N5EFsCn/wPT01G4+ADEPtWsw6WZSQ==
X-ME-Sender: <xms:AkoPXA4F4FZiiJhe-uoi_1NY5m1DYR3gmVx10-jf0YoGVMFy7XDFIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudegiedgkeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
 tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdeftd
 dmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhu
 shhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukf
 hppeduvddvrdelledrkedvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgt
 uhhrsehruhhsshgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:AkoPXJZ3Mv8z812JtnvmQeWn5HXoFmy-V1iCFE-u4BN4iC9h8i3NwQ>
 <xmx:AkoPXA1l12Mx2W95ZuXxnVkP72MHAzUcjtPEIznohOLLYPTEQbCwlw>
 <xmx:AkoPXMqwgj7HRx9UDyQYgVthHE_WOYDZE7aaVWcv37dmfYcK9YzhNQ>
 <xmx:AkoPXPOofqbL7kbUOUdxqbBSFAbRKR7-HopiOwU17XjmNPDAiiCiQw>
 <xmx:AkoPXFp6Yp1ZJCLZ3Ne2uT_jDJmXxCuIKgl72INGWDvta298m6xptQ>
 <xmx:A0oPXLuF1ZHQk87iRwqWSFnWhSro6hkdKfWohWbZxzlbumj25IQeVA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id A017EE450E;
 Tue, 11 Dec 2018 00:24:15 -0500 (EST)
Message-ID: <a6dbd5284d8700d591614481fda242a25ca5a3b5.camel@russell.cc>
Subject: Re: [RFC PATCH v2 11/11] powerpc/book3s32: Implement Kernel
 Userspace Access Protection
From: Russell Currey <ruscur@russell.cc>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Tue, 11 Dec 2018 16:25:07 +1100
In-Reply-To: <98e37def51328f58d8c2ceb60edd4b3da7b6f2ef.1543356926.git.christophe.leroy@c-s.fr>
References: <76d777b36e54e7b8d4c196405decc712fc5eaf45.1543356926.git.christophe.leroy@c-s.fr>
 <98e37def51328f58d8c2ceb60edd4b3da7b6f2ef.1543356926.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-28 at 09:27 +0000, Christophe Leroy wrote:
> This patch implements Kernel Userspace Access Protection for
> book3s/32.
> 
> Due to limitations of the processor page protection capabilities,
> the protection is only against writing. read protection cannot be
> achieved using page protection.
> 
> In order to provide the protection, Ku and Ks keys are modified in
> Userspace Segment registers, and different PP bits are used to:
> 
> PP01 provides RW for Key 0 and RO for Key 1
> PP10 provides RW for all
> PP11 provides RO for all
> 
> Today PP10 is used for RW pages and PP11 for RO pages. This patch
> modifies page protection to PP01 for RW pages.
> 
> Then segment registers are set to Ku 0 and Ks 1. When kernel needs
> to write to RW pages, the associated segment register is changed to
> Ks 0 in order to allow write access to the kernel.
> 
> In order to avoid having the read all segment registers when
> locking/unlocking the access, some data is kept in the thread_struct
> and saved on stack on exceptions. The field identifies both the
> first unlocked segment and the first segment following the last
> unlocked one. When no segment is unlocked, it contains value 0.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Hey Christophe, I tried to test this and got a machine check after the
kernel starts init.

Vector: 700 (Program Check) at [ef0b5e70]
    pc: 00000ca4
    lr: b7e1a030
    sp: ef0b5f30
   msr: 81002
  current = 0xef0b8000
    pid   = 1, comm = init

Testing with mac99 model in qemu.

- Russell

