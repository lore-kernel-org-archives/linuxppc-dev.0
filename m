Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53A181A003F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 08:29:41 +1100 (AEDT)
Date: Fri, 15 Jan 2016 22:29:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
 Will Deacon <will.deacon@arm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
 David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>,
 ddaney.cavm@gmail.com, james.hogan@imgtec.com,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160115212912.GN3421@worktop>
References: <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com> <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115173912.GU3818@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115173912.GU3818@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 15, 2016 at 09:39:12AM -0800, Paul E. McKenney wrote:
> Should we start putting litmus tests for the various examples
> somewhere, perhaps in a litmus-tests directory within each participating
> architecture?  I have a pile of powerpc-related litmus tests on my laptop,
> but they probably aren't doing all that much good there.

Yeah, or a version of them in C that we can 'compile'?
> 
> commit 2cb4e83a1b5c89c8e39b8a64bd89269d05913e41
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Fri Jan 15 09:30:42 2016 -0800
> 
>     documentation: Distinguish between local and global transitivity
>     
>     The introduction of smp_load_acquire() and smp_store_release() had
>     the side effect of introducing a weaker notion of transitivity:
>     The transitivity of full smp_mb() barriers is global, but that
>     of smp_store_release()/smp_load_acquire() chains is local.  This
>     commit therefore introduces the notion of local transitivity and
>     gives an example.
>     
>     Reported-by: Peter Zijlstra <peterz@infradead.org>
>     Reported-by: Will Deacon <will.deacon@arm.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

I think it fails to mention smp_mb__after_release_acquire(), although I
suspect we didn't actually introduce the primitive yet, which raises the
point, do we want to?
