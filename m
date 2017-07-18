Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBQQJ4zMpzDrFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 13:20:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, alistair@popple.id.au, dwmw2@infradead.org,
 rlippert@google.com
Subject: Re: [PATCH v3 06/10] powerpc/opal: Rework the opal-async interface
In-Reply-To: <1500338458.2475.3.camel@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
 <20170712042304.19745-7-cyrilbur@gmail.com>
 <1500291037.8256.13.camel@gmail.com> <1500338458.2475.3.camel@gmail.com>
Date: Tue, 18 Jul 2017 13:20:08 +1000
Message-ID: <8760eq1lef.fsf@concordia.ellerman.id.au>
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
> On Mon, 2017-07-17 at 21:30 +1000, Balbir Singh wrote:
>> On Wed, 2017-07-12 at 14:23 +1000, Cyril Bur wrote:
>> >  static int __opal_async_get_token(void)
>> >  {
>> >  	unsigned long flags;
>> >  	int token;
>> >  
>> > -	spin_lock_irqsave(&opal_async_comp_lock, flags);
>> > -	token = find_first_bit(opal_async_complete_map, opal_max_async_tokens);
>> > -	if (token >= opal_max_async_tokens) {
>> > -		token = -EBUSY;
>> > -		goto out;
>> > -	}
>> > -
>> > -	if (__test_and_set_bit(token, opal_async_token_map)) {
>> > -		token = -EBUSY;
>> > -		goto out;
>> > +	for (token = 0; token < opal_max_async_tokens; token++) {
>> > +		spin_lock_irqsave(&opal_async_comp_lock, flags);
>> 
>> Why is the spin lock inside the for loop? If the last token is free, the
>> number of times we'll take and release a lock is extensive, why are we
>> doing it this way?
>
> Otherwise we might hold the lock for quite some time.

No we won't. A loop over a few 10s or 100s of tokens is not going to
take long, compared to the overhead of taking the lock every iteration
through the loop.

If the linear search with the lock held is a bottle neck, then you can
keep a hint variable which tracks the last freed token and start
searching from there.

cheers
