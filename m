Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 0CE0F2C0099
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 15:00:08 +1000 (EST)
Date: Wed, 05 Jun 2013 22:00:05 -0700 (PDT)
Message-Id: <20130605.220005.1262211330700518675.davem@davemloft.net>
To: eric.dumazet@gmail.com
Subject: Re: [PATCH 5/5] net: Block MSG_CMSG_COMPAT in send(m)msg and
 recv(m)msg
From: David Miller <davem@davemloft.net>
In-Reply-To: <1370493325.24311.332.camel@edumazet-glaptop>
References: <aa015609319786835bcab445d507faa75c11f111.1369177867.git.luto@amacapital.net>
 <CAEjGV6xcF776C6N6VxeMY0Vyk+X51oNixdbN42-xkWjQOaMEQA@mail.gmail.com>
 <1370493325.24311.332.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mikey@neuling.org, netdev@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net, linuxppc-dev@ozlabs.org,
 anton@samba.org, trinity@vger.kernel.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 05 Jun 2013 21:35:25 -0700

> On Thu, 2013-06-06 at 12:56 +1000, Michael Neuling wrote:
>> On Thu, May 23, 2013 at 7:07 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> > MSG_CMSG_COMPAT is (AFAIK) not intended to be part of the API --
>> > it's a hack that steals a bit to indicate to other networking code
>> > that a compat entry was used.  So don't allow it from a non-compat
>> > syscall.
>> 
>> Dave & Linus
>> 
>> This is causing a regression on 64bit powerpc with 32bit usermode.
>> When I hit userspace, udev is broken and I suspect all networking is
>> broken as well.
>> 
>> Can we please revert 1be374a0518a288147c6a7398792583200a67261 upstream?
>> 
> 
> It seems to also break x86_64, if using 32bit usermode.

Sorry, I only merged this because Ingo Molnar and others kept beating
me over the head about merging this fix.

Linus please revert, and I will not bow to such pressure in the future,
I should know better.
