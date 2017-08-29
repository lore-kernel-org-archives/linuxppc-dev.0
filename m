Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhjqF2BH6zDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 08:24:24 +1000 (AEST)
Message-ID: <1504043837.2358.38.camel@kernel.crashing.org>
Subject: Re: [PATCH V3 6/6] crypto/nx: Add P9 NX support for 842 compression
 engine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: Dan Streetman <ddstreet@ieee.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Herbert Xu <herbert@gondor.apana.org.au>, Linux
 Crypto Mailing List <linux-crypto@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 mikey@neuling.org, suka@us.ibm.com, Ram Pai <linuxram@us.ibm.com>,
 npiggin@gmail.com, Haren Myneni <hbabu@us.ibm.com>
Date: Wed, 30 Aug 2017 07:57:17 +1000
In-Reply-To: <59A5E2AE.5060400@linux.vnet.ibm.com>
References: <1500699702.23205.8.camel@hbabu-laptop>
 <CALZtONBGVQy2iwkb8WpVd-_QG7bLFTvUbnuub6CCXP55YpQiSQ@mail.gmail.com>
 <1504041817.2358.32.camel@kernel.crashing.org>
 <59A5E2AE.5060400@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-29 at 14:54 -0700, Haren Myneni wrote:
> Opening send window for each crypto transform (crypto_alloc,
> compression/decompression, ..., crypto_free) so that does not have to
> wait for the previous copy/paste complete. VAS will map send and
> receive windows, and can cache in send windows (up to 128). So I
> thought using the same send window (per chip) for more requests (say
> 1000) may be adding overhead.
> 
> I will make changes if you prefer using 1 send window per chip.  

Did you check the cost of opening/closing a window ?

Cheers,
Ben.
