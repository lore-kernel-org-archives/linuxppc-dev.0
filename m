Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0417AC433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Feb 2022 16:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JvhpF0900z3cTH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Feb 2022 03:21:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jvhnf3yVqz3bVB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Feb 2022 03:21:08 +1100 (AEDT)
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPoPd-1neW831az5-00Mws5 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb
 2022 17:21:04 +0100
Received: by mail-wm1-f48.google.com with SMTP id
 l123-20020a1c2581000000b0037b9d960079so5574962wml.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2022 08:21:03 -0800 (PST)
X-Gm-Message-State: AOAM532MRugGR7VZYOj8RS5vNpQQyWEZZSEtSDJIou4RTVoOmzxgVIIp
 uEmTg6W14UVCY/s6nlSv/eaiAQMpdMRzXpdIerw=
X-Google-Smtp-Source: ABdhPJxEt42iOSrAM6C3TvkblI3b5gQmXnnRKKOtEBtFl2RyO5MYFlbo5PnAEnruW7eQTVPA+SeI0QUJdaKY2LsCsdY=
X-Received: by 2002:a05:600c:1f0b:: with SMTP id
 bd11mr2796188wmb.82.1644510063280; 
 Thu, 10 Feb 2022 08:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20220209163242.430265-1-michael@walle.cc>
In-Reply-To: <20220209163242.430265-1-michael@walle.cc>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Feb 2022 17:20:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0cBdT0EjStDhB5jSPWm=FiPVj8_5X6rVnBfXOcznTy6g@mail.gmail.com>
Message-ID: <CAK8P3a0cBdT0EjStDhB5jSPWm=FiPVj8_5X6rVnBfXOcznTy6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] soc: fsl: guts: cleanups and serial_number support
To: Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UF4CWEWmV9HZUJ0k3wGBoMsqfCS/eRsHptS0GmGX/gw491UFkNH
 WLfwvL6REKe6HHKJ8YWQVblskNLZR3A1aWGlt9iQ8AFU38GFv/S0uBMTa3Nu5SGhFXV2gpU
 C6bOGcr+5LxKFnqKzMtqWChldb+jN3LVkG3AsBY1Rble3/A9QqeFGrYSPf251bPeAtgs0Cp
 TMM2F8TE40vX4qjuyzjyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:91/+LlPpFdc=:xfZUx9PXsuUQGFzNzniM30
 1GH90cylAUyVOpAgXVPmiuJNqgwSdGh37Im3xrpED00+hzWge1+qFBTHhJezZtideUCzfrXaf
 mf4IF4YzlossDWMPXgoowqsrz25TI2jgO8c3b9HDBd+5FU78yjCaa+E5BY/Alja6yml2mSOrz
 VMCt8jB/hpq98zyD0fHBrP1NxZ51gahVd0tpGK9jopHVZNk2R1/6qYb2gDdgcdbc9lJ/BG6Mr
 GQ3cj8bVhWVfMcPbDiYF9AnNaECaY7kTrheTXMR3ot5i2ZT6h1KsUxCHU54F19KRHLmkzh+Oe
 o1goaSOj1eotmPLjYh1qUJYnXX+tv7crifAIDosZ7TscwVfqpTAioJsbpmd8nad+s+O6amF2p
 4i+QB0CG44Sj70nzDSUiSreKxbre9hGNu7f+DrIl0zTa2uE6ABzxGkaHRZtj7+276SH0us8y9
 +KjkuS5ADNYkDbFMdMegKE//o78CtQulJaxaLRJ7J802T/iY6Da0RHECvaOAqvYVdJboi0FOL
 id0IqQXXMzQ3DHh2fetVjIy9jSL4cY+GSE88Lw3s3Vsy+Rw+/GvquSP0yIm6+z3BQu4PfKJnB
 q2udyuBmzV2KJ++Jyq6jDRXNLZUoiVrM2nEEJv2f7XrVNmBfwl5GVzp/GyCvdZEUvHqUrglap
 ru6heLdizuGn8fWlXEHXSAqzAHxHwq74a4Nh4unhUXJWfwzA88sUEfTUvEX9Yy8bnUpuLQrsN
 Y9nVXx+S9/YOmBuIrpexI89IvfZP8i0uU49q8Z/vU2L/tgbRDxuxBtIGz4B4ElTk5QOhC49uC
 m0pBmPHx5X615uevsHsSK7sg8zjytnJ9+h/Jqt3CY1bV9mdo0M=
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Sudeep Holla <Sudeep.Holla@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 9, 2022 at 5:32 PM Michael Walle <michael@walle.cc> wrote:
>
> This series converts the guts driver from a platform driver to just an
> core_initcall. The driver itself cannot (or rather should never) be
> unloaded because others depends on detecting the current SoC revision
> to apply chip errata. Other SoC drivers do it the same way. Overall I
> got rid of all the global static variables.
>
> The last patch finally adds unique id support to the guts driver. But
> because the binding [1] for the security fuse processor is still pending,
> it is marked as RFC.
>
> [1] https://lore.kernel.org/linux-devicetree/20220127163728.3650648-2-michael@walle.cc/
>
> changes since v1:
>  - call kfree() in error case, thanks Dan
>  - add missing of_node_put(np), thanks Dan

Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
