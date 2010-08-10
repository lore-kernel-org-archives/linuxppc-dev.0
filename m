Return-Path: <dvhltc@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B307B6F06
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 08:36:50 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7AMVrkL011963
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 16:31:53 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7AMaOKm021042
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 16:36:27 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7AMaMb3013502
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 16:36:23 -0600
Message-ID: <4C61D464.5090307@us.ibm.com>
Date: Tue, 10 Aug 2010 15:36:20 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com>
	<alpine.LFD.2.00.1007222028420.2616@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.1007222028420.2616@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2010 11:38 AM, Thomas Gleixner wrote:
> On Thu, 22 Jul 2010, Darren Hart wrote:
>
>> Also of interest is that this path
>> cpu_idle()->cpu_die()->pseries_mach_cpu_die() to start_secondary()
>> enters with a preempt_count=1 if it wasn't corrupted across the hcall.
>
> That triggers the problem as well. preempt_count needs to be 0 when
> entering start_secondary(). So I really wonder how that ever worked.
>
>> The early boot path from _start however appears to call
>> start_secondary() with a preempt_count of 0.
>
> Which is correct.
>
>> The following patch is most certainly not correct, but it does eliminate
>
> It is correct, but i think it is incomplete as other portions of the
> thread_info on the stack might be in some weird state as well.

Just FYI, I took a look at the stack pointers as well as all the fields 
in the thread_info struct. The only one that changes is preempt_count. 
The previous value of preempt_count doesn't impact the value after cede. 
An initial value of 0, 1, or 4 all result in an after-cede value of 
0xffffffff. I also added 32 bits of padding on either side of the 
preempt_count in case the change was accidental - it wasnt', the padded 
values remained unchanged across the cede call while the preempt_count 
still changed to 0xffffffff.


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
