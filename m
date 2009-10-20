Return-Path: <sourcejedi.lkml@googlemail.com>
Received: from mail-fx0-f219.google.com (mail-fx0-f219.google.com
	[209.85.220.219]) by ozlabs.org (Postfix) with ESMTP id 1142AB7B8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Oct 2009 01:43:16 +1100 (EST)
Received: by fxm19 with SMTP id 19so6551616fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Oct 2009 07:43:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091020135835.GB2462@hack>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<200910201142.34006.rusty@rustcorp.com.au>
	<1256002193.6546.2.camel@slab>
	<200910201415.34361.rusty@rustcorp.com.au>
	<20091020135835.GB2462@hack>
Date: Tue, 20 Oct 2009 15:43:13 +0100
Message-ID: <9b2b86520910200743h4e134cf8jd2860d42b3936597@mail.gmail.com>
Subject: Re: [PATCH] BUILD_BUG_ON: make it handle more cases
From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
To: =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, Hollis Blanchard <hollisb@us.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>,
	linux-next@vger.kernel.org, kvm-ppc@vger.kernel.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/20/09, Am=E9rico Wang <xiyou.wangcong@gmail.com> wrote:
> On Tue, Oct 20, 2009 at 02:15:33PM +1030, Rusty Russell wrote:
>>BUILD_BUG_ON used to use the optimizer to do code elimination or fail
>>at link time; it was changed to first the size of a negative array (a
>>nicer compile time error), then (in
>>8c87df457cb58fe75b9b893007917cf8095660a0) to a bitfield.
>>
>>bitfields: needs a literal constant at parse time, and can't be put under
>>	"if (__builtin_constant_p(x))" for example.
>>negative array: can handle anything, but if the compiler can't tell it's
>>	a constant, silently has no effect.
>>link time: breaks link if the compiler can't determine the value, but the
>>	linker output is not usually as informative as a compiler error.
>>
>>If we use the negative-array-size method *and* the link time trick,
>>we get the ability to use BUILD_BUG_ON() under __builtin_constant_p()
>>branches, and maximal ability for the compiler to detect errors at
>>build time.
>>
>>Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>>
>>diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>>--- a/include/linux/kernel.h
>>+++ b/include/linux/kernel.h
>>@@ -683,12 +683,6 @@ struct sysinfo {
>> 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. *=
/
>> };
>>
>>-/* Force a compilation error if condition is true */
>>-#define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))
>>-
>>-/* Force a compilation error if condition is constant and true */
>>-#define MAYBE_BUILD_BUG_ON(cond) ((void)sizeof(char[1 - 2 * !!(cond)]))
>>-
>> /* Force a compilation error if condition is true, but also produce a
>>    result (of value 0 and type size_t), so the expression can be used
>>    e.g. in a structure initializer (or where-ever else comma expressions
>>@@ -696,6 +690,33 @@ struct sysinfo {
>> #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>> #define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
>>
>>+/**
>>+ * BUILD_BUG_ON - break compile if a condition is true.
>>+ * @cond: the condition which the compiler should know is false.
>>+ *
>>+ * If you have some code which relies on certain constants being equal, =
or
>>+ * other compile-time-evaluated condition, you should use BUILD_BUG_ON t=
o
>>+ * detect if someone changes it.
>>+ *
>>+ * The implementation uses gcc's reluctance to create a negative array,
>> but
>>+ * gcc (as of 4.4) only emits that error for obvious cases (eg. not
>> arguments
>>+ * to inline functions).  So as a fallback we use the optimizer; if it
>> can't
>>+ * prove the condition is false, it will cause a link error on the
>> undefined
>>+ * "__build_bug_on_failed".  This error message can be harder to track
>> down
>>+ * though, hence the two different methods.
>>+ */
>>+#ifndef __OPTIMIZE__
>>+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)])=
)
>>+#else
>>+extern int __build_bug_on_failed;
>
> Hmm, what exactly is __build_bug_on_failed?

Well, we haven't added a definition for it in this patch.  I'm sure
grep will tell you it wasn't defined before hand either.  So any
reference to it is an error - which will be reported at link time.

>>+#define BUILD_BUG_ON(condition)					\
>>+	do {							\
>>+		((void)sizeof(char[1 - 2*!!(condition)]));	\
>>+		if (condition) __build_bug_on_failed =3D 1;	\

If "condition" is known false at compile time, gcc -O will eliminate
the code which refers to __build_bug_on_failed.  If it's not proved to
be false - it will break the build, which is exactly what we want
BUILD_BUG_ON to do.

>>+	} while(0)
>>+#endif
>>+#define MAYBE_BUILD_BUG_ON(condition) BUILD_BUG_ON(condition)
>>+
>> /* Trap pasters of __FUNCTION__ at compile-time */
>> #define __FUNCTION__ (__func__)
>>
