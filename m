Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 69FA92C0098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 02:41:32 +1000 (EST)
Date: Sun, 19 May 2013 19:40:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
Message-ID: <20130519164009.GA2434@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <1368966844.6828.111.camel@gandalf.local.home>
 <20130519133418.GA24381@redhat.com>
 <1368979579.6828.114.camel@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368979579.6828.114.camel@gandalf.local.home>
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

On Sun, May 19, 2013 at 12:06:19PM -0400, Steven Rostedt wrote:
> On Sun, 2013-05-19 at 16:34 +0300, Michael S. Tsirkin wrote:
> 
> > Right but we need to keep it working on upstream as well.
> > If I do preempt_enable under a spinlock upstream won't it
> > try to sleep under spinlock?
> 
> No it wont. A spinlock calls preempt_disable implicitly, and a
> preempt_enable() will not schedule unless preempt_count is zero, which
> it wont be under a spinlock.
> 
> If it did, there would be lots of bugs all over the place because this
> is done throughout the kernel (a preempt_enable() under a spinlock).
> 
> In other words, don't ever use preempt_enable_no_resched().
> 
> -- Steve
> 


OK I get it. So let me correct myself. The simple code
that does something like this under a spinlock:
>       preempt_disable
>       pagefault_disable
>       error = copy_to_user
>       pagefault_enable
>       preempt_enable
>
is not doing anything wrong and should not get a warning,
as long as error is handled correctly later.
Right?
