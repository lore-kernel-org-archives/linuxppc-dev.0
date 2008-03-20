Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF03EDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 13:41:01 +1100 (EST)
Date: Wed, 19 Mar 2008 19:40:25 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 6/8] ptrace: arch_ptrace -ENOSYS return
In-Reply-To: <20080319212024.EA03126F995@magilla.localdomain>
Message-ID: <alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319212024.EA03126F995@magilla.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 19 Mar 2008, Roland McGrath wrote:
>
> The arch_ptrace and compat_arch_ptrace functions can now return
> -ENOSYS for requests they do not actually implement in arch
> code.

Hmm.. I see the whole series, and I see this patch, but I think it adds 
new code and new complexity, and I don't really see *why*.

So I'm obviously not going to apply it outside the merge window anyway, 
but even for later I'd really like to know what you're building up 
towards, because without understanding the upsides it just feels like it 
adds ugly code and unnecessary infrastructure without any real point to 
it.

And I have to say, I really hate that

		ret = arch_ptrace(child, request, addr, data);
		if (ret == -ENOSYS && !forced_successful_syscall_return())
			ret = ptrace_request(child, request, addr, data);

thing. Instead of doing it that ugly way (return value and a special 
per-arch forced_successful_syscall_return() thing), this really smells 
like you just want to change the calling conventions for "arch_ptrace()" 
instead.

Wouldn't it be nicer to just let "arch_ptrace()" return a flag saying 
whether it handled things or not?

			Linus
