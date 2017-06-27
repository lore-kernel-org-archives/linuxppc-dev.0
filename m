Return-Path: <arndbergmann@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxyVD0HtHzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 06:40:20 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id j200so3618379ioe.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 13:40:19 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <3ffb5648-00f6-26cb-116a-370085038a0d@deltatee.com>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-7-logang@deltatee.com>
 <504da99a-838c-48ec-c5b2-6b611d587a10@ti.com>
 <3ffb5648-00f6-26cb-116a-370085038a0d@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Jun 2017 22:40:16 +0200
Message-ID: <CAK8P3a2HhO_zCnsTzq7hmWSz5La5Thu19FWZpun16iMnyyNreQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/tilcdc: clean up ifdef hacks around iowrite64
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jyri Sarha <jsarha@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com,
 linux-alpha@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-crypto@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 26, 2017 at 6:26 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hi Jyri,
>
> Thanks for the ack. However, I'm reworking this patch set to use the
> include/linux/io-64-nonatomic* headers which will explicitly devolve
> into two 32-bit transfers. It's not clear whether this is appropriate
> for the tilcdc driver as it was never setup to use 32-bit transfers
> (unlike the others I had patched).
>
> If you think it's ok, I can still patch this driver to use the
> non-atomic headers. Otherwise I can leave it out. Please let me know.

You'd have to first figure out whether this device is of the lo-hi
or the hi-lo variant, or doesn't allow the I/O to be split at all.

Note that we could theoretically define ARM to use strd/ldrd
for writeq/readq, but I would expect that to be wrong with many
other devices that can use the existing io-64-nonatomic headers.

The comment in set_scanout() suggests that we actually do rely
on the write64 to be atomic, so we probably don't want to change
this driver.

         Arnd
