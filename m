Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id B24AB2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 06:23:28 +1000 (EST)
Message-ID: <1368995002.6828.117.camel@gandalf.local.home>
Subject: Re: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
From: Steven Rostedt <rostedt@goodmis.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 19 May 2013 16:23:22 -0400
In-Reply-To: <20130519164009.GA2434@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <1368966844.6828.111.camel@gandalf.local.home>
 <20130519133418.GA24381@redhat.com>
 <1368979579.6828.114.camel@gandalf.local.home>
 <20130519164009.GA2434@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Sun, 2013-05-19 at 19:40 +0300, Michael S. Tsirkin wrote:

> OK I get it. So let me correct myself. The simple code
> that does something like this under a spinlock:
> >       preempt_disable
> >       pagefault_disable
> >       error = copy_to_user
> >       pagefault_enable
> >       preempt_enable
> >
> is not doing anything wrong and should not get a warning,
> as long as error is handled correctly later.
> Right?

I came in mid thread and I don't know the context. Anyway, the above
looks to me as you just don't want to sleep. If you try to copy data to
user space that happens not to be currently mapped for any reason, you
will get an error. Even if the address space is completely valid. Is
that what you want?

-- Steve
