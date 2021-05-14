Return-Path: <SRS0=oOud=KJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26CCC433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 20:49:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D68613C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 20:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D68613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FhgcS6Nn2z3bsr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 06:49:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vS49ZJ9+;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GTRB7cQM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=vS49ZJ9+; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=GTRB7cQM; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fhgby4rlhz2ymQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 May 2021 06:48:46 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1621025315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmC86BwB0phopFZpwuF9hl7hTEmoyD6KcSADmydg6RA=;
 b=vS49ZJ9+hr508gMAXo+cuxJTPnLLHs4pozGVmJ6/AQdbSKLFAWxmRm8xl6QPiUUctZb2eh
 zsIM/jySP5G9Omm41aGyaryHVuNMHqwcWhYxH5ShlauQTaC8/GnyJkxWSC24jqgx9qsPRJ
 e3Y0ZHDXc+Pb42UwcPA7A+iRbeuwX16vL3Ge9pOxUuIKun80oZ1A3hNn7JZHTG3ITL4TmL
 hByJ3kP/xcPgVr2tw/qFvNXBDtN3+Q3JWpr7T4R+ZazXWpDLvrFhxOVrFARz4TvU3Z4Gc8
 i4xwYLOGLhS2npXvFh345CTa7P6/jT9M1Iu3i0SPPKJxbgdqODMUVNS1RL51oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1621025315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmC86BwB0phopFZpwuF9hl7hTEmoyD6KcSADmydg6RA=;
 b=GTRB7cQM0GVbUk8q2LAXVo6iSR+zHbp6X3l7KtXe7TpvDXkFQYX9JZUlMBVWgpfdIy/s4h
 NXSQEln9H2rfo5Cg==
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/31] powerpc/xive: Fix xive_irq_set_affinity for MSI
In-Reply-To: <20210430080407.4030767-8-clg@kaod.org>
References: <20210430080407.4030767-1-clg@kaod.org>
 <20210430080407.4030767-8-clg@kaod.org>
Date: Fri, 14 May 2021 22:48:35 +0200
Message-ID: <87pmxt2g9o.ffs@nanos.tec.linutronix.de>
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
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 30 2021 at 10:03, C=C3=A9dric Le Goater wrote:
> The MSI affinity is automanaged and it can be set before starting the
> associated IRQ.
>
> ( Should we simply remove the irqd_is_started() test ? )

If the hardware can handle it properly.

But see:

  cffb717ceb8e ("powerpc/xive: Ensure active irqd when setting affinity")

which introduced that condition. It mutters something about migration of
shutdown interrupts:

       [  123.053037264,3] XIVE[ IC 00  ] ISN 2 lead to invalid IVE !
       [   77.885859] xive: Error -6 reconfiguring irq 17
       [   77.885862] IRQ17: set affinity failed(-6).

Not that I can decode that :)

Non-managed interrupts have the sequence:

      startup()
      set_affinity()

which is historical and an earlier attempt to flip it caused havoc in
some places.

With managed we needed to make sure that the affinity is set correctly
right at start. So it needs to be done the other way round and it turned
out that for MSI this works.

I have no idea, whether that might make the above issue reappear or
not. If so, then we need some extra state to make it work.

The root cause which triggered the problem got fixed, so there should be
no issue _if_ this was specifically related to that CPU unplug case.

> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index 96737938e8e3..3485baf9ec8c 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -710,7 +710,7 @@ static int xive_irq_set_affinity(struct irq_data *d,
>  		return -EINVAL;
>=20=20
>  	/* Don't do anything if the interrupt isn't started */
> -	if (!irqd_is_started(d))
> +	if (!irqd_is_started(d) && !irqd_affinity_is_managed(d))
>  		return IRQ_SET_MASK_OK;
>=20=20
>  	/*

Thanks,

        tglx
