Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 56B75B6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  4 Jul 2010 19:37:38 +1000 (EST)
Message-ID: <4C30565D.6030508@redhat.com>
Date: Sun, 04 Jul 2010 12:37:33 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
	<EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
	<1278196909.4200.389.camel@pasglop>
	<79514591-DCC1-4D9E-AFB7-AA985ADF3C0F@suse.de>
	<4C305001.7060301@redhat.com>
	<40488555-C73E-4C04-BFAD-31ED99CDBBDA@suse.de>
In-Reply-To: <40488555-C73E-4C04-BFAD-31ED99CDBBDA@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2010 12:17 PM, Alexander Graf wrote:
> On 04.07.2010, at 11:10, Avi Kivity wrote:
>
>    
>> On 07/04/2010 12:04 PM, Alexander Graf wrote:
>>      
>>> My biggest concern about putting things in the device-tree is that I was trying to keep things as separate as possible. Why does the firmware have to know that it's running in KVM?
>>>        
>> It doesn't need to know about kvm, it needs to know that a particular hypercall protocol is available.
>>      
> Considering how the parts of the draft that I read about sound like, that's not the inventor's idea. PPC people love to see the BIOS be part of the virtualization solution. I don't. That's the biggest difference here and reason for us going different directions.
>    

Regardless of which direction is "correct", you need to go in one direction.

> I think what they thought of is something like
>
> if (in_kvm()) {
>    device_tree_put("/hypervisor/exit", EXIT_TYPE_MAGIC);
>    device_tree_put("/hypervisor/exit_magic", EXIT_MAGIC);
> }
>
> which then the OS reads out. But that's useless, as the hypercalls are hypervisor specific. So why make the detection on the Linux side generic?
>    

Looks like the benefit is less magic in the detection code.  x86 has 
(more or less) standardized feature detection.  Is this an attempt to 
bring something similar to ppc-land?

>>> Why do I have to patch 3 projects (Linux, OpenBIOS, Qemu) when I could go with patching a single one (Linux)?
>>>
>>>        
>> That's not a valid argument.  You patch as many projects as it takes to get it right (not that I have an opinion in this particular discussion).
>>      
> If you can put code in Linux that touches 3 submaintainer's directories or one submaintainer's directory with both ending up being functionally equivalent, which way would you go?
>    

We would do the right thing.  Trivial examples include adding defines to 
include/asm/processor.h or include/asm/msr-index.h, more complicated 
ones are the topic for my talk in kvm forum 2010.

Yes, coordinating the acks and trees and merge windows is not as fun as 
coding.  Yes, it's even more difficult with separate trees.  No, that's 
not an excuse if we[1] determine that the right thing to do is the most 
complicated.

[1] "we" in this case are the powerpc Linux arch maintainers and/or 
whoever defines the hardware specification

>> At the very least you have to patch qemu for reasons described before (backwards compatible live migration).
>>      
> There is no live migration on PPC (yet). That point is completely moot atm.
>    

You still need to make that feature disableable from userspace.

-- 
error compiling committee.c: too many arguments to function
