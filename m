Return-Path: <SRS0=jCWG=4P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF9CC4BA24
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 10:33:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DC024691
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 10:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DC024691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48SptP38t4zDqZW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 21:33:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linutronix.de
 (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Spqx00xGzDr02
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2020 21:31:38 +1100 (AEDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1j7GRn-0007Oi-T2; Thu, 27 Feb 2020 11:31:15 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id 4CE0E10409C; Thu, 27 Feb 2020 11:31:15 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: afzal mohammed <afzal.mohd.ma@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-omap@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 00/18] genirq: Remove setup_irq()
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
Date: Thu, 27 Feb 2020 11:31:15 +0100
Message-ID: <87y2somido.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Michal Marek <michal.lkml@markovi.net>,
 Nicolas Palix <nicolas.palix@imag.fr>, Gilles Muller <Gilles.Muller@lip6.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Afzal,

afzal mohammed <afzal.mohd.ma@gmail.com> writes:

> While trying to understand internals of irq handling, came across a
> thread [1] in which tglx was referring to avoid usage of setup_irq().
> Existing callers of setup_irq() reached mostly via 'init_IRQ()' &
> 'time_init()', while memory allocators are ready by 'mm_init()'.
>
> Hence instances of setup_irq() is replaced by request_irq() &
> setup_irq() (along with remove_irq()) definition deleted in the last
> patch.
>
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().

thanks a lot for tackling this!

Vs. merging this series, I suggest the following approach:

   - Resubmit the individual changes as single patches or small series
     to the relevant maintainers and subsystem mailing lists. They have
     no dependency on a core change and can be applied where they belong
     to.

   - After 5.6-rc6, verify which parts have made their way into
     linux-next and resubmit the ignored ones as a series to me along
     with the removal of the core parts.

That way we can avoid conflicting changes between subsystems and the tip
irq/core branch as much as possible.

Thanks,

        tglx
