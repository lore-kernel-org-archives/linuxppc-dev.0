Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BA2CFDDF4A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 04:56:11 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LloNc-0002a5-1K
	for linuxppc-dev@ozlabs.org; Mon, 23 Mar 2009 10:56:08 -0700
Message-ID: <22665081.post@talk.nabble.com>
Date: Mon, 23 Mar 2009 10:56:08 -0700 (PDT)
From: davidastro <davidastro@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Fix for __div64_32 locks when using some 64 bit numbers
In-Reply-To: <18887.4715.765245.409925@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <22567864.post@talk.nabble.com>
	<1237330984.25062.164.camel@pasglop>
	<22581509.post@talk.nabble.com>
	<18887.4715.765245.409925@drongo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,

You are correct. Since it was such a small piece of code, I didn't use diff
between the kernel I am using (2.6.14) and the newest ones (2.6.28 on the
Linux). Also, I do not know how to look in the kernel files commit history.
I guess the link you gave me might be of some help. 

Thanks for your help


Paul Mackerras wrote:
> 
> davidastro <davidastro@hotmail.com> writes:
> 
>> Basically, the numbers shown above was causing the 64 by 32 bit algorithm
>> to
>> divide by zero making the unit spin and also giving incorrect results.
>> Here is the code as it was before.
> [snip]
>>         cntlzw  r0,r5           # we are shifting the dividend right
>>         li      r10,-1          # to make it < 2^32, and shifting
>>         srw     r10,r10,r0      # the divisor right the same amount,
>>         add     r9,r4,r10       # rounding up (so the estimate cannot
>>         andc    r11,r6,r10      # ever be too large, only too small)
>>         andc    r9,r9,r10      #THIS CODE COULD STORE A ZERO IN r9
>>         or      r11,r5,r11
>>         rotlw   r9,r9,r0
>>         rotlw   r11,r11,r0
> 
> That bug was fixed in October 2005 in commit 344480b99730bfd2, and the
> fix is in v2.6.15-rc1 and all later kernels.  I fixed it a bit
> differently to your suggestion though - see
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=344480b99730bfd205e306d3fd168cdcebe83425
> 
> You must be working from an old kernel tree - which kernel version are
> you using?
> 
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/Fix-for-__div64_32-locks-when-using-some-64-bit-numbers-tp22567864p22665081.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
