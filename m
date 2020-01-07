Return-Path: <SRS0=KFH9=24=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDA3C33C8C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 17:36:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B45620848
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 17:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B45620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dolbeau.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47sfgn3JHFzDqLx
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jan 2020 04:36:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.128.67; helo=mail-wm1-f67.google.com;
 envelope-from=romain.dolbeau@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=dolbeau.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47sf9h63l5zDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2020 04:14:00 +1100 (AEDT)
Received: by mail-wm1-f67.google.com with SMTP id 20so329317wmj.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jan 2020 09:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QU5Lb3tIISSRv5nFcFZNbKakaAqpREIEd35+J2XwXOs=;
 b=DrxZT72x8LeuVz6+BMARJcpuQoOErLsxppnC+CRbVp+nt+AuCq/IXnAXMAR/JQuQA7
 iTOOFheN9ekHELsWJ2GWlMJ/iBvVrc5/wtOr7dKUlv8YB+CIoH+Oi293XD4QGoCVNNaD
 KC2CTFCK2P8haue960PCYauK3OgdpqWQmQmmZGT4vbtmFPKStImDPzOLHNw9Xhd6LXWQ
 g3d21dEewP14+SQhtW6WdYKYnGjXTKjyV5kWeUNFTK3a1B4OHSWlNidmlY46AIBEHyXF
 7OidogO5rYTo1lRHGhb8SV8LP7V1p1+B05CeppLqrOtHHiLfOeaAlzSKUzJAVfSaaJx7
 3H8A==
X-Gm-Message-State: APjAAAXt31dQgQBpJjALmCodLuLcHLxw4VD7lMkLFS9kO9DE8F6VVVZD
 +m4RXVuzSSESQ4lrMZ5zXoaeCD2OAoJCctaa0Bw=
X-Google-Smtp-Source: APXvYqzhXd/9wP1y5lIujY1jpqVa1aAzPvMNKbhEW3NNjL7osiGgZDu7gcoJjRSeYSHx2t8AyTS+ifJD4qgm8htt+gU=
X-Received: by 2002:a05:600c:2318:: with SMTP id
 24mr114367wmo.48.1578417236774; 
 Tue, 07 Jan 2020 09:13:56 -0800 (PST)
MIME-Version: 1.0
References: <CADuzgbqYpv40NvAMGjo1cU2cNnij-2p4SYpWgM-Xn0v-8Qapsg@mail.gmail.com>
 <e87e2397-a8d4-c928-d3d4-7ae700603770@physik.fu-berlin.de>
 <CA+7wUsxBkmG-jW_UVBUuMriZbDkJko3kg0hzmMrVMoJLu2+rPw@mail.gmail.com>
 <CADuzgbqoX3DQ6OVqdR6dw1oqnNn-Q0zLPshDi23DwDtYukDYdg@mail.gmail.com>
 <CADuzgboWQtVqp7-Ru4uQQaPerkhLnaS9=WiwX2dD4-5VypT2MA@mail.gmail.com>
 <CADuzgboYv69FQxQRvJ_Bd563OPO0e=USd+cTChfDK60D5x75hw@mail.gmail.com>
 <b2256437-efe1-909d-1488-174b6522f9e0@physik.fu-berlin.de>
 <87eexbk3gw.fsf@linux.ibm.com>
 <CADuzgbq-P8mgf9zLaxhdqUfQcqfRpSzjgRoofF84rp+-S064xg@mail.gmail.com>
 <87mubxl82x.fsf@igel.home>
 <CADuzgbqU-SVy5U_4Pkv2G8SJcT9JhyirhFGamnQusZBSRSgcPw@mail.gmail.com>
 <87immlkytp.fsf@igel.home>
 <CADuzgbo=Yr09hxrkbkwj7Crg0aUfx+RQZOt0sCSNOeYUfR0SmA@mail.gmail.com>
 <20191214103213.309bfbbb1f9c50fe47e733d9@zonnet.nl>
 <B661D5F4-575C-4E64-BC68-537223FFB5B6@gmail.com>
 <CADuzgbpiN-=VgmZCHOyXFDEuj2L+aVzJGfibkvgfnPD_atNZMw@mail.gmail.com>
 <709f10b0-6b7f-8de2-3fac-1f4f6350afaf@gmail.com>
In-Reply-To: <709f10b0-6b7f-8de2-3fac-1f4f6350afaf@gmail.com>
From: Romain Dolbeau <romain@dolbeau.org>
Date: Tue, 7 Jan 2020 18:13:45 +0100
Message-ID: <CADuzgboKYD2CeXODpEH5Vboov4gr0fPG8ZmCTaqWw-3ve53MiQ@mail.gmail.com>
Subject: Re: PPC64: G5 & 4k/64k page size
To: Bertrand <bertrand.dekoninck@gmail.com>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Jeroen Diederen <jjhdiederen@zonnet.nl>,
 PowerPC List Debian <debian-powerpc@lists.debian.org>,
 Andreas Schwab <schwab@linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le mar. 7 janv. 2020 =C3=A0 16:27, Bertrand <bertrand.dekoninck@gmail.com> =
a =C3=A9crit :
> I've tested the 5.5-rc package with the link you gave hereafter. When
> you said "working kernel", did you mean it would not crash ? It doesn't
> for me. I can boot successfully.

Yes, unlike the default Debian build, this one has 4 KiB page size.
It's not a solution, but it's a workaround for those affected by the bug
and perhaps a clue to the issue.

As your machine is booting regular 5.3 as well and seems not affected by
the bug, can you share some details about it? (exact model, number
of cores, ...).

> The only weirdness I could notice is that my swap space wasn't mounted.

No surprise, I think the on-disk format for the swap space hardwire
the page size. There's even a '-p' option to 'mkswap' to specify a
page size when creating the swap space.

Cordially,

--
Romain Dolbeau
