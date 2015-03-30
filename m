Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DD671A0028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:16:03 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 31 Mar 2015 03:16:02 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B9CB42BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:15:59 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2UHFp4k35455158
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:15:59 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2UHFQ5I013076
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:15:26 +1100
Message-ID: <5519849D.9070005@linux.vnet.ibm.com>
Date: Mon, 30 Mar 2015 22:45:09 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [v3, 3/3] powerpc/powernv: Introduce sysfs control for fastsleep
 workaround behavior
References: <20150330102156.43CD1140161@ozlabs.org>
In-Reply-To: <20150330102156.43CD1140161@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 30 March 2015 03:51 PM, Michael Ellerman wrote:
> On Sun, 2015-22-03 at 04:42:59 UTC, "Shreyas B. Prabhu" wrote:
>> Fastsleep is one of the idle state which cpuidle subsystem currently
>> uses on power8 machines. In this state L2 cache is brought down to a
>> threshold voltage. Therefore when the core is in fastsleep, the
>> communication between L2 and L3 needs to be fenced. But there is a bug
>> in the current power8 chips surrounding this fencing.
>>
>> OPAL provides a workaround which precludes the possibility of hitting
>> this bug. But running with this workaround applied causes checkstop
>> if any correctable error in L2 cache directory is detected. Hence OPAL
>> also provides a way to undo the workaround.
>>
>> In the existing implementation, workaround is applied by the last thread
>> of the core entering fastsleep and undone by the first thread waking up.
>> But this has a performance cost. These OPAL calls account for roughly
>> 4000 cycles everytime the core has to enter or wakeup from fastsleep.
>>
>> This patch introduces a sysfs attribute (fastsleep_workaround_state)
>> to choose the behavior of this workaround.
>>
>> By default, fastsleep_workaround_state = 0. In this case, workaround
>> is applied/undone everytime the core enters/exits fastsleep.
>>
>> fastsleep_workaround_state = 1. In this case the workaround is applied
>> once on all the cores and never undone. This can be triggered by
>> echo 1 > /sys/devices/system/cpu/fastsleep_workaround_state
>>
>> For simplicity this attribute can be modified only once. Implying, once
>> fastsleep_workaround_state is changed to 1, it cannot be reverted to
>> the default state.
> 
> This sounds good, although the name is a bit vague.
> 
> Just calling it "state" doesn't make it clear what 0 and 1 mean.
> I think better would be "fastsleep_workaround_active" ?
> 
> Though even that is a bit wrong, because 0 doesn't really mean it's not active,
> it means it's not *permanently* active.
> 
> So another option would be to make it a string attribute, with the initial
> state being eg. "dynamic" and then maybe "applied" for the applied state?
> 
How about "fastsleep_workaround_permanent", with default value = 0. User
can make workaround permanent by echoing 1 to it.

I'll post out V4 with the suggested changes.


Thanks,
Shreyas
