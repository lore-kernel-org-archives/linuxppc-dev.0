Return-Path: <anton@ozlabs.org>
Date: Sat, 5 Feb 2005 12:34:26 +1100
From: Anton Blanchard <anton@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20050205013426.GC11318@krispykreme.ozlabs.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com>
	<200502041336.59892.arnd@arndb.de>
	<1107560989.2189.119.camel@gaston>
	<200502050122.27254.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200502050122.27254.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> This is the patch to evaluate CPU_HAS_FEATURE() at compile time whenever
> possible. Testing showed that vmlinux shrinks around 4000 bytes with
> g5_defconfig. I also checked that pSeries code is completely unaltered
> semantically when support for all CPU types is enabled, although a few
> instructions are emitted in a different order by gcc.
> 
> I have made cpu_has_feature() an inline function that expects the full
> name of a feature bit while the CPU_HAS_FEATURE() macro still behaves
> the same way as in Olofs original patch for now.

Interesting :) However we already get bug reports with the current
CONFIG_POWER4_ONLY option. I worry about adding more options that users
could get wrong unless there is a noticeable improvement in performance.

Anton
