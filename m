Return-Path: <fred.liu@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 1D7EC680F3
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Sep 2005 20:05:18 +1000 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id j8CAG47t015156
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Sep 2005 03:16:04 -0700 (MST)
Received: from zch07exm01.corp.mot.com (zch07exm01.corp.mot.com [200.3.1.220])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id j8CABr8L021297
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Sep 2005 05:11:54 -0500 (CDT)
Message-ID: <AD266326EC54D9118CE700110A9E2BE206A30839@zch07exm01.corp.mot.com>
From: Liu Fred-a18596 <fred.liu@motorola.com>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 12 Sep 2005 18:05:13 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
Subject: RE: A bug in div64.s
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, Paul,

Thank you very much. Your code is really cool.

Best regards,
Fred

-----Original Message-----
From: Paul Mackerras [mailto:paulus@samba.org] 
Sent: Monday, September 12, 2005 4:26 PM
To: Liu Fred-a18596
Cc: linuxppc-dev@ozlabs.org
Subject: Re: A bug in div64.s

Liu Fred-a18596 writes:

> I found there was a bug in arch/ppc/lib/div64.s.
> 
> The original div64_32() function would produce a zero divide
> exception in case of div64_32(0x100000000, 0xFFFFFFFF).

Thanks for pointing this out.

> Here is the bug-fixed new div64_32()function.

A patch would have been more helpful, so we could see immediately what
you have changed.  Also, notes (or outlook or whatever mail program
you are using) has completely munged all the spacing of the code you
posted.

Anyway, I have some comments on your proposed fix:

>                addc.      r9,r4,r10 # rounding up (so the estimate cannot

I understand that the add that I had here can overflow in the case you
pointed out, so we need to preserve the carry.  But why did you use
"addc." rather than "addc" ?

>                mfxer   r12                    #
> 
>                rlwinm. r12, r12, 3, 31, 31    # XER[CA]
> 
>                cmpwi   r12, 1                 # carry ?
> 
>                bne     5f
> 
>                ori     r9, r9, 0x1            # carry !

I think just "addze r9,r9" would do instead of these 5 instructions,
wouldn't it?

Paul.
