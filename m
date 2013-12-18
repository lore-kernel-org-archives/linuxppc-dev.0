Return-Path: <michael@ellerman.id.au>
Message-ID: <1387331750.19507.3.camel@concordia>
Subject: Re: [PATCH] powerpc: Fix bad stack check in exception entry
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Date: Wed, 18 Dec 2013 12:55:50 +1100
In-Reply-To: <15350.1387167163@ale.ozlabs.ibm.com>
References: <15350.1387167163@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, anton@samba.org,
 Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-12-16 at 15:12 +1100, Michael Neuling wrote:
> In EXCEPTION_PROLOG_COMMON() we check to see if the stack pointer (r1)
> is valid when coming from the kernel.  If it's not valid, we die but
> with a nice oops message.
> 
> Currently we allocate a stack frame (subtract INT_FRAME_SIZE) before we
> check to see if the stack pointer is negative.  Unfortunately, this
> won't detect a bad stack where r1 is less than INT_FRAME_SIZE.

The key detail being that we *expect* a negative value, because kernel
addresses (0xc000000000000000) are negative.

cheers
