Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 828671A02B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 21:20:54 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 16:50:51 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 013BB3940063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:50:49 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5HBL0fT59048006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:51:00 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5HBKkc0013038
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:50:46 +0530
Message-ID: <53A0248D.7070909@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 16:50:45 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/kvm: support to handle sw breakpoint
References: <1402780097-28827-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53A0022D.5020108@suse.de> <1402996939.7661.126.camel@pasglop>
 <53A0096D.3020108@suse.de> <1402997541.7661.128.camel@pasglop>
 <53A00DB8.4030207@suse.de>
In-Reply-To: <53A00DB8.4030207@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 17 June 2014 03:13 PM, Alexander Graf wrote:
> 
> On 17.06.14 11:32, Benjamin Herrenschmidt wrote:
>> On Tue, 2014-06-17 at 11:25 +0200, Alexander Graf wrote:
>>> On 17.06.14 11:22, Benjamin Herrenschmidt wrote:
>>>> On Tue, 2014-06-17 at 10:54 +0200, Alexander Graf wrote:
>>>>> Also, why don't we use twi always or something else that actually is
>>>>> defined as illegal instruction? I would like to see this shared with
>>>>> book3s_32 PR.
>>>> twi will be directed to the guest on HV no ? We want a real illegal
>>>> because those go to the host (for potential emulation by the HV).
>>> Ah, good point. I guess we need different one for PR and HV then to
>>> ensure compatibility with older ISAs on PR.
>> Well, we also need to be careful with what happens if a PR guest puts
>> that instruction in, do that stop its HV guest/host ?
>>
>> What if it's done in userspace ? Do that stop the kernel ? :-)
> 
> The way SW breakpointing is handled is that when we see one, it gets
> deflected into user space. User space then has an array of breakpoints
> it configured itself. If the breakpoint is part of that list, it
> consumes it. If not, it injects a debug interrupt (program in this case)
> into the guest.
> 
> That way we can overlay that one instruction with as many layers as we
> like :). We only get a performance hit on execution of that instruction.
> 
>> Maddy, I haven't checked, does your patch ensure that we only ever stop
>> if the instruction is at a recorded bkpt address ? It still means that a
>> userspace process can practically DOS its kernel by issuing a lot of
>> these causing a crapload of exits.
> 
> Only user space knows about its breakpoint addresses, so we have to
> deflect. However since time still ticks on, we only increase jitter of
> the guest. The process would still get scheduled away after the same
 ^^^ Where is this taken care. I am still trying to understand. Kindly
can you explain or point to the code. Will help.

> amount of real time, no?
> 
> 
> Alex
> 
Thanks for review.
Regards
Maddy
