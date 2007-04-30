Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17973.33249.852991.342860@cargo.ozlabs.ibm.com>
Date: Mon, 30 Apr 2007 15:42:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: Incorrect order of last two arguments of ptrace for requests
	PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
In-Reply-To: <20061204215825.GB22514@krispykreme>
References: <453F421A.6070507@in.ibm.com>
	<1164220580.12365.8.camel@hades.cambridge.redhat.com>
	<20061204215825.GB22514@krispykreme>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard writes:

> I looked at this a while ago and my decision at the time was to keep the
> old implementation around for a while and create two new ones that match
> the x86 numbering:
> 
> #define PTRACE_GETREGS            12
> #define PTRACE_SETREGS            13
> #define PTRACE_GETFPREGS          14
> #define PTRACE_SETFPREGS          15
> 
> I hate gratuitous differences, each ptrace app ends up with a sea of
> ifdefs.
> 
> Also I think it would be worth changing getregs/setregs to grab the
> entire pt_regs structure. Otherwise most ops (gdb, strace etc) will just
> have to make multiple ptrace calls to get the nia etc.

Did you do a patch to do that?

Paul.
