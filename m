Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF479C61CE8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 16:32:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B246B2084C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 16:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BheFCW3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B246B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hjyj43fFzDqxM
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jan 2019 03:32:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="BheFCW3F"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hjx43X0szDqws
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jan 2019 03:31:04 +1100 (AEDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D85320883
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547915461;
 bh=ibT0sCQi5t9eGblvshfvampBmqj5GFccOn06+ET8Blc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BheFCW3F5GbZyiseBz2fYtn0ZIcQqiGrOFUtlkbDbUA0Yy3pfXNQxdBtyC4ymBO7F
 QSMTeOyfcTe162S/wSDCY/WylLMbtGoPVTAc9NerurLV0KvT41jxIbvonZ2o7Ji1kT
 407TAW/8vCwmzaxcwtr2Smjaqbs566drdQqImFjo=
Received: by mail-qt1-f176.google.com with SMTP id t13so18665571qtn.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 08:31:01 -0800 (PST)
X-Gm-Message-State: AJcUukc3ZR0j221TcxZ5ZK9w2L2sKK75ckIXNxASj4/BaKyP8Ozy+NVH
 y/kVr6IqDPOtdXidbJcvfcCDJg7oQQ8n+1C45w==
X-Google-Smtp-Source: ALg8bN73wh//Ipe4yjOdfezr1A+3x0hPSw5p173kUqE9cyBDQm8rdA5P8R+iiST0mItIQlHHLCRAvdyHWPZ6HOs2w6Y=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr20075820qvi.90.1547915460751; 
 Sat, 19 Jan 2019 08:31:00 -0800 (PST)
MIME-Version: 1.0
References: <1547914725-12125-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1547914725-12125-1-git-send-email-linux@roeck-us.net>
From: Rob Herring <robh@kernel.org>
Date: Sat, 19 Jan 2019 10:30:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMUX4ZGZutPSs1RsnXXDjz_GVfkPHbbXCdQfogMXym-w@mail.gmail.com>
Message-ID: <CAL_JsqKMUX4ZGZutPSs1RsnXXDjz_GVfkPHbbXCdQfogMXym-w@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: chrp: Use device_type helpers to access the
 node type
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 19, 2019 at 10:18 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The node type can no longer be accessed directly, resulting in the
> following build error. Use accessor function instead.
>
> arch/powerpc/platforms/chrp/setup.c: In function =E2=80=98chrp_init_IRQ=
=E2=80=99:
> arch/powerpc/platforms/chrp/setup.c:541:33: error:
>         =E2=80=98struct device_node=E2=80=99 has no member named =E2=80=
=98type=E2=80=99
>
> Fixes: 8ce5f8415753 ("of: Remove struct device_node.type pointer")
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: of_node_is_type() checks if the node pointer is NULL, so there is
>     no need to check it before calling the function.
>
>  arch/powerpc/platforms/chrp/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Already have the same patch acked by Michael and am sending to Linus shortl=
y.

Rob
