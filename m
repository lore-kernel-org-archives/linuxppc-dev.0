Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30F3EDDF16
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 06:09:18 +1100 (EST)
In-Reply-To: <20080303095443.GB27105@iram.es>
References: <1204301097.14759.6.camel@localhost.localdomain>
	<1204340690.15052.457.camel@pasglop>
	<Pine.LNX.4.58.0802292250490.21555@gandalf.stny.rr.com>
	<20080303095443.GB27105@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ecb965a1e5feba94cd97fb4b9535908e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add strncmp to PowerPC
Date: Mon, 3 Mar 2008 20:08:59 +0100
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Even if it was logically faster (which I still doubt) it's a hell of 
>> a lot
>> of cache lines to waste.

Yeah, 1 on 64-bit and 3 on 32-bit, that's a terrible lot.</sarcasm>

> Indeed, but there are some corner cases that the C code handles. Like
> a length of 0 which may lead to infinite loop in the asm code.
>
> OTOH, I'm a bit surprised by the extsb instructions in the compiler 
> generated
> code. We don't compile with -fsigned-char, do we? The clrldi
> instructions are also extremely stupid.

Those are both necessary to be equivalent to the C code, which uses
signed char explicitly.  It is generally considered a Good Thing(tm)
for the compiler to generate assembler code equivalent to the C code,
even if the C code is wrong.

> Now that I think a bit more about it, I believe that the C version is
> incorrect

It is.  It's a great entry for the IOCCC as well.

I just tested the following (can't guarantee it's correct, just a PoC):

int strncmp(const char *s1, const char *s2, unsigned long /*size_t*/ 
len)
{
         while (len--) {
                 unsigned char c1, c2;
                 c1 = *s1++;
                 c2 = *s2++;
                 int cmp = c1 - c2;
                 if (cmp)
                         return cmp;
                 if (c1 == 0 || c2 == 0)
                         break;
         }
         return 0;
}

which generates (with GCC-4.2.3)

strncmp:
         addi 5,5,1
         mtctr 5
.L2:
         bdz .L11
         lbz 0,0(3)
         addi 3,3,1
         lbz 9,0(4)
         addi 4,4,1
         cmpwi 7,0,0
         subf. 0,9,0
         cmpwi 6,9,0
         bne- 0,.L4
         beq- 7,.L4
         bne+ 6,.L2
.L4:
         mr 3,0
         blr
.L11:
         li 0,0
         mr 3,0
         blr

which isn't horrid, although it does some weirdish things obviously.

Current GCC-4.4.0 generates

strncmp:
         addi 5,5,1
         mr 10,3
         mtctr 5
         li 11,0
         bdz .L7
         .p2align 4,,15
.L4:
         lbzx 0,10,11
         lbzx 9,4,11
         addi 11,11,1
         subf. 3,9,0
         cmpwi 6,9,0
         cmpwi 7,0,0
         bnelr 0
         beqlr 7
         beqlr 6
         bdnz .L4
.L7:
         li 3,0
         blr

which is about as good as it can get (well, it didn't realise you
only need to test one of c1, c2 for zero.  Did I say this was just
proof-of-concept code?)


Segher
