Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net (are.twiddle.net [64.81.246.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0071679F6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 02:15:20 +1000 (EST)
Date: Wed, 10 May 2006 08:47:13 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060510154702.GA28938@twiddle.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 10, 2006 at 02:03:59PM +1000, Paul Mackerras wrote:
> With this patch, 64-bit powerpc uses __thread for per-cpu variables.

How do you plan to address the compiler optimizing

	__thread int foo;
	{
	  use(foo);
	  schedule();
	  use(foo);
	}

into

	{
	  int *tmp = &foo;	// tls arithmetic here
	  use(*tmp);
	  schedule();
	  use(*tmp);
	}

Across the schedule, we may have changed cpus, making the cached
address invalid.


r~
