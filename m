Return-Path: <severo.ricardo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 5DE2CDE0B3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 04:38:25 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so84722pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 09:38:24 -0800 (PST)
Message-ID: <5ee408090802130938u7d069636g42a496e489fe5b80@mail.gmail.com>
Date: Wed, 13 Feb 2008 15:38:24 -0200
From: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
To: "David Baird" <dhbaird@gmail.com>
Subject: Re: TLB Miss booting linux kernel on ppc 405
In-Reply-To: <440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
	<440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I tracked the kernel execution using step one instruction (si) on gdb
and matching the jumps with the System.map.
It is a Data TLB Miss and this is the register dump after the miss occurs:

    r1: 00502090
    r2: 0000000f
    r3: c00003c0
    r4: c0000000
    r5: 00000000
    r6: 00000000
    r7: 74747955
    r8: 4c302c39
    r9: 00000000
    pc: 00001100
    lr: 00000018

Now I'm checking the PPC cache configurations on XPS, because when
treating the DTLB Miss Exception a Machine Check Exception occurs when
it works with L1. Does this makes sense or am I confusing things?

Thanks,

On Feb 13, 2008 3:17 PM, David Baird <dhbaird@gmail.com> wrote:
> On Feb 13, 2008 9:50 AM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
> > Hi All,
> >
> > I'm using kernel 2.6.24 and when it comes to line 826 on the file
> > arch/ppc/kernel/head_4xx.S it gives a TLB Miss.
> >
> > arch/ppc/kernel/head_4xx.S
> > 823 start_here:
> > 824
> > 825         /* ptr to current */
> > 826         lis    r2,init_task@h
> > 827         ori    r2,r2,init_task@l
>
> I am just curious: how did you find that you have TLB miss on that
> line?  Is it an Instruction TLB miss or a Data TLB miss?
>
> Can you paste a dump of your registers (in XMD, rrd and srrd)?
>
> I was having TLB misses awhile back due to some other problems, but
> never had any on that line though.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Ricardo Ayres Severo <severo.ricardo@gmail.com>
