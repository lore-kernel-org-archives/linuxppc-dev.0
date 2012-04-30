Return-Path: <kaffeemonster@googlemail.com>
Received: from uhura.skim.hs-owl.de (uhura.skim.hs-owl.de [193.174.118.81])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8DC78B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 14:44:11 +1000 (EST)
Message-ID: <4F9E188E.80503@googlemail.com>
Date: Mon, 30 Apr 2012 06:43:58 +0200
From: Jan Seiffert <kaffeemonster@googlemail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [REGRESSION][PATCH V4 3/3] bpf jit: Let the powerpc jit handle
 negative offsets
References: <4F75CA89.4010709@googlemail.com> <4F75D2A5.7060407@googlemail.com>
 <20120403.180302.342779808900865443.davem@davemloft.net>
 <1333491102.3040.12.camel@pasglop> <1335753820.20866.27.camel@pasglop>
 <1335759088.20866.32.camel@pasglop> <4F9E1496.9060603@googlemail.com>
 <1335760199.20866.33.camel@pasglop>
In-Reply-To: <1335760199.20866.33.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: eric.dumazet@gmail.com, matt@ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
Reply-To: kaffeemonster@googlemail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt schrieb:
> On Mon, 2012-04-30 at 06:27 +0200, Jan Seiffert wrote:
>> Benjamin Herrenschmidt schrieb:
>>> On Mon, 2012-04-30 at 12:43 +1000, Benjamin Herrenschmidt wrote:
>>>
>>>>> Matt's having a look at powerpc
>>>>
>>>> Ok, he hasn't so I'll dig a bit.
>>>>
>>>> No obvious wrongness (but I'm not very familiar with bpf), though I do
>>>> have a comment: sk_negative_common() and bpf_slow_path_common() should
>>>> be made one and single macro which takes the fallback function as an
>>>> argument.
>>>
>>> Ok, with the compile fix below it seems to work for me:
>>>
>>> (Feel free to fold that into the original patch)
>>>
>>
>> Should i resend the complete patch with the compile fix?
> 
> Won't hurt...
> 

Ok

> BTW. Any idea about that bpf_program vs. sock_fprog issue I mentioned
> earlier ?
> 

No idea, i was going by the old saying:
"Thou shall not include kernel header, or you will feel the wrath of angry
kernel gurus."

> Cheers,
> Ben.
> 

Greetings
	Jan

-- 
The OO-Hype keeps on spinning, C stays.
