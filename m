Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6E70B6F19
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 00:37:49 +1000 (EST)
Date: Thu, 24 Jun 2010 16:37:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 12/40] x86, compat: convert ia32 layer to use
Message-ID: <20100624143717.GA7565@lst.de>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-13-git-send-email-imunsie@au1.ibm.com>
	<20100623101402.GA10564@lst.de> <20100623103619.GC5242@nowhere>
	<20100623104603.GB11845@lst.de> <20100623114116.GE5242@nowhere>
	<4C225F40.8000008@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C225F40.8000008@zytor.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Greg Ungerer <gerg@uclinux.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 23, 2010 at 12:23:44PM -0700, H. Peter Anvin wrote:
> >> arch/s390/kernel/sys_s390.c:SYSCALL_DEFINE(s390_fallocate)(int fd, int mode, loff_t offset,
> >> arch/sparc/kernel/sys_sparc_64.c:SYSCALL_DEFINE1(sparc_pipe_real, struct pt_regs *, regs)
> > 
> > In fact we sort of wanted to standardize the name of arch overriden compat
> > syscalls, so that userspace programs playing with syscalls tracing won't have
> > to deal with arch naming differences.
> > 
> 
> That seems totally wrong in so many ways.
> 
> What userspace sees is the system call name, e.g. fallocate or pipe.  It
> should *not* be visible to userspace that there is an arch-specici
> implementation.

This is really just the in-kernel name.  With tracing we export it to
userspace, so agreed that we should stay consistent.  We need a good
way to override both native and compat system calls with arch version
to always export the sys_ / compat_sys names.
