Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxLcb6jW8zDr2f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 06:43:43 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id p66so967208oia.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 13:43:43 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170622164817.25515-3-logang@deltatee.com>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-3-logang@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Jun 2017 22:43:40 +0200
Message-ID: <CAK8P3a1Uh=PQbGi540KGLpkoEVH+KUW18mzqN3aiijroXwEMWQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] iomap: implement ioread64 and iowrite64
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-crypto@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Suresh Warrier <warrier@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +u64 ioread64(void __iomem *addr)
> +{
> +       u64 low, high;
> +
> +       low = ioread32(addr);
> +       high = ioread32(addr + sizeof(u32));
> +       return low | (high << 32);
> +}
> +u64 ioread64be(void __iomem *addr)
> +{
> +       u64 low, high;
> +
> +       low = ioread32be(addr + sizeof(u32));
> +       high = ioread32be(addr);
> +       return low | (high << 32);
> +}
> +#endif

This hardcodes the behavior of include/linux/io-64-nonatomic-hi-lo.h, which
I find rather confusing, as only about one in five drivers wants this
behavior.

I'd suggest you don't add it in lib/iomap.c at all for 32-bit architectures,
but rather use the same logic that we have for readq/writeq in
io-64-nonatomic-hi-lo.h and io-64-nonatomic-lo-hi.h, adding
{lo_hi,hi_lo}_{ioread,iowrite}{,be} to the same files, and provide
the {ioread,iowrite}{,be} macros only if they have not been defined
at that point.

       Arnd
