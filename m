Return-Path: <SRS0=TRtS=2J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA38C43603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 11:22:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF1021D7D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 11:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qQeqjrQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF1021D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47dqGt4ypPzDqpJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 22:22:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=zx2c4.com (client-ip=192.95.5.64; helo=frisell.zx2c4.com;
 envelope-from=jason@zx2c4.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.b="qQeqjrQx"; 
 dkim-atps=neutral
Received: from frisell.zx2c4.com (frisell.zx2c4.com [192.95.5.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47dqCR0PcyzDqnv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2019 22:19:30 +1100 (AEDT)
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c7705612
 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 19 Dec 2019 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
 :references:in-reply-to:from:date:message-id:subject:to:cc
 :content-type:content-transfer-encoding; s=mail; bh=ZLcPlxeDACDJ
 3NSVftXM+/GXSTo=; b=qQeqjrQxQPmACLnzB9Y6MT8SrVAvXuw2661N5aeATtXA
 9HIP48nQStRNkVBcOe3KO6rO4McSDahHQlCBRiwypCICI1M+XCjHnHv6xMUzpw7J
 MP0KHUtNgkQC1EHODMNaQw45f7X8FEhHiYAg7fzuRN9mYreTZjPbgffelTC3pOIc
 /YssrmBkRZC5BqAjFyN42+YOpA6O5aABylkgYQVZSKlR8fHTewxVdQHVI1JwPNdr
 p3db7ZcS23a0EHpHzZOZcEeNuZtc5jVqSTbxEzazeUhRuWo4UQPdq2N0GWPU3TEL
 AiSbvsmIvfF/wL/2aodIZT9PuCxy+a4LDr3dla36iw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d10fae86
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 19 Dec 2019 10:22:45 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id v10so2484754oiv.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2019 03:19:26 -0800 (PST)
X-Gm-Message-State: APjAAAWOkQ7cA7I84kXLDv+ZdA8v0II6sjAZUxdrIQsIVBLlAKASzisV
 Sr5y4zmM08jbZub1XbHW7LRdpkzXCGiqwYrkfNk=
X-Google-Smtp-Source: APXvYqz8/QyrEN3iOAi2SzhrkeCtYOYZFq7ZJm1SOJeff08UgnFPX2WkB9jjwWr3roQCz3s+4y6Dw/4W0OPoR2yTKM4=
X-Received: by 2002:aca:2109:: with SMTP id 9mr1774231oiz.119.1576754365615;
 Thu, 19 Dec 2019 03:19:25 -0800 (PST)
MIME-Version: 1.0
References: <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
 <1553836851.2264.2.camel@gmail.com>
 <1553850306.nyv11r9iej.astroid@bobo.none>
 <20190329113109.3a9bd24e@gandalf.local.home>
 <1553912871.ce5mzizoek.astroid@bobo.none>
 <20190401083827.GE11158@hirez.programming.kicks-ass.net>
 <20190406000611.GA27782@lenoir> <1554801792.ruzup3dxhe.astroid@bobo.none>
 <7a5b63a0-2bf5-60bb-8678-b7b36671a29c@zx2c4.com>
 <20191219111319.hes3fhpqpvn7nklg@linutronix.de>
In-Reply-To: <20191219111319.hes3fhpqpvn7nklg@linutronix.de>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 19 Dec 2019 12:19:14 +0100
X-Gmail-Original-Message-ID: <CAHmME9op=JQoRwwpZMoN9HxkEoMyAMkw2ybfQV0F48OQEAc5KQ@mail.gmail.com>
Message-ID: <CAHmME9op=JQoRwwpZMoN9HxkEoMyAMkw2ybfQV0F48OQEAc5KQ@mail.gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 David? Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 19, 2019 at 12:13 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Based on my understanding is that the doorbell feature is part of the
> architecture. It can be used to signal other siblings on the same CPU.
> qemu TCG doesn't support that and does not allow to announce multiple
> siblings on the same CPU. However, the kernel uses this interface if it
> tries to send an interrupt to itself (the same CPU) so everything
> matches.
> Last time I run into this, the interface was change so the kernel das
> not send an IPI to itself. This changed now for another function=E2=80=A6

One way of fixing this is to just "not use the feature", as you seem
to be suggesting.

But actually shouldn't there be some CPU feature detection available?
Something like -- QEMU advertises to the kernel that it supports or
doesn't support doorbells, and the kernel then avoids those paths if
the CPU feature flag isn't present?

Jason
