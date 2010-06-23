Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65244B6EFF
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 05:25:15 +1000 (EST)
Message-ID: <4C225F40.8000008@zytor.com>
Date: Wed, 23 Jun 2010 12:23:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 12/40] x86, compat: convert ia32 layer to use
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-13-git-send-email-imunsie@au1.ibm.com>
	<20100623101402.GA10564@lst.de> <20100623103619.GC5242@nowhere>
	<20100623104603.GB11845@lst.de> <20100623114116.GE5242@nowhere>
In-Reply-To: <20100623114116.GE5242@nowhere>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Baron <jbaron@redhat.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Greg Ungerer <gerg@uclinux.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2010 04:41 AM, Frederic Weisbecker wrote:
> On Wed, Jun 23, 2010 at 12:46:04PM +0200, Christoph Hellwig wrote:
>> On Wed, Jun 23, 2010 at 12:36:21PM +0200, Frederic Weisbecker wrote:
>>> I think we wanted that to keep the sys32_ prefixed based naming, to avoid
>>> collisions with generic compat handler names.
>>
>> For native syscalls we do this by adding a arch prefix inside the
>> syscall name, e.g.:
>>
>> arch/s390/kernel/sys_s390.c:SYSCALL_DEFINE(s390_fallocate)(int fd, int mode, loff_t offset,
>> arch/sparc/kernel/sys_sparc_64.c:SYSCALL_DEFINE1(sparc_pipe_real, struct pt_regs *, regs)
> 
> In fact we sort of wanted to standardize the name of arch overriden compat
> syscalls, so that userspace programs playing with syscalls tracing won't have
> to deal with arch naming differences.
> 

That seems totally wrong in so many ways.

What userspace sees is the system call name, e.g. fallocate or pipe.  It
should *not* be visible to userspace that there is an arch-specici
implementation.

There are already a huge amount of gratuitous user space ABI
differences, of course, partly because we *still* don't actually have a
systematic model for argument passing.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
