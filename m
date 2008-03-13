Return-Path: <jdike@addtoit.com>
Received: from saraswathi.solana.com (saraswathi.solana.com [198.99.130.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAAFDDE0EA
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 01:43:45 +1100 (EST)
Date: Thu, 13 Mar 2008 10:42:21 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH -mm 2/4] ptrace: compat_ptrace_request siginfo
Message-ID: <20080313144221.GA10328@c2.user-mode-linux.org>
References: <20080313083107.8BDE926F992@magilla.localdomain>
	<20080313083243.E551A26F992@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080313083243.E551A26F992@magilla.localdomain>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 13, 2008 at 01:32:43AM -0700, Roland McGrath wrote:
> On powerpc, this fixes a longstanding regression of 32-bit ptrace
> calls on 64-bit kernels vs native calls (64-bit calls or 32-bit
> kernels).  This can be seen in a 32-bit call using PTRACE_GETSIGINFO
> to examine e.g. siginfo_t.si_addr from a signal that sets it.
> (This was broken as of 2.6.24 and, I presume, many or all prior versions.)

BTW, this also fixes a long-standing bug in x86_64 ptrace32_siginfo:

	ret = sys_ptrace(request, pid, addr, (unsigned long)si);
	if (ret)
		return ret;
	if (request == PTRACE_GETSIGINFO) {
		if (copy_from_user(&ssi, si, sizeof(siginfo_t)))
			return -EFAULT;
		ret = copy_siginfo_to_user32(si32, &ssi);
	}

si comes back with the upper bits of si_code missing, courtesy of
copy_siginfo_to_user:

	err |= __put_user((short)from->si_code, &to->si_code);

causing copy_siginfo_to_user32 to not copy any fields of the union
past the first word because the upper 16 bits are used to figure out
what needs copying.

			Jeff

-- 
Work email - jdike at linux dot intel dot com
