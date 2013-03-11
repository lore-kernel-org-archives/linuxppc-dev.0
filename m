Return-Path: <olof@lixom.net>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F24282C02C2
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Mar 2013 03:20:45 +1100 (EST)
Received: by mail-wg0-f46.google.com with SMTP id fg15so5009696wgb.25
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Mar 2013 09:20:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363016099.3348.47.camel@sauron.fi.intel.com>
References: <1363016099.3348.47.camel@sauron.fi.intel.com>
Date: Mon, 11 Mar 2013 09:20:41 -0700
Message-ID: <CAOesGMhy6YceRr3T4ZALhYeSQfEuASO+ajJy1Htwws=OMtvrTg@mail.gmail.com>
Subject: Re: Dead mappings and drivers in MTD
From: Olof Johansson <olof@lixom.net>
To: dedekind1@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 11, 2013 at 8:34 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> Hi MTD folks,
>
> we have huge amount of drivers, espacially mapping drives in
> 'drivers/mtd', and for sure may of them are for ancient devices which
> are long dead and not supported by modern kernels anyway. I would like
> to do a small clean-up. It is difficult to judge which ones are dead for
> me, so I am asking the community to help. Thanks!
>
> There are few easy cases - some drivers depend on Kconfig symbols which
> are not defined anywhere - I guess these are clear candidates for
> removal. For example this one:
>
> config MTD_DBOX2
>         tristate "CFI Flash device mapped on D-Box2"
>         depends on DBOX2 && MTD_CFI_INTELSTD && MTD_CFI_INTELEXT && MTD_CFI_AMDSTD
>         help
>           This enables access routines for the flash chips on the Nokia/Sagem
>           D-Box 2 board. If you have one of these boards and would like to use
>
> Grepping for "DBOX2" gives nothing.

In 2.6.14, it dropped two dependencies that used to be there for PPC32
and 8xx. There still was no DBOX2 symbol to fulfill that dependency
back then.

Take it out, if someone finds a user later on it can always be
reverted. Seems very very unlikely in this case.


-Olof
