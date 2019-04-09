Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F7BC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 09:27:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E6620833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 09:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vmf0guPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E6620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dhlV1qVzzDqKV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 19:27:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vmf0guPk"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dhhy5SbszDqDh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 19:25:22 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id b3so9037227plr.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=qxOhzi1ZEIhvrmj/15WniZAK1KyM/shH2T7Z+8Zwyl8=;
 b=Vmf0guPk9b5ooG/AS3Fu2jCHxzfxR1Rx4nI5wTvxgH+xZr+zvteMWvoz32ue4sh2e2
 cCZ4mtrljWxn3oVydboxoKnDmOKKZOMo0uWsdvSbUNMTu4YY5/Skv5bjMyfCV5qPR23w
 /0aWSY0gHsMoX4AHw4vUxFcsQxuS/w1XE92cxNRW/BQkYZVHyGonlIi2qU2sfSX9mQC/
 R7r38ZzlqSi0rz7iTnIBt6mIjN17W4dk6YnSXN4a3dMySJu1c+NhTXy3HhYL0mkB4vHt
 jWNfMz6dQgRmNV9fHpdUZmiIWmAhBtw4zVXEwDjbP6RHUOMs8Akp1e/fbyg1YCNv8RGj
 OQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=qxOhzi1ZEIhvrmj/15WniZAK1KyM/shH2T7Z+8Zwyl8=;
 b=ImVMfhz+B3vTxnNmT9bw128JDOSfU9lnOL4moSCZU1/g6uE3VIVv+5F3denAX31fN1
 HLxrBTp5tH2s5QWSnuLS8e2v7sfGmsdlV/Osw8qQmwTuSQEF6FdxsEFwe4lr7hjsLUL2
 gxiKSkGW2ZXzo27guuVj0LFe/yGPleM3v/20RLPWdByyQVD9UlHZpREPKmCln2QzUJS5
 ncgR4+9HkS1Wxh448vJ8TlI7RZBQS1C/hNQH1BeuMhI5otgoprX1F9UvpOYbAMsGukv3
 i9NE6ccxitoXpRZaPnmcd2leGC0vXc/K+1yj6hYg9C3Ndl1EH59Sox/27Mr+rxV3yTQG
 XDog==
X-Gm-Message-State: APjAAAVrbK281Ul3mq6s/TLFHPtCEbi0OHxmtwwGU5CmwP6CHxVt7fre
 kVNA275lZeyj+AM2O9dybwg=
X-Google-Smtp-Source: APXvYqz7AEfERpuIG2oL7F9wHTOwWSOU4zWkrenGVH/u+m2ZuI30qRs1iOCyau6sI9ciBZTYkubn8Q==
X-Received: by 2002:a17:902:f81:: with SMTP id
 1mr36361161plz.216.1554801919573; 
 Tue, 09 Apr 2019 02:25:19 -0700 (PDT)
Received: from localhost ([58.84.79.14])
 by smtp.gmail.com with ESMTPSA id y19sm44426329pfn.164.2019.04.09.02.25.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Apr 2019 02:25:18 -0700 (PDT)
Date: Tue, 09 Apr 2019 19:25:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
To: Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
 <1553836851.2264.2.camel@gmail.com>
 <1553850306.nyv11r9iej.astroid@bobo.none>
 <20190329113109.3a9bd24e@gandalf.local.home>
 <1553912871.ce5mzizoek.astroid@bobo.none>
 <20190401083827.GE11158@hirez.programming.kicks-ass.net>
 <20190406000611.GA27782@lenoir>
In-Reply-To: <20190406000611.GA27782@lenoir>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554801792.ruzup3dxhe.astroid@bobo.none>
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@samba.org>,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Frederic Weisbecker <fweisbec@gmail.com>, qemu-ppc@nongnu.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 David? Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Frederic Weisbecker's on April 6, 2019 10:06 am:
> On Mon, Apr 01, 2019 at 10:38:27AM +0200, Peter Zijlstra wrote:
>>=20
>> + fweisbec, who did the remote bits
>>=20
>> On Sat, Mar 30, 2019 at 01:10:28PM +1000, Nicholas Piggin wrote:
>> > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
>> > index 6b7cdf17ccf8..f0e539d0f879 100644
>> > --- a/kernel/irq_work.c
>> > +++ b/kernel/irq_work.c
>> > -/* Enqueue the irq work @work on the current CPU */
>> > -bool irq_work_queue(struct irq_work *work)
>> > +/*
>> > + * Enqueue the irq_work @work on @cpu unless it's already pending
>> > + * somewhere.
>> > + *
>> > + * Can be re-enqueued while the callback is still in progress.
>> > + */
>> > +bool irq_work_queue_on(struct irq_work *work, int cpu)
>> >  {
>> > +#ifndef CONFIG_SMP
>> > +	return irq_work_queue(work);
>> > +
>=20
> I'd suggest to use "if (!IS_ENABLED(CONFIG_SMP))" here to avoid the large
> ifdeffery.

Sadly you can't do it because arch_send_call_function_single_ipi is
not defined for !SMP. I made your suggested name change though (with
the __ prefix because work needs to be claimed and preempt disabled).

Thanks,
Nick
=
