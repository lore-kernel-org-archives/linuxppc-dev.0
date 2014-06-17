Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20D7E1A02B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 21:31:26 +1000 (EST)
Message-ID: <53A0270A.1070401@suse.de>
Date: Tue, 17 Jun 2014 13:31:22 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/kvm: support to handle sw breakpoint
References: <1402780097-28827-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53A0022D.5020108@suse.de> <1402996939.7661.126.camel@pasglop>
 <53A0096D.3020108@suse.de> <1402997541.7661.128.camel@pasglop>
 <53A00DB8.4030207@suse.de> <53A0248D.7070909@linux.vnet.ibm.com>
In-Reply-To: <53A0248D.7070909@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 17.06.14 13:20, Madhavan Srinivasan wrote:
> On Tuesday 17 June 2014 03:13 PM, Alexander Graf wrote:
>> On 17.06.14 11:32, Benjamin Herrenschmidt wrote:
>>> On Tue, 2014-06-17 at 11:25 +0200, Alexander Graf wrote:
>>>> On 17.06.14 11:22, Benjamin Herrenschmidt wrote:
>>>>> On Tue, 2014-06-17 at 10:54 +0200, Alexander Graf wrote:
>>>>>> Also, why don't we use twi always or something else that actually is
>>>>>> defined as illegal instruction? I would like to see this shared with
>>>>>> book3s_32 PR.
>>>>> twi will be directed to the guest on HV no ? We want a real illegal
>>>>> because those go to the host (for potential emulation by the HV).
>>>> Ah, good point. I guess we need different one for PR and HV then to
>>>> ensure compatibility with older ISAs on PR.
>>> Well, we also need to be careful with what happens if a PR guest puts
>>> that instruction in, do that stop its HV guest/host ?
>>>
>>> What if it's done in userspace ? Do that stop the kernel ? :-)
>> The way SW breakpointing is handled is that when we see one, it gets
>> deflected into user space. User space then has an array of breakpoints
>> it configured itself. If the breakpoint is part of that list, it
>> consumes it. If not, it injects a debug interrupt (program in this case)
>> into the guest.
>>
>> That way we can overlay that one instruction with as many layers as we
>> like :). We only get a performance hit on execution of that instruction.
>>
>>> Maddy, I haven't checked, does your patch ensure that we only ever stop
>>> if the instruction is at a recorded bkpt address ? It still means that a
>>> userspace process can practically DOS its kernel by issuing a lot of
>>> these causing a crapload of exits.
>> Only user space knows about its breakpoint addresses, so we have to
>> deflect. However since time still ticks on, we only increase jitter of
>> the guest. The process would still get scheduled away after the same
>   ^^^ Where is this taken care. I am still trying to understand. Kindly
> can you explain or point to the code. Will help.

We tell the guest via VPA about its steal time which includes QEMU time.


Alex
