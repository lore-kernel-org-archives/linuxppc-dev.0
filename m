Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id D158B2C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 05:14:22 +1000 (EST)
Date: Wed, 01 May 2013 15:14:19 -0400 (EDT)
Message-Id: <20130501.151419.1237664751661506825.davem@davemloft.net>
To: eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next] af_unix: fix a fatal race with bit fields
From: David Miller <davem@davemloft.net>
In-Reply-To: <1367421843.11020.43.camel@edumazet-glaptop>
References: <1367372393.22115.6.camel@pasglop>
 <20130501.033650.703182794549888825.davem@davemloft.net>
 <1367421843.11020.43.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, ambrose@google.com,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 01 May 2013 08:24:03 -0700

> [PATCH v2] af_unix: fix a fatal race with bit fields
> 
> Using bit fields is dangerous on ppc64/sparc64, as the compiler [1]
> uses 64bit instructions to manipulate them.
> If the 64bit word includes any atomic_t or spinlock_t, we can lose
> critical concurrent changes.
> 
> This is happening in af_unix, where unix_sk(sk)->gc_candidate/
> gc_maybe_cycle/lock share the same 64bit word.
> 
> This leads to fatal deadlock, as one/several cpus spin forever
> on a spinlock that will never be available again.
> 
> A safer way would be to use a long to store flags.
> This way we are sure compiler/arch wont do bad things.
> 
> As we own unix_gc_lock spinlock when clearing or setting bits,
> we can use the non atomic __set_bit()/__clear_bit().
> 
> recursion_level can share the same 64bit location with the spinlock,
> as it is set only with this spinlock held.
> 
> [1] bug fixed in gcc-4.8.0 :
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=52080
> 
> Reported-by: Ambrose Feinstein <ambrose@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Applied and queued up for -stable, thanks Eric.
