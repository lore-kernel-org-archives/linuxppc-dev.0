Return-Path: <SRS0=nzsQ=23=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C924C33C8C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 18:28:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF49624676
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 18:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF49624676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dolbeau.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47s3tQ44tkzDqFh
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 05:28:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.67; helo=mail-wr1-f67.google.com;
 envelope-from=romain.dolbeau@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=dolbeau.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47s3ft6S21zDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2020 05:18:46 +1100 (AEDT)
Received: by mail-wr1-f67.google.com with SMTP id g17so50724570wro.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jan 2020 10:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JppA8GA1YLeeCZAtmyLdFYdzL9Aeu/B5eNFBmTT5IAg=;
 b=gQr4peC5IfWIL4cGVySadhZ/cQI+GUWse+Ed/7I730thHHh6KhXqPqkc/4ocJB8I/D
 YRoctytDXlSAEvjbn7yh51G4BYIFETv/lJSO0xbEkKQpZvoHcwKpqLu/ToO5/Onu4ftB
 BzMfQrepiTdYir5DtoivnJYUdFFYYrrtWJjYnP9jT1Drkgv27cIUTX+vcUK0KAXrepe+
 pTGhU8Y9teYIdOo9Vok56mrQGGAT+3Fdr9XgPXWEkAyHFxladXdao438Fe6F33//g/QA
 cl6cDbV+kprFqa/lGiLhtm87Vz7nWgjdkKWC9yMaQLiKwL7RPH1ZrzWMXeoWf5BxZKrK
 GTyQ==
X-Gm-Message-State: APjAAAXgVgrkxw6bg+3lmGmAtdk67xk+QKSpqssgHM1Bav3YQebeBu9g
 kbg5KYwQqqkNbAbgMAqEtrXkDRITXAGukvY7siw=
X-Google-Smtp-Source: APXvYqzTNQO6UEXM84Nld03FxyXq5W+Q7umk3t5SaxlgQvnOox0V3dh+mpwM9bdbeUgp3Ak9hlbsQ6PXzMALNPiVz3s=
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr104197948wrw.311.1578334722132; 
 Mon, 06 Jan 2020 10:18:42 -0800 (PST)
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
 <87lfr62tbf.fsf@linux.ibm.com>
 <CADuzgbq3V0F=vob-tB=rroBaLwNR4viS2-=39TRBMyQwdj+xuw@mail.gmail.com>
 <874kx81xxt.fsf@linux.ibm.com>
In-Reply-To: <874kx81xxt.fsf@linux.ibm.com>
From: Romain Dolbeau <romain@dolbeau.org>
Date: Mon, 6 Jan 2020 19:18:30 +0100
Message-ID: <CADuzgbqtn7knixB+tO3m-r0m7fDDQXVA=z2EtGxsfQ_GjD0h7Q@mail.gmail.com>
Subject: Re: PPC64: G5 & 4k/64k page size (was: Re: Call for report -
 G5/PPC970 status)
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org,
 PowerPC List Debian <debian-powerpc@lists.debian.org>,
 Andreas Schwab <schwab@linux-m68k.org>, jjhdiederen <jjhdiederen@zonnet.nl>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le lun. 6 janv. 2020 =C3=A0 15:06, Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> a =C3=A9crit :
> Can you try this change.

Applied, recompiled with 64 KiB pages, still crashes.

The backtrace seems more readable this time (and wasn't overwritten by
something else), bad photo here:
<http://www.dolbeau.name/dolbeau/files/Photo0033.jpg>

Cordially,

--=20
Romain Dolbeau
