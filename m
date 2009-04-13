Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net (are.twiddle.net [75.149.56.221])
	by ozlabs.org (Postfix) with ESMTP id 80092DE107
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 06:29:45 +1000 (EST)
Message-ID: <49E39F3D.4060501@twiddle.net>
Date: Mon, 13 Apr 2009 13:23:25 -0700
From: Richard Henderson <rth@twiddle.net>
MIME-Version: 1.0
To: Matt Turner <mattst88@gmail.com>
Subject: Re: alpha: half done futex implementation
References: <b4198de60904111755u5c2078c7xcc689dbd78aeb957@mail.gmail.com>
In-Reply-To: <b4198de60904111755u5c2078c7xcc689dbd78aeb957@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Oliver Falk <oliver@linux-kernel.at>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-alpha@vger.kernel.org, Jay Estabrook <jay.estabrook@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Turner wrote:
> Hi,
> 
> Going on Richard's advice, I've tried to write an alpha futex
> implementation based on the powerpc futex.h.
> 
> I've gotten this far.. :\
> 

#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
      __asm__ __volatile(             \
      __ASM_MB                        \
      "1: ldl_l   %0,0(%3)\n"         \
          insn                        \
      "2: stl_c   %1,0(%3)\n"         \
      "   beq     %1,4f\n"            \
      "   mov     $31,%1\n"           \
      "3: .subsection 2\n"            \
      "4: br      1b\n"               \
      "   .previous\n"                \
      ".section __ex_table,\"a\"\n"   \
      "   .long   1b-.\n"             \
      "   lda     %0,3b-1b(%2)\n"     \
      "   .long   2b-.\n"             \
      "   lda     %0,3b-2b(%2)\n"     \
      "   .previous\n"                \
      : "=&r" (oldval), "=&r"(ret)    \
      : "r" (uaddr), "r"(oparg)       \
      : "memory")

   switch (op) {
     case FUTEX_OP_SET:
       __futex_atomic_op("mov %0,%1", ret, oldval, uaddr, oparg);
       break;
     case FUTEX_OP_ADD:
       __futex_atomic_op("addl %0,%4,%1\n", ret, oldval, uaddr, oparg);
       break;
     case FUTEX_OP_OR:
       __futex_atomic_op("or %0,%4,%1\n", ret, oldval, uaddr, oparg);
       break;
     case FUTEX_OP_ANDN:
       __futex_atomic_op("andnot %0,%4,%1\n", ret, oldval, uaddr, oparg);
       break;
     case FUTEX_OP_XOR:
       __futex_atomic_op("xor %0,%4,%1\n", ret, oldval, uaddr, oparg);
       break;
     default:
       ret = -ENOSYS;
   }


Also, there's a bug in the powerpc implementation.  It appears that 
oparg is clobbered, and if stwcx fails the operation will be repeated 
with incorrect inputs.


r~
