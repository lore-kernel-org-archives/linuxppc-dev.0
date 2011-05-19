Return-Path: <paulus@ozlabs.org>
Date: Thu, 19 May 2011 16:06:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 13/13] kvm/powerpc: Allow book3s_hv guests to use SMT
	processor modes
Message-ID: <20110519060610.GB8165@drongo>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104656.GN2837@brick.ozlabs.ibm.com>
	<F90D2118-7694-4AB0-9C17-8B449D14B9DF@suse.de>
	<20110517104422.GB7924@brick.ozlabs.ibm.com>
	<9A23FF37-0369-4DF7-89F7-62E6EA54C97F@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9A23FF37-0369-4DF7-89F7-62E6EA54C97F@suse.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 17, 2011 at 01:36:26PM +0200, Alexander Graf wrote:
>
> Just so I understand the scheme: One vcpu needs to go to MMU mode in
> KVM, it then sends IPIs to stop the other threads and finally we
> return from this wait here?

Actually, if one thread needs to get the other threads out of the
guest, it sets the HDEC to 0.  Since it's a shared register and
interrupts all threads on a 0 to -1 transition, setting it to 0 makes
all threads come out of the guest.

The IPI is for when we're going into the guest.  When we're in the
host, all the secondary threads are in nap and only the primary thread
is running.  (Offlining a cpu in the host results in the cpu/thread
going to nap mode.)  Sending an IPI to a napping thread wakes it up
and it resumes at the system reset vector with some bits set in SRR1
to say that it was previously in nap mode.

> Oh, I'm certainly fine with the scheme :). I would just like to
> understand it and see it documented somewhere, as it's slightly
> unintuitive.

It took some thought to work it out, so you're right, I should
definitely document it.

> Also, this scheme might confuse the host scheduler for a bit, as it
> might migrate threads to other host CPUs while it would prove
> beneficial for cache usage to keep them local. But since the
> scheduler doesn't know about the correlation between the threads, it
> can't be clever about it.

Well, it's not going to migrate a sleeping thread.  The accounting
gets slightly strange in that all the CPU time for running the 4 vcpus
in the vcore gets accounted to one of the vcpu threads (which one can
change over time).  However, the total across all qemu threads should
be correct.

Paul.
