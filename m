Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBQG45N0kzDrDf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 13:13:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, alistair@popple.id.au, dwmw2@infradead.org,
 rlippert@google.com
Subject: Re: [PATCH v3 02/10] mtd: powernv_flash: Lock around concurrent
 access to OPAL
In-Reply-To: <1500340459.2475.6.camel@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
 <20170712042304.19745-3-cyrilbur@gmail.com>
 <1500276875.8256.3.camel@gmail.com> <1500278150.29477.1.camel@gmail.com>
 <1500283754.8256.11.camel@gmail.com> <1500340459.2475.6.camel@gmail.com>
Date: Tue, 18 Jul 2017 13:12:58 +1000
Message-ID: <878tjm1lqd.fsf@concordia.ellerman.id.au>
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

Cyril Bur <cyrilbur@gmail.com> writes:

> On Mon, 2017-07-17 at 19:29 +1000, Balbir Singh wrote:
>> On Mon, 2017-07-17 at 17:55 +1000, Cyril Bur wrote:
>> > On Mon, 2017-07-17 at 17:34 +1000, Balbir Singh wrote:
>> > > On Wed, 2017-07-12 at 14:22 +1000, Cyril Bur wrote:
>> > > > OPAL can only manage one flash access at a time and will return an
>> > > > OPAL_BUSY error for each concurrent access to the flash. The simplest
>> > > > way to prevent this from happening is with a mutex.
>> > > > 
>> > > > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
>> > > > ---
>> > > 
>> > > Should the mutex_lock() be mutex_lock_interruptible()? Are we OK waiting on
>> > > the mutex while other operations with the lock are busy?
>> > > 
>> > 
>> > This is a good question. My best interpretation is that
>> > _interruptible() should be used when you'll only be coming from a user
>> > context. Which is mostly true for this driver, however, MTD does
>> > provide kernel interfaces, so I was hesitant, there isn't a great deal
>> > of use of _interruptible() in drivers/mtd. 
>> > 
>> > Thoughts?
>> 
>> What are the kernel interfaces (I have not read through mtd in detail)?
>> I would still like to see us not blocked in mutex_lock() across threads
>> for parallel calls, one option is to use mutex_trylock() and return if
>> someone already holds the mutex with -EBUSY, but you'll need to evaluate
>> what that means for every call.
>
> Yeah maybe mutex_trylock() is the way to go, thinking quickly, I don't
> see how it could be a problem for userspace using powernv_flash. I'm
> honestly not too sure about the depths of the mtd kernel interfaces but
> I've seen a tonne of cool stuff you could do, hence my reluctance to go
> with _interruptible()

If you use trylock that means all your callers now need to handle EBUSY,
which I doubt they do. Which means it goes up to userspace, which most
users will just treat as a hard error.

So that sounds like a bad plan to me.

cheers
