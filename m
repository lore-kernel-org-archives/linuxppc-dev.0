Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCsYk2yGyzDqCR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 16:46:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dougmill@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
In-Reply-To: <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
References: <20170131165537.GC23970@htj.duckdns.org>
 <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
Date: Wed, 01 Feb 2017 16:46:01 +1100
Message-ID: <87vasutqee.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jan 31, 2017 at 8:55 AM, Tejun Heo <tj@kernel.org> wrote:
>>
>> Douglas found and fixed a ref leak bug in percpu_ref_tryget[_live]().
>> The bug is caused by storing the return value of
>> atomic_long_inc_not_zero() into an int temp variable before returning
>> it as a bool.  The interim cast to int loses the upper bits and can
>> lead to false negatives.  As percpu_ref uses a high bit to mark a
>> draining counter, this can happen relatively easily.  Fixed by using
>> bool for the temp variable.
>
> I think this fix is wrong.
>
> The fact is, atomic_long_inc_not_zero() shouldn't be returning
> anything with high bits.. Casting to "int" should have absolutely no
> impact. "int" is the traditional C truth value (with zero/nonzero
> being false/true), and while we're generally moving towards "bool" for
> true/false return values, I do think that code that assumes that these
> functions can be cast to "int" are right.
>
> For example, we used to have similar bugs in "test_bit()" returning
> the actual bit value (which could be high).
>
> And when users hit that problem, we fixed "test_bit()", not the users of it.
>
> So I'd rather fix the places that (insanely) return a 64-bit value.
>
> Is this purely a ppc64 issue, or does it happen somewhere else too?

Sorry I'm late to this, I wasn't Cc'ed on the original patch.

It looks like this is only a powerpc issue, we're the only arch other
than x86-32 that implements atomic_long_inc_not_zero() by hand (not
using atomic64_add_unless()).

Assuming all other arches have an atomic64_add_unless() which returns
an int then they should all be safe.

Actually we have a test suite for atomic64. The patch below adds a check
which catches the problem on powerpc at the moment, and passes once I
change our version to return an int. I'll turn it into a proper patch
and send it to whoever maintains the tests.

cheers


diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index 46042901130f..813cd05bec9d 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -152,8 +152,10 @@ static __init void test_atomic64(void)
 	long long v0 = 0xaaa31337c001d00dLL;
 	long long v1 = 0xdeadbeefdeafcafeLL;
 	long long v2 = 0xfaceabadf00df001LL;
+	long long v3 = 0x8000000000000000LL;
 	long long onestwos = 0x1111111122222222LL;
 	long long one = 1LL;
+	int r_int;
 
 	atomic64_t v = ATOMIC64_INIT(v0);
 	long long r = v0;
@@ -239,6 +241,11 @@ static __init void test_atomic64(void)
 	BUG_ON(!atomic64_inc_not_zero(&v));
 	r += one;
 	BUG_ON(v.counter != r);
+
+	/* Confirm the return value fits in an int, even if the value doesn't */
+	INIT(v3);
+	r_int = atomic64_inc_not_zero(&v);
+	BUG_ON(!r_int);
 }
 
 static __init int test_atomics(void)
