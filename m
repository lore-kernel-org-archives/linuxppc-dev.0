Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A69C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D95620825
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D95620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jY5f29yhzDqKV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 01:56:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zytor.com
 (client-ip=198.137.202.136; helo=mail.zytor.com; envelope-from=hpa@zytor.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zytor.com
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jY3H4nXZzDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 01:54:35 +1000 (AEST)
Received: from [IPv6:2607:fb90:86d7:2c0d:f984:e141:407b:6a78]
 ([IPv6:2607:fb90:86d7:2c0d:f984:e141:407b:6a78])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x3FFsVWw3036852
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 15 Apr 2019 08:54:32 -0700
Date: Mon, 15 Apr 2019 08:54:28 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <87r2aaz74f.fsf@oldenburg2.str.redhat.com>
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
 <EF5CE34B-1A82-4391-B07E-DB832814AD1C@zytor.com>
 <87r2aaz74f.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
To: Florian Weimer <fweimer@redhat.com>
From: hpa@zytor.com
Message-ID: <60CC2FAD-CCFF-4550-AAF6-40B059BF88C7@zytor.com>
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
Cc: linux-api@vger.kernel.org, libc-alpha@sourceware.org,
 linuxppc-dev@lists.ozlabs.org, adhemerval.zanella@linaro.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On April 9, 2019 11:50:24 PM PDT, Florian Weimer <fweimer@redhat=2Ecom> wro=
te:
>* hpa:
>
>> PowerPC doesn't need it at all=2E
>
>Because the definition would be the same as struct termios?
>
>I think we should still define struct termios2 using the struct termios
>definition, and also define TCGETS2 and TCSETS2=2E  This way,
>applications
>can use the struct termios2 type without affecting portability to
>POWER=2E
>
>Thanks,
>Florian

Agreed=2E There is just no reason to have a new set of ioctl numbers for P=
owerPC; just make them aliases=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
