Return-Path: <stephane.marchesin@gmail.com>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 918FADDE3A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 01:39:54 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so3045049hsb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2008 06:39:52 -0800 (PST)
Message-ID: <6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
Date: Wed, 6 Feb 2008 15:39:51 +0100
From: "Stephane Marchesin" <marchesin@icps.u-strasbg.fr>
Sender: stephane.marchesin@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
In-Reply-To: <1166362145.6714.53.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	<1166053317.909.19.camel@praia>
	<20061214195842.GA14041@athena.road.mcmartin.ca>
	<1166362145.6714.53.camel@pmac.infradead.org>
Cc: henrik.sorensen@gmail.com, David Woodhouse <dwmw2@infradead.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/17/06, David Woodhouse <dwmw2@infradead.org> wrote:
>
> You still get to 'accidentally' do 64-bit arithmetic in-kernel that way
> though. Might be better just to provide __ucmpdi2, just as we have for
> the other functions which are required from libgcc
>
> It'd be better just to fix the compiler though -- which is in fact what
> they've done: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=25724
>               http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21237
>
> I've applied this as a temporary hack to the Fedora kernel until the
> compiler is updated there...
>

Hello,

We're hitting this i nouveau as well (http://nouveau.freedesktop.org),
since we make extensive use ot 64 bit ints. Over time, we've had a
number of reports on this issue, and at one point I read that it
should be fixed in gcc. But recently, a nouveau user on PPC32 (Henrik
in CC:) reported the issue again with gcc 4.2.3. Others have it on gcc
4.2.2 too:
http://bugs.freedesktop.org/show_bug.cgi?id=10547

So, the point of this email is to ask about the possibility of merging
in one of the __ucmpdi2 patches, like David's which is kept below for
reference. Most distros seem to ship with such a patch already, and it
seems that other drivers hit this as well.

Thanks,
Stephane


> --- linux-2.6.19.ppc/arch/powerpc/kernel/misc_32.S~     2006-11-29 21:57:37.000000000 +0000
> +++ linux-2.6.19.ppc/arch/powerpc/kernel/misc_32.S      2006-12-17 12:19:48.000000000 +0000
> @@ -728,6 +728,27 @@ _GLOBAL(__lshrdi3)
>         or      r4,r4,r7        # LSW |= t2
>         blr
>
> +/*
> + * __ucmpdi2: 64-bit comparison
> + *
> + * R3/R4 has 64 bit value A
> + * R5/R6 has 64 bit value B
> + * result in R3: 0 for A < B
> + *              1 for A == B
> + *              2 for A > B
> + */
> +_GLOBAL(__ucmpdi2)
> +       cmplw   r7,r3,r5        # compare high words
> +       li      r3,0
> +       blt     r7,2f           # a < b ... return 0
> +       bgt     r7,1f           # a > b ... return 2
> +       cmplw   r6,r4,r6        # compare low words
> +       blt     r6,2f           # a < b ... return 0
> +       li      r3,1
> +       ble     r6,2f           # a = b ... return 1
> +1:     li      r3,2
> +2:     blr
> +
>  _GLOBAL(abs)
>         srawi   r4,r3,31
>         xor     r3,r3,r4
> --- linux-2.6.19.ppc/arch/powerpc/kernel/ppc_ksyms.c~   2006-12-15 17:19:56.000000000 +0000
> +++ linux-2.6.19.ppc/arch/powerpc/kernel/ppc_ksyms.c    2006-12-17 12:16:54.000000000 +0000
> @@ -161,9 +161,11 @@ EXPORT_SYMBOL(to_tm);
>  long long __ashrdi3(long long, int);
>  long long __ashldi3(long long, int);
>  long long __lshrdi3(long long, int);
> +int __ucmpdi2(uint64_t, uint64_t);
>  EXPORT_SYMBOL(__ashrdi3);
>  EXPORT_SYMBOL(__ashldi3);
>  EXPORT_SYMBOL(__lshrdi3);
> +EXPORT_SYMBOL(__ucmpdi2);
>  #endif
>
>  EXPORT_SYMBOL(memcpy);
>
> --
> dwmw2
>
