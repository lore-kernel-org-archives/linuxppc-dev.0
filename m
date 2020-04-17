Return-Path: <SRS0=SBso=6B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A2C2D0EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 15:05:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155F120857
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 15:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155F120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 493fXw2XBCzDrgq
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 01:05:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 493fPY1NlGzDrgZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2020 00:59:10 +1000 (AEST)
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M5g68-1jJR6h23o2-007Fw0 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr
 2020 16:59:05 +0200
Received: by mail-qv1-f41.google.com with SMTP id v38so1005220qvf.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 07:59:05 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ1UhMRfMWfl3rbKFttKeuPfkg6Znb7sjaIRx1wlg0AqWy3McJT
 3HkR7R5KOeTGMnH1puaJyxEWycnanF1ZSVDa5Sk=
X-Google-Smtp-Source: APiQypK6H2sYYYSZKAdSmmfa2MAlt0yW4aUSm3D2h6CUEgVPlGKHt4i/wv76jSZrzUssUtAvPLNxCQopFYs1B7Ph4Co=
X-Received: by 2002:ad4:4d50:: with SMTP id m16mr1321929qvm.222.1587135544234; 
 Fri, 17 Apr 2020 07:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200408185834.434784-1-arnd@arndb.de>
 <20200408202421.GU25745@shell.armlinux.org.uk>
In-Reply-To: <20200408202421.GU25745@shell.armlinux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Apr 2020 16:58:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ZskJqBbTod-botFdx9fuWN9q5q25G1Gx=ky_Sg2cuHg@mail.gmail.com>
Message-ID: <CAK8P3a0ZskJqBbTod-botFdx9fuWN9q5q25G1Gx=ky_Sg2cuHg@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: avoid stack usage warning
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:iPh9W2MpbbY+1vyuKaOV5roFd5LXOF7L1FEHLGpAjXo1wV+18aE
 Hzi+LRXBYnfBmKIDYARc/hP7y2YmryX0kdQHQymc148CI7ehawCCiYBKwEQB37MrY0ubFod
 IBhbn/FLVAuiAmC9Qvc6xv9+G6tk+WvIj1T0rZOq+1b7bm4gKzJXr5xRmAxZ6p7QqSQf2il
 bw1AGLJ+iQnUhYZ3nl9Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Zth1ymXLqo=:vwng2tK28m6Hv+zZ9CvKza
 ydHdRv9nkB096ryetPIW/JZo/kQC/weu3T6pz98/cG03Vnpuuwhz0+2fe3sWGgxqjOcSsuac+
 S1SFoKAkJjYbjDxh4dv+yyUqaYzLwR5fAcPmuItykBxlTNKQJeQd8Pkx1boVlpccGWXt26jfv
 zbRD5yTFUqERWy3bjVfYIULFSzobJadi3Z1xsG0jsS9/7DGiAIUsVd2tll+Em+yx/SElRVgqB
 9OOn0RSYB0jw8Vfa4kcAKMqzhBKqe1EKJ+UQiNBLJycbD4jU/gg9HVZl0xSSDvFpt5X8FQ2bw
 nP/hRgzZn7zdmYak9F7NUjgMvwWfz0QALjGEUYGC5Xu4vGgWaPOu6Jc27+ftOCej5IV7NzDrG
 0Xsz+s1xHXBwMUsUV9bX71y5q/p36TC0Uh/FRbRONNtrSvp8o4DMd2/ksn8+mAtqS9WffAXVZ
 2uer+J+VZgblZln5gOKZm7oqiPVccqV1TA/4TAaacA/A4ofcCOOx8SfSE41JCSRh25nnXR/GY
 /reEYwEbY0og9UVK/woTxu96jqDw/VSuNi8t4g36hPK375VZ7wVuDKHqyz2YPzWksoKeCNFXi
 NzK3L5aHaVVihZOUj5LV7gepgQbG9AM012mr906F7sRQAB6wgZ0Aeedrs8h0eXn26BhgiBMg1
 Sehv5MH9q3UxTvH3C3yZ4qD+O2tF0ulgYaBr9wkyQFxW58uSLy/EGNFgAc/aAOKbaX1bj86tM
 r83H3tqQnXVsQY4rZBLHzp2VXV5muc1C3Hbh7DUZado2bYkMp4ZFNmFnQAsz0h498Lb9fF6OG
 pAyaOqGoykocUIYpevzkrL7L8Avtr0uC6Bf/noSWnwNX+pNQOs=
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
List-Id: <soc.lore.kernel.org>
Cc: Roy Pledge <Roy.Pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Youri Querry <youri.querry_1@nxp.com>, SoC Team <soc@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 8, 2020 at 10:24 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Wed, Apr 08, 2020 at 08:58:16PM +0200, Arnd Bergmann wrote:
> > -     int i;
> > -     struct qbman_eq_desc ed[32];
> > +     struct qbman_eq_desc *ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
>
> I think you need to rearrange this to be more compliant with the coding
> style.

Ok, I've updated this now to move the allocation into a new line
and applied this and the other fsl patch into the arm/fixes
branch for v5.7.

       Arnd
