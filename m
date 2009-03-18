Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 5DA32DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 02:33:05 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LjxlN-0003PD-C3
	for linuxppc-dev@ozlabs.org; Wed, 18 Mar 2009 08:33:01 -0700
Message-ID: <22581509.post@talk.nabble.com>
Date: Wed, 18 Mar 2009 08:33:01 -0700 (PDT)
From: davidastro <davidastro@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Fix for __div64_32 locks when using some 64 bit numbers
In-Reply-To: <1237330984.25062.164.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <22567864.post@talk.nabble.com>
	<1237330984.25062.164.camel@pasglop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Benjamin Herrenschmidt wrote:
> 
> On Tue, 2009-03-17 at 14:15 -0700, davidastro wrote:
>> I found a bug when using the function __div64_32 in assembly in a 32 bit
>> ppc
>> architecture unit.
>> 
>> I tried the numbers 55834565048000000 for the dividend and 4294967079 for
>> the divisor. When passing these two numbers to the function  __div64_32,
>> I
>> had a software lock. I searched for possible patches online and in
>> different
>> forums but I could not find anything related to the assembly
>> implementation
>> to this function (I would have to apologize if somebody already found a
>> fix
>> :-) ).
>> 
>> Anyway, when analyzing the assembly code, I found out with gdb the
>> problem.
>> I am not an expert in ppc architecture but I read the documentation and I
>> am
>> pretty sure I solved the issue (I have been testing for couple of days
>> using
>> random 64 to 32 number combinations with good results).
>> 
>> Who or Where should I post the fix to be reviewed.
> 
> Here is fine :-)
> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 


Basically, the numbers shown above was causing the 64 by 32 bit algorithm to
divide by zero making the unit spin and also giving incorrect results.
Here is the code as it was before.


#include <asm/ppc_asm.h>
#include <asm/processor.h>

_GLOBAL(__div64_32)
        lwz     r5,0(r3)        # get the dividend into r5/r6
        lwz     r6,4(r3)
        cmplw   r5,r4
        li      r7,0
        li      r8,0
        blt     1f
        divwu   r7,r5,r4        # if dividend.hi >= divisor,
        mullw   r0,r7,r4        # quotient.hi = dividend.hi / divisor
        subf.   r5,r0,r5        # dividend.hi %= divisor
        beq     3f
1:      mr      r11,r5          # here dividend.hi != 0
        andis.  r0,r5,0xc000
        bne     2f
        cntlzw  r0,r5           # we are shifting the dividend right
        li      r10,-1          # to make it < 2^32, and shifting
        srw     r10,r10,r0      # the divisor right the same amount,
        add     r9,r4,r10       # rounding up (so the estimate cannot
        andc    r11,r6,r10      # ever be too large, only too small)
        andc    r9,r9,r10      #THIS CODE COULD STORE A ZERO IN r9
        or      r11,r5,r11
        rotlw   r9,r9,r0
        rotlw   r11,r11,r0
        divwu   r11,r11,r9      # WARNING r9 COULD BE ZERO
2:      mullw   r10,r11,r4      # to get an estimate of the quotient,
        mulhwu  r9,r11,r4       # multiply the estimate by the divisor,
        subfc   r6,r10,r6       # take the product from the divisor,
        add     r8,r8,r11       # and add the estimate to the accumulated
        subfe.  r5,r9,r5        # quotient
        bne     1b
3:      cmplw   r6,r4
        blt     4f
        divwu   r0,r6,r4        # perform the remaining 32-bit division
        mullw   r10,r0,r4       # and get the remainder
        add     r8,r8,r0
        subf    r6,r10,r6
4:      stw     r7,0(r3)        # return the quotient in *r3
        stw     r8,4(r3)
        mr      r3,r6           # return the remainder in r3
        blr
 

In the line in bold with the warning:
"divwu   r11,r11,r9      # WARNING r9 COULD BE ZERO"

r9 could be zero if giving the right number by the previous operation:
"andc    r9,r9,r10      #THIS CODE COULD STORE A ZERO IN r9"

My propose solution is the following:

#include <asm/ppc_asm.h>
#include <asm/processor.h>

_GLOBAL(__div64_32)
        lwz     r5,0(r3)        # get the dividend into r5/r6
        lwz     r6,4(r3)
        cmplw   r5,r4
        li      r7,0
        li      r8,0
        blt     1f
        divwu   r7,r5,r4        # if dividend.hi >= divisor,
        mullw   r0,r7,r4        # quotient.hi = dividend.hi / divisor
        subf.   r5,r0,r5        # dividend.hi %= divisor
        beq     3f
1:      mr      r11,r5          # here dividend.hi != 0
        andis.  r0,r5,0xc000
        bne     2f
        cntlzw  r0,r5           # we are shifting the dividend right
        li      r10,-1          # to make it < 2^32, and shifting
        srw     r10,r10,r0      # the divisor right the same amount,
        add     r9,r4,r10       # rounding up (so the estimate cannot
        andc    r11,r6,r10      # ever be too large, only too small)
        andc.   r9,r9,r10		# Check result is not equal to zero (r9 is
dividing later on)
        bne		5f
        li		r9,1     		# Magic number to avoid r9 = 0 if ever happens
5:     or		r11,r5,r11        
        rotlw   r9,r9,r0
        rotlw   r11,r11,r0
        divwu   r11,r11,r9      # then we divide the shifted quantities
2:      mullw   r10,r11,r4      # to get an estimate of the quotient,
        mulhwu  r9,r11,r4       # multiply the estimate by the divisor,
        subfc   r6,r10,r6       # take the product from the divisor,
        add     r8,r8,r11       # and add the estimate to the accumulated
        subfe.  r5,r9,r5        # quotient
        bne     1b
3:      cmplw   r6,r4
        blt     4f
        divwu   r0,r6,r4        # perform the remaining 32-bit division
        mullw   r10,r0,r4       # and get the remainder
        add     r8,r8,r0
        subf    r6,r10,r6
4:      stw     r7,0(r3)        # return the quotient in *r3
        stw     r8,4(r3)
        mr      r3,r6           # return the remainder in r3
        blr


Now, I check if the operation:
"andc.   r9,r9,r10"

is equal to zero. If not equal to zero branch to 5:
"bne		5f"

which is the normal behavior of the algorithm, but if equal to zero perform:
"li		r9,1     		# Magic number to avoid r9 = 0 if ever happens"

In this case I assigned a 1 to r9 which is the smallest number close to
zero.
The division algorithm works by approximations and 1 one is a good
approximation for this pass.

Well, I have tested this code for two days and I have compared the results
with the C generic implementation
obtaining the same results but faster execution by the assembly
implementations (6-10 times faster).

Please, let me know if this solution pass the test and if it does, I would
like to know in which kernel version would be applied.


Thanks for your attention,   
-- 
View this message in context: http://www.nabble.com/Fix-for-__div64_32-locks-when-using-some-64-bit-numbers-tp22567864p22581509.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
