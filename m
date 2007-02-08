Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17867.1342.763881.188430@cargo.ozlabs.ibm.com>
Date: Thu, 8 Feb 2007 22:10:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Oleg Verych <olecom@flower.upol.cz>
Subject: Kbuild change breaks the ppc64 build
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 5de043f4bd11a9e0a3e8daec7d1905da575a76b7 breaks the build on
64-bit powerpc because we no longer get the -m64 flag passed to gcc.
There is code in arch/powerpc/Makefile which adds (or used to add)
-m64 to AS, LD and CC if we are running on a 64-bit machine (which I
am) and have a biarch toolchain (which I do).  Without -m64, the
toolchain assumes 32-bit and all sorts of things break spectacularly.

I haven't yet tracked down exactly why this commit has this effect,
since I find it takes considerable time and effort to understand
Kbuild.

Paul.
