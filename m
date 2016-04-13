Return-Path: <waiman.long@hpe.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0103.outbound.protection.outlook.com [65.55.169.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlW1Q2rMVzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:26:17 +1000 (AEST)
Message-ID: <570E6B76.5080306@hpe.com>
Date: Wed, 13 Apr 2016 11:53:26 -0400
From: Waiman Long <waiman.long@hpe.com>
MIME-Version: 1.0
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Boqun Feng <boqun.feng@gmail.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc: introduce {cmp}xchg for u8 and u16
References: <570752AA.9050603@linux.vnet.ibm.com>
 <20160408074744.GU3430@twins.programming.kicks-ass.net>
 <570A6078.2050002@linux.vnet.ibm.com> <20160412143023.GH1087@worktop>
 <570E2A45.9080702@linux.vnet.ibm.com>
In-Reply-To: <570E2A45.9080702@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/13/2016 07:15 AM, Pan Xinhui wrote:
> Hello Peter,
>
> On 2016年04月12日 22:30, Peter Zijlstra wrote:
>
>>> I am working on the qspinlock implementation on PPC.
>>> Your and Waiman's patches are so nice. :)
>> Thanks!, last time I looked at PPC spinlocks they could not use things
>> like ticket locks because PPC might be a guest and fairness blows etc..
>>
>> You're making the qspinlock-paravirt thing work on PPC, or doing
>> qspinlock only for bare-metal PPC?
>>
> I am making the both work. :)
> qspinlock works on PPC now. I am preparing the patches and will send them out in next weeks :)

What of performance improvement are you seeing in PPC?

> The paravirt work is a little hard.
> currently, there are pv_wait() and pv_kick(). but only pv_kick has the parameter cpu(who will hold the lock as soon as the lock is unlocked).
> We need parameter cpu(who holds the lock now) in pv_wait,too.

That can be doable to a certain extent. However, if the current lock 
holder acquired the lock via the fastpath only. The CPU information is 
not logged anywhere. For a contended lock, the information should be there.

Cheers,
Longman
