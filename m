Return-Path: <SRS0=Ntje=PC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDC9C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 08:45:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F1460FDA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 08:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63F1460FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVNJt6lQ4z3c6t
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 19:45:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.130; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVNJN5r7sz2yPS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2021 19:45:07 +1100 (AEDT)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mm9NA-1n1ARK31NY-00iAOi for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct
 2021 10:45:02 +0200
Received: by mail-wr1-f51.google.com with SMTP id e3so16829765wrc.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2021 01:45:02 -0700 (PDT)
X-Gm-Message-State: AOAM530bxNH36nrMhy+fd/s1XKuy0aYUOQHa/UbucxYZrEW4C70rkdgj
 XTsJQk3/LSO6ArKXiYFLjrXX3v8CwJPUibTLs60=
X-Google-Smtp-Source: ABdhPJy2Q55sSkLZB6jxCTWqm25cFC7UAeGhHD3tsyQeSyokhHvq8V2pJoW6joP1ItyVfyCebQbp8k3zAHKoURn20CM=
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr4618289wma.98.1634201102285;
 Thu, 14 Oct 2021 01:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211008164728.30e3d3a3@canb.auug.org.au>
 <20211011082704.3cff4568@canb.auug.org.au>
 <CAL_JsqJE_GHnehBz-71BOGXfjm6q2p0u6FQA5KwO8zK_i1LpMQ@mail.gmail.com>
 <CAK8P3a1EcNuxT-w-8w-HDr2+idsP=vFZ3Cn27fX7o56GOuu_Cg@mail.gmail.com>
 <20211014001232.3becbe99@crub>
In-Reply-To: <20211014001232.3becbe99@crub>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Oct 2021 10:44:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0yKvZW2-XFJtPORpa=FhG+UJgk=m0O1GiC_yLw+1Pfvw@mail.gmail.com>
Message-ID: <CAK8P3a0yKvZW2-XFJtPORpa=FhG+UJgk=m0O1GiC_yLw+1Pfvw@mail.gmail.com>
Subject: Re: linux-next: build warnings in Linus' tree
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:F/6mXaCJyES9AP2fDb184ELtPWX4M+29CaOvu7zS4UN07vrPbc3
 lh5AtFczaSYNDiVXPxh4M3zJBTwFDsrk4mmIXeEWuGBILTw3yHuCQLITAIKTTxEp3kQSwtb
 PIPjZaC+zZV3gDOLTKpZVu4fnkqVNAYYco0qqOSmTDp+bt/jANZXxYfwbhwODjN+2sTish9
 dyTybwUEXPd4JzKAwcN0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oFczKncLlJ0=:uIsOLbaRTeig8VTDcGsR1F
 UJfEHeT2Vk/tJBrbEq5NWTYbdnCCj2/mUg5qj+lvS+Y7lEYKcTxaJdqB6paqVu//9hn4Qwf7o
 MTeLNuHW+rIxJCVycik5EdwpWz5aavvHL8R0CiM7KxqfuyQbPzA8gdM+mPaJ7x59Rqr9oK4ak
 EIR/H9obONac88j2hEAtXhssjfF402V/MotRODT/B/VMgKE2WByKZ7Bf7naOq2FPCNh6NGuON
 TgtAFuQ4dmn0PjDI/isg697IDT08tZDAsnQxFNrXhavhy325YsGh/4EblrW1Eqs6I3Mti7lUy
 UIYLpoogjTzqgIi1hTCuT8FfUJ/MQTUOJ3VZg45FuQ6hsMojAfBRLsp/Pwl4X5ztKOGwnqvxx
 Al4Cle0JuUVHEqPGQHSkLh4odzCzbyfdjuJMYgBhon6GZY1koN88NYUccRq+RpdP3mVaxop4f
 RHkG9Pk+z4kmoViFYnmn/6lLyJ/UNJFq2uVmjUAO/rdTk6j7L3OH+j/FZCVeHgl485RMaewvf
 G2XAk6ugLB96C0jU9mJTcMdbEVgdRt1oQigRXsUlR5XepwKQT7MQdha/qZiE75x+dEWLvxj+s
 c+1S5x2Go2tnWn4eyk7dyGpBGlaRDyHiDwrY/i1JkGaZcQkaUkrZRlaFuvu08kUPm3jPEogsm
 KahiSrJUj7CHlBCnV3/IZsqZH538jSDG+4vWq7xqr8cAaJP5JA1nWUTHELeHpfT4+PI/JHspC
 CPm7rgZLMsPaM86x6jJrwiIS2kOCX5RWTf/D2Q==
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 14, 2021 at 12:12 AM Anatolij Gustschin <agust@denx.de> wrote:
> On Tue, 12 Oct 2021 16:39:56 +0200
> Arnd Bergmann arnd@arndb.de wrote:
> ...
> >Grant Likely was the original maintainer for MPC52xx until 2011,
> >Anatolij Gustschin is still listed as maintainer since then but hasn't
> >been active in it for a while either. Anatolij can probably best judge
> >which of these boards are still in going to be used with future kernels,
> >but I suspect once you start removing bits from 52xx, the newer
> >but less common 512x platform can go away as well.
>
> many of these boards are still used, i.e. o2d*, digsy_mtc, tqm5200.

Just for clarification, I assume when you say "still used" that implies
getting updated to new kernels rather than just running the old BSPs,
right?

What are the typical distro release cycles for those machines
you list: do you move from one LTS kernel to the next each year,
or are they getting more sporadic over time?

Do you expect the machines with the lowest memory such as the
32MB digsy to stop getting kernel updates before the others?

> I've sent first series to fix some warnings. Other dts fixes
> require driver changes, so it will take some time to fix them.

Thanks!

      Arnd
