Return-Path: <dvhltc@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 126B91007D1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 14:46:15 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o754gYRm014863
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:42:34 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o754jtEO054850
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:45:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o754js9A020914
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 22:45:55 -0600
Message-ID: <4C5A41FF.3000605@us.ibm.com>
Date: Wed, 04 Aug 2010 21:45:51 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com> <4C491E14.9010100@us.ibm.com>
	<20100723050814.GA26162@dirshya.in.ibm.com>
	<1279861860.1970.74.camel@pasglop>
	<20100723070701.GC26162@dirshya.in.ibm.com>
In-Reply-To: <20100723070701.GC26162@dirshya.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2010 12:07 AM, Vaidyanathan Srinivasan wrote:
> * Benjamin Herrenschmidt<benh@kernel.crashing.org>  [2010-07-23 15:11:00]:
>
>> On Fri, 2010-07-23 at 10:38 +0530, Vaidyanathan Srinivasan wrote:
>>> Yes.  extended_cede_processor() will return with interrupts enabled in
>>> the cpu. (This is done by the hypervisor).  Under normal cases we
>>> cannot be interrupted because no IO interrupts are routed to us after
>>> xics_teardown_cpu() and since the CPU is out of the map, nobody will
>>> send us IPIs.
>>
>> What about decrementer ?
>
> Decrementer expiry event handling is bit complex.  The event as such
> may not bring back the extended_cede_processor() cpu, but may be
> marked pending when we get out of this state eventually.  I will find
> more information on this event and update.

Hi Vaidy, have you been able to dig anything up about the decrementer 
expiry?

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team


>
>>> Though H_CEDE will return with interrupts enabled, it is unlikely that
>>> an interrupt can be delivered in this context.
>>
>> Well, if interrupts are soft-disabled, even if one occurs, we will just
>> mask and return, so that at least should be ok.
>
> Yes.  We will immediately return to the extended_cede_processor() in
> the while loop until the preferred_offline_state is changed.
>
> --Vaidy
