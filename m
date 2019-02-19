Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4030C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 04:23:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30197217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 04:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adSZE/GZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30197217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443SKP1cdtzDqJq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 15:23:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="adSZE/GZ"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443SGf6vhmzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 15:21:14 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id r14so9732786pls.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 20:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
 :message-id:content-transfer-encoding;
 bh=cfAO62Dg2t4JUibAXiVZf0PvpT4+VoIQZqy1eyuLdgc=;
 b=adSZE/GZtmJ/RRGM5ZQnEp5vqA4bCHg0RqOAahg7EYCpu3Y/Q46sBmvSWYCpzNdgW3
 XHue01Esm/63JJWMfPCH0gpzr6NOJi35Ll4KIDwTukvtpqjvns2VqpyHdxAqCtStLtRn
 L4ORWu+7jIPmdapcb+Dm/8+xK3QkQLOHBmv+vnq6dTvLnx3UG0/KZx0jZ+1sZZ0RGL14
 eE6Jcxov2WdkX38OH/d63uk95ELDpUieQjOTzFKH0ZMdMGrjtQ2zp7WW5OjIrJCeKePJ
 Fmywqa660k2qXDPfnlQipBN4PwgjcRMonULwjHSF1JjIrMx+K1kRBw0YuMgOtPs18gf5
 C77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=cfAO62Dg2t4JUibAXiVZf0PvpT4+VoIQZqy1eyuLdgc=;
 b=aY5kppmDlSXmLae5n2scJ8dmS0fd2bdVvOrm6CJeBW/poyuINymfF3YnmSzjyzheYb
 hPVfhxociPk9lome3875AdeowGMrDLSOidvrFQ6kDIRF3FPBnJV9H1Ej1HaoqUIXHHEz
 whQwqh9TxpUwktg1XfQpV0t51Qbx5TJoWQxupKDeDXB2NJfVWN4e0m5QiEV1pcZj1UwD
 9pjXqEzYA0EmXkGfZI745xJKG0qqXlik1rYz0lALNf4cHTwcZ9Y+1XSpWFMejnH8aL8S
 tL3v/pgtR2B8XcgFzivC5srkQUi0FnYMWKbS4/YDEpyABGawUd8b3f+OJBzJsue+MV7d
 /wrg==
X-Gm-Message-State: AHQUAuaxYBpt2qjWL+Xh3t+MeK+JwNNQDyNTDXwBSBLceYyLfgGv93hi
 5P9A/6+DDZE7iEmqc9C5kRze/MWdT7Y=
X-Google-Smtp-Source: AHgI3IY+yMmMeu1bhnR+xgmeRxEepvulXMRgzpzXSKTSK6ilI2wdqhG0To0VnGj5egDcedeP1/Y9xg==
X-Received: by 2002:a17:902:5a8d:: with SMTP id
 r13mr28882453pli.190.1550550070645; 
 Mon, 18 Feb 2019 20:21:10 -0800 (PST)
Received: from localhost ([61.69.157.156])
 by smtp.gmail.com with ESMTPSA id l22sm24213043pfj.179.2019.02.18.20.21.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 20:21:10 -0800 (PST)
Date: Tue, 19 Feb 2019 14:21:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Russell Currey <ruscur@russell.cc>
References: <20190206062837.26917-1-ruscur@russell.cc>
 <1549515373.con208q1rq.astroid@bobo.none>
 <87o97njdjg.fsf@concordia.ellerman.id.au>
In-Reply-To: <87o97njdjg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550549702.xfczazszdw.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on February 8, 2019 11:04 am:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Russell Currey's on February 6, 2019 4:28 pm:
>>> Without restoring the IAMR after idle, execution prevention on POWER9
>>> with Radix MMU is overwritten and the kernel can freely execute userspa=
ce without
>>> faulting.
>>>=20
>>> This is necessary when returning from any stop state that modifies user
>>> state, as well as hypervisor state.
>>>=20
>>> To test how this fails without this patch, load the lkdtm driver and
>>> do the following:
>>>=20
>>>    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
>>>=20
>>> which won't fault, then boot the kernel with powersave=3Doff, where it
>>> will fault.  Applying this patch will fix this.
>>>=20
>>> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of use=
r
>>> space")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>>
>> Good catch and debugging. This really should be a quirk, we don't want=20
>> to have to restore this thing on a thread switch.
>=20
> I'm not sure I follow. We don't context switch it on Radix, but we do
> on hash if pkeys are enabled.

Badly worded, I mean a hardware quirk. It should follow thread
switches. Still, avoiding it for the no-loss case is better than
nothing. We can just revisit it as an optimization if future
hardware does not require the restore.

>> Can we put it under a CONFIG option if we're not using IAMR?
>=20
> We'll always be using it with Radix, and we might be using it for pkeys
> on hash, unless pkeys are compiled out. But I don't really expect anyone
> to be running with pkeys compiled out.
>=20
> So I think the only case we could optimise is that we're on hash and the
> current thread has an IAMR of 0, then we could just not restore
> (assuming we come out of idle with IAMR=3D0).
>=20
> But maybe I'm not understanding.

Nah it sounds like more trouble than it's worth in that case.

Thanks,
Nick
=
