Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8558CB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 23:33:47 +1000 (EST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1926EDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 23:33:45 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id n76DXemA015388
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 23:33:40 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n76DXeXk765974
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 23:33:40 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n76DXeiM012024
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 23:33:40 +1000
Message-ID: <4A7ADBB1.3050906@in.ibm.com>
Date: Thu, 06 Aug 2009 19:03:37 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.31-rc5-git2 crash on a idle system.
References: <4A78292A.5000607@in.ibm.com>	 <1249421223.18245.36.camel@pasglop>
	<4A794E26.8080207@in.ibm.com> <1249465934.18245.54.camel@pasglop>
In-Reply-To: <1249465934.18245.54.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: neilb@suse.de, linuxppc-dev@ozlabs.org, linux-raid@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Thanks. Since it's a memory corruption (or seems to be) however, it's
> possible that the bisection will mislead you. IE. The culprit could be
> somewhere else, and the commit you'll find via bisection just happens to
> move things around in the kernel in such a way that the corruption hits
> that code path instead of another rarely used one.
>
> I would suggest using printk to print out the content of memory where
> the code appears to have been smashed at different stages during boot
> (maybe even in the initcalls loop in init/main.c) to try to point out
> what appears to be causing the corruption.
>   
By the time machine is up and running the particular memory location
in question is already overwritten. So seems like the corruption occurs
during the boot.

I added few printks in the initcall debug code patch. The o/p suggests
that by the time first initicall debug message is printed the code is
already corrupted. Further debug suggests, when start_kernel() is
called the code at address(0xc000000000600000) is already corrupted.
About 28 bytes of code starting from the above address is overwritten. 

I will try to add few more debug statements to find the place where
this corruption might me happening.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
