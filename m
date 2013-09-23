Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 235B02C00E6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 06:52:42 +1000 (EST)
Message-ID: <1379969467.11249.21.camel@pasglop>
Subject: Re: [PATCH] powerpc/irq: Run softirqs off the top of the irq stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2013 06:51:07 +1000
In-Reply-To: <CA+55aFwcPU+fAqDGp0QhSYip7MYPBB+kQiU4GHEdgMo82i7RVg@mail.gmail.com>
References: <1379620267-25191-1-git-send-email-fweisbec@gmail.com>
 <CA+55aFyXf370Ds6FH5wPPycZLSPD5qiP7rjWqxwDetfHfKjg1w@mail.gmail.com>
 <alpine.DEB.2.02.1309201244080.4089@ionos.tec.linutronix.de>
 <20130920162603.GA30381@localhost.localdomain>
 <CA+55aFyBcjP2U6ipzZay=FdhzA4oFNwE4tU0OcJJhwFvgoeALw@mail.gmail.com>
 <CAFTL4hzucS5nJbCrArPv9zfY=QpyUESMK2Th0tKFHVCjDP7-eA@mail.gmail.com>
 <1379799901.24090.6.camel@pasglop> <523E4F8A.7020708@zytor.com>
 <1379824754.24090.11.camel@pasglop> <1379824861.24090.12.camel@pasglop>
 <20130922162410.GA10649@laptop.programming.kicks-ass.net>
 <1379887000.24090.19.camel@pasglop>
 <CA+55aFwaf_Wst=AS75ydBJVQ6aJxPfAzXdt-UXj3qC9WeUt7kw@mail.gmail.com>
 <1379889489.24090.34.camel@pasglop> <1379910958.6625.3.camel@pasglop>
 <CA+55aFwcPU+fAqDGp0QhSYip7MYPBB+kQiU4GHEdgMo82i7RVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: James Hogan <james.hogan@imgtec.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, Helge Deller <deller@gmx.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, "James
 E.J. Bottomley" <jejb@parisc-linux.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-23 at 09:47 -0700, Linus Torvalds wrote:
> On Sun, Sep 22, 2013 at 9:35 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > This is the "band aid" discussed so far for the stack overflow
> > problem for powerpc.
> 
> I don't think it's a "band-aid" in any way, except perhaps in the
> sense that there are certainly other things we can also do in this
> series (ie I liked Frederic's cleanups etc).

Ah yes, I thought of it as a band-aid in the sense that a better
approach would be to switch to the irq stack earlier like x86_64 does
but that would be a lot more invasive. Definitely something I would look
into if I was to tackle changing how we do per-cpu and the PACA though.

Cheers,
Ben.
