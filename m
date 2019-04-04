Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A6EC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:27:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648EC206BA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLD5rm6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648EC206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZpJD5f7xzDqRr
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLD5rm6c"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZpGS5zSbzDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 03:25:52 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id i17so1623584pfo.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=uc9V3le3mRTcZrPZmuf/Y3kRDqWJtHjwYuOs72bchn0=;
 b=ZLD5rm6cz8t6yhV53AOB4znGQHwUYPiGeoxs4dffFD+wVg7OGZR6dyDt1Csv0UBVSh
 L5QDUgk7z+x5huUQknsamlz4Lb+FI/a+d5cWqlbvkF214SkDrpEFPgLFhZZbdL+JXuyD
 MJUmjSkBp0GaGvBtmz4ANCVPz41nMbbE3tqN0j54LW6NDZkVJkFJsiRFsXkLTpQR8QLo
 VcX3wsWREM8nH/8Rg9Olqf+cFf6yj/68yk4B7+2+VdHHyI57l51w5/tVTFmv7oosZLz2
 v44oj6Dgv2nmCnUZJElyI9A9dtNARhXlYAc0Tx0J2RswX9z9zc7O2IUYFb1MNcGHRQVa
 woVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=uc9V3le3mRTcZrPZmuf/Y3kRDqWJtHjwYuOs72bchn0=;
 b=nd9BeBKpcoTrB2RLQgiBL3N7Lvtb80MIsoagx9/Qy/OiiQALskL9F51P2O7DE+FaJk
 0HtWCZEax1IuY6JG/2yRyD/8ViPInWQep+gWAFN3ENcZm4lSaZBrt02ah/onzS8hbDWF
 FgoyN2b5kqiKPj/FLbAUG6RuvSJdPE2D3ov6EtA4cWEpKh6p53ZIPynC4okJourih3Fe
 rqAw4TYSGLIDrKUx+FrawROH2L8H6hr+uvcnD8uMjFCfYegttl0GN1UM7sfs9/pfB8Co
 YX3TEAu209G3CPTbBO58W9Q5jH5FuLcbo7PPLFkKIBH8tQfgvW41zab196/BacTtG7MU
 CJZg==
X-Gm-Message-State: APjAAAXlS9m3ESBbSbXhqYT3Lv4ECwHRGxNQRbaLAwIxq+YHDfbOZARI
 0sAARFWrfB9QoRQn2sqDvFI=
X-Google-Smtp-Source: APXvYqw6xHze9qs+1TzYvTw4anOYiNFfqlUS9pwpXlz1TXg3ld5Sr43z9JvlD0XMmXJSYIo2YU5mvA==
X-Received: by 2002:a63:945:: with SMTP id 66mr6498542pgj.128.1554395150792;
 Thu, 04 Apr 2019 09:25:50 -0700 (PDT)
Received: from localhost (193-116-89-42.tpgi.com.au. [193.116.89.42])
 by smtp.gmail.com with ESMTPSA id g67sm30154901pfg.94.2019.04.04.09.25.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 Apr 2019 09:25:49 -0700 (PDT)
Date: Fri, 05 Apr 2019 02:25:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Qemu-ppc] pseries on qemu-system-ppc64le crashes in
 doorbell_core_ipi()
To: Peter Zijlstra <peterz@infradead.org>
References: <20190327123615.rwhk6h3ayfurvapf@linutronix.de>
 <7d97f3c6-4614-ead7-179a-e7e223ea3997@kaod.org>
 <2bbc1490-400d-585e-d74b-924c570b4236@kaod.org>
 <1553836851.2264.2.camel@gmail.com>
 <1553850306.nyv11r9iej.astroid@bobo.none>
 <20190329113109.3a9bd24e@gandalf.local.home>
 <1553912871.ce5mzizoek.astroid@bobo.none>
 <20190401083827.GE11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190401083827.GE11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554395089.85h590cqg5.astroid@bobo.none>
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

Peter Zijlstra's on April 1, 2019 6:38 pm:
>=20
> + fweisbec, who did the remote bits
>=20
> On Sat, Mar 30, 2019 at 01:10:28PM +1000, Nicholas Piggin wrote:
>> Something like this?
>>=20
>> kernel/irq_work: Do not raise an IPI when queueing work on the local CPU
>>=20
>> The QEMU powerpc/pseries machine model was not expecting a self-IPI,
>> and it may be a bit surprising thing to do, so have irq_work_queue_on
>> do local queueing when target is current CPU.
>=20
> This seems OK to me.
>=20
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for taking a look.

Sebastian, are you able to test if this patch solves your problem?

Thanks,
Nick

=
