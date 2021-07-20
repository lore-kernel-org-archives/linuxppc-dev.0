Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC2EC07E95
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jul 2021 10:28:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA35610D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jul 2021 10:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA35610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTZgV2tHXz3bg0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jul 2021 20:28:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rrc4HUbr;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jR9gOGNe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=rrc4HUbr; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=jR9gOGNe; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTZg10W5Hz309r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jul 2021 20:28:13 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1626776885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDwlcccV3/vrCei0Ik2QF0oAbhCHCeGSps/lbR/oXjs=;
 b=rrc4HUbrItu4keiCBFDV6/iZsLiL8usY9FbDHeI4D0I1/zy+CkNxG1g/5XN9JnUxDBX1XH
 D8nz4ERDGHLbOEIT6E/f4yGW2VHnGFKo1WLQJIxyye2fbdZwZ8qSxtslrqM9QYKkj2ffZs
 seq8Kab8uW4nWTm68L+sBOS0XdBrAuCI4uidnM8U84SNow92p0TxRnF1HSbzt3SvPAQDpr
 T2RSz05IuSv9YmY1RGtRFynXZoGZkvntuXukmueiIJlwSFCEcq4MXiMIgfckew/n+lUT62
 U33GBTeu0r4pJrD81lbua3jk0eve0oivLfdISVdOx5NP2n2Rhv/7CcYMsHYC6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1626776885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDwlcccV3/vrCei0Ik2QF0oAbhCHCeGSps/lbR/oXjs=;
 b=jR9gOGNeHOnpLDQqTwtWhDmu3e6WgD3WgKRfTXr62rFosvzmq87Ej2fos213iV2PD7DabD
 8U9PI7FVSnWR/iBg==
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: use IRQF_NO_DEBUG for IPIs
In-Reply-To: <20210719130614.195886-1-clg@kaod.org>
References: <20210719130614.195886-1-clg@kaod.org>
Date: Tue, 20 Jul 2021 12:28:05 +0200
Message-ID: <87czrde0ui.ffs@nanos.tec.linutronix.de>
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

On Mon, Jul 19 2021 at 15:06, C=C3=A9dric Le Goater wrote:
> There is no need to use the lockup detector ("noirqdebug") for IPIs.
> The ipistorm benchmark measures a ~10% improvement on high systems
> when this flag is set.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
