Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D1C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:05:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021E42082E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2xTyXps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021E42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZnpV4W8tzDqRv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:05:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2xTyXps"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Znms02FwzDqM7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 03:03:40 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id g12so1381224pll.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=Vay5OayZgjsq0sa6Vy7Pa4NgOoLhnLYhnjVWa0vxXwQ=;
 b=Y2xTyXpshL+m78e8pKV19ar6HEpKv2vy8O1ny60dQ5JTWeRqyRLKDDg+7++z26MTMY
 Ph6sTotedd5AErWPBL1dDH4e2/WjgoWCGJX424aa2zDp20TOsNcdIE9Rzs5vcQetENaz
 CaGcEb8Kv56nj7q2GgByRtSNwYh5owl9qcPtHgUpI5CF2Z9i63kRCEATGB4JlSxEkvkU
 r72J6lAaib3jgjd9lujmUSIsVJY/OKa+SNV5yb71NrgFnNqfTZfzan5Mrj5l7VW9ISCI
 AP/j4cwpzZXstYtyFXp40+NzkF4hsCfM02NTo2QHdF2knctziDsU4snEDoRP7RxCjXZV
 9eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=Vay5OayZgjsq0sa6Vy7Pa4NgOoLhnLYhnjVWa0vxXwQ=;
 b=MeVzxr26h2tmiJc+zdiuI83DVIIBAXAqzuGLvb+r6FsIrL6tHEqmqWvpSE36dBEQQ5
 RjwxIpRKyuK631/0/C/hDTR9ssrbeyNIL8V7+TaBhMH/GPHA0Ca9JMimFOdqUIMroiE3
 uyjy/iJpxpMJpHXhJ5/JJwMTGsXHmtTK64p+My5GyQwooBGcjAuuCIFw8OlUAO5iLhoA
 n7KIx6Z8sVWo4RV+B0kBnvuoaoIvgmjEfpzNDQNfnwThX+5uQARE9LSb7yjsW84wjEME
 ZIjOd2TVhlsnwEuoVlKas2mCdRGUWbaeoXDZ54ZFBx82Kcg3Nzyqw180VlD51WU+TNWo
 AMZg==
X-Gm-Message-State: APjAAAXNvETOU8Gqpxw5urRDOl7CCDHtmyxPHZjombBqIfYYoypwpMQS
 8NE5+a7KWUg31TRfeAuCyxbMAWfx
X-Google-Smtp-Source: APXvYqz8iq6mKNrazdpLPcrzI6qnmgcztaOBt37YmMkvGFG3WJQtS3PCve0H8fr3C5kJJXq3Pj6Jzw==
X-Received: by 2002:a17:902:2e01:: with SMTP id
 q1mr7151702plb.253.1554393817548; 
 Thu, 04 Apr 2019 09:03:37 -0700 (PDT)
Received: from localhost (193-116-89-42.tpgi.com.au. [193.116.89.42])
 by smtp.gmail.com with ESMTPSA id i2sm28560144pfo.9.2019.04.04.09.03.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 Apr 2019 09:03:36 -0700 (PDT)
Date: Fri, 05 Apr 2019 02:03:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/watchdog: Use hrtimers for per-CPU heartbeat
To: ego@linux.vnet.ibm.com
References: <20190402112521.24888-1-npiggin@gmail.com>
 <CAHZ_5WzckrKg=D+joA_JJU0riObA4bb7oQj-bfBNna5y22wQ+Q@mail.gmail.com>
In-Reply-To: <CAHZ_5WzckrKg=D+joA_JJU0riObA4bb7oQj-bfBNna5y22wQ+Q@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1554393782.55llyo2nxz.astroid@bobo.none>
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
Cc: Ravikumar Bangoria <ravi.bangoria@in.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Gautham R Shenoy's on April 4, 2019 9:19 pm:
> Hello Nicholas,
>=20
> On Tue, Apr 2, 2019 at 4:57 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Using a jiffies timer creates a dependency on the tick_do_timer_cpu
>> incrementing jiffies. If that CPU has locked up and jiffies is not
>> incrementing, the watchdog heartbeat timer for all CPUs stops and
>> creates false positives and confusing warnings on local CPUs, and
>> also causes the SMP detector to stop, so the root cause is never
>> detected.
>>
>> Fix this by using hrtimer based timers for the watchdog heartbeat,
>> like the generic kernel hardlockup detector.
>>
>> Reported-by: Ravikumar Bangoria <ravi.bangoria@in.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> [..snip..]
>=20
>> @@ -325,19 +325,21 @@ EXPORT_SYMBOL(arch_touch_nmi_watchdog);
>>
>>  static void start_watchdog_timer_on(unsigned int cpu)
>>  {
>> -       struct timer_list *t =3D per_cpu_ptr(&wd_timer, cpu);
>> +       struct hrtimer *hrtimer =3D this_cpu_ptr(&wd_hrtimer);
>=20
> This function can be called during the initialization via
>=20
> watchdog_nmi_start -->
>     for_each_online_cpu(cpu)
>            start_wd_on_cpu(cpu) -->
>                    start_watchdog_timer_on(cpu)
>=20
> Thus, it is not guarateed that we are always calling
> start_watchdog_timer_on() from the CPU where
> we want to start the watchdog timer.
>=20
> Thus, should we be calling this function from start_wd_on_cpu() via an
> smp_call_function_single() ?

Good catch, yes I think we need that change (like kernel/watchdog.c).

I'll resend.

Thanks,
Nick
=
