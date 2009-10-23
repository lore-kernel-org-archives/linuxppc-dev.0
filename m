Return-Path: <xiyou.wangcong@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 393CEB7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 12:50:07 +1100 (EST)
Received: by pwj6 with SMTP id 6so285266pwj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 18:50:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9b2b86520910200743h4e134cf8jd2860d42b3936597@mail.gmail.com>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<200910201142.34006.rusty@rustcorp.com.au>
	<1256002193.6546.2.camel@slab>
	<200910201415.34361.rusty@rustcorp.com.au>
	<20091020135835.GB2462@hack>
	<9b2b86520910200743h4e134cf8jd2860d42b3936597@mail.gmail.com>
Date: Fri, 23 Oct 2009 09:50:05 +0800
Message-ID: <2375c9f90910221850r584e16a9k924aa2e0861bd358@mail.gmail.com>
Subject: Re: [PATCH] BUILD_BUG_ON: make it handle more cases
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Content-Type: text/plain; charset=UTF-8
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

On Tue, Oct 20, 2009 at 10:43 PM, Alan Jenkins
<sourcejedi.lkml@googlemail.com> wrote:
> On 10/20/09, Am=C3=A9rico Wang <xiyou.wangcong@gmail.com> wrote:
>> On Tue, Oct 20, 2009 at 02:15:33PM +1030, Rusty Russell wrote:
>>>BUILD_BUG_ON used to use the optimizer to do code elimination or fail
>>>at link time; it was changed to first the size of a negative array (a
>>>nicer compile time error), then (in
>>>8c87df457cb58fe75b9b893007917cf8095660a0) to a bitfield.
>>>
>>>bitfields: needs a literal constant at parse time, and can't be put unde=
r
>>> =C2=A0 =C2=A0 =C2=A0"if (__builtin_constant_p(x))" for example.
>>>negative array: can handle anything, but if the compiler can't tell it's
>>> =C2=A0 =C2=A0 =C2=A0a constant, silently has no effect.
>>>link time: breaks link if the compiler can't determine the value, but th=
e
>>> =C2=A0 =C2=A0 =C2=A0linker output is not usually as informative as a co=
mpiler error.
>>>
>>>If we use the negative-array-size method *and* the link time trick,
>>>we get the ability to use BUILD_BUG_ON() under __builtin_constant_p()
>>>branches, and maximal ability for the compiler to detect errors at
>>>build time.
>>>
>>>Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>>>
>>>diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>>>--- a/include/linux/kernel.h
>>>+++ b/include/linux/kernel.h
>>>@@ -683,12 +683,6 @@ struct sysinfo {
>>> =C2=A0 =C2=A0 =C2=A0char _f[20-2*sizeof(long)-sizeof(int)]; /* Padding:=
 libc5 uses this.. */
>>> };
>>>
>>>-/* Force a compilation error if condition is true */
>>>-#define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))
>>>-
>>>-/* Force a compilation error if condition is constant and true */
>>>-#define MAYBE_BUILD_BUG_ON(cond) ((void)sizeof(char[1 - 2 * !!(cond)]))
>>>-
>>> /* Force a compilation error if condition is true, but also produce a
>>> =C2=A0 =C2=A0result (of value 0 and type size_t), so the expression can=
 be used
>>> =C2=A0 =C2=A0e.g. in a structure initializer (or where-ever else comma =
expressions
>>>@@ -696,6 +690,33 @@ struct sysinfo {
>>> #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>>> #define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
>>>
>>>+/**
>>>+ * BUILD_BUG_ON - break compile if a condition is true.
>>>+ * @cond: the condition which the compiler should know is false.
>>>+ *
>>>+ * If you have some code which relies on certain constants being equal,=
 or
>>>+ * other compile-time-evaluated condition, you should use BUILD_BUG_ON =
to
>>>+ * detect if someone changes it.
>>>+ *
>>>+ * The implementation uses gcc's reluctance to create a negative array,
>>> but
>>>+ * gcc (as of 4.4) only emits that error for obvious cases (eg. not
>>> arguments
>>>+ * to inline functions). =C2=A0So as a fallback we use the optimizer; i=
f it
>>> can't
>>>+ * prove the condition is false, it will cause a link error on the
>>> undefined
>>>+ * "__build_bug_on_failed". =C2=A0This error message can be harder to t=
rack
>>> down
>>>+ * though, hence the two different methods.
>>>+ */
>>>+#ifndef __OPTIMIZE__
>>>+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]=
))
>>>+#else
>>>+extern int __build_bug_on_failed;
>>
>> Hmm, what exactly is __build_bug_on_failed?
>
> Well, we haven't added a definition for it in this patch. =C2=A0I'm sure
> grep will tell you it wasn't defined before hand either. =C2=A0So any
> reference to it is an error - which will be reported at link time.
>
>>>+#define BUILD_BUG_ON(condition) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\
>>>+ =C2=A0 =C2=A0 do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((void)sizeof(char[1 - 2*!!(=
condition)])); =C2=A0 =C2=A0 =C2=A0\
>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (condition) __build_bug_o=
n_failed =3D 1; =C2=A0 =C2=A0 =C2=A0 \
>
> If "condition" is known false at compile time, gcc -O will eliminate
> the code which refers to __build_bug_on_failed. =C2=A0If it's not proved =
to
> be false - it will break the build, which is exactly what we want
> BUILD_BUG_ON to do.

Ah, clever trick! Got it.
Thanks!

Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>
