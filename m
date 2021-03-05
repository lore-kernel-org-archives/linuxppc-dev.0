Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9C1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 12:04:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3A564FE2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 12:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3A564FE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsRHK46gwz3dLQ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 23:04:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsRGy2Xjnz3cPn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Mar 2021 23:04:08 +1100 (AEDT)
Received: from mail-oi1-f182.google.com ([209.85.167.182]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MulVd-1lZg2R0PUR-00rrNM for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Mar
 2021 13:04:04 +0100
Received: by mail-oi1-f182.google.com with SMTP id z126so2225924oiz.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Mar 2021 04:04:03 -0800 (PST)
X-Gm-Message-State: AOAM530QDx/B4qTmE20Avie+Bmx4PJB3qV/MGLcu286H8u7oam+QnK5L
 ZJ0u0ZOU9y1LdUt+JEImtIU4BN3QPZ+t1Af34wc=
X-Google-Smtp-Source: ABdhPJzvwNIaEW00Aml4Gt9DByl41wlsXQXcSHXEPeKAsXC8bMoOquef8BfTOVyLV4/l6Byf5f01UCfsF2Iye6vPn94=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr6517268oib.11.1614945842125; 
 Fri, 05 Mar 2021 04:04:02 -0800 (PST)
MIME-Version: 1.0
References: <f08ef2b6f339ba19987cfef4307a4dd26b2faf97.1614933479.git.christophe.leroy@csgroup.eu>
 <CAK8P3a2b+u+8smkKWB-V2Non+nnZmNG4dNi6cGpM8weYuY5j6A@mail.gmail.com>
 <5811950d-ef14-d416-35e6-d694ef920a7d@csgroup.eu>
In-Reply-To: <5811950d-ef14-d416-35e6-d694ef920a7d@csgroup.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 5 Mar 2021 13:03:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a34cnCk4=Xyxvib57JLN-ck4T0-FUZRAQT_L6MDKjE+-w@mail.gmail.com>
Message-ID: <CAK8P3a34cnCk4=Xyxvib57JLN-ck4T0-FUZRAQT_L6MDKjE+-w@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/32: remove bogus ppc_select syscall
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0kCD38r+vVvZjWc/tZPHcSkOWs94Cx9Yvj9qdaUQF1iglgOR4yo
 YD+OgK8ehxlmbAs6I3Wc0VlslYMdCHy8fyCwLt5bLetOSjVOeydENekrNA/7LfFpcIjehG8
 +Fjsl5yhZtFFEjZZUeKqOSku5hgeaGfn5EO1kcUkZKexqdCD9Q65b2YXESdcXckys89xSNi
 YBMTu2/UNhlv+aqKveXBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hToTwb+NV68=:bvaMFRsnShIHdlQ6FJGtvZ
 5/KBdE3Wjjw9jsH28RemF8sDEk4DOZGFCk+Y1qKPiiIOPUN8edUhX4XxVauPEna0mr8R598mM
 NHJfNNymoIg6qh4noF5fOO7P/EkRVl9ib+v4UpETqs1XRpkQ+m4TnvdtPpsUcLiB/Q1SqDk+C
 lYwt6inJ/WgXYX0l9EsWvpHtBEuVx3Vh3qvex3Amy0NZAWUyCP6Y55sKd0aWXRNoyKVtJPz6S
 ZJB/WsaPmQNipH/+TZ668sxqaSIvpTBGwOELK+qci5RkKSTdVt6moDC1mjiBDVcyyvIcusfN1
 vYr2OgdBuDm/ne25AZVrUd8r5Fq4St+rNgh5FzZMV9bhyhbdR8JhTOy/2pDSaooTCqEJtxiZN
 FzVvqNe7QzRv++2RGEiTpvcXW8FA3T/pX/pNAqVoYRr0jtL8EQizjehP+k2CC
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

On Fri, Mar 5, 2021 at 11:15 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 05/03/2021 =C3=A0 11:06, Arnd Bergmann a =C3=A9crit :
> > On Fri, Mar 5, 2021 at 9:40 AM Christophe Leroy <christophe.leroy@csgro=
up.eu> wrote:
> > - glibc support for ppc32 gets merged during the linux-2.5 days, suppor=
ting
> >    only #142 with the new behavior.

It turns out to be older than I said. This was actually in glibc-1.94
from 1997, so during
the linux-2.1 days, not 2.5!

> Whaou, nice archeology, thanks. Do you mind if I copy the history you est=
ablished ?

That's fine, please copy it.

> In your commit, you said 2.3.48. Here in the history you say 2.1.48. Whic=
h one is correct ?

2.1.48 is correct.

> Regardless of whethere binaries are broken or not for other reason, is th=
at worth expecting an
> almost 25 yr old binary to run on future kernels ? If one is able to put =
the necessary effort to
> port you hardware to the latest kernel, can't he really port the binary a=
s well ?

I think the questions of supporting old hardware with new software and
supporting old
binaries on modern kernels are largely orthogonal. The policy we have
is that we don't
break existing user setups, and it really seems unlikely that anyone
still uses pre-1997
executables for anything that requires a modern kernel!

I now checked the oldest mklinux I could find (DR2.1 from 1997), and
even has the
modern glibc and linux-2.0.28 kernel patched to provide the modern semantic=
s at
syscall #142 for glibc, with the same (already unused) compatibility hack a=
t #82
that we still have for ppc32 today. This made mklinux DR2.1 binaries
incompatible
with mainline linux-2.0 kernels, but they might still work with modern kern=
els,
regardless of whether we remove support for binaries that worked with mainl=
ine
linux-2.0.

       Arnd
