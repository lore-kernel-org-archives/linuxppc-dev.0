Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA99C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 19:13:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496AA2082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 19:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="K4cmJ8+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496AA2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Yf4J0Br6zDqQK
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 06:13:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yandex.ru
 (client-ip=2a02:6b8:0:1a2d::611; helo=forward501o.mail.yandex.net;
 envelope-from=st5pub@yandex.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="K4cmJ8+F"; 
 dkim-atps=neutral
Received: from forward501o.mail.yandex.net (forward501o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yf2c1k8YzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 06:11:36 +1100 (AEDT)
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::21])
 by forward501o.mail.yandex.net (Yandex) with ESMTP id B44261E80271;
 Tue,  2 Apr 2019 22:11:21 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id hJLkrDDClS-BJU4Mjb7; 
 Tue, 02 Apr 2019 22:11:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1554232281; bh=ujdYPjeV/k1ZxMLKlIqsUF9I3AeNKWX+BJCImrB51nY=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=K4cmJ8+FtC23oBXGjXYJouLDsm4nEfPnj+IoYBgQuS2+aLqI0UVdVQE9274xtQHPO
 tJffbZxdbE9Bm+SvFBl78GU2s7fVxFtuglDyhBqc5P+dwmBzBxtZZT8DVKvyCoXOlu
 rrcLYUL629dwyUGATiaUcAgo5JxMqYs9MGjO+29w=
Authentication-Results: mxback7o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-633109cb7707.qloud-c.yandex.net with HTTP;
 Tue, 02 Apr 2019 22:11:19 +0300
From: Andrey Abramov <st5pub@yandex.ru>
To: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <87zhpaox14.fsf@concordia.ellerman.id.au>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <21287961553964090@iva7-8a22bc446c12.qloud-c.yandex.net>
 <87zhpaox14.fsf@concordia.ellerman.id.au>
Subject: Re: [PATCH 2/5] powerpc: module_[32|64].c: replace swap function with
 built-in one
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 02 Apr 2019 22:11:19 +0300
Message-Id: <673731554232279@sas1-633109cb7707.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

01.04.2019, 13:11, "Michael Ellerman" <mpe@ellerman.id.au>:
> This looks OK. It's a bit of a pity to replace the 8-byte-at-a-time copy
> with a byte-at-a-time copy, but I suspect it's insignificant compared to
> the overhead of calling the comparison and swap functions.
>
> And we could always add a generic 8-byte-at-a-time swap function if it's
> a bottleneck.

I am sorry, I forgot to quickly comment on your letter.
Now (after George Spelvin's patches) the generic swap is able
to use u64 or u32 if the alignment and size are divisible
by 4 or 8, so we lose nothing here.
