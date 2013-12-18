Return-Path: <anton@samba.org>
Date: Wed, 18 Dec 2013 21:15:02 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc: Make 64-bit non-VMX __copy_tofrom_user bi-endian
Message-ID: <20131218211502.034c3eb0@kryten>
In-Reply-To: <20131218092957.4a12cbcf@kryten>
References: <20131218092957.4a12cbcf@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> [ This is a rare but nasty LE issue. Most of the time we use the
> POWER7 optimised __copy_tofrom_user_power7 loop, but when it hits an
> exception we fall back to the base __copy_tofrom_user loop. - Anton ]

To try and catch any screw ups in our ppc64 memcpy and copy_tofrom_user
loops, I wrote a quick test:

http://ozlabs.org/~anton/junkcode/validate_kernel_copyloops.tar.gz

"make check" runs through all source and destination alignments for a
range of sizes. It verifies the data was copied correctly and the
redzone before and after were untouched.

It tests:

copyuser_64
copyuser_power7
memcpy_64
memcpy_power7

memcpy_64 is currently unused on LE, but I added Paul McKenney's LE
fixes regardless. copyuser_64 has the same LE fix (posted yesterday).
All loops pass the test on both LE and BE.

Anton
