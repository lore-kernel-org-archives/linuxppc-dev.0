Return-Path: <anton@ozlabs.org>
Date: Tue, 5 Dec 2006 08:58:25 +1100
From: Anton Blanchard <anton@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Incorrect order of last two arguments of ptrace for requests
	PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
Message-ID: <20061204215825.GB22514@krispykreme>
References: <453F421A.6070507@in.ibm.com>
	<1164220580.12365.8.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1164220580.12365.8.camel@hades.cambridge.redhat.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> > In ptrace, when request is PPC_PTRACE_GETREGS, SETREGS, GETFPREGS and 
> > SETFPREGS, order of the last two arguments is not correct.
> > 
> > General format of ptrace is ptrace (request, pid, addr, data).  For the 
> > above mentioned request ids in ppc64, if we use ptrace like
> > 
> >  long reg[32];
> >  ptrace (PPC_PTRACE_GETREGS, pid, 0, &reg[0]);
> > 
> > the return value is always -1.
> > 
> > If we exchange the last two arguments like,
> > 
> >  ptrace (PPC_PTRACE_GETREGS, pid, &reg[0], 0);
> > 
> > it works!
> > 
> > This is because PPC_PTRACE_GETREGS option for powerpc is implemented 
> > such that general purpose
> > registers of the child process get copied to the address variable 
> > instead of data variable. Same is
> > the case with other PPC request options PPC_PTRACE_SETREGS, GETFPREGS 
> > and SETFPREGS.
> > 
> > Prepared a patch for this problem and tested with 2.6.18-rc6 kernel. 
> > This patch can be applied directly to 2.6.19-rc3 kernel.

I looked at this a while ago and my decision at the time was to keep the
old implementation around for a while and create two new ones that match
the x86 numbering:

#define PTRACE_GETREGS            12
#define PTRACE_SETREGS            13
#define PTRACE_GETFPREGS          14
#define PTRACE_SETFPREGS          15

I hate gratuitous differences, each ptrace app ends up with a sea of
ifdefs.

Also I think it would be worth changing getregs/setregs to grab the
entire pt_regs structure. Otherwise most ops (gdb, strace etc) will just
have to make multiple ptrace calls to get the nia etc.

Anton
