Return-Path: <vatsa@in.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3EF067BA1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 17:04:07 +1000 (EST)
Received: from e32.co.us.ibm.com (e32.boulder.ibm.com [9.17.249.42])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3C4qcHL015007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 00:52:38 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3C4qYuK012171
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 00:52:34 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3C4tqrJ174086
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 22:55:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3C4qYgB025286
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 22:52:34 -0600
Date: Wed, 12 Apr 2006 10:20:32 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] tickless idle cpus: core patch - v2
Message-ID: <20060412045032.GA25581@in.ibm.com>
References: <20060407063044.GA22416@in.ibm.com>
	<17462.61423.42032.559627@cargo.ozlabs.ibm.com>
	<20060410121847.GB5564@in.ibm.com>
	<17467.59608.503042.216312@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17467.59608.503042.216312@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: vatsa@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2006 at 03:35:20AM +1000, Paul Mackerras wrote:
> It would be nice if we could arrange to call stop_hz_timer from the
> top-level cpu_idle() function rather than having to call it from the
> individual power_save() functions such as power4_idle().  Can you see
> a problem with doing that?

I had considered doing that, but one problem with it is - how do we ensure that 
start_hz_timer will be called before idle thread calls schedule? A problem 
scenario is when the power_save() function returns without taking an interrupt 
(as is possible in pseries_dedicated_idle_sleep?), since start_hz_timer is 
currently called from only an interrupt context.

Now we could contemplate calling start_hz_timer directly from cpu_idle
when power_save() function returns - but how do we get the register
context required as an argument in start_hz_timer()?

-- 
Regards,
vatsa
