Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BEBF1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 20:14:01 +1100 (AEDT)
Date: Fri, 15 Jan 2016 10:13:48 +0100
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
Message-ID: <20160115091348.GA27936@worktop>
References: <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115085554.GF3421@worktop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 15, 2016 at 09:55:54AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 14, 2016 at 01:29:13PM -0800, Paul E. McKenney wrote:
> > So smp_mb() provides transitivity, as do pairs of smp_store_release()
> > and smp_read_acquire(), 
> 
> But they provide different grades of transitivity, which is where all
> the confusion lays.
> 
> smp_mb() is strongly/globally transitive, all CPUs will agree on the order.
> 
> Whereas the RCpc release+acquire is weakly so, only the two cpus
> involved in the handover will agree on the order.

And the stuff we're confused about is how best to express the difference
and guarantees of these two forms of transitivity and how exactly they
interact.

And smp_load_acquire()/smp_store_release() are RCpc because TSO archs
and PPC. the atomic*_{acquire,release}() are RCpc because PPC and
LOCK,UNLOCK are similarly RCpc because of PPC.

Now we'd like PPC to stick a SYNC in either LOCK or UNLOCK so at least
the locks are RCsc again, but they resist for performance reasons but
waver because they don't want to be the ones finding all the nasty bugs
because they're the only one.

Now the thing I worry about, and still have not had an answer to is if
weakly ordered MIPS will end up being RCsc or RCpc for their locks if
they get implemented with SYNC_ACQUIRE and SYNC_RELEASE instead of the
current SYNC.
