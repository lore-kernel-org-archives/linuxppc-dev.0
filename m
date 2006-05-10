Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17506.29128.591758.502430@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 09:05:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510154702.GA28938@twiddle.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, t@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Richard Henderson writes:

> How do you plan to address the compiler optimizing
> 
> 	__thread int foo;
> 	{
> 	  use(foo);
> 	  schedule();
> 	  use(foo);
> 	}
> 
> into
> 
> 	{
> 	  int *tmp = &foo;	// tls arithmetic here
> 	  use(*tmp);
> 	  schedule();
> 	  use(*tmp);
> 	}

Hmmm...  Would it be sufficient to use a RELOC_HIDE in __get_cpu_var,
like this?

#define __get_cpu_var(x)	(*(RELOC_HIDE(&per_cpu__##x, 0)))

Paul.
