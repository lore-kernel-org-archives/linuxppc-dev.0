Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420dWS3hwNzF26J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:07:00 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so7590410oih.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 01:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <1535527943-32566-1-git-send-email-krzk@kernel.org>
 <CAJKOXPe-fY5T8DMTgjQfrJN=b_9JcytYeeqkX9rQw6EbQ_GiXA@mail.gmail.com>
In-Reply-To: <CAJKOXPe-fY5T8DMTgjQfrJN=b_9JcytYeeqkX9rQw6EbQ_GiXA@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 29 Aug 2018 10:06:46 +0200
Message-ID: <CA+7wUsxE5gUXuUzkZ5bjz_d5WXab8RQxF3bre_DAMpUW=QpKTg@mail.gmail.com>
Subject: Re: [RFT] powerpc/boot: Fix missing crc32poly.h when building with
 KERNEL_XZ
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, mkubecek@suse.cz,
 Meelis Roos <mroos@linux.ee>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2018 at 9:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 29 Aug 2018 at 09:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > After commit faa16bc404d7 ("lib: Use existing define with
> > polynomial") the lib/xz/xz_crc32.c includes a header from include/linux
> > directory thus any other user of this code should define proper include
> > path.
> >
> > This fixes the build error on powerpc with CONFIG_KERNEL_XZ:
> >
> >     In file included from ../arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
> >                      from ../arch/powerpc/boot/decompress.c:42:
> >     ../arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:29: fatal error: linux/crc32poly.h: No such file or directory
> >
> > Reported-by: Michal Kubecek <mkubecek@suse.cz>
>
> Reported earlier by Kbuild:
> https://lkml.org/lkml/2018/8/23/47
>
> for the credits:
> Reported-by: kbuild test robot <lkp@intel.com>

Technically Meelis reported it earlier:

https://lkml.org/lkml/2018/8/22/365

;)
