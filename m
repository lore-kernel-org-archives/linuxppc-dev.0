Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 43F81B721D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 22:16:31 +1000 (EST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3EC72DDDB2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 22:16:29 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp09.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5HBUpxB022021
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 17:00:51 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5HCGG0P2375804
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 17:46:16 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5HCGF4V002813
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 22:16:16 +1000
Message-ID: <4A38DE90.4020500@in.ibm.com>
Date: Wed, 17 Jun 2009 17:46:16 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [BUG] lib/kernel_lock.c:126 with cgroups regression ltp tests
References: <4A38CAAC.4090606@in.ibm.com> <1245237613.4269.13.camel@concordia>
In-Reply-To: <1245237613.4269.13.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel <linux-kernel@vger.kernel.org>, chrisw@sous-sol.org,
	linuxppc-dev@ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
	menage@google.com, abogani@texware.it,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Wed, 2009-06-17 at 16:21 +0530, Sachin Sant wrote:
>   
>> While executing cgroups regression tests from LTP May 2009
>> release on a Power6 box came across the following bug.
>>     
>
>   
>> This is with 2.6.30-git10 (300df7dc89cc276377fc020704e34875d5c473b6)
>>     
>
> Looks like 337eb00a2 missed some return paths in do_remount_sb()?
>
> $ git log -p -U13 337eb00a2c3a421999c39c94ce7e33545ee8baa7 fs/super.c
> commit 337eb00a2c3a421999c39c94ce7e33545ee8baa7
> Author: Alessio Igor Bogani <abogani@texware.it>
Thanks Michael.

The following submitted patch from Chris fixes this issue.

http://patchwork.kernel.org/patch/30675/

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
