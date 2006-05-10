Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17506.31456.68099.57515@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 09:44:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Richard Henderson <rth@twiddle.net>, t@twiddle.net,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linuxppc-dev@ozlabs.org, amodra@bigpond.net
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <17506.29128.591758.502430@cargo.ozlabs.ibm.com>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<17506.29128.591758.502430@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

> Hmmm...  Would it be sufficient to use a RELOC_HIDE in __get_cpu_var,
> like this?
> 
> #define __get_cpu_var(x)	(*(RELOC_HIDE(&per_cpu__##x, 0)))

But that won't work because the compiler can still cache &per_cpu__x.
I guess I have to do this:

#define __get_cpu_var(var, cpu)					\
	(*(__typeof__(&per_cpu__##var))({			\
		void *__ptr;					\
		asm("addi %0,13,per_cpu__"#var"@tprel"		\
		    : "=r" (__ptr));				\
		__ptr;						\
	}))

That means we lose the possible optimization of combining the addi
into a following load or store.  Bah.  However, I guess it's still
better than what we do at the moment.

Paul.
