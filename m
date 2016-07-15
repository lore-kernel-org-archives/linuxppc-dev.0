Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rrY8R1xnGzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 23:20:06 +1000 (AEST)
Date: Fri, 15 Jul 2016 14:19:51 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, bhe@redhat.com,
 arnd@arndb.de, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com, bauerman@linux.vnet.ibm.com,
 dyoung@redhat.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 3/3] kexec: extend kexec_file_load system call
Message-ID: <20160715131950.GB19840@leverpostej>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715130955.GC23514@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 15, 2016 at 09:09:55AM -0400, Vivek Goyal wrote:
> On Tue, Jul 12, 2016 at 10:42:01AM +0900, AKASHI Takahiro wrote:
> 
> [..]
> > -SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > +SYSCALL_DEFINE6(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
> > -		unsigned long, flags)
> > +		unsigned long, flags, const struct kexec_fdset __user *, ufdset)
> 
> Can one add more parameters to existing syscall. Can it break existing
> programs with new kernel? I was of the impression that one can't do that.
> But may be I am missing something.

I think the idea was that we would only look at the new params if a new
flags was set, and otherwise it would behave as the old syscall.

Regardless, I think it makes far more sense to add a kexec_file_load2
syscall if we're going to modify the prototype at all. It's a rather
different proposition to the existing syscall, and needs to be treated
as such.

Thanks,
Mark.
