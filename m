Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 478142C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 22:34:25 +1000 (EST)
Date: Tue, 21 May 2013 13:18:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
Message-ID: <20130521111818.GI26912@twins.programming.kicks-ass.net>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <1368966844.6828.111.camel@gandalf.local.home>
 <20130519133418.GA24381@redhat.com>
 <1368979579.6828.114.camel@gandalf.local.home>
 <20130519164009.GA2434@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130519164009.GA2434@redhat.com>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, Steven Rostedt <rostedt@goodmis.org>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org,
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

On Sun, May 19, 2013 at 07:40:09PM +0300, Michael S. Tsirkin wrote:
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

Indeed, but I don't get the point of the preempt_{disable,enable}()
here. Why does it have to disable preemption explicitly here? I thought
all you wanted was to avoid the pagefault handler and make it do the
exception table thing; for that pagefault_disable() is sufficient.
