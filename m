Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id F37732C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 21:08:48 +1000 (EST)
Date: Wed, 22 May 2013 14:07:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/10] uaccess: better might_sleep/might_fault behavior
Message-ID: <20130522110729.GB5643@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <201305221125.36284.arnd@arndb.de>
 <20130522101916.GM18810@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130522101916.GM18810@twins.programming.kicks-ass.net>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
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

On Wed, May 22, 2013 at 12:19:16PM +0200, Peter Zijlstra wrote:
> On Wed, May 22, 2013 at 11:25:36AM +0200, Arnd Bergmann wrote:
> > Calling might_fault() for every __get_user/__put_user is rather expensive
> > because it turns what should be a single instruction (plus fixup) into an
> > external function call.
> 
> We could hide it all behind CONFIG_DEBUG_ATOMIC_SLEEP just like
> might_sleep() is. I'm not sure there's a point to might_fault() when
> might_sleep() is a NOP.

The patch that you posted gets pretty close.
E.g. I'm testing this now:
+#define might_fault() do { \
+       if (_might_fault()) \
+               __might_sleep(__FILE__, __LINE__, 0); \
+       might_resched(); \
+} while(0)

So if might_sleep is a NOP, __might_sleep and might_resched are NOPs
so compiler will optimize this all out.

However, in a related thread, you pointed out that might_sleep is not a NOP if
CONFIG_PREEMPT_VOLUNTARY is set, even without CONFIG_DEBUG_ATOMIC_SLEEP.

Do you think we should drop the preemption point in might_fault?
Only copy_XX_user?
Only __copy_XXX_user ?

-- 
MST
