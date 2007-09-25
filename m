Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18169.1165.5981.330400@cargo.ozlabs.ibm.com>
Date: Tue, 25 Sep 2007 22:52:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull powerpc.git merge branch
In-Reply-To: <24149ACB-D786-4415-99A8-117FAC9936E6@kernel.crashing.org>
References: <18168.62378.472571.655865@cargo.ozlabs.ibm.com>
	<24149ACB-D786-4415-99A8-117FAC9936E6@kernel.crashing.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Should this also go to -stable?

It turns out that it's not triggerable (as an oops) from userspace in
2.6.22 and earlier.  Commit 1b6610d6 of Ben H's took out #ifdef
CONFIG_PPC32 around a couple of CHECK_FULL_REGS calls, which is what
made it triggerable on ppc64.  We have an interesting difference
between ppc32 and ppc64 in our CHECK_FULL_REGS implementation - it's a
BUG_ON on 64-bit but just a printk on 32-bit.  So on 32-bit someone
could use it to spam the logs but not to actually crash the system.

So yes, I guess it should go to -stable once Linus takes it, but it's
a much less serious vulnerability in 2.6.22 and earlier than I first
thought (since it's only 32-bit, and just a user-triggerable printk).

And yes we should consolidate the CHECK_FULL_REGS implementations as a
WARN_ON with a counter to limit how many we do.

Paul.
