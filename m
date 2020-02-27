Return-Path: <SRS0=jCWG=4P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B63CC3F2C2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 22:08:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C324C24677
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 22:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pQakjTO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C324C24677
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48T6JM2bmnzDr7Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 09:08:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48T6GH15CWzDqvD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2020 09:07:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=pQakjTO9; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48T6GF6kFZz9sPk;
 Fri, 28 Feb 2020 09:07:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1582841222;
 bh=UPdHkhQ2wE3MV+Rb8y/DrIlO42XJmnPWVNFsHh/Jdgc=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=pQakjTO9dtScDc23cMzK3fbXIPrmBimHJNZANPYt3oMnzl3wX/p06Nv2WjGihUONs
 TIJ7XAU71DA6m0Zrrdm7Xi1Ibqi98u/U5+9zRgGSGc1ugpY0QvgUy26QOJt619xT5T
 D7ruYs6OFkKXFhimAUbI0sIXMV+xJyY9f2qB6DDrYIfc7/z5RZVONmQUMSvtdQPc58
 xWGVFw+9EUDxvZhz2ZHarijIMfDQZDd5ofdjSMoR0tBt7AhDPOFmjiaH3jNZwn30xX
 n2xPpaWSoUblR/fwK7othw/9aO8+f36kSe9pRIv+zJINWg3b7DbKm5aHC8fvi9edcW
 +tUvvjLkPwPtQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Bug 206203] kmemleak reports various leaks in
 drivers/of/unittest.c
In-Reply-To: <bug-206203-206035-Iux2rayMYJ@https.bugzilla.kernel.org/>
References: <bug-206203-206035@https.bugzilla.kernel.org/>
 <bug-206203-206035-Iux2rayMYJ@https.bugzilla.kernel.org/>
Date: Fri, 28 Feb 2020 09:06:57 +1100
Message-ID: <87sgiv1y7y.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

bugzilla-daemon@bugzilla.kernel.org writes:
> https://bugzilla.kernel.org/show_bug.cgi?id=206203
>
> --- Comment #3 from Erhard F. (erhard_f@mailbox.org) ---
> Created attachment 287671
>   --> https://bugzilla.kernel.org/attachment.cgi?id=287671&action=edit
> kmemleak output (kernel 5.6-rc3, PowerMac G5 11,2)
>
> Same on a PowerMac G5 11,2 (kernel 5.6-rc3).

Can you attach the /sys/kernel/debug/kmemleak output please.

cheers
