Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 200F61A0026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 18:45:31 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 16111-09 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 12 Sep 2014 09:45:26 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Chuck Ebbert' <cebbert.lkml@gmail.com>
Subject: RE: [PATCH v3 0/3] sched: Always check the integrity of the canary
Date: Fri, 12 Sep 2014 08:43:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17490889@AcuExch.aculab.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
 <063D6719AE5E284EB5DD2968C1650D6D17490245@AcuExch.aculab.com>
 <20140911122619.51ed1918@as>
In-Reply-To: <20140911122619.51ed1918@as>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "jcastillo@redhat.com" <jcastillo@redhat.com>,
 "akpm@google.com" <akpm@google.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "bmr@redhat.com" <bmr@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "prarit@redhat.com" <prarit@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, 'Aaron Tomlin' <atomlin@redhat.com>,
 "dzickus@redhat.com" <dzickus@redhat.com>, "riel@redhat.com" <riel@redhat.com>,
 "mingo@kernel.com" <mingo@kernel.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "jgh@redhat.com" <jgh@redhat.com>,
 "pzijlstr@redhat.com" <pzijlstr@redhat.com>,
 "oleg@redhat.com" <oleg@redhat.com>, "minchan@kernel.org" <minchan@kernel.org>,
 "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chuck Ebbert=20
> David Laight <David.Laight@ACULAB.COM> wrote:
>=20
> > From: Aaron Tomlin
> > > Currently in the event of a stack overrun a call to schedule()
> > > does not check for this type of corruption. This corruption is
> > > often silent and can go unnoticed. However once the corrupted
> > > region is examined at a later stage, the outcome is undefined
> > > and often results in a sporadic page fault which cannot be
> > > handled.
> > >
> > > The first patch adds a canary to init_task's end of stack.
> > > While the second patch provides a helper to determine the
> > > integrity of the canary. The third checks for a stack
> > > overrun and takes appropriate action since the damage
> > > is already done, there is no point in continuing.
> >
> > Clearly you've just been 'bitten' by a kernel stack overflow.
> > But a simple 'canary' isn't going to find most of the overflows
> > and will give an incorrect 'sense of security'.
> >
> > The canary will only work if the stack is densely written.
> > In practise the stack alignment rules create gaps, and the
> > most likely reason for overflow is a large on-stack buffer
> > that isn't actually written to.
> >
> > The only real way to detect kernel stack overflow is to arrange
> > for an unmapped page beyond the stack.
> > That costs KVA, but not much else.
> >
>=20
> That doesn't work either, because the threadinfo sits between the end of =
the
> stack and the beginning of the next page, making it possible to corrupt c=
ritical
> data without running off the page.

Then flip the order of the allocations so that the threadinfo is at the oth=
er end.
I'm not sure how many per-lwp structures the linux kernel has, but
I know that on netbsd the main thing the kernel stack hits is the fpu
save area - the end of that is the avx area which won't be needed when
the stack usage is large.
Everything else could be moved from the stack pages to the lwp struct itsel=
f.

	David
