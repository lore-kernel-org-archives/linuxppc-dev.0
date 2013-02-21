Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7DB232C0295
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 10:46:18 +1100 (EST)
Message-ID: <1361490374.4676.58.camel@pasglop>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Thu, 21 Feb 2013 17:46:14 -0600
In-Reply-To: <5126955B.9070808@mail.ru>
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
 <1361406741.4676.44.camel@pasglop> <512685B7.5080404@mail.ru>
 <1361478942.4676.53.camel@pasglop> <5126955B.9070808@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-02-21 at 22:44 +0100, Phileas Fogg wrote:
> Stripped OpenWRT image:
> ------------------------
> 
> c00000000001a474:       48 00 00 05     bl      0xc00000000001a478
> c00000000001a478:       7c a8 02 a6     mflr    r5
> c00000000001a47c:       38 a5 00 1c     addi    r5,r5,28
> c00000000001a480:       7c 21 0b 78     mr      r1,r1
> c00000000001a484:       80 85 00 00     lwz     r4,0(r5)
> c00000000001a488:       2c 04 00 00     cmpwi   r4,0
> c00000000001a48c:       40 82 00 62     bnea-   0x60
> c00000000001a490:       4b ff ff f0     b       0xc00000000001a480
> c00000000001a494:       00 00 00 00     .long 0x0
> c00000000001a498:       a0 6d 00 48     lhz     r3,72(r13)
> c00000000001a49c:       48 00 00 11     bl      0xc00000000001a4ac


Smell like a bad stack pointer to me...

One thing I noticed is that kexec doesn't seem to hard disable
interrupts, which is ... fishy at best. It should do that
before it switches stacks around. Dunno if that's the cause
of the problem but it might be worth adding a hard_irq_disable()
after all the local_irq_disable(), making sure we are hard
disabled before going into asm.

Cheers,
Ben.
