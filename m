Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com
 [IPv6:2607:f8b0:4003:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSnmG3THrzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 07:40:14 +1000 (AEST)
Received: by mail-oi0-x243.google.com with SMTP id h4so4328873oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 14:40:14 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <7c7bfec63342409ebd58913836a0739a@svr-chch-ex1.atlnz.lc>
References: <20170512042002.18524-1-chris.packham@alliedtelesis.co.nz>
 <20170512042002.18524-4-chris.packham@alliedtelesis.co.nz>
 <20170517181021.yfctrok7f25d5bu5@pd.tnic>
 <7c7bfec63342409ebd58913836a0739a@svr-chch-ex1.atlnz.lc>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 May 2017 23:40:12 +0200
Message-ID: <CAK8P3a0BFBJhDmS5r3O_x8d8Ws18vxresaULPBoN3JX49_LT3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] EDAC: mv64x60: replace in_le32/out_le32 with
 ioread32/iowrite32
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Borislav Petkov <bp@alien8.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 17, 2017 at 11:16 PM, Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 18/05/17 06:18, Borislav Petkov wrote:
> One thing I would like confirmation on is is in_le32 -> ioread32 the
> correct change? I tossed up between ioread32 and readl. Looking at
> mv643xx_eth.c which supports both the MV643XX and Orion it's using readl
> so perhaps I should be using that.

There is no easy answer: on powerpc, readl is used for PCI,
while in_le32 is used for on-chip devices, so in_le32 is the
right one in principle. The main difference is that readl can
work with CONFIG_EEH on pseries, but in_le32 is cheaper.

On ARM and most other architectures, readl is used for both
PCI and on-chip devices, so that's what portable code tends
to use.

ioread32 is required to behave the same way as readl
on all __iomem pointers returned from ioremap(), but
is an extern function on powerpc and can be more
expensive when CONFIG_GENERIC_IOMAP is set.

I'd go with readl() in this case.

     Arnd
