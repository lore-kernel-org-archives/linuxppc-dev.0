Return-Path: <SRS0=XoDG=ZE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0D4C43331
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 12:42:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E1120818
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="T71/JYX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E1120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47C6pj6WKXzDqGM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 23:42:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47C6jn71b2zF1wX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2019 23:38:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="T71/JYX7"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47C6jn2Mfzz9sP4;
 Tue, 12 Nov 2019 23:38:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1573562317;
 bh=u8PtPdFwh6LAkLykCtMHOtF4IC6sKGnHKS1uCNqFdgk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=T71/JYX7DYIoe2lbsDhSPD1fndBLi6rmHtQjFTM6k641QvTtfn3dOXvJ/Z8AhneVW
 YIrfMlJ5yjPHwRor6bIE7SQTii7K1erPk2+BG4hsU0xYZLmI4u/xp/ft4m5YOakohT
 tGTsMvY8Q4f6wkjYjUxqZTTaQhkLWNOxjqKTPyjPvs4qkiq+eEL0fqa0ZJ9QtoN3y+
 j0MvHZwmpLCI/6FbJqRhhC5EyvlKxgNDWxCUOE87OJc1BJSlZrPMfQQ8IoaI5AL19K
 H71JTjg+U+VU30hSBijuFfLmoGpAV7oQhaEpItB4eYaR3dgiocypNWVZpj8mnfCZKX
 /cndjiUgkMQ6g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 03/34 v3] powerpc: Use CONFIG_PREEMPTION
In-Reply-To: <20191024160458.vlnf3wlcyjl2ich7@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-4-bigeasy@linutronix.de>
 <156db456-af80-1f5e-6234-2e78283569b6@c-s.fr>
 <87d0ext4q3.fsf@mpe.ellerman.id.au>
 <20191024135920.cp673ivbcomu2bgy@linutronix.de>
 <20191024160458.vlnf3wlcyjl2ich7@linutronix.de>
Date: Tue, 12 Nov 2019 23:38:33 +1100
Message-ID: <874kz92rsm.fsf@mpe.ellerman.id.au>
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
Cc: Paul Mackerras <paulus@samba.org>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
>
> Switch the entry code over to use CONFIG_PREEMPTION.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +Kconfig]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v2=E2=80=A6v3: Don't mention die.c changes in the description.
> v1=E2=80=A6v2: Remove the changes to die.c.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
