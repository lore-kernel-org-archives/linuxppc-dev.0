Return-Path: <SRS0+275bbb1d53a6f5600fb4+1670+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81657DDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 18:40:27 +1100 (EST)
Date: Thu, 20 Mar 2008 03:40:05 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/8] ptrace: arch_ptrace -ENOSYS return
Message-ID: <20080320074005.GB19969@infradead.org>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319212024.EA03126F995@magilla.localdomain>
	<alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org>
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
	Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2008 at 07:40:25PM -0700, Linus Torvalds wrote:
> 
> And I have to say, I really hate that
> 
> 		ret = arch_ptrace(child, request, addr, data);
> 		if (ret == -ENOSYS && !forced_successful_syscall_return())
> 			ret = ptrace_request(child, request, addr, data);
> 
> thing. Instead of doing it that ugly way (return value and a special 
> per-arch forced_successful_syscall_return() thing), this really smells 
> like you just want to change the calling conventions for "arch_ptrace()" 
> instead.
> 
> Wouldn't it be nicer to just let "arch_ptrace()" return a flag saying 
> whether it handled things or not?

I think the easiest and cleanest would be to just drop this whole
series.  There's no inherent advantage of

	ret = -ENOSYS;

in the arch_ptrace default case over

	ret = ptrace_request(...);
