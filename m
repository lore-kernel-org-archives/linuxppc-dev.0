Return-Path: <fweisbec@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id DDB25B70D3
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 21:41:19 +1000 (EST)
Received: by bwz1 with SMTP id 1so2373042bwz.15
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 04:41:17 -0700 (PDT)
Date: Wed, 23 Jun 2010 13:41:17 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/40] x86, compat: convert ia32 layer to use
Message-ID: <20100623114116.GE5242@nowhere>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-13-git-send-email-imunsie@au1.ibm.com>
	<20100623101402.GA10564@lst.de> <20100623103619.GC5242@nowhere>
	<20100623104603.GB11845@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100623104603.GB11845@lst.de>
Cc: Jason Baron <jbaron@redhat.com>, x86@kernel.org,
	Greg Ungerer <gerg@uclinux.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 23, 2010 at 12:46:04PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 23, 2010 at 12:36:21PM +0200, Frederic Weisbecker wrote:
> > I think we wanted that to keep the sys32_ prefixed based naming, to avoid
> > collisions with generic compat handler names.
> 
> For native syscalls we do this by adding a arch prefix inside the
> syscall name, e.g.:
> 
> arch/s390/kernel/sys_s390.c:SYSCALL_DEFINE(s390_fallocate)(int fd, int mode, loff_t offset,
> arch/sparc/kernel/sys_sparc_64.c:SYSCALL_DEFINE1(sparc_pipe_real, struct pt_regs *, regs)


In fact we sort of wanted to standardize the name of arch overriden compat
syscalls, so that userspace programs playing with syscalls tracing won't have
to deal with arch naming differences.
