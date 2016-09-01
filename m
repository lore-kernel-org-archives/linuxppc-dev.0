Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-yw0-x22a.google.com (mail-yw0-x22a.google.com
 [IPv6:2607:f8b0:4002:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPtRT4j72zDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 16:59:49 +1000 (AEST)
Received: by mail-yw0-x22a.google.com with SMTP id r9so45153009ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 23:59:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <48bab268a61.66716f37@auth.smtp.1and1.co.uk>
References: <1472124856-12767-1-git-send-email-prasannatsmkumar@gmail.com>
 <20160825121546.GA25650@Red>
 <CANc+2y4JqGRXCLUEpMo8EB8thW5jsweh0Lg2VjuvpNgSR-AwMA@mail.gmail.com>
 <48b8455031e.651d5701@auth.smtp.1and1.co.uk>
 <CANc+2y64+ECEh0GwQU4qQrEtsFjjbmaRJYt1t=J1Q3nT6TG6sA@mail.gmail.com>
 <48bab268a61.66716f37@auth.smtp.1and1.co.uk>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Thu, 1 Sep 2016 12:29:47 +0530
Message-ID: <CANc+2y5jJ9GNg10ob3o7CLqzLqt9+oH8vU_RmEUjAfDdwOft9A@mail.gmail.com>
Subject: Re: hwrng: pasemi_rng.c: Migrate to managed API
To: Darren Stevens <darren@stevens-zone.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 LABBE Corentin <clabbe.montjoie@gmail.com>, linux-crypto@vger.kernel.org,
 mpm@selenic.com, olof@lixom.net, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I didn't explain well, There is a CFE command 'show devtree' here's the
> relevant bits (I Hope)

This is much simple than I expected.

> [CFE ]CFE> show devtree
> [/]
>  | #interrupt-cells                 val   0x00000002
>  | #address-cells                   val   0x00000002
>  | #size-cells                      val   0x00000002
>
> ...[snip]...
>
>    [sdc@fc000000]
>     | name                          str   'sdc'
>     | device_type                   str   'sdc'
>     | #address-cells                val   0x00000001
>     | #size-cells                   val   0x00000001
>     | compatible                    str   '1682m-sdc' 'pasemi,pwrficient-sdc'
> 'pasemi,sdc'
>     | reg                           cell  00000000 FC000000 00000000 00800000
>
> ...[snip]...
>
>       [rng@fc105000]
>        | name                       str   'rng'
>        | device_type                str   'rng'
>        | compatible                 str   '1682m-rng' 'pasemi,pwrficient-rng'
> 'pasemi,rng'
>        | reg                        cell  FC105000 00001000
>

Device tree provided by CFE has the size. I will send another patch
which uses devm_ioremap_resource().

Appreciate your help. Thank you :).
