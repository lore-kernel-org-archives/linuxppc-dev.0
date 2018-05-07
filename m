Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ffDm71gFzF1cZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 20:36:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jslaby@suse.com>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback from
 console code
In-Reply-To: <20180504153717.4806d9c4@roar.ozlabs.ibm.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
 <20180430145558.4308-5-npiggin@gmail.com>
 <87muxg80ga.fsf@concordia.ellerman.id.au>
 <20180504153717.4806d9c4@roar.ozlabs.ibm.com>
Date: Mon, 07 May 2018 20:36:39 +1000
Message-ID: <87wowfbvm0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Fri, 04 May 2018 15:16:37 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > Use the more refined and tested event polling loop from opal_put_chars
>> > as the fallback console flush in the opal-kmsg path. This loop is used
>> > by the console driver today, whereas the opal-kmsg fallback is not
>> > likely to have been used for years.
>> >
>> > Use WARN_ONCE rather than a printk when the fallback is invoked to
>> > prepare for moving the console flush into a common function.  
>> 
>> Do we want to add a WARN in that path? If we're panicking things might
>> get worse if we WARN (which takes a trap).
>
> True, probably a good idea not to... oh there's a printk_once so
> that'll work nicely.

Cool.

I have this series in a tree so you can send me an incremental diff if
it's reasonably small.

cheers
