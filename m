Return-Path: <dvhltc@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2B30B6F0E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 23:45:25 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o74Dfgcf002048
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 07:41:42 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o74DjDuD151212
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 07:45:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o74Dj1nY027986
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 07:45:03 -0600
Message-ID: <4C596EDB.30004@us.ibm.com>
Date: Wed, 04 Aug 2010 06:44:59 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
In-Reply-To: <1279837509.1970.24.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 07/22/2010 03:25 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-22 at 11:24 -0700, Darren Hart wrote:
>>
>> 1) How can the preempt_count() get mangled across the H_CEDE hcall?
>> 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?
>
> The preempt count is on the thread info at the bottom of the stack.
>
> Can you check the stack pointers ?

Hi Ben, sorry if I didn't get back to you on this already. I checked the 
stack pointer before and after the cede call and they match.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
