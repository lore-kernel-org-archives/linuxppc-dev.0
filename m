Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200502050122.27254.arnd@arndb.de>
References: <20050204072254.GA17565@austin.ibm.com>
	<200502041336.59892.arnd@arndb.de> <1107560989.2189.119.camel@gaston>
	<200502050122.27254.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 12:47:05 +1100
Message-Id: <1107568025.2189.136.camel@gaston>
Mime-Version: 1.0
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


> This is the patch to evaluate CPU_HAS_FEATURE() at compile time whenever
> possible. Testing showed that vmlinux shrinks around 4000 bytes with
> g5_defconfig. I also checked that pSeries code is completely unaltered
> semantically when support for all CPU types is enabled, although a few
> instructions are emitted in a different order by gcc.
> 
> I have made cpu_has_feature() an inline function that expects the full
> name of a feature bit while the CPU_HAS_FEATURE() macro still behaves
> the same way as in Olofs original patch for now.

Note that this doesn't the asm part of it, where feature "sections"
are nop'ed out... it may be interesting to get rid of the nops too
here, oh well, that's too complicated for now.

Ben.
