Return-Path: <SRS0=ETne=BY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E1C433E3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2020 13:16:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7F820866
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2020 13:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KPM90R4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7F820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BSkVM75hqzDqfX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2020 23:16:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BSkQk5RsmzDqh3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2020 23:13:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=KPM90R4M; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BSkQk0rwKz9sTH;
 Fri, 14 Aug 2020 23:13:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1597410814;
 bh=l2FbenAMKVjMAVcoLFTwflI2LhsdwmWtUuHyxCio1WU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KPM90R4MMSJhhOCKn2bYca1bAfFpBj6aQodZfVKWXtdHY2PqnXOUJcS10UGZqepUd
 c76m7m92I5CHPTkKIb0pVjqu7zPTzSE2LySOCygljsOPMjvVct42Uv9sOLbNXHXu8M
 VvemUk1a7Z/mwgq/QktxYq5+6/SJW4x0gQ/AT3hRNQuyEb0zcOY5RgVb0H/wR8E0gg
 DsL+Wi5PUjbLEi759wR8GB6ODwx6mNMbDQ2mg2aMDv69APqgOXkPJCSivOM17L7u+Y
 S9CaXIz07Yc4rs72g6pVR4CLzsD2DIlDjNigfUnuhk3rEp6Tn6gGtYNwyGhYmTMLaX
 zr1+p3dUlw2cQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Subject: Re: [PATCH] kernel/watchdog: fix warning -Wunused-variable for
 watchdog_allowed_mask in ppc64
In-Reply-To: <20200814043951.199192-1-bala24@linux.ibm.com>
References: <20200814043951.199192-1-bala24@linux.ibm.com>
Date: Fri, 14 Aug 2020 23:13:33 +1000
Message-ID: <87a6yx9xqa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, sandipan@linux.ibm.com,
 Balamuruhan S <bala24@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Balamuruhan S <bala24@linux.ibm.com> writes:
> In ppc64 config if `CONFIG_SOFTLOCKUP_DETECTOR` is not set then it
> warns for unused declaration of `watchdog_allowed_mask` while building,
> move the declaration inside ifdef later in the code.
>
> ```
> kernel/watchdog.c:47:23: warning: =E2=80=98watchdog_allowed_mask=E2=80=99=
 defined but not used [-Wunused-variable]
>  static struct cpumask watchdog_allowed_mask __read_mostly;
> ```
>
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  kernel/watchdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't maintain that file.

Please resend and Cc it to:

$ ./scripts/get_maintainer.pl -f kernel/watchdog.c
tglx@linutronix.de
peterz@infradead.org
Jisheng.Zhang@synaptics.com
rdna@fb.com
viro@zeniv.linux.org.uk
gpiccoli@canonical.com
pmladek@suse.com
linux-kernel@vger.kernel.org


cheers
