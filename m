Return-Path: <krzk@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420dfL2X1PzF1RN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:12:58 +1000 (AEST)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3F80B2089F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 08:12:56 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id n11-v6so4503791wmc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 01:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <1535527943-32566-1-git-send-email-krzk@kernel.org>
 <CAJKOXPe-fY5T8DMTgjQfrJN=b_9JcytYeeqkX9rQw6EbQ_GiXA@mail.gmail.com>
 <CA+7wUsxE5gUXuUzkZ5bjz_d5WXab8RQxF3bre_DAMpUW=QpKTg@mail.gmail.com>
In-Reply-To: <CA+7wUsxE5gUXuUzkZ5bjz_d5WXab8RQxF3bre_DAMpUW=QpKTg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 29 Aug 2018 10:12:43 +0200
Message-ID: <CAJKOXPfFds9di8d+CHACTYLS8a1ZKc1KGAkL3z=ZyF-HEr-e+Q@mail.gmail.com>
Subject: Re: [RFT] powerpc/boot: Fix missing crc32poly.h when building with
 KERNEL_XZ
To: malat@debian.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mkubecek@suse.cz,
 mroos@linux.ee
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Aug 2018 at 10:06, Mathieu Malaterre <malat@debian.org> wrote:
>
> On Wed, Aug 29, 2018 at 9:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, 29 Aug 2018 at 09:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > After commit faa16bc404d7 ("lib: Use existing define with
> > > polynomial") the lib/xz/xz_crc32.c includes a header from include/linux
> > > directory thus any other user of this code should define proper include
> > > path.
> > >
> > > This fixes the build error on powerpc with CONFIG_KERNEL_XZ:
> > >
> > >     In file included from ../arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
> > >                      from ../arch/powerpc/boot/decompress.c:42:
> > >     ../arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:29: fatal error: linux/crc32poly.h: No such file or directory
> > >
> > > Reported-by: Michal Kubecek <mkubecek@suse.cz>
> >
> > Reported earlier by Kbuild:
> > https://lkml.org/lkml/2018/8/23/47
> >
> > for the credits:
> > Reported-by: kbuild test robot <lkp@intel.com>
>
> Technically Meelis reported it earlier:
>
> https://lkml.org/lkml/2018/8/22/365
>
> ;)

Oh, right... so for the full credits:
Reported-by: Meelis Roos <mroos@linux.ee>

Best regards,
Krzysztof
