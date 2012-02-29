Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
 [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B18AAB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 06:06:18 +1100 (EST)
Message-ID: <4F4E771D.1040403@freescale.com>
Date: Wed, 29 Feb 2012 13:06:05 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Don't sync timebase when inside KVM
References: <1330481769-24390-1-git-send-email-agraf@suse.de>
 <4F4E6574.5050604@freescale.com>
 <39AA9511-4D56-4087-BC98-4BB32EF048AA@suse.de>
In-Reply-To: <39AA9511-4D56-4087-BC98-4BB32EF048AA@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/29/2012 12:28 PM, Alexander Graf wrote:
> 
> 
> On 29.02.2012, at 18:50, Scott Wood <scottwood@freescale.com> wrote:
> 
>> On 02/28/2012 08:16 PM, Alexander Graf wrote:
>>> When we know that we're running inside of a KVM guest, we don't have to
>>> worry about synchronizing timebases between different CPUs, since the
>>> host already took care of that.
>>>
>>> This fixes CPU overcommit scenarios where vCPUs could hang forever trying
>>> to sync each other while not being scheduled.
>>>
>>> Reported-by: Stuart Yoder <B08248@freescale.com>
>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>
>> This should apply to any hypervisor, not just KVM.  
> 
> Sure, but do you have a generic function to evaluate that? :)

The presence of a hypervisor node without testing compatible.  Might not
get them all, but at least it will cover more than just KVM.

>> Which platforms are you seeing this on?  If it's on Freescale chips,
>> U-Boot should be doing the sync and Linux should never do it, even in
>> the absence of a hypervisor.
> 
> This is on e500mc.

On e500mc Linux should never by trying to sync the timebase.  If it is,
let's fix that.

-Scott
