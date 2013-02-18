Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 7ED4E2C0293
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 03:31:31 +1100 (EST)
Message-ID: <1361205087.23152.159.camel@gandalf.local.home>
Subject: Re: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
From: Steven Rostedt <rostedt@goodmis.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Mon, 18 Feb 2013 11:31:27 -0500
In-Reply-To: <5122551E.1080703@linux.vnet.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
 <CANN689F9S7c1M8+cEpz3tsxGF34+NTRBLvxgPUOtbvav5u+RRA@mail.gmail.com>
 <5122551E.1080703@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, Michel Lespinasse <walken@google.com>,
 mingo@kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rjw@sisk.pl,
 namhyung@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, oleg@redhat.com, vincent.guittot@linaro.org,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-02-18 at 21:51 +0530, Srivatsa S. Bhat wrote:
> Hi Michel,

> Yes.. I don't think we can avoid that. Moreover, since we _want_ unfair
> reader/writer semantics to allow flexible locking rules and guarantee
> deadlock-safety, having a recursive reader side is not even an issue, IMHO.

Recursive unfair reader lock may guarantee deadlock-safety, but
remember, it adds a higher probability of live-locking the write_lock.
Which is another argument to keep this separate to cpu hotplug only.

-- Steve
