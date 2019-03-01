Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929E4C10F03
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:35:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C022084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=email.cz header.i=@email.cz header.b="CO+ugOi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C022084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=email.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449r5Y4rJlzDqC5
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 00:35:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=email.cz
 (client-ip=2a02:598:a::78:89; helo=mxb1.seznam.cz;
 envelope-from=jaydee@email.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=email.cz header.i=@email.cz header.b="CO+ugOi7"; 
 dkim-atps=neutral
Received: from mxb1.seznam.cz (mxb1.seznam.cz [IPv6:2a02:598:a::78:89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449r3Z3C4QzDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 00:33:43 +1100 (AEDT)
Received: from email.seznam.cz
 by email-smtpc15b.ko.seznam.cz (email-smtpc15b.ko.seznam.cz [10.53.14.195])
 id 6777e634631f128167f92c75; Fri, 01 Mar 2019 14:33:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=beta;
 t=1551447215; bh=nNxbQNky3zm1DEvMd4h1GLNAs+bQv+ueMQS1aM/+bHo=;
 h=Received:From:To:Subject:Date:Message-Id:References:Mime-Version:
 X-Mailer:Content-Type:Content-Transfer-Encoding;
 b=CO+ugOi7alSYdXzc6eEL+pEoldpZiY1UoRd6z8Giiuk6MkEN8PY4nECUCKQ90GZ/2
 HO/tDrnwQHWRAJY8Q+nPoYS70M3lj3N8CtSsRhRdlJ08T4a3uf/KWC4cXOLzQ3Z3/v
 nRSwtNFlvRaBXC44hBARWq633ndUk0UHuct4Od1w=
Received: from unknown ([::ffff:46.226.16.253])
 by email.seznam.cz (szn-ebox-4.5.350) with HTTP;
 Fri, 01 Mar 2019 14:33:33 +0100 (CET)
From: "Jakub Drnec" <jaydee@email.cz>
To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: PROBLEM: monotonic clock going backwards on ppc64
Date: Fri, 01 Mar 2019 14:33:33 +0100 (CET)
Message-Id: <21Z.Zf5M.7zwRiKSx98z.1SUJIj@seznam.cz>
References: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
 <CA+7wUswyzc5SGjjb+WS4QpopyL0qoGYj0WF1jNaTfsC5ZsMpdw@mail.gmail.com>
Mime-Version: 1.0 (szn-mime-2.0.43)
X-Mailer: szn-ebox-4.5.350
Content-Type: text/plain;
	charset=utf-8
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

Hi,

>> Decreasing the realtime clock across the y2k38 threshold is one reliabl=
e way to reproduce.
>> Allegedly this can also happen just by running ntpd, I have not managed=
 to reproduce that other
>> than booting with rtc at >2038 and then running ntp.

> Isn't it the expected behavior. Here is what I see for powermac:
>...    gives us a time in the documented 1904..2040 year range. I decided=
 not

This (or some related issue involving monotonic time going wonky) surfaced=
 on a system running 4.5 kernel with sane clock values running ntpd. It ma=
y not be limited to setting the clock beyond 2038, that is just a convenie=
nt way to reproduce something visibly wrong.

If the "ntpd-related monotonic" issue is separate from what I reported, I =
did not find anything in the commit history that looks likely to have fixe=
d that, so I think that is still a thing.

Another way of looking at the issue is that when you set the clock beyond =
2038 (or the mystery ntpd thing happens), vdso and syscall versions of clo=
ck_gettime start reporting wildly different values for CLOCK_MONOTONIC. If=
 someone manages to somehow interlace calls to those two assuming they are=
 consistent, crazy bugs will ensue...

Regards,
Jakub
