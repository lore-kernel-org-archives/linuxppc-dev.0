Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC 1/3] powerpc: __copy_tofrom_user tweaked for
	Cell
Date: Sat, 21 Jun 2008 23:06:48 +0200
References: <200806191753.59599.markn@au1.ibm.com>
	<200806210400.20794.arnd@arndb.de>
	<18524.33738.450400.63491@cargo.ozlabs.ibm.com>
In-Reply-To: <18524.33738.450400.63491@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806212306.49584.arnd@arndb.de>
Cc: Gunnar von Boehn <VONBOEHN@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 21 June 2008, Paul Mackerras wrote:
> Is this application really transferring bulk data and using buffers
> that aren't a multiple of the page size? =A0Do you know whether the
> copies ended up being misaligned?

In the problem case that was reported to me, it was all bulk data,
and all the oprofile samples showed up in the unaligned code path
of the usercopy code, which does the microcoded (on cell) shift
operations.

> Of course, if we really want the fastest copy possible, the thing to
> do is to use VMX loads and stores on 970, POWER6 and Cell. =A0The
> overhead of setting up to use VMX in the kernel would probably kill
> any advantage, though -- at least, that's what I found when I tried
> using VMX for copy_page in the kernel on 970 a few years ago.

Right, that is understandable, we saw similar results when Sebastian
was working on VMX optimized AES code.

> Let's see what Mark comes up with. =A0We may be able to find a way to do
> it that works well across all current CPUs and also is OK for small
> copies. =A0If not we might need to do what you suggest.

ok.

	Arnd <><
