Return-Path: <bergner@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 13FE8B6F88
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2011 00:51:14 +1100 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bergner@vnet.ibm.com>;
 Tue, 1 Nov 2011 09:45:25 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA1Divjt230126
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Nov 2011 09:44:58 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA1DiruJ026315
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Nov 2011 07:44:54 -0600
Subject: Re: powerpc 476, Little-endian, pte fault
From: Peter Bergner <bergner@vnet.ibm.com>
To: Santosh Kumar <santoshkumar.a@gmail.com>
In-Reply-To: <CAJw04pBpXsTS4=FeG5ZF3nqORXhiOZ=3V60cFCuJfgTiJcCh2g@mail.gmail.com>
References: <CAJw04pD24W_nGSLheWunCa_o7QqBmRf_TSAD44EkzazigRe_nQ@mail.gmail.com>
 <12144.1320040276@neuling.org>
 <CAJw04pAh5QDQMkUHbj9=rRPiUCZejimHiydCJFMAoZeSd_ydhA@mail.gmail.com>
 <20440.1320054588@neuling.org> <1320060214.30202.34.camel@pasglop>
 <CAJw04pBpXsTS4=FeG5ZF3nqORXhiOZ=3V60cFCuJfgTiJcCh2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Nov 2011 08:44:34 -0500
Message-ID: <1320155074.2996.190.camel@otta>
Mime-Version: 1.0
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

On Tue, 2011-11-01 at 08:32 +0530, Santosh Kumar wrote:
> I am using the same compiler as 476 & 440 instruction is almost the same.

Well the 476 implements ISA 2.05, which I think has added a fair amount
over the 440.  Not to mention the 476 core that has been released has
a FP unit.  I'll note that GCC has support for a 476 with and without
a FP unit, even though AFAIK, we only ship one with a FP unit.
The relevant options are -mcpu=476 (no FP unit) and -mcpu=476fp
(with FP unit).  Basically, -mcpu=476 is equivalent to
-mcpu=476fp -msoft-float.



> @@ -53,7 +58,12 @@
>         mullw   r10,r0,r4       # and get the remainder
>         add     r8,r8,r0
>         subf    r6,r10,r6
> +#ifdef CONFIG_INVADER
>  4:     stw     r7,0(r3)        # return the quotient in *r3
>         stw     r8,4(r3)
> +#else
> +4:     stw     r7,0(r3)        # return the quotient in *r3
> +       stw     r8,4(r3)
> +#endif
>         mr      r3,r6           # return the remainder in r3
>         blr

This looks like a typo, since you didn't actually swap the offsets
on the stw's like you did in all of the other patch hunks.


Peter
