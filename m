Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 34AB82C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 11:40:11 +1000 (EST)
Message-ID: <1367372393.22115.6.camel@pasglop>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 01 May 2013 11:39:53 +1000
In-Reply-To: <1367370761.11020.22.camel@edumazet-glaptop>
References: <1367370761.11020.22.camel@edumazet-glaptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev <netdev@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>,
 Ambrose Feinstein <ambrose@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-30 at 18:12 -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Using bit fields is dangerous on ppc64, as the compiler uses 64bit
> instructions to manipulate them. If the 64bit word includes any
> atomic_t or spinlock_t, we can lose critical concurrent changes.
> 
> This is happening in af_unix, where unix_sk(sk)->gc_candidate/
> gc_maybe_cycle/lock share the same 64bit word.
> 
> This leads to fatal deadlock, as one/several cpus spin forever
> on a spinlock that will never be available again.
> 
> Reported-by: Ambrose Feinstein <ambrose@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
> 
> Could ppc64 experts confirm using byte is safe, or should we really add
> a 32bit hole after the spinlock ? If so, I wonder how many other places
> need a change...

Wow, nice one !

I'm not even completely certain bytes are safe to be honest, though
probably more than bitfields. I'll poke our compiler people.

The worry is of course how many more of these do we potentially have ? 
We might be able to automate finding these issues with sparse, I
suppose.

Also I'd be surprised if ppc64 is the only one with that problem... what
about sparc64 and arm64 ?

Cheers,
Ben.

>  include/net/af_unix.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index a8836e8..4520a23f 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -57,8 +57,8 @@ struct unix_sock {
>  	struct list_head	link;
>  	atomic_long_t		inflight;
>  	spinlock_t		lock;
> -	unsigned int		gc_candidate : 1;
> -	unsigned int		gc_maybe_cycle : 1;
> +	unsigned char		gc_candidate;
> +	unsigned char		gc_maybe_cycle;
>  	unsigned char		recursion_level;
>  	struct socket_wq	peer_wq;
>  };
> 
