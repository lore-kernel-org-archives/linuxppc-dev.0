Message-ID: <40867E82.3010202@nortelnetworks.com>
Date: Wed, 21 Apr 2004 10:00:34 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: help with asm code?
References: <4085483B.1090604@nortelnetworks.com> <1082506664.2077.9.camel@gaston>
In-Reply-To: <1082506664.2077.9.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

>>	lis	r5,hrt_ak_offsets@ha
>>	addi	r5,r5,hrt_ak_offsets@l
>>	lbzx	r6,r6,r5
>>	add	r10,r4,r6
>>
>>
>>I'm having a small problem, in that when I run this code it hangs my
>>kernel.  Any ideas what's wrong?  The values in r6 and r5 seem to match
>>what I expect, but when I do the lbzx it dies.
>
>
> I don't know for sure, maybe you MMU context is wrong at the time ?

The code is being called from fast_exception_return, syscall_exit_cont,
and restore_user.

> How do you know it dies there and not elsewhere ?

If I remove the lbzx/add lines, everything works fine.  With the lbzx
line it dies, even if r10 is overwritten right away.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
