Return-Path: <jimix@watson.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64A7867BC5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2006 01:08:25 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBFE8mhC023157
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 09:08:48 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBFE8KQc202438
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 09:08:20 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBFE8KQs008976
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 09:08:20 -0500
In-Reply-To: <6473fb3e0612150325w3c6f01b0rdd4953dc9cb6430e@mail.gmail.com>
References: <6473fb3e0612150325w3c6f01b0rdd4953dc9cb6430e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37F182F3-71D2-4A8C-84B0-A036684B447B@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: atomic_clear_mask() on PPC ?
Date: Fri, 15 Dec 2006 09:08:19 -0500
To: Simon Vallet <svallet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc 32-bit seems to have it:
   arch/powerpc/kernel/misc_32.S _GLOBAL 742 _GLOBAL(atomic_clear_mask)

Assuming its the "thing" you actually want, since atomic_t is always  
an int, the exact same code sequence will be fine under 64bit, I  
guess PPc64 never needed it?
Perhaps we should move it to misc.S?
-JX

On Dec 15, 2006, at 6:25 AM, Simon Vallet wrote:

> Hi,
>
> I'm currently trying to "port" a binary-only driver to Linux/PPC :  
> the card manufacturer
> provides MacOS X and Linux/i386 drivers, providing *some* sources  
> with the Linux driver.
>
> The plan is to use the provided sources, and to get the remaining  
> symbols & code from the MacOSX
> object -- Unfortunately, one of those components makes a call to  
> atomic_clear_mask(), which doesn't
> seem available on PPC yet.
>
> So the question is : is there a workaround for this, and if not,  
> how would you implement this call
> (I have absolutely no knowledge of PPC assembly). Quickly grepping  
> through kernel headers reveals it
> is present for i386, arm and x86_64, but not sparc or ppc. Is there  
> a reason for this ?
>
> Simon
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
