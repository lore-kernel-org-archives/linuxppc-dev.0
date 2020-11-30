Return-Path: <SRS0=CZBu=FE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7BFC64E8A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 21:43:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F8A20857
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 21:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="flvGJ0pX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fSliX71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F8A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ClJcw5d65zDqL8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:43:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=flvGJ0pX; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=1fSliX71; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ClJZx65g6zDqcj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2020 08:41:29 +1100 (AEDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1606772483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NgAh9VYwDOpjvKBpD2kOK9tCCluKx8G046lvyTTuLAM=;
 b=flvGJ0pXm8+KoywzWh7TI7hPa+f4S8bNnctn1hTerxfblVkBvWtRmRzFNNnl1uYEtTMDWo
 BuDjZHkzhZgd8BRQ0Bga1Iskh5D+8Lmp/HSqtifCMCC9/Qi0mCjBhcqbV9zhiFZ0liDp3x
 BWh1TiP8AZgth915d7oNFSy0NLQabOvU2wVh8ZGg6i7tAccHC7PJiumKbQB6nlHCaWV+RC
 6sN9e2/MIzIZFprcTm/MGYaSqKQJYnhEk2Imc58ZIXS85u08a9rZ2ICEqadK4zuCmA+iQ2
 s5FsCttc46/wlZnNc/E4z6svCCRjJJLS0CfosU4U3hm++PkKrT05dSDeNGNsBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1606772483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NgAh9VYwDOpjvKBpD2kOK9tCCluKx8G046lvyTTuLAM=;
 b=1fSliX71lIiev+tFc4Vm9I65X+STSs/VhekX/6qU2C94l/LibCpwQml9cMFLGz5A8OkzIe
 8lcnZgcqy03lmJBA==
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v4 2/8] genirq/irqdomain: Clean legacy IRQ
 allocation
In-Reply-To: <20201124061720.86766-3-aik@ozlabs.ru>
References: <20201124061720.86766-1-aik@ozlabs.ru>
 <20201124061720.86766-3-aik@ozlabs.ru>
Date: Mon, 30 Nov 2020 22:41:22 +0100
Message-ID: <87blfeiku5.fsf@nanos.tec.linutronix.de>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-gpio@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey,

On Tue, Nov 24 2020 at 17:17, Alexey Kardashevskiy wrote:
> There are 10 users of __irq_domain_alloc_irqs() and only one - IOAPIC -
> passes realloc==true. There is no obvious reason for handling this
> specific case in the generic code.

There is also no obvious reason for _NOT_ handling it at the core code.

> This splits out __irq_domain_alloc_irqs_data() to make it clear what
> IOAPIC does and makes __irq_domain_alloc_irqs() cleaner.

That's your interpretation of cleaner.

You need to expose __irq_domain_alloc_irqs_data() for that which is a
core only functionality, so it's not cleaner. It's exposing internals
which are not to be exposed.

The right thing to do is to get rid of the legacy allocation of x86
during early_irq_init() which is possible with the recent restructuring
of the interrupt initialization code in x86. That's a cleanup which will
actually remove code and not expose internals just because.

> This should cause no behavioral change.

Should not cause is a pretty weak statement.

You're missing a nasty detail here. Contrary to the normal irqdomain
rules virq 0 _IS_ valid on x86 for historical reasons and that's not
trivial to change.

Thanks,

        tglx
