Return-Path: <rsa@us.ibm.com>
Subject: Re: [PATCH] powerpc: Make rtas console _much_ faster
From: Ryan Arnold <rsa@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20060418185534.B1ADF679F0@ozlabs.org>
References: <20060418185534.B1ADF679F0@ozlabs.org>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 15:03:11 -0500
Message-Id: <1145563391.29313.174.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-04-18 at 20:55 +0200, Michael Ellerman wrote:

> There's already code in the hvc_console driver to make the khvcd thread do
> a "quick" loop, where it just calls yield() instead of sleeping. The only code
> that triggered that behaviour was recently removed though, which I don't
> quite understand.

I think I'm the guilty part and I removed that code because it was silly
to be pushing to the tty with a partially filled buffer when we could
pack it up full.  The original intention of HVC_POLL_QUICK was for
letting the TTY grok the data read from firmware.  I think I was just
worried about 'off by one' errors and did it to be safe.  I didn't count
on the write frequency side-effect

The hvc_console was originally quite speedy after I added khvcd (before
it was broken apart into back-end/front-end).  We should review it for
performance on all platforms again in the future.

> Still, if we set HVC_POLL_QUICK whenever the push hvc_push() doesn't push all
> characters (ie. RTAS blocks), we can get good performance out of the hvc_rtas
> backend. With this patch the "benchmark" takes ~2.8 seconds.

You might as well use HVC_POLL_QUICK to speed up the write.  I put that
construct in for quick reading, not quick writing but it is a dead at
the moment.  Maybe rename it HVC_WRITE_QUICK?

> I'll test this on P5 LPAR, is there anyone else that uses hvc_console?
> Thoughts?

btw, there are a lot of users of hvc_console, power4 (non-interrupt
driven), power5 (interrupt-driven), cbe simulator, and rtas console.

Is it possible to make the poll frequency platform dependent?

-- 
Ryan S. Arnold <rsa@us.ibm.com>
IBM Linux Technology Center
Linux on Power Toolchain
