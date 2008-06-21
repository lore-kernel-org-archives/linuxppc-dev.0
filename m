Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Cbe-oss-dev] [RFC 1/3] powerpc: __copy_tofrom_user tweaked for
	Cell
Date: Sat, 21 Jun 2008 04:00:20 +0200
References: <200806191753.59599.markn@au1.ibm.com>
	<OF3C6636F6.52E3D242-ONC125746D.005214B0-C125746D.0053FABE@de.ibm.com>
	<18523.1109.809247.646816@cargo.ozlabs.ibm.com>
In-Reply-To: <18523.1109.809247.646816@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806210400.20794.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 20 June 2008, Paul Mackerras wrote:

> Transferring data over loopback is possibly an exception to that.
> However, it's very rare to transfer large amounts of data over
> loopback, unless you're running a benchmark like iperf or netperf. :-/

Well, it is the exact case that came up in a real world scenario
for cell: On a network intensive application where the SPUs are
supposed to do all the work, we ended up not getting enough
data in and out through gbit ethernet because the PPU spent
much of its time in copy_to_user.

Going to 10gbit will make the problem even more apparent.

I understand that optimizing for this case will cost extra
branches for the other cases, but maybe we can find a better
compromise than before. Can you name a test case that you
consider important to optimize for for what you consider
real-life tests?

Doing some static compile-time analysis, I found that most
of the call sites (which are not necessarily most of
the run time calls) pass either a small constant size of
less than a few cache lines, or have a variable size but are
not at all performance critical.
Since the prefetching and cache line size awareness was
most of the improvement for cell (AFAIU), maybe we can
annotate the few interesting cases, say by introducing a
new copy_from_user_large() function that can be easily
optimized for large transfers on a given CPU, while
the remaining code keeps optmizing for small transfers
and may even get rid of the full page copy optimization
in order to save a branch.

	Arnd <><
