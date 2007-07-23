Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FF16DDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 02:06:23 +1000 (EST)
Message-ID: <46A4D1F5.1060005@billgatliff.com>
Date: Mon, 23 Jul 2007 11:06:13 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Bill Gatliff <bgat@billgatliff.com>,  gdb@sourceware.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: Gdbserver syscall clobber
References: <469B922D.3050701@billgatliff.com>
	<20070716155348.GA5281@caradoc.them.org>
	<469E550E.5080905@billgatliff.com>
	<20070718183143.GA25324@caradoc.them.org>
In-Reply-To: <20070718183143.GA25324@caradoc.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Jacobowitz wrote:
> On Wed, Jul 18, 2007 at 12:59:42PM -0500, Bill Gatliff wrote:
>   
>> Now, I'm a little rusty on PPC asm (I've been doing a lot of ARM
>> lately), but it looks to me like the kernel is setting bit 0 in CR0
>> (oris r10, r10, 0x1000) a.k.a LT, but the user side is looking at CR0
>> (bnslr+) bit 3 a.k.a. SO.  Or maybe the other way around, I'm not sure
>> after reading Sections 1.2 and 2.1 of the Programming Environments manual.
>>     
>
> It's not checking for restart here - userspace isn't supposed to have to.
> It's probably checking for error.  Check for the bit of kernel code
> that's supposed to back you up two instructions.
>
>   

I don't see it in this kernel.  What I see is this after the call to the 
syscall handler:

    li    r10,-_LAST_ERRNO
    cmpl    0,r3,r10
    blt    30f
    neg    r3,r3
    cmpi    0,r3,ERESTARTNOHAND
    bne    22f
    li    r3,EINTR
22:    lwz    r10,_CCR(r1)    /* Set SO bit in CR */
    oris    r10,r10,0x1000
    stw    r10,_CCR(r1)
30:    stw    r3,GPR3(r1)    /* Update return value */
    b    ret_from_except
66:    li    r3,ENOSYS
    b    22b


?

-- 
Bill Gatliff
bgat@billgatliff.com
