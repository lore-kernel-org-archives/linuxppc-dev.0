Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 366132C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:11:57 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 19:00:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8B9E53578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:11:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7M8tlZT5898714
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 18:55:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7M9BrrZ009091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:11:55 +1000
Message-ID: <5215D540.9020309@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 14:39:20 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC V2 PATCH 4/6] cpuidle/ppc: Add longnap state to the idle
 states on powernv
References: <20130814115311.5193.32212.stgit@preeti.in.ibm.com>
 <20130814115623.5193.36974.stgit@preeti.in.ibm.com>
 <1377142130.25016.273.camel@pasglop>
In-Reply-To: <1377142130.25016.273.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, rjw@sisk.pl, paulmck@linux.vnet.ibm.com,
 arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org,
 john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 08/22/2013 08:58 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2013-08-14 at 17:26 +0530, Preeti U Murthy wrote:
>> This patch hooks into the existing broadcast framework along with the support
>> that this patchset introduces for ppc, and the cpuidle driver backend
>> for powernv(posted out by Deepthi Dharwar:https://lkml.org/lkml/2013/7/23/128)
>> to add sleep state as one of the deep idle states, in which the decrementer
>> is switched off.
>>
>> However in this patch, we only emulate sleep by going into a state which does
>> a nap with the decrementer interrupts disabled, termed as longnap. This enables
>> focus on the timer broadcast framework for ppc in this series of patches ,
>> which is required as a first step to enable sleep on ppc.
> 
> This is only for debug / proof of concept right ? We should use a real
> sleep here.
> 
> If we need to know whether the FW supports it (PORE etc...) we shall add
> a device-tree property from the FW to indicate that fact.

We also need the sleep support right? The context management, I mean.
Yes it is a debug patch, so as to first ensure that we have the hook up
to the broadcast framework done right.

Regards
Preeti U Murthy
