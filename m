Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17409.5498.94107.591048@cargo.ozlabs.ibm.com>
Date: Sun, 26 Feb 2006 13:42:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH] ppc32: handle Book E debug exceptions on kernel stack
In-Reply-To: <20060224185251.GA9084@xyzzy.farnsworth.org>
References: <20060214190700.GB17822@xyzzy.farnsworth.org>
	<Pine.LNX.4.44.0602222217220.28948-100000@gate.crashing.org>
	<20060223234945.GB25101@localhost.localdomain>
	<20060224185251.GA9084@xyzzy.farnsworth.org>
Cc: linuxppc-embedded@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dale Farnsworth writes:

> There's a race between a critical exception and the normal exception
> entry path.  If a normal exception occurs in user mode and then a
> critical exception occurs before the normal exception handler has set
> r1 to the kernel stack area, we end up with r1 containing the user sp,
> though the critical exception occurred in kernel mode.

That's a separate problem from what we were discussing, which is why
program_check_exception is entered with interrupts disabled.

> I haven't yet come up with a way to detect this case and reliably use
> the kernel stack on a critical exception.

One way to solve this is to put the kernel stack pointer in some SPRGn
when exiting to usermode, and on critical exceptions, use that SPRGn
for the kernel stack if it is non-zero.  In the exception entry path
(for both normal and critical exceptions) put 0 in it once r1 has been
set up with a valid kernel stack pointer.  This also works if you have
to call firmware such as RTAS which runs in kernel mode but may put
arbitrary values in r1.

Paul.
