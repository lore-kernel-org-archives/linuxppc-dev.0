Return-Path: <eric.dumazet@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47F29B6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jun 2011 17:49:48 +1000 (EST)
Received: by wyh21 with SMTP id 21so290303wyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jun 2011 00:49:44 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] BPF JIT for PPC64
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2boxmxt45.fsf@igel.home>
References: <4E04288F.4090201@ozlabs.org>  <m2boxmxt45.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 25 Jun 2011 09:49:40 +0200
Message-ID: <1308988180.2532.27.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le samedi 25 juin 2011 à 09:33 +0200, Andreas Schwab a écrit :
> Matt Evans <matt@ozlabs.org> writes:
> 
> > +	stdu	r1, -128(r1);					\
> 
> > +	addi	r5, r1, 128+BPF_PPC_STACK_BASIC+(2*8);		\
> 
> > +	addi	r1, r1, 128;					\
> 
> > +					PPC_STD(r_M + i, 1, -128 + (8*i));
> 
> > +					PPC_LD(r_M + i, 1, -128 + (8*i));
> 
> s/128/BPF_PPC_STACK_SAVE/?
> 

I am not sure using registers to hold MEM[] is a win if MEM[idx] is used
once in the filter

# tcpdump "tcp[20]+tcp[21]=0" -d
(000) ldh      [12]
(001) jeq      #0x800           jt 2	jf 15
(002) ldb      [23]
(003) jeq      #0x6             jt 4	jf 15
(004) ldh      [20]
(005) jset     #0x1fff          jt 15	jf 6
(006) ldxb     4*([14]&0xf)
(007) ldb      [x + 34]
(008) st       M[1]
(009) ldb      [x + 35]
(010) tax      
(011) ld       M[1]
(012) add      x
(013) jeq      #0x0             jt 14	jf 15
(014) ret      #65535
(015) ret      #0

In this sample, we use M[1] once ( one store, one load)

So saving previous register content on stack in prologue, and restoring
it in epilogue actually slow down the code, and adds two instructions in filter asm code.

This also makes epilogue code not easy (not possible as a matter of fact)
to unwind in helper function

In x86_64 implementation, I chose bpf_error be able to force
an exception, not returning to JIT code but directly to bpf_func() caller

bpf_error:
# force a return 0 from jit handler
        xor             %eax,%eax
        mov             -8(%rbp),%rbx
        leaveq
        ret
