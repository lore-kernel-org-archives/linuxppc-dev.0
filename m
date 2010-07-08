Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5DCA7B6EEE
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jul 2010 16:08:11 +1000 (EST)
Subject: Re: [PATCH] Adjust arch/powerpc inline asms for recent gcc change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
References: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 16:08:05 +1000
Message-ID: <1278569285.28659.76.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-06-25 at 11:56 +0200, Jakub Jelinek wrote:

>  static inline void sync(void)
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> index b8f152e..288d8b2 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -19,14 +19,14 @@ static __inline__ int atomic_read(const atomic_t *v)
>  {
>  	int t;
>  
> -	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
> +	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
>  
>  	return t;
>  }
>  

This gives me:

/home/benh/linux-powerpc-test/arch/powerpc/kernel/time.c: In function ‘timer_interrupt’:
/home/benh/linux-powerpc-test/arch/powerpc/include/asm/atomic.h:22: error: ‘asm’ operand has impossible constraints
make[2]: *** [arch/powerpc/kernel/time.o] Error 1

$ gcc --version
gcc (Debian 4.4.4-1) 4.4.4


Cheers,
Ben.
