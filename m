Return-Path: <santoshkumar.a@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C2312B6F7E
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2011 04:14:56 +1100 (EST)
Received: by wwn31 with SMTP id 31so2445513wwn.21
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Nov 2011 10:14:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1320155074.2996.190.camel@otta>
References: <CAJw04pD24W_nGSLheWunCa_o7QqBmRf_TSAD44EkzazigRe_nQ@mail.gmail.com>
 <12144.1320040276@neuling.org>
 <CAJw04pAh5QDQMkUHbj9=rRPiUCZejimHiydCJFMAoZeSd_ydhA@mail.gmail.com>
 <20440.1320054588@neuling.org> <1320060214.30202.34.camel@pasglop>
 <CAJw04pBpXsTS4=FeG5ZF3nqORXhiOZ=3V60cFCuJfgTiJcCh2g@mail.gmail.com>
 <1320155074.2996.190.camel@otta>
Date: Tue, 1 Nov 2011 22:44:51 +0530
Message-ID: <CAJw04pA3mDOgHrOvPxeXR8Fw6Jn1kBz9qSrgq2vJ7HPpyQwSbg@mail.gmail.com>
Subject: Re: powerpc 476, Little-endian, pte fault
From: Santosh Kumar <santoshkumar.a@gmail.com>
To: Peter Bergner <bergner@vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, Ian Munsie <ianmunsi@au1.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The relevant options are -mcpu=3D476 (no FP unit) and -mcpu=3D476fp> (wit=
h FP unit). =A0Basically, -mcpu=3D476 is equivalent to> -mcpu=3D476fp -msof=
t-float.
Yes what you have mentioned is right.

I had a problem configuring the GCC for 476 in little endian mode,
therefore I am using 440 compiler. As this compiler doesn't accept
-mcpu=3D476 i am using -mcpu=3D440.

So is this PTE fault related to the compiler options?

Thanks,
Santosh Kumar .A

On 1 November 2011 19:14, Peter Bergner <bergner@vnet.ibm.com> wrote:
> On Tue, 2011-11-01 at 08:32 +0530, Santosh Kumar wrote:
>> I am using the same compiler as 476 & 440 instruction is almost the same=
.
>
> Well the 476 implements ISA 2.05, which I think has added a fair amount
> over the 440. =A0Not to mention the 476 core that has been released has
> a FP unit. =A0I'll note that GCC has support for a 476 with and without
> a FP unit, even though AFAIK, we only ship one with a FP unit.
> The relevant options are -mcpu=3D476 (no FP unit) and -mcpu=3D476fp
> (with FP unit). =A0Basically, -mcpu=3D476 is equivalent to
> -mcpu=3D476fp -msoft-float.
>
>
>
>> @@ -53,7 +58,12 @@
>> =A0 =A0 =A0 =A0 mullw =A0 r10,r0,r4 =A0 =A0 =A0 # and get the remainder
>> =A0 =A0 =A0 =A0 add =A0 =A0 r8,r8,r0
>> =A0 =A0 =A0 =A0 subf =A0 =A0r6,r10,r6
>> +#ifdef CONFIG_INVADER
>> =A04: =A0 =A0 stw =A0 =A0 r7,0(r3) =A0 =A0 =A0 =A0# return the quotient =
in *r3
>> =A0 =A0 =A0 =A0 stw =A0 =A0 r8,4(r3)
>> +#else
>> +4: =A0 =A0 stw =A0 =A0 r7,0(r3) =A0 =A0 =A0 =A0# return the quotient in=
 *r3
>> + =A0 =A0 =A0 stw =A0 =A0 r8,4(r3)
>> +#endif
>> =A0 =A0 =A0 =A0 mr =A0 =A0 =A0r3,r6 =A0 =A0 =A0 =A0 =A0 # return the rem=
ainder in r3
>> =A0 =A0 =A0 =A0 blr
>
> This looks like a typo, since you didn't actually swap the offsets
> on the stw's like you did in all of the other patch hunks.
>
>
> Peter
>
>
>
>
