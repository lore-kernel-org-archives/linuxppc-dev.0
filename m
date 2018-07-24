Return-Path: <krzk@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZbKP3rKSzDqyZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 21:11:53 +1000 (AEST)
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A637620875
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 11:11:50 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id c14-v6so2111460wmb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 04:11:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5ef968e1cb2a473cad97f6bfead369ca@AcuMS.aculab.com>
References: <20180723162020.6221-1-krzk@kernel.org>
 <5ef968e1cb2a473cad97f6bfead369ca@AcuMS.aculab.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 24 Jul 2018 13:11:48 +0200
Message-ID: <CAJKOXPdveQeg_M42v69m9vBEz2SaJE0_BZNRUqGLt4Ve+ZLYSg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
To: David Laight <David.Laight@aculab.com>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24 July 2018 at 13:05, David Laight <David.Laight@aculab.com> wrote:
> From: Krzysztof Kozlowski
>> Sent: 23 July 2018 17:20
>> Use generic kernel CRC32 implementation because it:
>> 1. Should be faster (uses lookup tables),
>
> Are you sure?
> The lookup tables are unlikely to be in the data cache and
> the 6 cache misses kill performance.
> (Not that it particularly matters when setting up multicast hash tables).

Good point, so this statement should be rather "Could be faster"... I
did not run any performance tests so this is not backed up by any
data.

I think the main benefit is rather easier code maintenance by removing
duplicated, custom code.

>> 2. Removes duplicated CRC generation code,
>> 3. Uses well-proven algorithm instead of coding it one more time.
> ...
>>
>> Not tested on hardware.
>
> Have you verified that the old and new functions give the
> same result for a few mac addresses?
> It is very easy to use the wrong bits in crc calculations
> or generate the output in the wrong bit order.

I copied the original code and new one onto a different driver and run
this in a loop for thousands of data input (although not all possible
MAC combinations). The output was the same. I agree however that real
testing would be important.

Best regards,
Krzysztof
