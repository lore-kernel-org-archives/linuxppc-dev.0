Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17169.8003.500873.998471@cargo.ozlabs.ibm.com>
Date: Sun, 28 Aug 2005 12:19:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <d18c6049f1976912db9a7022a85c158a@embeddededge.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
	<20050826225509.GF5541@smtp.west.cox.net>
	<da1e14409c0face6cee5b4d5fa750c00@embeddededge.com>
	<20050827050422.GC7234@siegfried.thelikelysolution.ca>
	<d18c6049f1976912db9a7022a85c158a@embeddededge.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek writes:

> Yes, the application interfaces are all defined as 100 Hz (10 mSec).
> If the POSIX timer implementation is done properly, it should be
> possible to determine the timer parameters to eliminate this, but
> I doubt any applications do this.  They all assume 10 mSec :-)

There are in fact only a few interfaces that work in terms of "clock
ticks", which are 10ms as far as userspace is concerned.  I can think
of times() and that's about it.  There are also the si_utime and
si_stime fields of the siginfo_t that comes along with a SIGCHLD.  All
of those are about reporting CPU time used, not about specifying
timeouts.

All of the interfaces that specify timeouts or control timers use
struct timeval (seconds + microseconds) or struct timespec (seconds +
nanoseconds), or else use milliseconds (e.g. poll()).

Paul.
