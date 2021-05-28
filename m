Return-Path: <SRS0=g7Ik=KX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ABEC4708C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 23:40:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F206135F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 23:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F206135F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FsLlR0kkrz2ydJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 May 2021 09:40:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=lMY337Ra;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=lMY337Ra; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FsLkv4Wl7z2yQy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 May 2021 09:39:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FsLks4rdfz9sSn;
 Sat, 29 May 2021 09:39:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1622245190;
 bh=tCKfRdDsHRARNYe1niE/9INPTKn1Q+R+8330bDDbE0A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lMY337RaBX/Wyy8otO+T2xi7D/Y90wwB9f11kCOgZslKBJSguGARNynBCX576pkaA
 ZMLCFBBHlGhIquU5X9pAGtVNdh4hY9+WoVR4hEaFKeGGajZ38TBsrVmTOzDQlUAhnq
 0Teg3sVLepYGTEgLtoZsh+7ZEwGO8C3/l6pbVY64/nLomnx43wJCeDbpQbbwXJKdTy
 SFyjVM7HlOpzTGL0juRJS0mcX0rxalBj56fZDN/MpJYwNWNHPfXSg/MmDnOwZboq17
 j6LBfzROw9s4UuCZJPWW+6ITcY7EAwRs9wu5YkDGF7+WXHrERUMOTqp66bT5+7elRx
 4cU0qTR4x6AFw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Roman Bolshakov <r.bolshakov@yadro.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Revert "powerpc: Switch to relative jump labels"
In-Reply-To: <20210528012943.23192-1-r.bolshakov@yadro.com>
References: <20210528012943.23192-1-r.bolshakov@yadro.com>
Date: Sat, 29 May 2021 09:39:49 +1000
Message-ID: <87pmxah1h6.fsf@mpe.ellerman.id.au>
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 Anastasia Kovaleva <a.kovaleva@yadro.com>, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Roman Bolshakov <r.bolshakov@yadro.com> writes:
> This reverts commit b0b3b2c78ec075cec4721986a95abbbac8c3da4f.
>
> Otherwise, direct kernel boot with initramfs no longer works in QEMU.
> It's broken in some bizarre way because a valid initramfs is not
> recognized anymore:
>
>   Found initrd at 0xc000000001f70000:0xc000000003d61d64
>   rootfs image is not initramfs (XZ-compressed data is corrupt); looks like an initrd
>
> The issue is observed on v5.13-rc3 if the kernel is built with
> defconfig, GCC 7.5.0 and GNU ld 2.32.0.

Are you able to try a different compiler?

I test booting qemu constantly, but I don't use GCC 7.5.

I assume your initramfs is compressed with XZ? How large is it
compressed?

And what qemu version are you using?

cheers

