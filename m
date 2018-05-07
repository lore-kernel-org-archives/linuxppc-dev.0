Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ffCh4sqZzF14r
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 20:35:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 08/15] powerpc/powernv: implement opal_put_chars_atomic
In-Reply-To: <20180501203721.7b60fcd8@roar.ozlabs.ibm.com>
References: <20180430145558.4308-1-npiggin@gmail.com>
 <20180430145558.4308-9-npiggin@gmail.com>
 <1525168138.2325.100.camel@kernel.crashing.org>
 <20180501203721.7b60fcd8@roar.ozlabs.ibm.com>
Date: Mon, 07 May 2018 20:35:42 +1000
Message-ID: <87zi1bbvnl.fsf@concordia.ellerman.id.au>
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

> On Tue, 01 May 2018 19:48:58 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Tue, 2018-05-01 at 00:55 +1000, Nicholas Piggin wrote:
>> > The RAW console does not need writes to be atomic, so relax
>> > opal_put_chars to be able to do partial writes, and implement an
>> > _atomic variant which does not take a spinlock. This API is used
>> > in xmon, so the less locking that is used, the better chance there
>> > is that a crash can be debugged.  
>> 
>> Same comment I already had :-) "atomic" in Linux tends to mean
>> something else (ie, atomic context), so I'd rather have something
>> like opal_put_chars_sync() or such...
>
> Oh yeah, I didn't ignore you, just... I thought atomic was okay.
> atomic *also* tends to mean happens atomically. I think the in
> atomic context meaning actually tends to be inatomic.
>
> Sync I actually thought could be more easily confused with
> synchronous vs asynchronous here.

I think we probably want opal_put_chars() to stay as it is.

And then add a variant for the call (just xmon?) that want lock free
behaviour.

opal_put_chars_unlocked() or something?

cheers
