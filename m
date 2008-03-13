Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81E50DDF0B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 00:02:32 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id m2DD2D4U011494
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 18:32:13 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2DD2DO2717028
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 18:32:13 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m2DD2CHN019134
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 13:02:13 GMT
Message-ID: <47D925D2.9050003@linux.vnet.ibm.com>
Date: Thu, 13 Mar 2008 18:32:10 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [BUG] 2.6.25-rc5-mm1 kernel panic with "Exception: 501 " on
	powerpc
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
	<47D7D2C9.4090001@linux.vnet.ibm.com>
	<20080312104645.34e58319.akpm@linux-foundation.org>
	<20080312175102.GC613@parisc-linux.org>
	<1205360769.7436.8.camel@concordia.ozlabs.ibm.com>
	<20080312223300.GE613@parisc-linux.org>
In-Reply-To: <20080312223300.GE613@parisc-linux.org>
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, pbadari@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthew Wilcox wrote:
> On Thu, Mar 13, 2008 at 09:26:09AM +1100, Michael Ellerman wrote:
>> down() looks OK, but there's still a spin_lock_irq() in __down_common(),
>> although I don't know if it makes sense for us to be in __down() at that
>> stage.
> 
> The spin_lock_irq in __down_common is correct.  We're going to schedule(),
> so we spin_unlock_irq() to save us passing the flags into the helper
> function.  If we had interrupts disabled on entry, there's an Aieee
> for that.
> 

Hi All,

Sorry for all the noise made :-(, something wrong in the test setup from my end, 
the kernel was 2.6.25-rc3-mm1 not 2.6.25-rc5-mm1. This bug is not seen in the
2.6.25-rc5-mm1 kernel.

-- 
Thanks & Regards,
Kamalesh Babulal,
