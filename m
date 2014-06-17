Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 762A51A0245
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 20:51:29 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 16:21:22 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9230CE0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:22:24 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5HAqJDk4129184
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:22:20 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5HApIZ1018352
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 16:21:18 +0530
Message-ID: <53A01DA4.3060702@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 16:21:16 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc/kvm: support to handle sw breakpoint
References: <1402780097-28827-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53A0022D.5020108@suse.de> <1402996939.7661.126.camel@pasglop>
 <53A0096D.3020108@suse.de> <1402997541.7661.128.camel@pasglop>
In-Reply-To: <1402997541.7661.128.camel@pasglop>
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

On Tuesday 17 June 2014 03:02 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2014-06-17 at 11:25 +0200, Alexander Graf wrote:
>> On 17.06.14 11:22, Benjamin Herrenschmidt wrote:
>>> On Tue, 2014-06-17 at 10:54 +0200, Alexander Graf wrote:
>>>> Also, why don't we use twi always or something else that actually is
>>>> defined as illegal instruction? I would like to see this shared with
>>>> book3s_32 PR.
>>> twi will be directed to the guest on HV no ? We want a real illegal
>>> because those go to the host (for potential emulation by the HV).
>>
>> Ah, good point. I guess we need different one for PR and HV then to 
>> ensure compatibility with older ISAs on PR.
> 
> Well, we also need to be careful with what happens if a PR guest puts
> that instruction in, do that stop its HV guest/host ?
> 

Damn, my mail client is messed up. did not see the mail till now.


I havent tried this incase of PR guest kernel. I will need to try this
before commenting.

> What if it's done in userspace ? Do that stop the kernel ? :-)
> 

Basically flow is that, when we see this instruction, we return to host,
and host checks for address in the SW array and if not it returns to kernel.

> Maddy, I haven't checked, does your patch ensure that we only ever stop
> if the instruction is at a recorded bkpt address ? It still means that a
> userspace process can practically DOS its kernel by issuing a lot of
> these causing a crapload of exits.
> 
This is valid, userspace can create a mess, need to handle this, meaning
incase if we dont find a valid SW breakpoint for this address in the
HOST, we need to route it to guest and kill it at app.

Regards
Maddy

> Cheers,
> Ben.
> 
>> Alex
>>
>>> I'm
>>> trying to see if I can get the architect to set one in stone in a future
>>> proof way.
>>>
>>> Cheers,
>>> Ben.
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
