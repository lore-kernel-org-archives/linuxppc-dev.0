Return-Path: <balbir@linux.vnet.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FD2BDDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 14:37:51 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7H4fK3g150920
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 14:41:20 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7H4bkoA4390920
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 14:37:46 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7H5bk4p003239
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 15:37:46 +1000
Message-ID: <46C52615.80205@linux.vnet.ibm.com>
Date: Fri, 17 Aug 2007 10:07:41 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Machine automagically reboots with 2.6.23-rc2-mm2
References: <46C4C26C.3090502@linux.vnet.ibm.com>
	<30255.1187317044@neuling.org>
In-Reply-To: <30255.1187317044@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> 
> SLB shadow was bust.  Make sure you have
> edd0622bd2e8f755c960827e15aa6908c3c5aa94
> 
>     [POWERPC] Fix potential duplicate entry in SLB shadow buffer
>     
>     We were getting a duplicate entry in the SLB shadow buffer in
>     slb_flush_and_rebolt() if the kernel stack was in the same segment
>     as PAGE_OFFSET, which on POWER6 causes the hypervisor to terminate
>     the partition with an error.  This fixes it.
>     
>     Also we were not creating an SLB entry (or an SLB shadow buffer
>     entry) for the kernel stack on secondary CPUs when starting the
>     CPU.  This isn't a major problem, since an appropriate entry will
>     be created on demand, but this fixes that also for consistency.
>     
>     Signed-off-by: Paul Mackerras <paulus@samba.org>
> 

Thanks for pointing that out, I'll get the fix and retry.

Balbir Singh.
