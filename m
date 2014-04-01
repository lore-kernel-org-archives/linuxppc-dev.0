Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 90F751400B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 04:11:58 +1100 (EST)
Message-ID: <533AF359.1030504@suse.de>
Date: Tue, 01 Apr 2014 19:11:53 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4] KVM: PPC: Bookehv: Get vcpu's last instruction for
 emulation
References: <1392913821-4520-1-git-send-email-mihai.caraman@freescale.com>
 <1392913821-4520-4-git-send-email-mihai.caraman@freescale.com>
 <1395868664.12738.68.camel@snotra.buserror.net> <53397091.4050601@suse.de>
 <1396307005.20849.37.camel@snotra.buserror
 <9EA94FFE-EC8B-40BE-A6BE-1D0FCF81F2E9@suse.de>
 <1396371496.20849.51.camel@snotra.buserror.net>
In-Reply-To: <1396371496.20849.51.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/01/2014 06:58 PM, Scott Wood wrote:
> On Tue, 2014-04-01 at 07:47 +0200, Alexander Graf wrote:
>>> Am 01.04.2014 um 01:03 schrieb Scott Wood <scottwood@freescale.com>:
>>>
>>>> On Mon, 2014-03-31 at 15:41 +0200, Alexander Graf wrote:
>>>>> On 03/26/2014 10:17 PM, Scott Wood wrote:
>>>>>> On Thu, 2014-02-20 at 18:30 +0200, Mihai Caraman wrote:
>>>>>> +    /*
>>>>>> +     * Another thread may rewrite the TLB entry in parallel, don't
>>>>>> +     * execute from the address if the execute permission is not set
>>>>>> +     */
>>>> What happens when another thread rewrites the TLB entry in parallel?
>>>> Does tlbsx succeed? Does it fail? Do we see failure indicated somehow?
>>>> Are the contents of the MAS registers consistent at this point or
>>>> inconsistent?
>>> If another thread rewrites the TLB entry, then we use the new TLB entry,
>>> just as if it had raced in hardware.  This check ensures that we don't
>>> execute from the new TLB entry if it doesn't have execute permissions
>>> (just as hardware would).
>>>
>>> What happens if the new TLB entry is valid and executable, and the
>>> instruction pointed to is valid, but doesn't trap (and thus we don't
>>> have emulation for it)?
>>>
>>>> There has to be a good way to detect such a race and deal with it, no?
>>> How would you detect it?  We don't get any information from the trap
>>> about what physical address the instruction was fetched from, or what
>>> the instruction was.
>> Ah, this is a guest race where the guest modifies exactly the TLB in question. I see.
>>
>> Why would this ever happen in practice (in a case where we're not executing malicious code)?
> I don't know.  It probably wouldn't.  But it seems wrong to not check
> the exec bit.

Right, I'm just saying that a program interrupt is not too bad of an 
answer in case the guest does something as stupid as this in kernel 
space :). It's definitely good practice to check for the exec bit.


Alex
