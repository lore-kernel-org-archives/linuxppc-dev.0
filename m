Return-Path: <dan.j.williams@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F34C82C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Sep 2012 16:47:59 +1000 (EST)
Received: by pbbro8 with SMTP id ro8so7091269pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Sep 2012 23:47:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <FD18E5D573A8AB48A365D4D78185DE992E5C0D@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1344500448-10927-1-git-send-email-qiang.liu@freescale.com>
 <FD18E5D573A8AB48A365D4D78185DE992E5C0D@039-SN1MPN1-001.039d.mgd.msft.net>
Date: Sat, 1 Sep 2012 23:47:56 -0700
Message-ID: <CAA9_cmc3y5fix=QrqPEOhD5TP=4MEOmv_V5OaJcsPXmCAha-Rg@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] Talitos: Support for async_tx XOR offload
From: Dan Williams <dan.j.williams@gmail.com>
To: Geanta Neag Horia Ioan-B05471 <B05471@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Li Yang-R58472 <r58472@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 Liu Qiang-B32616 <B32616@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Phillips Kim-R1AAHA <R1AAHA@freescale.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2012 at 7:23 AM, Geanta Neag Horia Ioan-B05471
<B05471@freescale.com> wrote:
>
> Besides these:
> 1. As Dan Williams mentioned, you should explain why you are using
> both spin_lock_bh and spin_lock_irqsave on the same lock.

It looks like talitos_process_pending() can be called from hardirq
context via talitos_error().  So spin_lock_bh is not sufficient.
