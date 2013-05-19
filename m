Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 9C5DE2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 May 2013 23:35:32 +1000 (EST)
Date: Sun, 19 May 2013 16:34:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
Message-ID: <20130519133418.GA24381@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <1368966844.6828.111.camel@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368966844.6828.111.camel@gandalf.local.home>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-m32r@ml.linux-m32r.org,
 linux-kernel@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 19, 2013 at 08:34:04AM -0400, Steven Rostedt wrote:
> On Sun, 2013-05-19 at 12:35 +0300, Michael S. Tsirkin wrote:
> 
> > No, I was not assuming that. What I'm trying to say is that a caller
> > that does something like this under a spinlock:
> > 	preempt_disable
> > 	pagefault_disable
> > 	error = copy_to_user
> > 	pagefault_enable
> > 	preempt_enable_no_resched
> > 
> > is not doing anything wrong and should not get a warning,
> > as long as error is handled correctly later.
> > Right?
> > 
> 
> What I see wrong with the above is the preempt_enable_no_resched(). The
> only place that should be ever used is right before a schedule(), as you
> don't want to schedule twice (once for the preempt_enable() and then
> again for the schedule itself).
> 
> Remember, in -rt, a spin lock does not disable preemption.
> 
> -- Steve

Right but we need to keep it working on upstream as well.
If I do preempt_enable under a spinlock upstream won't it
try to sleep under spinlock?


-- 
MST
