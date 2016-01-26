Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com
 [IPv6:2607:f8b0:4001:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D8F91A0072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 10:45:26 +1100 (AEDT)
Received: by mail-ig0-x236.google.com with SMTP id mw1so946253igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 15:45:26 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20160126232921.GY4503@linux.vnet.ibm.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
 <20160126172227.GG6357@twins.programming.kicks-ass.net>
 <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
 <20160126201037.GU4503@linux.vnet.ibm.com>
 <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
 <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
 <20160126232921.GY4503@linux.vnet.ibm.com>
Date: Tue, 26 Jan 2016 15:45:23 -0800
Message-ID: <CA+55aFyD94yaA1QzXgfeO18T-czY3TVUi5n6r-9jOUObDeR-zQ@mail.gmail.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
 linux-mips <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Peter Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
 linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 "the arch/x86 maintainers" <x86@kernel.org>, xen-devel@lists.xenproject.org,
 Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org,
 James Hogan <james.hogan@imgtec.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 adi-buildroot-devel@lists.sourceforge.net,
 David Daney <ddaney.cavm@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-metag@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Joe Perches <joe@perches.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 26, 2016 at 3:29 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> No trailing data-dependent read, so agreed, no smp_read_barrier_depends()
> needed.  That said, I believe that we should encourage rcu_dereference*()
> or lockless_dereference() instead of READ_ONCE() for documentation
> reasons, though.

I agree that that is likely the right thing to do in pretty much all situations.

In theory, there might be performance situations where we'd want to
actively avoid the smp_read_barrier_depends() inherent in those, but
considering that it's only a performance issue on alpha, and we
probably have all of two or three people using Linux on alpha, it's a
pretty theoretical performance worry.

                  Linus
