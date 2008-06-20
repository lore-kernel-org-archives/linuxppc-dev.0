Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18523.1109.809247.646816@cargo.ozlabs.ibm.com>
Date: Fri, 20 Jun 2008 11:13:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [RFC 1/3] powerpc: __copy_tofrom_user tweaked for
	Cell
In-Reply-To: <OF3C6636F6.52E3D242-ONC125746D.005214B0-C125746D.0053FABE@de.ibm.com>
References: <200806191753.59599.markn@au1.ibm.com>
	<200806191643.59037.arnd@arndb.de>
	<OF3C6636F6.52E3D242-ONC125746D.005214B0-C125746D.0053FABE@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <ellerman@au1.ibm.com>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gunnar von Boehn writes:

> The "regular" code was much slower for the normal case and has a special
> version for the 4K optimized case.

That's a slightly inaccurate view...

The reason for having the two cases is that when I profiled the
distribution of sizes and alignments of memory copies in the kernel,
the result was that almost all copies (something like 99%, IIRC) were
either 128 bytes or less, or else a whole page at a page-aligned
address.

Thus we get the best performance by having a simple copy routine with
minimal setup overhead for the small copy case, plus an aggressively
optimized page copy routine.  Spending time setting up for a
multi-cacheline copy that's not a whole page is just going to hurt the
small copy case without providing any real benefit.

Transferring data over loopback is possibly an exception to that.
However, it's very rare to transfer large amounts of data over
loopback, unless you're running a benchmark like iperf or netperf. :-/

Paul.
